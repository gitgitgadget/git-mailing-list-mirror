From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] diff: don't retrieve binary blobs for diffstat
Date: Sat, 19 Feb 2011 03:16:32 -0500
Message-ID: <20110219081631.GB18056@sigill.intra.peff.net>
References: <20110219080307.GA18039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 09:16:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqhzl-0003kw-MI
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 09:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319Ab1BSIQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 03:16:36 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:42774 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998Ab1BSIQf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 03:16:35 -0500
Received: (qmail 7511 invoked by uid 111); 19 Feb 2011 08:16:33 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 19 Feb 2011 08:16:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Feb 2011 03:16:32 -0500
Content-Disposition: inline
In-Reply-To: <20110219080307.GA18039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167256>

We only need the size, which is much cheaper to get,
especially if it is a big binary file.

Signed-off-by: Jeff King <peff@peff.net>
---
This of course is only really helpful if you have marked the files as
binary via gitattributes, since otherwise we have to pull in the blob to
find out that it's binary. :)

But in my real-world photo/video repo, which has media files marked via
gitattributes as binary (but to textconv exif tags, of course). The
commit in question has 26 files totalling 88 megabytes.

  $ time git show --stat >old
  real    0m0.428s
  user    0m0.392s
  sys     0m0.032s

  $ time git.jk.diffstat-binary show --stat >new
  real    0m0.005s
  user    0m0.004s
  sys     0m0.000s

  $ cmp old new && echo ok
  ok

8500% speedup isn't too bad. :)

 diff.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 2ac0fe9..6640857 100644
--- a/diff.c
+++ b/diff.c
@@ -245,6 +245,15 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 	return 0;
 }
 
+/* like fill_mmfile, but only for size, so we can avoid retrieving blob */
+static unsigned long diff_filespec_size(struct diff_filespec *one)
+{
+	if (!DIFF_FILE_VALID(one))
+		return 0;
+	diff_populate_filespec(one, 1);
+	return one->size;
+}
+
 static int count_trailing_blank(mmfile_t *mf, unsigned ws_rule)
 {
 	char *ptr = mf->ptr;
@@ -2081,11 +2090,9 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	}
 
 	if (diff_filespec_is_binary(one) || diff_filespec_is_binary(two)) {
-		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
-			die("unable to read files to diff");
 		data->is_binary = 1;
-		data->added = mf2.size;
-		data->deleted = mf1.size;
+		data->added = diff_filespec_size(two);
+		data->deleted = diff_filespec_size(one);
 	}
 
 	else if (complete_rewrite) {
-- 
1.7.4.1.26.g3372c
