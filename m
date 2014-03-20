From: Jeff King <peff@peff.net>
Subject: [PATCH 09/12] t0001: use test_config_global
Date: Thu, 20 Mar 2014 19:18:12 -0400
Message-ID: <20140320231812.GI8479@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:18:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmE5-0003x3-S8
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759708AbaCTXSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:18:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:43594 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759365AbaCTXSN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:18:13 -0400
Received: (qmail 28059 invoked by uid 102); 20 Mar 2014 23:18:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:18:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:18:12 -0400
Content-Disposition: inline
In-Reply-To: <20140320231159.GA7774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244611>

We hand-set several config options using :

  git config -f $HOME/.gitconfig ...

Instead, we can use "test_config_global". Not only is this
more readable, but it cleans up for us so that subsequent
tests aren't polluted by our settings.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0001-init.sh | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index fdcf4b3..9515da3 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -211,9 +211,8 @@ test_expect_success 'init with --template (blank)' '
 test_expect_success 'init with init.templatedir set' '
 	mkdir templatedir-source &&
 	echo Content >templatedir-source/file &&
+	test_config_global init.templatedir "${HOME}/templatedir-source" &&
 	(
-		test_config="${HOME}/.gitconfig" &&
-		git config -f "$test_config"  init.templatedir "${HOME}/templatedir-source" &&
 		mkdir templatedir-set &&
 		cd templatedir-set &&
 		sane_unset GIT_TEMPLATE_DIR &&
@@ -225,10 +224,9 @@ test_expect_success 'init with init.templatedir set' '
 '
 
 test_expect_success 'init --bare/--shared overrides system/global config' '
+	test_config_global core.bare false &&
+	test_config_global core.sharedRepository 0640 &&
 	(
-		test_config="$HOME"/.gitconfig &&
-		git config -f "$test_config" core.bare false &&
-		git config -f "$test_config" core.sharedRepository 0640 &&
 		mkdir init-bare-shared-override &&
 		cd init-bare-shared-override &&
 		git init --bare --shared=0666
@@ -239,9 +237,8 @@ test_expect_success 'init --bare/--shared overrides system/global config' '
 '
 
 test_expect_success 'init honors global core.sharedRepository' '
+	test_config_global core.sharedRepository 0666 &&
 	(
-		test_config="$HOME"/.gitconfig &&
-		git config -f "$test_config" core.sharedRepository 0666 &&
 		mkdir shared-honor-global &&
 		cd shared-honor-global &&
 		git init
-- 
1.9.0.560.g01ceb46
