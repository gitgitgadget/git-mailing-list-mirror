From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] cat-file --batch / --batch-check: do not exit if hashes are missing
Date: Mon,  9 Jun 2008 01:28:37 +0200
Message-ID: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 01:29:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5UKN-0000Yv-S6
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 01:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756052AbYFHX2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 19:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756048AbYFHX2n
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 19:28:43 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:45293 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044AbYFHX2m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 19:28:42 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1343874mue.1
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 16:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:from;
        bh=gbjyM1KVh07BSatLJ6dYnie6gcYl5Bz6JRCI5jYSv14=;
        b=SLrSIDiTxNgb2cIQQ/ls7ufSk3Z8tEIMGIr0JeEpHAmioBwtk9BRPx5GVrwV1tOBAe
         WnBG3QUbbxvnyrxjE1iWVsH2ikoxfJAWPcycpI8Z6wNYr8D/1IQya/ZdgQWUNzDp/qwz
         0Iyti7uvZJ3OPHDB5Umvw7rZSZZDHGmMLxgpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=XigfzH6c2mtl6t/4le3CBHSbuKX/z/EpdfOIyRI6tRn+qUbqrmyy4ey+rwSLwJXmnv
         wSts7YB7JxetjlHFQrSu5J7KYj9ngGvZFvvSRTwPu1AbTe0NkAbEK337ajB0dc/M4KcT
         obexjnuf7aL+4FMS50TaHe9pvsw4B3IvkjyWc=
Received: by 10.103.49.12 with SMTP id b12mr1888254muk.72.1212967720777;
        Sun, 08 Jun 2008 16:28:40 -0700 (PDT)
Received: from fly ( [91.33.232.240])
        by mx.google.com with ESMTPS id s10sm14887584mue.16.2008.06.08.16.28.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 16:28:40 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K5UJS-0001Lj-2v; Mon, 09 Jun 2008 01:28:38 +0200
X-Mailer: git-send-email 1.5.6.rc1.20.g9e7c7e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84346>

Previously, cat-file --batch / --batch-check would silently exit if it
was passed a non-existent SHA1 on stdin.  Now it prints "<SHA1>
missing" as in all other cases (and as advertised in the
documentation).

Note that cat-file --batch-check (but not --batch) will still output
"error: unable to find <SHA1>" on stderr if a non-existent SHA1 is
passed, but this does not affect parsing its stdout.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
 builtin-cat-file.c  |    7 +++++--
 t/t1006-cat-file.sh |   15 ++++++++++++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index f8b3160..112b9db 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -168,8 +168,11 @@ static int batch_one_object(const char *obj_name, int print_contents)
 	else
 		type = sha1_object_info(sha1, &size);
 
-	if (type <= 0)
-		return 1;
+	if (type <= 0) {
+		printf("%s missing\n", obj_name);
+		fflush(stdout);
+		return 0;
+	}
 
 	printf("%s %s %lu\n", sha1_to_hex(sha1), typename(type), size);
 	fflush(stdout);
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 973aef7..04c3be0 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -174,9 +174,18 @@ do
     '
 done
 
-test_expect_success "--batch-check for a non-existent object" '
-    test "deadbeef missing" = \
-    "$(echo_without_newline deadbeef | git cat-file --batch-check)"
+test_expect_success "--batch-check for a non-existent named object" '
+    test "foobar42 missing
+foobar84 missing" = \
+    "$(( echo foobar42; echo_without_newline foobar84; ) | git cat-file --batch-check)"
+'
+
+test_expect_success "--batch-check for a non-existent hash" '
+    test "0000000000000000000000000000000000000042 missing
+0000000000000000000000000000000000000084 missing" = \
+    "$(( echo 0000000000000000000000000000000000000042;
+         echo_without_newline 0000000000000000000000000000000000000084; ) \
+       | git cat-file --batch-check)"
 '
 
 test_expect_success "--batch-check for an emtpy line" '
-- 
1.5.6.rc1.20.g9e7c7e.dirty
