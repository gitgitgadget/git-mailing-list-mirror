From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] completion: refactor __gitcomp related tests
Date: Mon, 22 Oct 2012 03:39:00 +0200
Message-ID: <1350869941-22485-2-git-send-email-felipe.contreras@gmail.com>
References: <1350869941-22485-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 03:39:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ6zM-00083d-S7
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 03:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760Ab2JVBjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 21:39:16 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64203 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab2JVBjP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 21:39:15 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1798769wgb.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 18:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xNgNs6kl06XVYAU6haE6HtsAx8QR6GNZJntMgb0CJs0=;
        b=mSXBnNIyk2tP9t/cSD5ifxZEOwpsD3qNeyzikPLitZzLsQs1DvtaHAdqfi8Z6G49Jy
         srZgg0ZbF9T3zx4XkvyCBpX9smg4aubmPiF7JKaosSPwEB+Co0t0wMtiuRpCc5xjwX43
         KENIX/KGIe49Pi/E2Qu2uMQ7GhWUtatvcl+3lGRUStO6Mlo1Vz0t2aAEZ8PKv7Oknq7j
         dcd8bt9GPGOg3xgZfVOkVfutiOBwB/IyczD6NUPHNkU9WW0tnWEumScsMqrlKRgRcMTH
         yZH8XQO1gyLrDShrejojV+fjnnBLrKDLvUtY1+BX7Qcn5HIy+BAijqsxHRR1+NAGZpmt
         Z6dw==
Received: by 10.216.213.152 with SMTP id a24mr4751841wep.224.1350869954122;
        Sun, 21 Oct 2012 18:39:14 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id b7sm48611637wiz.3.2012.10.21.18.39.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 18:39:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1350869941-22485-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208169>

Lots of duplicated code!

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 72 ++++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 49 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cbd0fb6..1c6952a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -72,87 +72,61 @@ test_completion_long ()
 
 newline=$'\n'
 
-test_expect_success '__gitcomp - trailing space - options' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
-	--reuse-message=Z
-	--reedit-message=Z
-	--reset-author Z
-	EOF
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
