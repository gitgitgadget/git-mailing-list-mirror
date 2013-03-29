From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/5] t7800: don't hide grep output
Date: Fri, 29 Mar 2013 11:28:34 +0000
Message-ID: <e6195818a21a6712098ca6042a4c05a66ecac98e.1364555970.git.john@keeping.me.uk>
References: <cover.1364555970.git.john@keeping.me.uk>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 29 12:30:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULXVS-0000hE-HG
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 12:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab3C2L3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 07:29:34 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:49999 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab3C2L3e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 07:29:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E8E4C6064FF;
	Fri, 29 Mar 2013 11:29:33 +0000 (GMT)
X-Quarantine-ID: <o9JX5O5WX9PS>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o9JX5O5WX9PS; Fri, 29 Mar 2013 11:29:32 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 4C89A606504;
	Fri, 29 Mar 2013 11:29:19 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.411.g65a544e
In-Reply-To: <cover.1364555970.git.john@keeping.me.uk>
In-Reply-To: <cover.1364555970.git.john@keeping.me.uk>
References: <cover.1364555970.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219492>

Remove the stdin_contains and stdin_doesnt_contain helper functions
which add nothing but hide the output of grep, hurting debugging.

Suggested-by: Johannes Sixt <j.sixt@viscovery.net>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t7800-difftool.sh | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 017f55a..9fd09db 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -23,16 +23,6 @@ prompt_given ()
 	test "$prompt" = "Launch 'test-tool' [Y/n]: branch"
 }
 
-stdin_contains ()
-{
-	grep >/dev/null "$1"
-}
-
-stdin_doesnot_contain ()
-{
-	! stdin_contains "$1"
-}
-
 # Create a file on master and change it on branch
 test_expect_success PERL 'setup' '
 	echo master >file &&
@@ -296,24 +286,24 @@ test_expect_success PERL 'setup with 2 files different' '
 test_expect_success PERL 'say no to the first file' '
 	(echo n && echo) >input &&
 	git difftool -x cat branch <input >output &&
-	stdin_contains m2 <output &&
-	stdin_contains br2 <output &&
-	stdin_doesnot_contain master <output &&
-	stdin_doesnot_contain branch <output
+	grep m2 output &&
+	grep br2 output &&
+	! grep master output &&
+	! grep branch output
 '
 
 test_expect_success PERL 'say no to the second file' '
 	(echo && echo n) >input &&
 	git difftool -x cat branch <input >output &&
-	stdin_contains master <output &&
-	stdin_contains branch  <output &&
-	stdin_doesnot_contain m2 <output &&
-	stdin_doesnot_contain br2 <output
+	grep master output &&
+	grep branch output &&
+	! grep m2 output &&
+	! grep br2 output
 '
 
 test_expect_success PERL 'difftool --tool-help' '
 	git difftool --tool-help >output &&
-	stdin_contains tool <output
+	grep tool output
 '
 
 test_expect_success PERL 'setup change in subdirectory' '
@@ -330,28 +320,28 @@ test_expect_success PERL 'setup change in subdirectory' '
 
 test_expect_success PERL 'difftool -d' '
 	git difftool -d --extcmd ls branch >output &&
-	stdin_contains sub <output &&
-	stdin_contains file <output
+	grep sub output &&
+	grep file output
 '
 
 test_expect_success PERL 'difftool --dir-diff' '
 	git difftool --dir-diff --extcmd ls branch >output &&
-	stdin_contains sub <output &&
-	stdin_contains file <output
+	grep sub output &&
+	grep file output
 '
 
 test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
 	git difftool --dir-diff --prompt --extcmd ls branch >output &&
-	stdin_contains sub <output &&
-	stdin_contains file <output
+	grep sub output &&
+	grep file output
 '
 
 test_expect_success PERL 'difftool --dir-diff from subdirectory' '
 	(
 		cd sub &&
 		git difftool --dir-diff --extcmd ls branch >output &&
-		stdin_contains sub <output &&
-		stdin_contains file <output
+		grep sub output &&
+		grep file output
 	)
 '
 
-- 
1.8.2.411.g65a544e
