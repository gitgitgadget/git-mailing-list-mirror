From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 2/3] tests: use __gitcompadd to simplify completion tests
Date: Sun, 14 Oct 2012 17:52:50 +0200
Message-ID: <1350229971-9343-3-git-send-email-felipe.contreras@gmail.com>
References: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER Gabor <szeder@ira.uka.de>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 17:53:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNQVA-0003ne-01
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 17:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab2JNPxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 11:53:04 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58167 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab2JNPxD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 11:53:03 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3800981wgb.1
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CwtENX6Tb928GbelODnDJkcBxFEUPyjH/l+ATApMeK4=;
        b=XtfATepcVRASz/+nrpts5oOHqbFBEcKkSSzyw4enJj0Hj/IteM8SCXXRfqQTfr1juf
         wdsiOx8W7H4wwjbdObYyw+xRFHoMhN0jD/S82L4ONBPnuloOgxsdsQRjmrMmUIMvlJDP
         pPyOIXHazHmLjWguzo87mFVcjeb9E68j5dVTKyojM0EOt0WhWaUgwj63BgfK2eVx2CUN
         8n+zXe/l/J+ntiR37E2j3QU0Y5pGY6L66XRVY1slQy+E5wX7bMokk6U7U6hqIVqelOUM
         pEjqXlf70DJFegayAKh67NHn1IrLc9msnLlKKHaZYZJMMHOUDyMpWQM0Vo92dous2Iw3
         yWUA==
Received: by 10.180.80.104 with SMTP id q8mr18006961wix.6.1350229982734;
        Sun, 14 Oct 2012 08:53:02 -0700 (PDT)
Received: from localhost (ip-109-43-0-56.web.vodafone.de. [109.43.0.56])
        by mx.google.com with ESMTPS id hv8sm9416365wib.0.2012.10.14.08.53.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 08:53:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1
In-Reply-To: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207671>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 92d7eb4..49c6eb4 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -39,19 +39,18 @@ _get_comp_words_by_ref ()
 	done
 }
 
-print_comp ()
+__gitcompadd ()
 {
-	local IFS=$'\n'
-	echo "${COMPREPLY[*]}" > out
+	compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}" > out
 }
 
 run_completion ()
 {
-	local -a COMPREPLY _words
+	local -a _words
 	local _cword
 	_words=( $1 )
 	(( _cword = ${#_words[@]} - 1 ))
-	__git_wrap__git_main && print_comp
+	__git_wrap__git_main
 }
 
 test_completion ()
@@ -70,12 +69,10 @@ test_expect_success '__gitcomp - trailing space - options' '
 	--reset-author Z
 	EOF
 	(
-		local -a COMPREPLY &&
 		cur="--re" &&
 		__gitcomp "--dry-run --reuse-message= --reedit-message=
 				--reset-author" &&
-		IFS="$newline" &&
-		echo "${COMPREPLY[*]}" > out
+		IFS="$newline"
 	) &&
 	test_cmp expected out
 '
@@ -88,12 +85,10 @@ test_expect_success '__gitcomp - trailing space - config keys' '
 	browser.Z
 	EOF
 	(
-		local -a COMPREPLY &&
 		cur="br" &&
 		__gitcomp "branch. branch.autosetupmerge
 				branch.autosetuprebase browser." &&
-		IFS="$newline" &&
-		echo "${COMPREPLY[*]}" > out
+		IFS="$newline"
 	) &&
 	test_cmp expected out
 '
@@ -104,12 +99,10 @@ test_expect_success '__gitcomp - option parameter' '
 	resolve Z
 	EOF
 	(
-		local -a COMPREPLY &&
 		cur="--strategy=re" &&
 		__gitcomp "octopus ours recursive resolve subtree
 			" "" "re" &&
-		IFS="$newline" &&
-		echo "${COMPREPLY[*]}" > out
+		IFS="$newline"
 	) &&
 	test_cmp expected out
 '
@@ -120,12 +113,10 @@ test_expect_success '__gitcomp - prefix' '
 	branch.maint.mergeoptions Z
 	EOF
 	(
-		local -a COMPREPLY &&
 		cur="branch.me" &&
 		__gitcomp "remote merge mergeoptions rebase
 			" "branch.maint." "me" &&
-		IFS="$newline" &&
-		echo "${COMPREPLY[*]}" > out
+		IFS="$newline"
 	) &&
 	test_cmp expected out
 '
@@ -136,12 +127,10 @@ test_expect_success '__gitcomp - suffix' '
 	branch.maint.Z
 	EOF
 	(
-		local -a COMPREPLY &&
 		cur="branch.me" &&
 		__gitcomp "master maint next pu
 			" "branch." "ma" "." &&
-		IFS="$newline" &&
-		echo "${COMPREPLY[*]}" > out
+		IFS="$newline"
 	) &&
 	test_cmp expected out
 '
-- 
1.7.12.1
