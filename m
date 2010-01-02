From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH v3 RFC 1/3] Smart-http tests: Improve coverage in test t5560
Date: Sat,  2 Jan 2010 12:45:17 -0800
Message-ID: <1262465119-96115-1-git-send-email-tarmigan+git@gmail.com>
References: <905315641001021244o522ac092g7fdaaab83a2609e2@mail.gmail.com>
Cc: git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 21:46:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRArK-0001QV-JL
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 21:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654Ab0ABUpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 15:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107Ab0ABUpj
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 15:45:39 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:54594 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab0ABUph (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 15:45:37 -0500
Received: by yxe17 with SMTP id 17so12876288yxe.33
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 12:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=aT8Rf2ZHXheQVesY701wtYnHrfH1GdXHGyMk7zoj2xY=;
        b=b6yo7QoPqRfqphGil8I5qb+W2TNoO5zl6Emum2TTc+oWhTxgPPaNoTm1Sn1Ki4Hs7I
         HDkfisZCX7myaiCVyBd4g1TVJhlEZzGlxCUuetd16mBTvLeTigs4+sdvf7Cv5bS1fDHL
         h4Bl2ITAjIHGaH1L2UWGEyHzRPxBkokXFO/xc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=HQKCFoQRT4N2GIk70hvvdhOq4Adx2qApCBBnPXbYcGUw03uH6nbenbGptSp+TdkyfQ
         LqpRYaiwgyIVU9CmPOfjLkeqnZJeU4H/m+dmR5iFJrHETwZud/bbAsk26tiTOzRE+rnG
         5nrsNmLz2rUcPDJVd7Zi94ScOedqi9Ct1V7GQ=
Received: by 10.151.1.26 with SMTP id d26mr5178517ybi.241.1262465137008;
        Sat, 02 Jan 2010 12:45:37 -0800 (PST)
Received: from localhost.localdomain (c-69-181-44-199.hsd1.ca.comcast.net [69.181.44.199])
        by mx.google.com with ESMTPS id 5sm6541697yxd.35.2010.01.02.12.45.34
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 12:45:35 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <905315641001021244o522ac092g7fdaaab83a2609e2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136046>

Commit 34b6cb8bb ("http-backend: Protect GIT_PROJECT_ROOT from /../
requests") added the path_info helper function to test t5560 but did
not use it.  We should use it as it provides another level of error
checking.

The /etc/.../passwd case is one that is not special (and the test
fails for reasons other than being aliased), so we remove that test
case.

Also rename the function from 'path_info' to 'expect_aliased'.

cc: Shawn O. Pearce <spearce@spearce.org>
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
1.6.6
