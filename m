From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 5/6] completion: refactor __gitcomp related tests
Date: Sun, 18 Nov 2012 11:51:56 +0100
Message-ID: <1353235917-13059-6-git-send-email-felipe.contreras@gmail.com>
References: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:52:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2Uc-00050s-4a
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620Ab2KRKwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:52:36 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38183 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab2KRKwf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:52:35 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599489bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r3TAqyVrZRqNbQ/abmwSYSpkmD48Jq2j1ORYgpmTU/I=;
        b=eRcu05uKNYc5tc/AhdmxPNgIBhtuNdvBegN2nGGJ23zmRRnjEjqci/BrhApihxzVqO
         AzUFqtyRhY46J82st5nM8mecfYOnNNNvGtSCQNzTFraadhVZmBBUU5ggSI+VrqRrMgaE
         Pj8IvKqzeh+eymF4alqXVfyi027Yq5YYi1Cyt+lpIm9Z4fgNyWyU1NBeUkBKpw5sMo5W
         isseyRrsviQAV7bVHqVY2HVzA3ip0O7253sKTCbvI4zuaYEfmkCGzHWdLEZEqE6HXBH9
         l2XRDLkj2qcQK3I0ApHzs9JWBf3SZyAGyo6VtZFDq1o6ek7JL+UlNynWBZXSP9e4HcPq
         wAZg==
Received: by 10.204.4.133 with SMTP id 5mr3899107bkr.21.1353235954317;
        Sun, 18 Nov 2012 02:52:34 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id ht18sm2897992bkc.14.2012.11.18.02.52.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:52:33 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210010>

Lots of duplicated code removed!

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 76 ++++++++++++++++++---------------------------------
 1 file changed, 27 insertions(+), 49 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 90a9a91..fba632f 100755
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
+# Test __gitcomp
+# Arguments are:
+# 1: current word (cur)
+# -: the rest are passed to __gitcomp
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
