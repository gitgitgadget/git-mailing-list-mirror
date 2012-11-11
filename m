From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/6] completion: refactor __gitcomp related tests
Date: Sun, 11 Nov 2012 15:35:57 +0100
Message-ID: <1352644558-9410-6-git-send-email-felipe.contreras@gmail.com>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:36:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYeZ-00065I-Ob
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126Ab2KKOge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:36:34 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41620 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066Ab2KKOgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:36:33 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2066470bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dwI2B69VGAOwOUjIXzPdWzHxd7JolabHXgI5KlkrY4Y=;
        b=rvpeidYUEzQmbG0b9r/j1pYJvIxIMYMZejaY50rLAkcgz4sVwmRG0yhFhPO7QcEzDM
         G2Mqh1u8S2TUc9tlGRTipbfVkAlomiKWL/4mOYiONVlsi/OyXVLtG/CeaERkyA1f0PFX
         dz6k1pouMn5GV2E4lLnUX1rBCqtZ45eRN3b9gZyQz+lybtAB3KsQIQeyRlhUuxPxTR16
         K88Ph9oqm8YQ24ZWSIP6E/NtkJuLZu8uUP24f6lbjhhFLlYDmzfOh2gS5K/9ul33L/MY
         kMsw6DETI1yaDrkoDWI63oSl+mcxCNxujHY0P15TJChwd0GCa327zTAnTm2gZ528dSvp
         WN4g==
Received: by 10.204.148.214 with SMTP id q22mr5797357bkv.128.1352644592479;
        Sun, 11 Nov 2012 06:36:32 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id go4sm1175533bkc.15.2012.11.11.06.36.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:36:31 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209387>

Lots of duplicated code!

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 76 ++++++++++++++++++---------------------------------
 1 file changed, 27 insertions(+), 49 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 59cdbfd..66c7af6 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -71,87 +71,65 @@ test_completion ()
 
 newline=$'\n'
 
-test_expect_success '__gitcomp - trailing space - options' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
-	--reuse-message=Z
-	--reedit-message=Z
-	--reset-author Z
-	EOF
+# Test __gitcomp.
+# Arguments are:
+# 1: typed text so far (cur)
+# *: arguments to pass to __gitcomp
+test_gitcomp ()
+{
+	sed -e 's/Z$//' > expected &&
 	(
 		local -a COMPREPLY &&
-		cur="--re" &&
-		__gitcomp "--dry-run --reuse-message= --reedit-message=
-				--reset-author" &&
+		cur="$1" &&
+		shift &&
+		__gitcomp "$@" &&
 		IFS="$newline" &&
 		echo "${COMPREPLY[*]}" > out
 	) &&
 	test_cmp expected out
+}
+
+test_expect_success '__gitcomp - trailing space - options' '
+	test_gitcomp "--re" "--dry-run --reuse-message= --reedit-message=
+		--reset-author" <<-EOF
+	--reuse-message=Z
+	--reedit-message=Z
+	--reset-author Z
+	EOF
 '
 
 test_expect_success '__gitcomp - trailing space - config keys' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_gitcomp "br" "branch. branch.autosetupmerge
+		branch.autosetuprebase browser." <<-\EOF
 	branch.Z
 	branch.autosetupmerge Z
 	branch.autosetuprebase Z
 	browser.Z
 	EOF
-	(
-		local -a COMPREPLY &&
-		cur="br" &&
-		__gitcomp "branch. branch.autosetupmerge
-				branch.autosetuprebase browser." &&
-		IFS="$newline" &&
-		echo "${COMPREPLY[*]}" > out
-	) &&
-	test_cmp expected out
 '
 
 test_expect_success '__gitcomp - option parameter' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_gitcomp "--strategy=re" "octopus ours recursive resolve subtree" \
+		"" "re" <<-\EOF
 	recursive Z
 	resolve Z
 	EOF
-	(
-		local -a COMPREPLY &&
-		cur="--strategy=re" &&
-		__gitcomp "octopus ours recursive resolve subtree
-			" "" "re" &&
-		IFS="$newline" &&
-		echo "${COMPREPLY[*]}" > out
-	) &&
-	test_cmp expected out
 '
 
 test_expect_success '__gitcomp - prefix' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_gitcomp "branch.me" "remote merge mergeoptions rebase" \
+		"branch.maint." "me" <<-\EOF
 	branch.maint.merge Z
 	branch.maint.mergeoptions Z
 	EOF
-	(
-		local -a COMPREPLY &&
-		cur="branch.me" &&
-		__gitcomp "remote merge mergeoptions rebase
-			" "branch.maint." "me" &&
-		IFS="$newline" &&
-		echo "${COMPREPLY[*]}" > out
-	) &&
-	test_cmp expected out
 '
 
 test_expect_success '__gitcomp - suffix' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_gitcomp "branch.me" "master maint next pu" "branch." \
+		"ma" "." <<-\EOF
 	branch.master.Z
 	branch.maint.Z
 	EOF
-	(
-		local -a COMPREPLY &&
-		cur="branch.me" &&
-		__gitcomp "master maint next pu
-			" "branch." "ma" "." &&
-		IFS="$newline" &&
-		echo "${COMPREPLY[*]}" > out
-	) &&
-	test_cmp expected out
 '
 
 test_expect_success 'basic' '
-- 
1.8.0
