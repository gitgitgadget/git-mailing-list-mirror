From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] attr.c::path_matches(): special case paths that end
 with a slash
Date: Thu, 28 Mar 2013 15:49:25 -0400
Message-ID: <20130328194924.GA21095@sigill.intra.peff.net>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <1364323171-20299-4-git-send-email-gitster@pobox.com>
 <20130326190558.GC26462@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 20:50:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULIpk-0005Aq-SJ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 20:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab3C1Ttc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 15:49:32 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43918 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab3C1Ttc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 15:49:32 -0400
Received: (qmail 29456 invoked by uid 107); 28 Mar 2013 19:51:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 15:51:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 15:49:25 -0400
Content-Disposition: inline
In-Reply-To: <20130326190558.GC26462@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219454>

On Tue, Mar 26, 2013 at 03:05:58PM -0400, Jeff King wrote:

> On Tue, Mar 26, 2013 at 11:39:30AM -0700, Junio C Hamano wrote:
> 
> > A similar adjustment for match_pathname() might be needed, but I
> > didn't look into it.
> [...]
> We do seem to use strncmp_icase through the rest of the function,
> though, which should be OK. The one exception is that we call fnmatch at
> the end. Should the allocation hack from the previous patch make its way
> into an "fnmatch_icase_bytes()" function, so we can use it here, too?
> And then when we have a more efficient solution, we can just plug it in
> there.

Hmm, yeah, there is more going on here than just that. If I add the
tests below, the first one (a wildcard) passes, because you fixed the
fnmatch code path. But the deep/ ones do not, as they should be going
through match_pathname. I expected the deep/with/wildcard one to fail
(because of the fnmatch problem I mentioned above), but not the
deep/and/slashless one, which should be using strncmp. I'll see if I can
track down the cause.

-Peff

---
diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
index 3be809c..234a615 100755
--- a/t/t5002-archive-attr-pattern.sh
+++ b/t/t5002-archive-attr-pattern.sh
@@ -32,6 +32,21 @@ test_expect_success 'setup' '
 	git add ignored-without-slash/foo &&
 	echo ignored-without-slash export-ignore >>.git/info/attributes &&
 
+	mkdir -p wildcard-without-slash &&
+	echo "ignored without slash" >wildcard-without-slash/foo &&
+	git add wildcard-without-slash/foo &&
+	echo "wild*-without-slash export-ignore" >>.git/info/attributes &&
+
+	mkdir -p deep/and/slashless &&
+	echo "ignored without slash" >deep/and/slashless/foo &&
+	git add deep/and/slashless/foo &&
+	echo deep/and/slashless export-ignore >>.git/info/attributes &&
+
+	mkdir -p deep/with/wildcard &&
+	echo "ignored without slash" >deep/with/wildcard/foo &&
+	git add deep/with/wildcard/foo &&
+	echo "deep/*t*/wildcard export-ignore" >>.git/info/attributes &&
+
 	mkdir -p one-level-lower/two-levels-lower/ignored-only-if-dir &&
 	echo ignored by ignored dir >one-level-lower/two-levels-lower/ignored-only-if-dir/ignored-by-ignored-dir &&
 	git add one-level-lower &&
@@ -55,6 +70,12 @@ test_expect_missing     archive/ignored-without-slash/foo &&
 test_expect_missing	archive/ignored-ony-if-dir/ignored-by-ignored-dir
 test_expect_missing     archive/ignored-without-slash/ &&
 test_expect_missing     archive/ignored-without-slash/foo &&
+test_expect_missing     archive/wildcard-without-slash/
+test_expect_missing     archive/wildcard-without-slash/foo &&
+test_expect_missing     archive/deep/and/slashless/ &&
+test_expect_missing     archive/deep/and/slashless/foo &&
+test_expect_missing     archive/deep/with/wildcard/ &&
+test_expect_missing     archive/deep/with/wildcard/foo &&
 test_expect_exists	archive/one-level-lower/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-only-if-dir/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-ony-if-dir/ignored-by-ignored-dir
