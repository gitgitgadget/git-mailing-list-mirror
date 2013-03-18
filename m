From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 1/8] dir.c: git-status --ignored: don't drop ignored directories
Date: Mon, 18 Mar 2013 21:28:29 +0100
Message-ID: <514778ED.5090204@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Mar 18 21:29:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHgfz-0001lU-W1
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 21:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab3CRU2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 16:28:32 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:45800 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab3CRU2b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 16:28:31 -0400
Received: by mail-ee0-f47.google.com with SMTP id e52so2760506eek.34
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=II5lak0OMW0i2YSVWjrd95TRrGWQBmvZSzcnxOJvASI=;
        b=tKDXR+Nv3hla+19Jb1DUz3Hdr20/LlyUsLmu2tJEySBsgWRIqaSMXrm6F5tQ6LTuM5
         7a4KsDUaP5kX39hNZrQIqn1nUtzpNfGiPf5SujVv38wORkvjaKOxGrl8quL8ImBxj5Yg
         yxFGCcP6cx6YKXUsyc9GWBlHPvR6zL41qxujRDPl/0ojFTVzYxEatb3rOdjPT1+sjc0C
         IedQ15v6TBwyofPxh7DIE2eROUl0RLDTlniJDJGP9j64m6u0cYEXJzfekp3qe3TcEwOH
         KVqG7Un0yoRewouNkcyQoD76SCvOP0fSkQs2UwIrwLyh7ys7kAG1U3YcazLqlMfL0WDI
         ZLHw==
X-Received: by 10.14.179.5 with SMTP id g5mr52719634eem.41.1363638510365;
        Mon, 18 Mar 2013 13:28:30 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id r4sm29262366eeo.12.2013.03.18.13.28.28
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 13:28:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <514775FA.9080304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218441>

'git-status --ignored' drops ignored directories if they contain untracked
files in an untracked sub directory.

Fix it by getting exact (recursive) excluded status in treat_directory.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c                      |  9 +++++++++
 t/t7061-wtstatus-ignore.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/dir.c b/dir.c
index 57394e4..ec4eebf 100644
--- a/dir.c
+++ b/dir.c
@@ -1060,6 +1060,15 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 
 	/* This is the "show_other_directories" case */
 
+	/* might be a sub directory in an excluded directory */
+	if (!exclude) {
+		struct path_exclude_check check;
+		int dt = DT_DIR;
+		path_exclude_check_init(&check, dir);
+		exclude = is_path_excluded(&check, dirname, len, &dt);
+		path_exclude_check_clear(&check);
+	}
+
 	/*
 	 * We are looking for ignored files and our directory is not ignored,
 	 * check if it contains only ignored files
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 0da1214..0f1034e 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -143,4 +143,31 @@ test_expect_success 'status ignored tracked directory and uncommitted file with
 	test_cmp expected actual
 '
 
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! tracked/
+EOF
+
+test_expect_success 'status ignored tracked directory with uncommitted file in untracked subdir with --ignore' '
+	rm -rf tracked/uncommitted &&
+	mkdir tracked/ignored &&
+	: >tracked/ignored/uncommitted &&
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
+test_expect_success 'status ignored tracked directory with uncommitted file in untracked subdir with --ignore -u' '
+	git status --porcelain --ignored -u >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.1.2.8021.g7e51819
