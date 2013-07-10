From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC/PATCH 3/4] t4203: test mailmap functionality directly rather than indirectly
Date: Wed, 10 Jul 2013 15:04:00 -0400
Message-ID: <1373483041-27901-4-git-send-email-sunshine@sunshineco.com>
References: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 21:05:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwzhU-0007B8-Lf
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 21:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab3GJTFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 15:05:09 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:60263 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab3GJTFH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 15:05:07 -0400
Received: by mail-yh0-f49.google.com with SMTP id v1so2876226yhn.22
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=E2wj/liaxKysmQyJnbNyIma3OdtqE+FAvzGP98N4zTo=;
        b=RdmxtXOqVJE5c7hRM9ZW25eTpix9qq+H0h7A+/bkEm9kFExXXVVMI4sXHKtBbIfQh+
         649jtk84WgqsCLoYw8j4Ku9YltjJW+gXLR60IKxOFOAIhIFlrHOPryfoHVxIajPFT0Qw
         W6t7vTbAmag95i5eXXKyoEEwiGVMS8tD8G0FZI2OTg8lnp6m9eHGLQWkRWX17HK/KSQm
         zr4clj5+jScrslCmDk9sif+wCv138l++tU+2RI2dhtSsXHWVuHFc6yVl/2I3z/ldPn99
         xA8RDK/QTXFYepxNuT/wUTztIECzFFHh8ivuD6xc3KzG3Vuhkxz8b4mI9xqIXOgcS4o4
         d94g==
X-Received: by 10.236.231.46 with SMTP id k44mr18834899yhq.37.1373483106308;
        Wed, 10 Jul 2013 12:05:06 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id 66sm54426527yhe.20.2013.07.10.12.05.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jul 2013 12:05:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230066>

With the introduction of check-mailmap, it is now possible to check
.mailmap functionality directly rather than indirectly as a side-effect
of other commands (such as git-shortlog), therefore, do so.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4203-mailmap.sh | 133 ++++++++++++++++++-----------------------------------
 1 file changed, 45 insertions(+), 88 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 8645492..48a000b 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -74,128 +74,96 @@ test_expect_success 'check-mailmap bogus contact' '
 '
 
 cat >expect <<\EOF
-A U Thor (1):
-      initial
-
-nick1 (1):
-      second
-
+A U Thor <author@example.com>
+nick1 <bugs@company.xx>
 EOF
 
 test_expect_success 'No mailmap' '
-	git shortlog HEAD >actual &&
+	git check-mailmap --stdin <contacts >actual &&
 	test_cmp expect actual
 '
 
 cat >expect <<\EOF
-Repo Guy (1):
-      initial
-
-nick1 (1):
-      second
-
+Repo Guy <author@example.com>
+nick1 <bugs@company.xx>
 EOF
 
 test_expect_success 'default .mailmap' '
 	echo "Repo Guy <author@example.com>" > .mailmap &&
-	git shortlog HEAD >actual &&
+	git check-mailmap --stdin <contacts >actual &&
 	test_cmp expect actual
 '
 
 # Using a mailmap file in a subdirectory of the repo here, but
 # could just as well have been a file outside of the repository
 cat >expect <<\EOF
-Internal Guy (1):
-      second
-
-Repo Guy (1):
-      initial
-
+Repo Guy <author@example.com>
+Internal Guy <bugs@company.xx>
 EOF
 test_expect_success 'mailmap.file set' '
 	mkdir -p internal_mailmap &&
 	echo "Internal Guy <bugs@company.xx>" > internal_mailmap/.mailmap &&
 	git config mailmap.file internal_mailmap/.mailmap &&
-	git shortlog HEAD >actual &&
+	git check-mailmap --stdin <contacts >actual &&
 	test_cmp expect actual
 '
 
 cat >expect <<\EOF
-External Guy (1):
-      initial
-
-Internal Guy (1):
-      second
-
+External Guy <author@example.com>
+Internal Guy <bugs@company.xx>
 EOF
 test_expect_success 'mailmap.file override' '
 	echo "External Guy <author@example.com>" >> internal_mailmap/.mailmap &&
 	git config mailmap.file internal_mailmap/.mailmap &&
-	git shortlog HEAD >actual &&
+	git check-mailmap --stdin <contacts >actual &&
 	test_cmp expect actual
 '
 
 cat >expect <<\EOF
-Repo Guy (1):
-      initial
-
-nick1 (1):
-      second
-
+Repo Guy <author@example.com>
+nick1 <bugs@company.xx>
 EOF
 
 test_expect_success 'mailmap.file non-existent' '
 	rm internal_mailmap/.mailmap &&
 	rmdir internal_mailmap &&
-	git shortlog HEAD >actual &&
+	git check-mailmap --stdin <contacts >actual &&
 	test_cmp expect actual
 '
 
 cat >expect <<\EOF
-Internal Guy (1):
-      second
-
-Repo Guy (1):
-      initial
-
+Repo Guy <author@example.com>
+Internal Guy <bugs@company.xy>
 EOF
 
 test_expect_success 'name entry after email entry' '
 	mkdir -p internal_mailmap &&
 	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
 	echo "Internal Guy <bugs@company.xx>" >>internal_mailmap/.mailmap &&
-	git shortlog HEAD >actual &&
+	git check-mailmap --stdin <contacts >actual &&
 	test_cmp expect actual
 '
 
 cat >expect <<\EOF
-Internal Guy (1):
-      second
-
-Repo Guy (1):
-      initial
-
+Repo Guy <author@example.com>
+Internal Guy <bugs@company.xy>
 EOF
 
 test_expect_success 'name entry after email entry, case-insensitive' '
 	mkdir -p internal_mailmap &&
 	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
 	echo "Internal Guy <BUGS@Company.xx>" >>internal_mailmap/.mailmap &&
-	git shortlog HEAD >actual &&
+	git check-mailmap --stdin <contacts >actual &&
 	test_cmp expect actual
 '
 
 cat >expect <<\EOF
-A U Thor (1):
-      initial
-
-nick1 (1):
-      second
-
+A U Thor <author@example.com>
+nick1 <bugs@company.xx>
 EOF
 test_expect_success 'No mailmap files, but configured' '
 	rm -f .mailmap internal_mailmap/.mailmap &&
-	git shortlog HEAD >actual &&
+	git check-mailmap --stdin <contacts >actual &&
 	test_cmp expect actual
 '
 
@@ -217,54 +185,43 @@ test_expect_success 'setup mailmap blob tests' '
 
 test_expect_success 'mailmap.blob set' '
 	cat >expect <<-\EOF &&
-	Blob Guy (1):
-	      second
-
-	Repo Guy (1):
-	      initial
-
+	Repo Guy <author@example.com>
+	Blob Guy <bugs@company.xx>
 	EOF
-	git -c mailmap.blob=map:just-bugs shortlog HEAD >actual &&
+	git -c mailmap.blob=map:just-bugs check-mailmap --stdin \
+		<contacts >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'mailmap.blob overrides .mailmap' '
 	cat >expect <<-\EOF &&
-	Blob Guy (2):
-	      initial
-	      second
-
+	Blob Guy <author@example.com>
+	Blob Guy <bugs@company.xx>
 	EOF
-	git -c mailmap.blob=map:both shortlog HEAD >actual &&
+	git -c mailmap.blob=map:both check-mailmap --stdin \
+		<contacts  >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'mailmap.file overrides mailmap.blob' '
 	cat >expect <<-\EOF &&
-	Blob Guy (1):
-	      second
-
-	Internal Guy (1):
-	      initial
-
+	Internal Guy <author@example.com>
+	Blob Guy <bugs@company.xx>
 	EOF
 	git \
 	  -c mailmap.blob=map:both \
 	  -c mailmap.file=internal.map \
-	  shortlog HEAD >actual &&
+	  check-mailmap --stdin <contacts >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'mailmap.blob can be missing' '
 	cat >expect <<-\EOF &&
-	Repo Guy (1):
-	      initial
-
-	nick1 (1):
-	      second
-
+	Repo Guy <author@example.com>
+	nick1 <bugs@company.xx>
 	EOF
-	git -c mailmap.blob=map:nonexistent shortlog HEAD >actual &&
+	git -c mailmap.blob=map:nonexistent check-mailmap --stdin \
+		<contacts >actual &&
 	test_cmp expect actual
 '
 
@@ -273,12 +230,12 @@ test_expect_success 'mailmap.blob defaults to off in non-bare repo' '
 	(
 		cd non-bare &&
 		test_commit one .mailmap "Fake Name <author@example.com>" &&
-		echo "     1	Fake Name" >expect &&
-		git shortlog -ns HEAD >actual &&
+		echo "Fake Name <author@example.com>" >expect &&
+		git check-mailmap "A U Thor <author@example.com>" >actual &&
 		test_cmp expect actual &&
 		rm .mailmap &&
-		echo "     1	A U Thor" >expect &&
-		git shortlog -ns HEAD >actual &&
+		echo "A U Thor <author@example.com>" >expect &&
+		git check-mailmap "A U Thor <author@example.com>" >actual &&
 		test_cmp expect actual
 	)
 '
@@ -287,8 +244,8 @@ test_expect_success 'mailmap.blob defaults to HEAD:.mailmap in bare repo' '
 	git clone --bare non-bare bare &&
 	(
 		cd bare &&
-		echo "     1	Fake Name" >expect &&
-		git shortlog -ns HEAD >actual &&
+		echo "Fake Name <author@example.com>" >expect &&
+		git check-mailmap "A U Thor <author@example.com>" >actual &&
 		test_cmp expect actual
 	)
 '
-- 
1.8.3.2
