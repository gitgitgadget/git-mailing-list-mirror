From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 06/14] dir.c: make 'git-status --ignored' work within leading
 directories
Date: Mon, 15 Apr 2013 21:09:25 +0200
Message-ID: <516C5065.7060008@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Apr 15 21:09:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URomS-00028I-AI
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062Ab3DOTJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:09:28 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:35643 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366Ab3DOTJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:09:27 -0400
Received: by mail-ea0-f180.google.com with SMTP id d10so2213631eaj.25
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=NH03VJglVq/n4o3orSM6dQ93MMq5l59FNUZO2rIeXmg=;
        b=MKOy4INoV4rSW+w3d1H7/Zsj8tpYQCd01ovoddcxIlwG6vDyfWAcAdCXAZkGAIGiNH
         A855EKc+MBHGekPqAexCZWC/u2aZA/3VLfG+OhpWXGgNy5j0CZYo9d1oe1YpZFOwjk3F
         HCHoiSbXEd6TaUr8uiXxnptzKWxoMEjau1aZSLvS0PkEUHHj8TG/wvlvw855Vm2jhDdR
         UdpQG54GkTxTgZawQnyyTAsErsOwOBFCA1vwnnLv3186MB/U25r4EbWP7P2fIgJ1ifZ5
         iOi2vnr3Qv3UT3VzEShdFKGwRqb7tcKaBfzp5dQi3BDCha9zGIhRVXZDNFvozAhicpyI
         qroA==
X-Received: by 10.14.175.134 with SMTP id z6mr22554547eel.15.1366052966601;
        Mon, 15 Apr 2013 12:09:26 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id b5sm28269313eew.16.2013.04.15.12.09.25
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 12:09:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516C4F27.30203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221295>

'git-status --ignored path/' doesn't list ignored files and directories
within 'path' if some component of 'path' is classified as untracked.

Disable the DIR_SHOW_OTHER_DIRECTORIES flag while traversing leading
directories. This prevents treat_leading_path() with DIR_SHOW_IGNORED flag
from aborting at the top level untracked directory.

As a side effect, this also eliminates a recursive directory scan per
leading directory level, as treat_directory() can no longer call
read_directory_recursive() when called from treat_leading_path().

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c                      |  3 +++
 t/t7061-wtstatus-ignore.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/dir.c b/dir.c
index c5705e3..822e501 100644
--- a/dir.c
+++ b/dir.c
@@ -1403,12 +1403,14 @@ static int treat_leading_path(struct dir_struct *dir,
 	struct strbuf sb = STRBUF_INIT;
 	int baselen, rc = 0;
 	const char *cp;
+	int old_flags = dir->flags;
 
 	while (len && path[len - 1] == '/')
 		len--;
 	if (!len)
 		return 1;
 	baselen = 0;
+	dir->flags &= ~DIR_SHOW_OTHER_DIRECTORIES;
 	while (1) {
 		cp = path + baselen + !!baselen;
 		cp = memchr(cp, '/', path + len - cp);
@@ -1431,6 +1433,7 @@ static int treat_leading_path(struct dir_struct *dir,
 		}
 	}
 	strbuf_release(&sb);
+	dir->flags = old_flags;
 	return rc;
 }
 
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 6171a49..4c6f145 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -32,6 +32,25 @@ test_expect_success 'status untracked directory with --ignored -u' '
 	git status --porcelain --ignored -u >actual &&
 	test_cmp expected actual
 '
+cat >expected <<\EOF
+?? untracked/uncommitted
+!! untracked/ignored
+EOF
+
+test_expect_success 'status prefixed untracked directory with --ignored' '
+	git status --porcelain --ignored untracked/ >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? untracked/uncommitted
+!! untracked/ignored
+EOF
+
+test_expect_success 'status prefixed untracked sub-directory with --ignored -u' '
+	git status --porcelain --ignored -u untracked/ >actual &&
+	test_cmp expected actual
+'
 
 cat >expected <<\EOF
 ?? .gitignore
-- 
1.8.1.2.8026.g2b66448.dirty
