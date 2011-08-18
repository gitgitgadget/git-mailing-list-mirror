From: Jeff King <peff@peff.net>
Subject: [PATCH 11/10] support pager.* for aliases
Date: Thu, 18 Aug 2011 14:59:10 -0700
Message-ID: <20110818215909.GA7799@sigill.intra.peff.net>
References: <20110818215820.GA7767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 23:59:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuAcT-0001qc-3c
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 23:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab1HRV7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 17:59:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46363
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781Ab1HRV7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 17:59:14 -0400
Received: (qmail 25428 invoked by uid 107); 18 Aug 2011 21:59:54 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 17:59:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2011 14:59:10 -0700
Content-Disposition: inline
In-Reply-To: <20110818215820.GA7767@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179632>

Until this patch, doing something like:

  git config alias.foo log
  git config pager.foo /some/specific/pager

would not respect pager.foo at all. With this patch, we
will use pager.foo for the "foo" alias.  We will also
fallback to pager.log if "foo" is a non-shell alias that
uses the "log" command (but any pager.foo overrides
pager.log).

Signed-off-by: Jeff King <peff@peff.net>
---
 git.c            |    3 +++
 t/t7006-pager.sh |   31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 8828c18..375e9b2 100644
--- a/git.c
+++ b/git.c
@@ -180,6 +180,9 @@ static int handle_alias(int *argcp, const char ***argv)
 	alias_command = (*argv)[0];
 	alias_string = alias_lookup(alias_command);
 	if (alias_string) {
+		if (use_pager == -1)
+			use_pager = check_pager_config(alias_command);
+
 		if (alias_string[0] == '!') {
 			const char **alias_argv;
 			int argc = *argcp, i;
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 4582336..a8c6e85 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -450,4 +450,35 @@ test_expect_success TTY 'command-specific pager overridden by environment' '
 	test_cmp expect actual
 '
 
+test_expect_success TTY 'command-specific pager works for aliases' '
+	sane_unset PAGER GIT_PAGER &&
+	echo "foo:initial" >expect &&
+	>actual &&
+	test_config alias.aliaslog "log --format=%s" &&
+	test_config pager.aliaslog "sed s/^/foo:/ >actual" &&
+	test_terminal git aliaslog -1 &&
+	test_cmp expect actual
+'
+
+test_expect_success TTY 'non-shell alias falls back to command pager config' '
+	sane_unset PAGER GIT_PAGER &&
+	echo "foo:initial" >expect &&
+	>actual &&
+	test_config alias.aliaslog "log --format=%s" &&
+	test_config pager.log "sed s/^/foo:/ >actual" &&
+	test_terminal git aliaslog -1 &&
+	test_cmp expect actual
+'
+
+test_expect_success TTY 'alias-specific pager can override aliased command' '
+	sane_unset PAGER GIT_PAGER &&
+	>expect &&
+	>actual &&
+	test_config alias.aliaslog "log --format=%s" &&
+	test_config pager.log "sed s/^/log:/ >actual" &&
+	test_config pager.aliaslog false &&
+	test_terminal git aliaslog -1 &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.6.10.g62f04
