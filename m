From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 02/14] dir.c: git-status --ignored: don't list files in
 ignored directories
Date: Mon, 15 Apr 2013 21:06:30 +0200
Message-ID: <516C4FB6.8060703@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Apr 15 21:06:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URoje-0006nv-1S
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934877Ab3DOTGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:06:33 -0400
Received: from mail-ea0-f169.google.com ([209.85.215.169]:37736 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934232Ab3DOTGd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:06:33 -0400
Received: by mail-ea0-f169.google.com with SMTP id n15so2427553ead.28
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 12:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aXgksmvaP2TUatMyYI38PgBxIkPuUiu1iOxxwUP+H4E=;
        b=HByeoIdHlxePxXH9ZtBVh11FUmLi8zw1gZ2Qd3bh40DA0XV1ftYug0IxJJNYzOdOd0
         V/eye01B4wGMKULjdrDRxrTEojvppC1lXz/Wy7OD1kc4v4bfHW644KhyyPbA62dfAtZJ
         N76rHsXCCjWruMv93KkvhLQlmtef2UV+niaXqTRejak9G9A2F9CpWe9FcOd4JwOLOGga
         7n73O33SES5v4OsdhHxsmFBVTarlFBZPjvx8x9ADqCvxNRfEPFYKsb078tAq5flK31EK
         Pu6UfEx3tj4ilmK3v2kpvwNSxhtPH2vBKrT20qS+pGzal6bmi6SdR1/ZLIRMqiTVqpV/
         LyCA==
X-Received: by 10.14.218.66 with SMTP id j42mr64699061eep.46.1366052791936;
        Mon, 15 Apr 2013 12:06:31 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id b5sm28257739eew.16.2013.04.15.12.06.30
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 12:06:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516C4F27.30203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221291>

'git-status --ignored' lists both the ignored directory and the ignored
files if the files are in a tracked sub directory.

When recursing into sub directories in read_directory_recursive, pass on
the check_only parameter so that we don't accidentally add the files.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c                      |  4 +---
 t/t7061-wtstatus-ignore.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index ec4eebf..7c9bc9c 100644
--- a/dir.c
+++ b/dir.c
@@ -1273,7 +1273,6 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		return path_ignored;
 	case DT_DIR:
 		strbuf_addch(path, '/');
-
 		switch (treat_directory(dir, path->buf, path->len, exclude, simplify)) {
 		case show_directory:
 			break;
@@ -1343,8 +1342,7 @@ static int read_directory_recursive(struct dir_struct *dir,
 		switch (treat_path(dir, de, &path, baselen, simplify)) {
 		case path_recurse:
 			contents += read_directory_recursive(dir, path.buf,
-							     path.len, 0,
-							     simplify);
+				path.len, check_only, simplify);
 			continue;
 		case path_ignored:
 			continue;
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 0f1034e..4ece129 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -170,4 +170,31 @@ test_expect_success 'status ignored tracked directory with uncommitted file in u
 	test_cmp expected actual
 '
 
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! tracked/
+EOF
+
+test_expect_success 'status ignored tracked directory with uncommitted file in tracked subdir with --ignore' '
+	: >tracked/ignored/committed &&
+	git add -f tracked/ignored/committed &&
+	git commit -m. &&
+	git status --porcelain --ignored >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! tracked/ignored/uncommitted
+EOF
+
+test_expect_success 'status ignored tracked directory with uncommitted file in tracked subdir with --ignore -u' '
+	git status --porcelain --ignored -u >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.1.2.8026.g2b66448.dirty
