From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 03/14] dir.c: git-status --ignored: don't list empty ignored
 directories
Date: Mon, 15 Apr 2013 21:07:16 +0200
Message-ID: <516C4FE4.9090806@gmail.com>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 15 21:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URokN-0007lH-PU
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934897Ab3DOTHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:07:19 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:48331 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934232Ab3DOTHS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:07:18 -0400
Received: by mail-ee0-f44.google.com with SMTP id c41so2466620eek.3
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=gAv9TQ22KU3l4kEOpFK8ZKmRb/vWtpPHxNYeQwuTRek=;
        b=yvHF1+qCjmKZKxr4tawuVMRP2VgQ8cWIU/YkiowGPkKE51bg65/xTsqF8PAa2KBaro
         nN4bH9r0RNmue5CM3Pndx2Q6e+JgBwDuPpiDRTv7NzFOrlRB5gitO4lQd6pDsyaTsfik
         KeNRn1723w/SAhbxy4gEMsy2vSellIhAmnJ+Q991NzZRs3GS0zWKcywoYErf7dye1ELd
         F85K2E4wOCCAmopMfb8XVD5tbA7AD41uNBfVjPOKUV181/nYrPOcwAQnQcAbRHVQfP3a
         REuGoAJSGuuZHMPgYXD1jJ4HnAZdftRZiJwMrhkkLcrTChWUGvKk32W2qUxMLBzeAJLL
         yx+A==
X-Received: by 10.15.102.3 with SMTP id bq3mr65328923eeb.42.1366052836756;
        Mon, 15 Apr 2013 12:07:16 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id b47sm8809929eez.2.2013.04.15.12.07.15
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 12:07:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516C4F27.30203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221292>

'git-status --ignored' lists ignored tracked directories without any
ignored files if a tracked file happens to match an exclude pattern.

Always exclude tracked files.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c                      | 11 ++++-------
 t/t7061-wtstatus-ignore.sh | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index 7c9bc9c..fd1f088 100644
--- a/dir.c
+++ b/dir.c
@@ -1109,16 +1109,13 @@ static int treat_file(struct dir_struct *dir, struct strbuf *path, int exclude,
 	struct path_exclude_check check;
 	int exclude_file = 0;
 
+	/* Always exclude indexed files */
+	if (index_name_exists(&the_index, path->buf, path->len, ignore_case))
+		return 1;
+
 	if (exclude)
 		exclude_file = !(dir->flags & DIR_SHOW_IGNORED);
 	else if (dir->flags & DIR_SHOW_IGNORED) {
-		/* Always exclude indexed files */
-		struct cache_entry *ce = index_name_exists(&the_index,
-		    path->buf, path->len, ignore_case);
-
-		if (ce)
-			return 1;
-
 		path_exclude_check_init(&check, dir);
 
 		if (!is_path_excluded(&check, path->buf, path->len, dtype))
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 4ece129..28b7d95 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -122,10 +122,34 @@ cat >expected <<\EOF
 ?? .gitignore
 ?? actual
 ?? expected
+EOF
+
+test_expect_success 'status ignored tracked directory and ignored file with --ignore' '
+	echo "committed" >>.gitignore &&
+	git status --porcelain --ignored >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+EOF
+
+test_expect_success 'status ignored tracked directory and ignored file with --ignore -u' '
+	git status --porcelain --ignored -u >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
 !! tracked/
 EOF
 
 test_expect_success 'status ignored tracked directory and uncommitted file with --ignore' '
+	echo "tracked" >.gitignore &&
 	: >tracked/uncommitted &&
 	git status --porcelain --ignored >actual &&
 	test_cmp expected actual
-- 
1.8.1.2.8026.g2b66448.dirty
