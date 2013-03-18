From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 2/8] dir.c: git-status --ignored: don't list files in ignored
 directories
Date: Mon, 18 Mar 2013 21:28:36 +0100
Message-ID: <514778F4.3070106@gmail.com>
References: <514775FA.9080304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 21:29:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHgg5-0001pq-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 21:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284Ab3CRU2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 16:28:38 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:59367 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab3CRU2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 16:28:37 -0400
Received: by mail-ee0-f44.google.com with SMTP id l10so2868538eei.31
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ulkvGsy6Bn38WDqW+qWVFt0SZ/H1CxFugR2pCuOXOBI=;
        b=b9oJFb6krX3UX7rOqj6x8TiHWZYAQ0wlIx9PVqWT8j8yUlgZi5Ch3za0mGYOqe5nCY
         xgXs6Q8zlYmoel2+4N+Cb+ZhbN84l2WPwVgk9Rln968eV795CXmnAE2Jbi9E+Sgx1OVX
         MhTvlEYWmeoL3y62Mkaks6lgqfKQIxxSCT2nR4zQ2TDWLdGuLOJO32cC67zktlt7MBzQ
         xIiFkJfZk0euXitIwWezR20KkIrA5CnH45Srqb+MRymVCAjh54oeiFxCANujmQMyI3gd
         b2G+695M55ukQk6zDGht/cWr0kmooZ8HAS2TNGLNLTDctp3aDwBSAnrwXf7AN+rmL8fB
         HIyQ==
X-Received: by 10.14.202.71 with SMTP id c47mr52176998eeo.39.1363638516450;
        Mon, 18 Mar 2013 13:28:36 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id q5sm29288575eeo.17.2013.03.18.13.28.34
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 13:28:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <514775FA.9080304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218442>

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
1.8.1.2.8021.g7e51819
