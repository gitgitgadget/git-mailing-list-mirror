From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] t7502: test early quit from commit with bad ident
Date: Thu, 26 Jul 2012 16:32:50 -0400
Message-ID: <20120726203250.GF16048@sigill.intra.peff.net>
References: <20120726202644.GA15043@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 22:33:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuUjy-0007hQ-2P
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 22:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456Ab2GZUcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 16:32:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37611 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678Ab2GZUcw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 16:32:52 -0400
Received: (qmail 13446 invoked by uid 107); 26 Jul 2012 20:32:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 16:32:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 16:32:50 -0400
Content-Disposition: inline
In-Reply-To: <20120726202644.GA15043@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202308>

In commit f20f387, "git commit" notices and dies much
earlier when we have a bogus commit identity. That commit
did not add a test because we cannot do so reliably (namely,
we can only trigger the behavior on a system where the
automatically generated identity is bogus). However, now
that we have a prerequisite check for this feature, we can
add a test that will at least run on systems that produce
such a bogus identity.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7502-commit.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index c444812..deb187e 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -248,6 +248,8 @@ test_expect_success 'setup auto-ident prerequisite' '
 	    sane_unset GIT_COMMITTER_NAME &&
 	    git var GIT_COMMITTER_IDENT); then
 		test_set_prereq AUTOIDENT
+	else
+		test_set_prereq NOAUTOIDENT
 	fi
 '
 
@@ -269,6 +271,21 @@ echo editor started > "$(pwd)/.git/result"
 exit 0
 EOF
 
+test_expect_success NOAUTOIDENT 'do not fire editor when committer is bogus' '
+	>.git/result
+	>expect &&
+
+	echo >>negative &&
+	(
+		sane_unset GIT_COMMITTER_EMAIL &&
+		sane_unset GIT_COMMITTER_NAME &&
+		GIT_EDITOR="\"$(pwd)/.git/FAKE_EDITOR\"" &&
+		export GIT_EDITOR &&
+		test_must_fail git commit -e -m sample -a
+	) &&
+	test_cmp expect .git/result
+'
+
 test_expect_success 'do not fire editor in the presence of conflicts' '
 
 	git clean -f &&
-- 
1.7.11.3.8.ge78f547
