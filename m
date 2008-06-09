From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH v2] cat-file --batch / --batch-check: do not exit if hashes are missing
Date: Mon,  9 Jun 2008 02:02:21 +0200
Message-ID: <1212969741-24899-1-git-send-email-LeWiemann@gmail.com>
References: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 02:03:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Ur5-00063f-J6
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 02:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbYFIAC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 20:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754433AbYFIAC2
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 20:02:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:32058 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323AbYFIAC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 20:02:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1335480fgg.17
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 17:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=VUhn8D9Co2pem3yT5mf+myyidZlzJGqge27LuST9bAw=;
        b=kzKxAkFQKuhHAZRAzbpQEyWXeFHDlsIN0txM8YJV6t2bW2vXkcxXNM0eXrZeO1zOYl
         rs94ZaFEkr0zFsXQjMOC38JbpEeplfNFMf5vetszbrCXvAxKSr6H5ZKBRzu5U4Hf99xj
         Ej13CXrRuAiYX8CBNjUtj7J/MiYPqJZq7YXIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=dBT1gUZC6O4rNPkFJVT+3VucxRTJxRn2J9R7s4RlarRC9aZVj+K7CJzepuKdEt4YMW
         12r/2AAYGBQELm66EopqJF7LTHU/U/uvc9p88ELXMfD8lViYtqNc7V71RIuGwH7U06rl
         dNu8b6WAO4HkdrecUzzPPRgPRu9hZsaKJeixc=
Received: by 10.86.100.19 with SMTP id x19mr3566048fgb.12.1212969745545;
        Sun, 08 Jun 2008 17:02:25 -0700 (PDT)
Received: from fly ( [91.33.232.240])
        by mx.google.com with ESMTPS id 12sm10784057fgg.0.2008.06.08.17.02.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 17:02:23 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K5Uq5-0006U1-RO; Mon, 09 Jun 2008 02:02:21 +0200
X-Mailer: git-send-email 1.5.6.rc1.21.gc5a36.dirty
In-Reply-To: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84348>

Previously, cat-file --batch / --batch-check would silently exit if it
was passed a non-existent SHA1 on stdin.  Now it prints "<SHA1>
missing" as in all other cases (and as advertised in the
documentation).

Note that cat-file --batch-check (but not --batch) will still output
"error: unable to find <SHA1>" on stderr if a non-existent SHA1 is
passed, but this does not affect parsing its stdout.

Also, type <= 0 was previously using the potentially uninitialized
type variable (relying on it being 0); it is now being initialized.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Changed since v1: initialize type variable, and add a test case that
has a good chance of catching this.

 builtin-cat-file.c  |    9 ++++++---
 t/t1006-cat-file.sh |   24 +++++++++++++++++++++---
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index f8b3160..bd343ef 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -150,7 +150,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 static int batch_one_object(const char *obj_name, int print_contents)
 {
 	unsigned char sha1[20];
-	enum object_type type;
+	enum object_type type = 0;
 	unsigned long size;
 	void *contents = contents;
 
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
index 973aef7..542b4ae 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -174,9 +174,27 @@ do
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
+'
+
+test_expect_success "--batch for an existent and a non-existent hash" '
+    test "$tag_sha1 tag $tag_size
+$tag_content
+0000000000000000000000000000000000000000 missing" = \
+    "$(( echo $tag_sha1;
+         echo_without_newline 0000000000000000000000000000000000000000; ) \
+       | git cat-file --batch)"
 '
 
 test_expect_success "--batch-check for an emtpy line" '
-- 
1.5.6.rc1.21.gc5a36.dirty
