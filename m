From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/4] t4203: test mailmap functionality directly rather than indirectly
Date: Thu, 11 Jul 2013 10:55:27 -0400
Message-ID: <1373554528-15775-4-git-send-email-sunshine@sunshineco.com>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 11 16:56:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxIIJ-0000E8-9D
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 16:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556Ab3GKO4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 10:56:19 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:53334 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932497Ab3GKO4R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 10:56:17 -0400
Received: by mail-yh0-f52.google.com with SMTP id f10so3242259yha.39
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=E2wj/liaxKysmQyJnbNyIma3OdtqE+FAvzGP98N4zTo=;
        b=YwwweXnz/itN2+0nXSAnzh1yd0uP31abgrWBcuLKl8sfCec46Ma7VATwHWqYX728hw
         8wA1CTKZerdR57Yya3bVcsupP/h+M3B6RhjSyjoDk3b2FA4P0onA4D0gTltl6JfgyZEB
         32xPDOwGA0NRdBSzARc2VM9V7R5g52/PO96OsAQCHi6AXCkmcJTQ/5ImAAiPhn8Zz7Aj
         6lf5lZvX3MeULL+A9VrMdKInP5iuag1uqZo4VLzPVV7PLMQ+TQdPYX7EbSxij4issAjo
         Tv9LRNYDp0/KvEmTM/K2ULkFMqq/fLEV1yI/YHu4uX5KNlb716uNaqxrNznTscvr5g0v
         lhqQ==
X-Received: by 10.236.114.102 with SMTP id b66mr14105113yhh.6.1373554576351;
        Thu, 11 Jul 2013 07:56:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id s29sm60841065yhf.6.2013.07.11.07.56.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 07:56:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230104>

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
