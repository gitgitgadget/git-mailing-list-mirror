From: Jeff King <peff@peff.net>
Subject: [BUG] serious inflate inconsistency on master
Date: Tue, 3 Jul 2012 18:19:01 -0400
Message-ID: <20120703221900.GA28897@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 00:19:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmBRU-0000vE-Uf
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 00:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756739Ab2GCWTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 18:19:05 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52613
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756580Ab2GCWTE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 18:19:04 -0400
Received: (qmail 27191 invoked by uid 107); 3 Jul 2012 22:19:11 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jul 2012 18:19:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2012 18:19:01 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200973>

I'm getting a 'serious inflate consistency' error while running "git
verify-pack" (actually, "git index-pack --verify" under the hood). It
bisects to 4614043 (index-pack: use streaming interface for collision
test on large blobs, 2012-05-24).

The interesting thing about this repository is that it has a 2.8G text
file in it which compresses down to only about 420M. I'm not sure that
4614043 actually introduces the bug, but rather just triggers the code
path.

I'm able to reproduce it with the following script:

  # empty repo...
  git init repo &&
  cd repo &&

  # set this low to make sure we follow the unpack_data code-path
  git config core.bigfilethreshold 100k &&

  # now make a file bigger than our threshold, but that will compress
  # well
  perl -le 'print for (1..100000)' >file &&

  # and then make a commit
  git add file &&
  git commit -m file &&

  # and a pack with it
  git repack -ad &&

  # and then verify that pack
  git verify-pack .git/objects/pack/*.pack

The problem seems to be in index-pack.c:unpack_data, which does this:

>	git_inflate_init(&stream);
>	stream.next_out = data;
>	stream.avail_out = consume ? 64*1024 : obj->size;
>
>	do {
>		unsigned char *last_out = stream.next_out;
>		ssize_t n = (len < 64*1024) ? len : 64*1024;
>		n = pread(pack_fd, inbuf, n, from);
>		if (n < 0)
>			die_errno(_("cannot pread pack file"));
>		if (!n)
>			die(Q_("premature end of pack file, %lu byte missing",
>			       "premature end of pack file, %lu bytes missing",
>			       len),
>			    len);
>		from += n;
>		len -= n;
>		stream.next_in = inbuf;
>		stream.avail_in = n;
>		status = git_inflate(&stream, 0);
>		if (consume) {
>			if (consume(last_out, stream.next_out - last_out, cb_data)) {
>				free(inbuf);
>				free(data);
>				return NULL;
>			}
>			stream.next_out = data;
>			stream.avail_out = 64*1024;
>		}
>	} while (len && status == Z_OK && !stream.avail_in);
>
>	/* This has been inflated OK when first encountered, so... */
>	if (status != Z_STREAM_END || stream.total_out != obj->size)
>		die(_("serious inflate inconsistency"));

We limit ourselves to handling just 64K at a time. So we read in 64K and
stuff it in the next_in/avail_in buffer. And then we make 64K of buffer
available for zlib to write into via the next_out/avail_out buffer. So
zlib reads the first chunk, and after reading 28K or so fills up the 64K
output buffer and returns. We call consume on the chunk, but when we hit
the outer loop condition, stream.avail_in still mentions the 36K we
haven't processed yet, and the loop ends with status == Z_OK, which
triggers the assertion below it.

So I don't really understand what this !stream.avail_in is doing there
in the do-while loop.  Don't we instead need to have an inner loop that
keeps feeding the result of pread into git_inflate until we don't have
any available data left?

Something like the patch below, which seems to work for me, but I still
don't understand the function of the !stream.avail_in check in the outer
loop.

-Peff

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8b5c1eb..0db1923 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -538,15 +538,19 @@ static void *unpack_data(struct object_entry *obj,
 		len -= n;
 		stream.next_in = inbuf;
 		stream.avail_in = n;
-		status = git_inflate(&stream, 0);
-		if (consume) {
-			if (consume(last_out, stream.next_out - last_out, cb_data)) {
-				free(inbuf);
-				free(data);
-				return NULL;
-			}
-			stream.next_out = data;
-			stream.avail_out = 64*1024;
+		if (!consume)
+			status = git_inflate(&stream, 0);
+		else {
+			do {
+				status = git_inflate(&stream, 0);
+				if (consume(last_out, stream.next_out - last_out, cb_data)) {
+					free(inbuf);
+					free(data);
+					return NULL;
+				}
+				stream.next_out = data;
+				stream.avail_out = 64*1024;
+			} while (status == Z_OK && stream.avail_in);
 		}
 	} while (len && status == Z_OK && !stream.avail_in);
 
