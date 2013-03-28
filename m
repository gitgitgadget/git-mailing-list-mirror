From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] t: check that a pattern without trailing slash matches a
 directory
Date: Thu, 28 Mar 2013 17:50:04 -0400
Message-ID: <20130328215004.GF10936@sigill.intra.peff.net>
References: <20130328214358.GA10685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 22:50:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULKiZ-0005Z2-1z
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 22:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096Ab3C1VuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 17:50:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44074 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927Ab3C1VuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 17:50:11 -0400
Received: (qmail 30819 invoked by uid 107); 28 Mar 2013 21:51:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 17:51:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 17:50:04 -0400
Content-Disposition: inline
In-Reply-To: <20130328214358.GA10685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219468>

Prior to v1.8.1.1, with:

  git init
  echo content >foo &&
  mkdir subdir &&
  echo content >subdir/bar &&
  echo "subdir export-ignore" >.gitattributes
  git add . &&
  git commit -m one &&
  git archive HEAD | tar tf -

the resulting archive would contain only "foo" and
".gitattributes", not subdir.  This was broken with a recent
change that intended to allow "subdir/ export-ignore" to
also exclude the directory, but instead ended up _requiring_
the trailing slash by mistake.

A pattern "subdir" should match any path "subdir", whether it is a
directory or a non-diretory.  A pattern "subdir/" insists that a
path "subdir" must be a directory for it to match.

This patch adds test not just for this simple case, but also
for deeper cross-directory cases, as well as cases with
wildcards.

Signed-off-by: Jeff King <peff@peff.net>
---
Added new tests since v1 that handle the match_pathname code path.

 t/t5002-archive-attr-pattern.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
index 0c847fb..6667d15 100755
--- a/t/t5002-archive-attr-pattern.sh
+++ b/t/t5002-archive-attr-pattern.sh
@@ -27,6 +27,25 @@ test_expect_success 'setup' '
 	echo ignored-only-if-dir/ export-ignore >>.git/info/attributes &&
 	git add ignored-only-if-dir &&
 
+	mkdir -p ignored-without-slash &&
+	echo "ignored without slash" >ignored-without-slash/foo &&
+	git add ignored-without-slash/foo &&
+	echo "ignored-without-slash export-ignore" >>.git/info/attributes &&
+
+	mkdir -p wildcard-without-slash &&
+	echo "ignored without slash" >wildcard-without-slash/foo &&
+	git add wildcard-without-slash/foo &&
+	echo "wild*-without-slash export-ignore" >>.git/info/attributes &&
+
+	mkdir -p deep/and/slashless &&
+	echo "ignored without slash" >deep/and/slashless/foo &&
+	git add deep/and/slashless/foo &&
+	echo "deep/and/slashless export-ignore" >>.git/info/attributes &&
+
+	mkdir -p deep/with/wildcard &&
+	echo "ignored without slash" >deep/with/wildcard/foo &&
+	git add deep/with/wildcard/foo &&
+	echo "deep/*t*/wildcard export-ignore" >>.git/info/attributes &&
 
 	mkdir -p one-level-lower/two-levels-lower/ignored-only-if-dir &&
 	echo ignored by ignored dir >one-level-lower/two-levels-lower/ignored-only-if-dir/ignored-by-ignored-dir &&
@@ -49,6 +68,14 @@ test_expect_missing	archive/ignored-ony-if-dir/ignored-by-ignored-dir
 test_expect_exists	archive/not-ignored-dir/
 test_expect_missing	archive/ignored-only-if-dir/
 test_expect_missing	archive/ignored-ony-if-dir/ignored-by-ignored-dir
+test_expect_missing	archive/ignored-without-slash/ &&
+test_expect_missing	archive/ignored-without-slash/foo &&
+test_expect_missing	archive/wildcard-without-slash/
+test_expect_missing	archive/wildcard-without-slash/foo &&
+test_expect_missing	archive/deep/and/slashless/ &&
+test_expect_missing	archive/deep/and/slashless/foo &&
+test_expect_missing	archive/deep/with/wildcard/ &&
+test_expect_missing	archive/deep/with/wildcard/foo &&
 test_expect_exists	archive/one-level-lower/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-only-if-dir/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-ony-if-dir/ignored-by-ignored-dir
-- 
1.8.2.13.g0f18d3c
