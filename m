From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 4/8] dir.c: git-status --ignored: don't list empty directories
 as ignored
Date: Mon, 18 Mar 2013 21:28:49 +0100
Message-ID: <51477901.9020804@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Mar 18 21:36:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHgn1-0006k4-R0
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 21:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab3CRUft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 16:35:49 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:38075 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639Ab3CRUfs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 16:35:48 -0400
Received: by mail-ea0-f177.google.com with SMTP id r16so2662280ead.36
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=xPE0c62uCxoIbp4AGUZbrS2Y4tkXn2HvCj2Ic5ymais=;
        b=dxXZ+sfdokCWfSIbTFccvYRHFBZayDDoPaJgcT6H54HXDzJCw3F+ATElWHrrHITLRz
         Bk8A+ZiL95PrBmYUD/zcWXGL8bKwiGofwHR9MjoJFnghPp2CWzLAtrtptbTVnizdw45K
         sumneRKAKskeyPtq2+60BOip/pz1H9NEiDxxmigplz2ApNmdneLhQpOtm8/sw+ih3VIQ
         2n79DTLUoSNOvFuu5I9r/Zw/RKnnqYD6PymN/v0LyXhKAch6i1ElplCHHr0Imv8oM16K
         5A3kQtVPelIziqjzXkx9XcMILRuVoPVSphitGQYezX+on8EpH9IgnjaVK715ID2yidmQ
         V6xg==
X-Received: by 10.14.202.71 with SMTP id c47mr52178728eeo.39.1363638529329;
        Mon, 18 Mar 2013 13:28:49 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id q42sm29265734eem.14.2013.03.18.13.28.47
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 13:28:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <514775FA.9080304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218448>

'git-status --ignored' lists empty untracked directories as ignored, even
though they don't have any ignored files.

When checking if a directory is already listed as untracked (i.e. shouldn't
be listed as ignored as well), don't assume that the dirctory has only
ignored files if it doesn't have untracked files, as the directory may be
empty.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c                      | 17 ++++++++---------
 t/t7061-wtstatus-ignore.sh | 26 ++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/dir.c b/dir.c
index fd1f088..64457db 100644
--- a/dir.c
+++ b/dir.c
@@ -1071,17 +1071,16 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 
 	/*
 	 * We are looking for ignored files and our directory is not ignored,
-	 * check if it contains only ignored files
+	 * check if it contains untracked files (i.e. is listed as untracked)
 	 */
 	if ((dir->flags & DIR_SHOW_IGNORED) && !exclude) {
-		int ignored;
-		dir->flags &= ~DIR_SHOW_IGNORED;
-		dir->flags |= DIR_HIDE_EMPTY_DIRECTORIES;
-		ignored = read_directory_recursive(dir, dirname, len, 1, simplify);
-		dir->flags &= ~DIR_HIDE_EMPTY_DIRECTORIES;
-		dir->flags |= DIR_SHOW_IGNORED;
-
-		return ignored ? ignore_directory : show_directory;
+		int untracked;
+		dir->flags &= ~(DIR_SHOW_IGNORED|DIR_SHOW_OTHER_DIRECTORIES);
+		untracked = read_directory_recursive(dir, dirname, len, 1, simplify);
+		dir->flags |= DIR_SHOW_IGNORED|DIR_SHOW_OTHER_DIRECTORIES;
+
+		if (untracked)
+			return ignore_directory;
 	}
 	if (!(dir->flags & DIR_SHOW_IGNORED) &&
 	    !(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 28b7d95..6171a49 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -64,13 +64,35 @@ cat >expected <<\EOF
 ?? .gitignore
 ?? actual
 ?? expected
-!! untracked-ignored/
 EOF
 
-test_expect_success 'status untracked directory with ignored files with --ignore' '
+test_expect_success 'status empty untracked directory with --ignore' '
 	rm -rf ignored &&
 	mkdir untracked-ignored &&
 	mkdir untracked-ignored/test &&
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
+test_expect_success 'status empty untracked directory with --ignore -u' '
+	git status --porcelain --ignored -u >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! untracked-ignored/
+EOF
+
+test_expect_success 'status untracked directory with ignored files with --ignore' '
 	: >untracked-ignored/ignored &&
 	: >untracked-ignored/test/ignored &&
 	git status --porcelain --ignored >actual &&
-- 
1.8.1.2.8021.g7e51819
