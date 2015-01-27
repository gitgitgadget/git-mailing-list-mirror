From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add failing test for fetching from multiple packs over
 dumb httpd
Date: Tue, 27 Jan 2015 13:12:21 -0500
Message-ID: <20150127181220.GA17067@peff.net>
References: <1422372041-16474-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 19:12:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGAcl-0000G3-S7
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 19:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758636AbbA0SMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 13:12:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:42419 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754723AbbA0SMW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 13:12:22 -0500
Received: (qmail 5278 invoked by uid 102); 27 Jan 2015 18:12:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Jan 2015 12:12:22 -0600
Received: (qmail 3101 invoked by uid 107); 27 Jan 2015 18:12:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Jan 2015 13:12:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jan 2015 13:12:21 -0500
Content-Disposition: inline
In-Reply-To: <1422372041-16474-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263081>

On Tue, Jan 27, 2015 at 03:20:41PM +0000, Charles Bailey wrote:

> From: Charles Bailey <cbailey32@bloomberg.net>
> 
> When objects are spread across multiple packs, if an initial fetch does
> require all pack files, a subsequent fetch for objects in packs not
> retrieved in the initial fetch will fail.

s/does/does not/, I think?

> I'm not very familiar with the http client code so this analysis is based
> purely on observed behaviour.

Debugging the http code is a royal pain because all the work happens in
a separate helper. I use a git-remote-debug script like this:

  #!/bin/sh
  host=localhost:5001
  proto=$(echo "${2:-$1}" | sed 's/:.*//')
  prog=git-remote-$proto
  echo >&2 "gdb -ex 'target remote $host' $prog"
  gdbserver localhost:5001 "$prog" "$@"

and then you can use:

  git fetch debug::http://...

in the test script, cut-and-paste the gdb command printed to stderr, and
you're dropped into the appropriate debugger without worrying about all
of the stdio mess.

> When fetching only some refs from a repository served over dumb httpd Git
> appears to download all of the index files for the available packs but then
> only chooses the pack files that help it resolve the objects which we need.

Right. And it looks like we have special code in sha1_file.c to make
sure we do not trust an index which does not have a matching packfile.
So that's good.

The http-walker code does its own check, in fetch_and_setup_pack_index,
that checks for an existing valid copy of the index. If we don't have
it, we download the index and proceed. If we do, we skip straight to
grabbing the pack. But if we have it and it doesn't appear valid, we
return an error. And there seems to be a bug with checking the validity.

It looks like the culprit is 7b64469 (Allow parse_pack_index on
temporary files, 2010-04-19). It added a new "idx_path" parameter to
parse_pack_index, which we pass as NULL.  That causes its call to
check_packed_git_idx to fail (because it has no idea what file we are
talking about!).

This seems to fix it:

diff --git a/sha1_file.c b/sha1_file.c
index 30995e6..eda4d90 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1149,6 +1149,9 @@ struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
 	const char *path = sha1_pack_name(sha1);
 	struct packed_git *p = alloc_packed_git(strlen(path) + 1);
 
+	if (!idx_path)
+		idx_path = sha1_pack_index_name(sha1);
+
 	strcpy(p->pack_name, path);
 	hashcpy(p->sha1, sha1);
 	if (check_packed_git_idx(idx_path, p)) {

(Alternatively, we could pass in sha1_pack_index_name instead of NULL in
the first place, but I think it is reasonable for parse_pack_index to
take care of this).

I think it may also make sense for fetch_and_setup_pack_index to delete
and re-download a broken .idx file (rather than aborting), but I don't
think that's a big deal. It should only happen in the face of on-disk
data corruption, and the user can remove the broken .idx themselves.

-Peff
