From: Jeff King <peff@peff.net>
Subject: [PATCH 7/9] grep: respect diff attributes for binary-ness
Date: Thu, 2 Feb 2012 03:21:02 -0500
Message-ID: <20120202082102.GG6786@sigill.intra.peff.net>
References: <20120202081747.GA10271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:21:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsruq-0000sf-W2
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822Ab2BBIVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:21:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52885
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754789Ab2BBIVG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:21:06 -0500
Received: (qmail 17958 invoked by uid 107); 2 Feb 2012 08:28:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 03:28:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 03:21:02 -0500
Content-Disposition: inline
In-Reply-To: <20120202081747.GA10271@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189599>

There is currently no way for users to tell git-grep that a
particular path is or is not a binary file; instead, grep
always relies on its auto-detection (or the user specifying
"-a" to treat all binary-looking files like text).

This patch teaches git-grep to use the same attribute lookup
that is used by git-diff. We could add a new "grep" flag,
but that is unnecessarily complex and unlikely to be useful.
Despite the name, the "-diff" attribute (or "diff=foo" and
the associated diff.foo.binary config option) are really
about describing the contents of the path. It's simply
historical that diff was the only thing that cared about
these attributes in the past.

And if this simple approach turns out to be insufficient, we
still have a backwards-compatible path forward: we can add a
separate "grep" attribute, and fall back to respecting
"diff" if it is unset.

Signed-off-by: Jeff King <peff@peff.net>
---
 grep.c                 |   16 ++++++++++++++--
 grep.h                 |    1 +
 t/t7008-grep-binary.sh |   24 ++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index bb18569..a50d161 100644
--- a/grep.c
+++ b/grep.c
@@ -1024,11 +1024,11 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 
 	switch (opt->binary) {
 	case GREP_BINARY_DEFAULT:
-		if (buffer_is_binary(gs->buf, gs->size))
+		if (grep_source_is_binary(gs))
 			binary_match_only = 1;
 		break;
 	case GREP_BINARY_NOMATCH:
-		if (buffer_is_binary(gs->buf, gs->size))
+		if (grep_source_is_binary(gs))
 			return 0; /* Assume unmatch */
 		break;
 	case GREP_BINARY_TEXT:
@@ -1350,3 +1350,15 @@ void grep_source_load_driver(struct grep_source *gs)
 		gs->driver = userdiff_find_by_name("default");
 	grep_attr_unlock();
 }
+
+int grep_source_is_binary(struct grep_source *gs)
+{
+	grep_source_load_driver(gs);
+	if (gs->driver->binary != -1)
+		return gs->driver->binary;
+
+	if (!grep_source_load(gs))
+		return buffer_is_binary(gs->buf, gs->size);
+
+	return 0;
+}
diff --git a/grep.h b/grep.h
index 73b28c2..36e49d8 100644
--- a/grep.h
+++ b/grep.h
@@ -152,6 +152,7 @@ int grep_source_load(struct grep_source *gs);
 void grep_source_clear_data(struct grep_source *gs);
 void grep_source_clear(struct grep_source *gs);
 void grep_source_load_driver(struct grep_source *gs);
+int grep_source_is_binary(struct grep_source *gs);
 
 int grep_source(struct grep_opt *opt, struct grep_source *gs);
 
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 917a264..fd6410f 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -99,4 +99,28 @@ test_expect_success 'git grep y<NUL>x a' "
 	test_must_fail git grep -f f a
 "
 
+test_expect_success 'grep respects binary diff attribute' '
+	echo text >t &&
+	git add t &&
+	echo t:text >expect &&
+	git grep text t >actual &&
+	test_cmp expect actual &&
+	echo "t -diff" >.gitattributes &&
+	echo "Binary file t matches" >expect &&
+	git grep text t >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep respects not-binary diff attribute' '
+	echo binQary | q_to_nul >b &&
+	git add b &&
+	echo "Binary file b matches" >expect &&
+	git grep bin b >actual &&
+	test_cmp expect actual &&
+	echo "b diff" >.gitattributes &&
+	echo "b:binQary" >expect &&
+	git grep bin b | nul_to_q >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.9.3.gc3fce1.dirty
