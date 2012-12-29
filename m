From: Jeff King <peff@peff.net>
Subject: [BUG] two-way read-tree can write null sha1s into index
Date: Sat, 29 Dec 2012 15:51:54 -0500
Message-ID: <20121229205154.GA21058@sigill.intra.peff.net>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <20120728150524.GB25269@sigill.intra.peff.net>
 <20121229100130.GA31497@elie.Belkin>
 <20121229102707.GA26730@sigill.intra.peff.net>
 <20121229103430.GG18903@elie.Belkin>
 <20121229110541.GA1408@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 21:52:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tp3OH-0005uJ-V8
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 21:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab2L2Uv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 15:51:58 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39016 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945Ab2L2Uv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 15:51:56 -0500
Received: (qmail 31880 invoked by uid 107); 29 Dec 2012 20:53:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 15:53:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 15:51:54 -0500
Content-Disposition: inline
In-Reply-To: <20121229110541.GA1408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212316>

On Sat, Dec 29, 2012 at 06:05:41AM -0500, Jeff King wrote:

>   [clear state from last run]
>   $ rm -rf .git/rebase-apply
>   $ git reset --hard
> 
>   [apply the patch; we get a conflict]
>   $ git am -3sc queue-3.2/alsa-usb-audio-fix-missing-autopm-for-midi-input.patch
> 
>   [now run just the read-tree from "am --abort"]
>   $ git.compile read-tree --reset -u HEAD ORIG_HEAD
>   warning: cache entry has null sha1: sound/usb/midi.c
> 
>   [and now check our index]
>   $ git ls-files -s sound/usb/midi.c
>   100644 0000000000000000000000000000000000000000 0 sound/usb/midi.c
> 
>   [yes, this index is bogus]
>   $ git write-tree
>   error: invalid object 100644 0000000000000000000000000000000000000000 for 'sound/usb/midi.c'
>   fatal: git-write-tree: error building trees
> 
> So I think this check may actually be finding a real bug. I have seen
> these null sha1s in the wild, but I was never able to track down the
> actual cause. Maybe this will give us a clue. Now we just need to work
> backwards and figure out who is putting it in the in-memory index and
> why.

I made some progress on this, but I'd like a sanity check from others
(especially Junio). As far as I can tell, this is a bug in read-tree.

When we call "read-tree --reset -u HEAD ORIG_HEAD", the first thing we
do with the index is call read_cache_unmerged. Originally that would
read the index, leaving aside any unmerged entries. However, as of
d1a43f2 (reset --hard/read-tree --reset -u: remove unmerged new paths,
2008-10-15), it actually creates a new cache entry. This serves as a
placeholder, so that we later know to update the working tree.

However, we later noticed that the sha1 of that unmerged entry was
just copied from some higher stage, leaving you with random content in
the index.  That was fixed by e11d7b5 ("reset --merge": fix unmerged
case, 2009-12-31), which instead puts the null sha1 into the newly
created entry, and sets a CE_CONFLICTED flag. At the same time, it
teaches the unpack-trees machinery to pay attention to this flag, so
that oneway_merge throws away the current value.

However, it did not update the code paths for  twoway_merge, which is
where we end up in the read-tree above. We notice that the HEAD and
ORIG_HEAD versions are the same, and say "oh, we can just reuse the
current version". But that's not true. The current version is bogus.

So I think we need to update twoway_merge to recognize unmerged entries,
which gives us two options:

  1. Reject the merge.

  2. Throw away the current unmerged entry in favor of the "new" entry
     (when old and new are the same, of course; otherwise we would
     reject).

I think (2) is the right thing. It fixes the entry of the bogus sha1
into the index, _and_ it solves the problem that "git am --abort" leaves
the conflicted entry as a modification. It should just go away. But
maybe I am forgetting some other case where read-tree should be more
conservative, and (1) is a safer choice.

Something like this patch:

diff --git a/unpack-trees.c b/unpack-trees.c
index 6d96366..e06e01f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1746,14 +1746,19 @@ int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 		newtree = NULL;
 
 	if (current) {
-		if ((!oldtree && !newtree) || /* 4 and 5 */
-		    (!oldtree && newtree &&
-		     same(current, newtree)) || /* 6 and 7 */
-		    (oldtree && newtree &&
-		     same(oldtree, newtree)) || /* 14 and 15 */
-		    (oldtree && newtree &&
-		     !same(oldtree, newtree) && /* 18 and 19 */
-		     same(current, newtree))) {
+		if (current->ce_flags & CE_CONFLICTED) {
+			if (same(oldtree, newtree))
+				return merged_entry(newtree, current, o);
+			return o->gently ? -1 : reject_merge(current, o);
+		}
+		else if ((!oldtree && !newtree) || /* 4 and 5 */
+			 (!oldtree && newtree &&
+			  same(current, newtree)) || /* 6 and 7 */
+			 (oldtree && newtree &&
+			  same(oldtree, newtree)) || /* 14 and 15 */
+			 (oldtree && newtree &&
+			  !same(oldtree, newtree) && /* 18 and 19 */
+			  same(current, newtree))) {
 			return keep_entry(current, o);
 		}
 		else if (oldtree && !newtree && same(current, oldtree)) {

I suspect threeway_merge may need a similar update, but I haven't looked
too carefully yet.

-Peff
