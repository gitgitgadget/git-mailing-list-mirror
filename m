From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 01/14] dir.c: git-status --ignored: don't drop ignored
 directories
Date: Mon, 15 Apr 2013 21:05:19 +0200
Message-ID: <516C4F6F.5020708@gmail.com>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 21:05:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URoiU-0005Eh-D8
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933000Ab3DOTFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:05:22 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:58144 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab3DOTFV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:05:21 -0400
Received: by mail-ea0-f181.google.com with SMTP id z10so2291775ead.26
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=lTJ6rZWEP803qa0BnrB9WwaR3deeWCcvuwPl6s6gFVQ=;
        b=AONasi/QzeLBnVQAL9ashHCvFpv8v13z0eGq0YCZ/iCJI97W9OPmq99kthFbYyZYEO
         +mVH7jheKw66GI8zP+5e6ynB+aWH2oP0RKp6OEHrGz7wY+dEch/uHvrrE/LX4xvHmxuN
         zUQf4GbRhYuZTYnvog39lKsYtaORIoRk21UWS7CGaT1wqjAzQyWaGqiLRv3HmENgAzsR
         CNmFrl/I6u/o58hEw81P55Q6wOsC01/ddXwDAZwetBYFFBG0Cf1vrA+U3fUcJFBxO5DT
         Wb/HHOVPLlLtawBSACFwmPBZs4ABiPAVJkiVwz8J1FrQBtOKvYIhOa9tD6yRI6Pe3Pwv
         CH4A==
X-Received: by 10.14.210.132 with SMTP id u4mr64967120eeo.19.1366052720226;
        Mon, 15 Apr 2013 12:05:20 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id u44sm28339245eel.7.2013.04.15.12.05.18
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 12:05:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516C4F27.30203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221290>

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
1.8.1.2.8026.g2b66448.dirty
