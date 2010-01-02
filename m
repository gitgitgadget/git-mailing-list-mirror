From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH v4 1/3] Smart-http tests: Improve coverage in test t5560
Date: Sat,  2 Jan 2010 13:38:05 -0800
Message-ID: <1262468287-8629-1-git-send-email-tarmigan+git@gmail.com>
References: <20100102205928.GM6914@spearce.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 22:38:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRBg6-0008GD-KI
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 22:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab0ABViT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 16:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897Ab0ABViS
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 16:38:18 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:46611 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0ABViS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 16:38:18 -0500
Received: by gxk3 with SMTP id 3so1824960gxk.1
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 13:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=63XVooTnxN04qEuWVv9Oa9h4ikWEEVXSsWP9L35GIQE=;
        b=RU0MFVjADYddzcOLUdHOGkZGTbbLzcIHeEwFywiVvcU/t5sEE7awUQU2XnquxHzFzk
         DYRjEBmyadTwLoYbMayuNOUEqTIi5ve8a6X4vyuUd9qbbppE9oyy/k7DzlX2BzRMlUEL
         ElRurbmLqru7Ict8BP12D7bjtF8v2emA77iRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=XYGt7r88eZZOn5ACZFyW4Ldz4xfl6ouxOAj3zSHmyDqgpW+icZeph1PF3cFV5gCxxF
         Nh1Ax/fkIuV5cKlswjS3VSoFQrdkkrzlTBsavwHvYZ9lk9S4uymKf+HcnEUHw+93GFtk
         N3lJ9O7hlt5u3wYX5rhVIry3L0g/cdAhm9uAY=
Received: by 10.101.126.10 with SMTP id d10mr1350476ann.96.1262468297535;
        Sat, 02 Jan 2010 13:38:17 -0800 (PST)
Received: from localhost.localdomain (c-69-181-44-199.hsd1.ca.comcast.net [69.181.44.199])
        by mx.google.com with ESMTPS id 5sm6538971yxg.10.2010.01.02.13.38.15
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 13:38:16 -0800 (PST)
X-Mailer: git-send-email 1.6.6.236.gc56f3
In-Reply-To: <20100102205928.GM6914@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136055>

Commit 34b6cb8bb ("http-backend: Protect GIT_PROJECT_ROOT from /../
requests") added the path_info helper function to test t5560 but did
not use it.  We should use it as it provides another level of error
checking.

The /etc/.../passwd case is one that is not special (and the test
fails for reasons other than being aliased), so we remove that test
case.

Also rename the function from 'path_info' to 'expect_aliased'.

Acked-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>

---
One thing to note is that
	expect_aliased 0 /repo.git/HEAD
test still does not actually test any results back from http-backend,
but that's also how it was before as well.
---
 t/t5560-http-backend.sh |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/t/t5560-http-backend.sh b/t/t5560-http-backend.sh
index 04a9896..0e4dc4b 100755
--- a/t/t5560-http-backend.sh
+++ b/t/t5560-http-backend.sh
@@ -162,15 +162,15 @@ test_expect_success 'http.receivepack false' '
 run_backend() {
 	REQUEST_METHOD=GET \
 	GIT_PROJECT_ROOT="$HTTPD_DOCUMENT_ROOT_PATH" \
-	PATH_INFO="$2" \
+	PATH_INFO="$1" \
 	git http-backend >act.out 2>act.err
 }
 
-path_info() {
+expect_aliased() {
 	if test $1 = 0; then
 		run_backend "$2"
 	else
-		test_must_fail run_backend "$2" &&
+		run_backend "$2" &&
 		echo "fatal: '$2': aliased" >exp.err &&
 		test_cmp exp.err act.err
 	fi
@@ -179,15 +179,14 @@ path_info() {
 test_expect_success 'http-backend blocks bad PATH_INFO' '
 	config http.getanyfile true &&
 
-	run_backend 0 /repo.git/HEAD &&
+	expect_aliased 0 /repo.git/HEAD &&
 
-	run_backend 1 /repo.git/../HEAD &&
-	run_backend 1 /../etc/passwd &&
-	run_backend 1 ../etc/passwd &&
-	run_backend 1 /etc//passwd &&
-	run_backend 1 /etc/./passwd &&
-	run_backend 1 /etc/.../passwd &&
-	run_backend 1 //domain/data.txt
+	expect_aliased 1 /repo.git/../HEAD &&
+	expect_aliased 1 /../etc/passwd &&
+	expect_aliased 1 ../etc/passwd &&
+	expect_aliased 1 /etc//passwd &&
+	expect_aliased 1 /etc/./passwd &&
+	expect_aliased 1 //domain/data.txt
 '
 
 cat >exp <<EOF
-- 
1.6.6.236.gc56f3
