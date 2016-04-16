From: Mike Hommey <mh@glandium.org>
Subject: fast-import's gfi_unpack_entry causes too many munmap/mmap cycles
Date: Sat, 16 Apr 2016 18:18:39 +0900
Message-ID: <20160416091839.GA12764@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 11:18:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arMNU-0001Ur-CY
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 11:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbcDPJSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 05:18:51 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:38532 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbcDPJSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 05:18:48 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1arMND-00041o-Ld; Sat, 16 Apr 2016 18:18:39 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291717>

Hi,

I think I've mentioned this issue in the past, and fixed one case of
munmap/mmap cycle in fast-import. I've found more cases where this can
happen, and while on Linux, it's not a problem, on OSX, it leads to
catastrophic performance, when the import is massive.

One part of the problem is that gfi_unpack_entry just assumes that as
long as the pack was touched since last access, it _has_ to close all
windows and remap the pack. Afaict, when the requested entry is in the
range of what was previously mapped, there is no reason to do this, and
the following patch would help:

diff --git a/fast-import.c b/fast-import.c
index 75f7748..91fa2a1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1294,7 +1294,8 @@ static void *gfi_unpack_entry(
 {
        enum object_type type;
        struct packed_git *p = all_packs[oe->pack_id];
-       if (p == pack_data && p->pack_size < (pack_size + 20)) {
+       if (p == pack_data && oe->idx.offset >= (p->pack_size - 20) &&
+           p->pack_size < (pack_size + 20)) {
                /* The object is stored in the packfile we are writing to
                 * and we have modified it since the last time we scanned
                 * back to read a previously written object.  If an old

Now, the problem is that this doesn't help with use cases like the
following:
- create commit A.
- get its tree with `ls :mark ""`

In that case, since the tree was (very likely) created by committing,
the entry is located beyond the open window for the pack.

There is some kind of work around for that particular use case: get the
tree *during* the commit, with `ls ""` after all the
filemodify/filedelete entries, and before the newline that finishes the
commit. Unfortunately, in that case, store_tree does its job twice (once
for the ls, and once when committing for real), and that leads to
significant overhead.

And even if I am okay with that overhead, I still hit the problem again
when using that tree later with `M 040000 $sha1 ` in the next commit,
because that does a load_tree() for the tree sha1, after a commit having
occurred, which touched the pack, bringing me back to square one (the
sad part being that it does so while the tree_content for the tree in
question is already in memory).

Now, while each individual case could be improved to avoid
gfi_unpack_entry, it seems to me it would be better to make
gfi_unpack_entry better somehow. I wonder if there's not a better way
than having it close and reopen windows all the time for recent objects.
Can't the pack be pre-allocated and mapped by window-size fragments, for
example? (Would that maybe not work properly on all platforms?)

Mike

PS: And if I could find a work around that does work with existing
releases of git, that would be great. The root of all my pain is that I
have tree deltas between consecutive commits, when the commits are not
necessarily parent/child. e.g. for a commit history like

A --- B
 \
  \-- C

I have:
- diff between null-tree and A
- diff between A and B
- diff between B and C

Which means for C, I *need* to create a commit without a `from`, and
initialize its tree with `M 040000 sha-1-of-B's-tree `.
