From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 3/8] dir.c: git-status --ignored: don't list empty ignored
 directories
Date: Mon, 18 Mar 2013 21:28:43 +0100
Message-ID: <514778FB.20603@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Mar 18 21:29:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHggE-0001vP-3t
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 21:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769Ab3CRU2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 16:28:46 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52148 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454Ab3CRU2o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 16:28:44 -0400
Received: by mail-ee0-f46.google.com with SMTP id e49so2748457eek.19
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 13:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=5e5njoT/cDW5+cmgMjxwoOmpXJteHjweXoGhA2l4Lzc=;
        b=VjX0+gCOe7q353BFrQfCQErf1nolL33I3yHac0PpKGfrMk+2dWCbHgepWZJsO6RpT7
         Y/RMhUyaxtGenhwhq3v8HpIdMtqpAofc4YYl1TbM/sCRnSOCKKIReT4cSzhKUkf32j9y
         EKegGzy9ZB+tEhUuhMqt5wkwnqj9+NKO0io1moRfos1M0efc0Ay99HJ58mPm4lU2/dik
         bgdeXC8BVE8/3mW8jWZphJowbYCy49c6f+I8DspFEzErNQ0SqnoFr8HnMEreYbfRSgph
         jxv2cjQnk+cmqXhPLPNNOjczgwAwnOZ6Q+4arcy+BjoIPY9dWrF533Bpw5prSkYQoVuv
         K6Nw==
X-Received: by 10.14.0.135 with SMTP id 7mr52368703eeb.5.1363638523613;
        Mon, 18 Mar 2013 13:28:43 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id u44sm29269255eel.7.2013.03.18.13.28.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 13:28:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <514775FA.9080304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218443>

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
1.8.1.2.8021.g7e51819
