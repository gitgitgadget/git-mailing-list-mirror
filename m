From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH v2 1/2] test-lib: extend test_decode_color to handle more color codes
Date: Wed, 20 Oct 2010 15:17:25 -0700
Message-ID: <1287613046-61804-1-git-send-email-kevin@sb.org>
References: <7v4ocgx2we.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Nazri Ramliy <ayiehere@gmail.com>, Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 00:18:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8gyt-0001F2-UJ
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 00:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587Ab0JTWRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 18:17:55 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53374 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065Ab0JTWRy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 18:17:54 -0400
Received: by pvh1 with SMTP id 1so114442pvh.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 15:17:54 -0700 (PDT)
Received: by 10.143.9.11 with SMTP id m11mr40814wfi.349.1287613073918;
        Wed, 20 Oct 2010 15:17:53 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id w22sm1109430wfd.7.2010.10.20.15.17.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 15:17:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.220.g19a98
In-Reply-To: <7v4ocgx2we.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159442>

Enhance the test_decode_color function to handle all common color codes,
including background colors and escapes that contain multiple codes.
This change necessitates changing <WHITE> to <BOLD>, so update t4034
as well.

This change is necessary for the next commit in order to test
background colors properly.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
I turned sed into awk. Looks like awk is already used elsehwere in git,
so I'm assuming this is safe, but please let me know if it's not.

 t/t4034-diff-words.sh |   72 ++++++++++++++++++++++++------------------------
 t/test-lib.sh         |   49 ++++++++++++++++++++++++++++-----
 2 files changed, 77 insertions(+), 44 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 6f7548c..3f3c757 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -35,10 +35,10 @@ aeff = aeff * ( aaa )
 EOF
 
 cat > expect <<\EOF
-<WHITE>diff --git a/pre b/post<RESET>
-<WHITE>index 330b04f..5ed8eff 100644<RESET>
-<WHITE>--- a/pre<RESET>
-<WHITE>+++ b/post<RESET>
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 330b04f..5ed8eff 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
 <CYAN>@@ -1,3 +1,7 @@<RESET>
 <RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
 
@@ -122,10 +122,10 @@ test_expect_success '--word-diff=plain --no-color' '
 '
 
 cat > expect <<EOF
-<WHITE>diff --git a/pre b/post<RESET>
-<WHITE>index 330b04f..5ed8eff 100644<RESET>
-<WHITE>--- a/pre<RESET>
-<WHITE>+++ b/post<RESET>
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 330b04f..5ed8eff 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
 <CYAN>@@ -1,3 +1,7 @@<RESET>
 <RED>[-h(4)-]<RESET><GREEN>{+h(4),hh[44]+}<RESET>
 
@@ -143,10 +143,10 @@ test_expect_success '--word-diff=plain --color' '
 '
 
 cat > expect <<\EOF
-<WHITE>diff --git a/pre b/post<RESET>
-<WHITE>index 330b04f..5ed8eff 100644<RESET>
-<WHITE>--- a/pre<RESET>
-<WHITE>+++ b/post<RESET>
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 330b04f..5ed8eff 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
 <CYAN>@@ -1 +1 @@<RESET>
 <RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
 <CYAN>@@ -3,0 +4,4 @@<RESET> <RESET><MAGENTA>a = b + c<RESET>
@@ -163,10 +163,10 @@ test_expect_success 'word diff without context' '
 '
 
 cat > expect <<\EOF
-<WHITE>diff --git a/pre b/post<RESET>
-<WHITE>index 330b04f..5ed8eff 100644<RESET>
-<WHITE>--- a/pre<RESET>
-<WHITE>+++ b/post<RESET>
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 330b04f..5ed8eff 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
 <CYAN>@@ -1,3 +1,7 @@<RESET>
 h(4),<GREEN>hh<RESET>[44]
 
@@ -199,10 +199,10 @@ test_expect_success 'option overrides .gitattributes' '
 '
 
 cat > expect <<\EOF
-<WHITE>diff --git a/pre b/post<RESET>
-<WHITE>index 330b04f..5ed8eff 100644<RESET>
-<WHITE>--- a/pre<RESET>
-<WHITE>+++ b/post<RESET>
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 330b04f..5ed8eff 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
 <CYAN>@@ -1,3 +1,7 @@<RESET>
 h(4)<GREEN>,hh[44]<RESET>
 
@@ -231,10 +231,10 @@ test_expect_success 'command-line overrides config' '
 '
 
 cat > expect <<\EOF
-<WHITE>diff --git a/pre b/post<RESET>
-<WHITE>index 330b04f..5ed8eff 100644<RESET>
-<WHITE>--- a/pre<RESET>
-<WHITE>+++ b/post<RESET>
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 330b04f..5ed8eff 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
 <CYAN>@@ -1,3 +1,7 @@<RESET>
 h(4),<GREEN>{+hh+}<RESET>[44]
 
@@ -260,10 +260,10 @@ test_expect_success 'remove diff driver regex' '
 '
 
 cat > expect <<\EOF
-<WHITE>diff --git a/pre b/post<RESET>
-<WHITE>index 330b04f..5ed8eff 100644<RESET>
-<WHITE>--- a/pre<RESET>
-<WHITE>+++ b/post<RESET>
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 330b04f..5ed8eff 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
 <CYAN>@@ -1,3 +1,7 @@<RESET>
 h(4),<GREEN>hh[44<RESET>]
 
@@ -282,10 +282,10 @@ echo 'aaa (aaa)' > pre
 echo 'aaa (aaa) aaa' > post
 
 cat > expect <<\EOF
-<WHITE>diff --git a/pre b/post<RESET>
-<WHITE>index c29453b..be22f37 100644<RESET>
-<WHITE>--- a/pre<RESET>
-<WHITE>+++ b/post<RESET>
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index c29453b..be22f37 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
 <CYAN>@@ -1 +1 @@<RESET>
 aaa (aaa) <GREEN>aaa<RESET>
 EOF
@@ -301,10 +301,10 @@ echo '(:' > pre
 echo '(' > post
 
 cat > expect <<\EOF
-<WHITE>diff --git a/pre b/post<RESET>
-<WHITE>index 289cb9d..2d06f37 100644<RESET>
-<WHITE>--- a/pre<RESET>
-<WHITE>+++ b/post<RESET>
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 289cb9d..2d06f37 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
 <CYAN>@@ -1 +1 @@<RESET>
 (<RED>:<RESET>
 EOF
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2af8f10..6dd3ce9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -238,14 +238,47 @@ test_set_editor () {
 }
 
 test_decode_color () {
-	sed	-e 's/.\[1m/<WHITE>/g' \
-		-e 's/.\[31m/<RED>/g' \
-		-e 's/.\[32m/<GREEN>/g' \
-		-e 's/.\[33m/<YELLOW>/g' \
-		-e 's/.\[34m/<BLUE>/g' \
-		-e 's/.\[35m/<MAGENTA>/g' \
-		-e 's/.\[36m/<CYAN>/g' \
-		-e 's/.\[m/<RESET>/g'
+	awk '
+		function name(n) {
+			if (n == 0) return "RESET";
+			if (n == 1) return "BOLD";
+			if (n == 30) return "BLACK";
+			if (n == 31) return "RED";
+			if (n == 32) return "GREEN";
+			if (n == 33) return "YELLOW";
+			if (n == 34) return "BLUE";
+			if (n == 35) return "MAGENTA";
+			if (n == 36) return "CYAN";
+			if (n == 37) return "WHITE";
+			if (n == 40) return "BLACK";
+			if (n == 41) return "BRED";
+			if (n == 42) return "BGREEN";
+			if (n == 43) return "BYELLOW";
+			if (n == 44) return "BBLUE";
+			if (n == 45) return "BMAGENTA";
+			if (n == 46) return "BCYAN";
+			if (n == 47) return "BWHITE";
+		}
+		{
+			while (match($0, /\x1b\[[0-9;]*m/) != 0) {
+				printf "%s<", substr($0, 1, RSTART-1);
+				codes = substr($0, RSTART+2, RLENGTH-3);
+				if (length(codes) == 0)
+					printf "%s", name(0)
+				else {
+					n = split(codes, ary, ";");
+					sep = "";
+					for (i = 1; i <= n; i++) {
+						printf "%s%s", sep, name(ary[i]);
+						sep = ";"
+					}
+				}
+				printf ">";
+				$0 = substr($0, RSTART + RLENGTH, length($0) - RSTART - RLENGTH + 1);
+			}
+			print
+		}
+	'
 }
 
 q_to_nul () {
-- 
1.7.3.1.220.g19a98
