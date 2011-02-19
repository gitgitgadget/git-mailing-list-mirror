From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] diff: handle diffstat of rewritten binary files
Date: Sat, 19 Feb 2011 03:04:56 -0500
Message-ID: <20110219080456.GA18056@sigill.intra.peff.net>
References: <20110219080307.GA18039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 09:05:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqhoN-00088a-NS
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 09:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601Ab1BSIE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 03:04:59 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43114 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374Ab1BSIE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 03:04:58 -0500
Received: (qmail 7446 invoked by uid 111); 19 Feb 2011 08:04:57 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 19 Feb 2011 08:04:57 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Feb 2011 03:04:56 -0500
Content-Disposition: inline
In-Reply-To: <20110219080307.GA18039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167255>

The logic in builtin_diffstat assumes that a
complete_rewrite pair should have its lines counted. This is
nonsensical for binary files and leads to confusing things
like:

  $ git diff --stat --summary HEAD^ HEAD
   foo.rand |  Bin 4096 -> 4096 bytes
   1 files changed, 0 insertions(+), 0 deletions(-)

  $ git diff --stat --summary -B HEAD^ HEAD
   foo.rand |   34 +++++++++++++++-------------------
   1 files changed, 15 insertions(+), 19 deletions(-)
   rewrite foo.rand (100%)

So let's reorder the function to handle binary files first
(which from diffstat's perspective look like complete
rewrites anyway), then rewrites, then actual diffstats.

There are two bonus prizes to this reorder:

  1. It gets rid of a now-superfluous goto.

  2. The binary case is at the top, which means we can
     further optimize it in the next patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index 5422c43..2ac0fe9 100644
--- a/diff.c
+++ b/diff.c
@@ -2079,25 +2079,30 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		data->is_unmerged = 1;
 		return;
 	}
-	if (complete_rewrite) {
+
+	if (diff_filespec_is_binary(one) || diff_filespec_is_binary(two)) {
+		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
+			die("unable to read files to diff");
+		data->is_binary = 1;
+		data->added = mf2.size;
+		data->deleted = mf1.size;
+	}
+
+	else if (complete_rewrite) {
 		diff_populate_filespec(one, 0);
 		diff_populate_filespec(two, 0);
 		data->deleted = count_lines(one->data, one->size);
 		data->added = count_lines(two->data, two->size);
-		goto free_and_return;
 	}
-	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
-		die("unable to read files to diff");
 
-	if (diff_filespec_is_binary(one) || diff_filespec_is_binary(two)) {
-		data->is_binary = 1;
-		data->added = mf2.size;
-		data->deleted = mf1.size;
-	} else {
+	else {
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
 
+		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
+			die("unable to read files to diff");
+
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = o->xdl_opts;
@@ -2105,7 +2110,6 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 			      &xpp, &xecfg);
 	}
 
- free_and_return:
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
 }
-- 
1.7.4.1.26.g3372c
