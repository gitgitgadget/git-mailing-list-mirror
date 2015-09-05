From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/5] t7610: don't use test_config in a subshell
Date: Sat,  5 Sep 2015 14:12:45 +0100
Message-ID: <dc4119cc27db2636dfefdd9045161fe47302f780.1441458341.git.john@keeping.me.uk>
References: <20150905085429.GB25039@sigill.intra.peff.net>
 <cover.1441458341.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 15:13:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYDHR-0007wv-Sm
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 15:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbbIENNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 09:13:14 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:43528 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbbIENNH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 09:13:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 23AE7CDA5E4;
	Sat,  5 Sep 2015 14:13:07 +0100 (BST)
X-Quarantine-ID: <dwZsr13Q7EKM>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dwZsr13Q7EKM; Sat,  5 Sep 2015 14:13:06 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id CBD2BCDA567;
	Sat,  5 Sep 2015 14:12:50 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441458341.git.john@keeping.me.uk>
In-Reply-To: <cover.1441458341.git.john@keeping.me.uk>
References: <cover.1441458341.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277369>

test_config uses test_when_finished to reset the configuration after the
test, but this does not work inside a subshell.  This does not cause a
problem here because the first thing the next test does is to set this
config variable itself, but we are about to add a check that will
complain when test_when_finished is used in a subshell.

In this case, "subdir" not a submodule so test_config has the same
effect when run at the top level and can simply be moved out of the
subshell.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t7610-mergetool.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 7eeb207..6f12b23 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -174,9 +174,9 @@ test_expect_success 'mergetool skips autoresolved' '
 '
 
 test_expect_success 'mergetool merges all from subdir' '
+	test_config rerere.enabled false &&
 	(
 		cd subdir &&
-		test_config rerere.enabled false &&
 		test_must_fail git merge master &&
 		( yes "r" | git mergetool ../submod ) &&
 		( yes "d" "d" | git mergetool --no-prompt ) &&
-- 
2.5.0.466.g9af26fa
