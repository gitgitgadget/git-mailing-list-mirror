From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 05/14] dir.c: git-status --ignored: don't list empty directories
 as ignored
Date: Mon, 15 Apr 2013 21:08:42 +0200
Message-ID: <516C503A.5000000@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Apr 15 21:08:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URolk-0001CB-PN
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837Ab3DOTIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:08:45 -0400
Received: from mail-ea0-f179.google.com ([209.85.215.179]:43749 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3DOTIo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:08:44 -0400
Received: by mail-ea0-f179.google.com with SMTP id f15so2320000eak.10
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=FfXHO2wCCeUMk2AxlNVCyZCmWHutL80epsIniMiFS5c=;
        b=Ih1NfFb0HETpHbrz+LjOlhBfXwXioo6e0y4EjfrDYqF67krTmOBNMY/Baug0klBUHN
         vEKIQlEs9aH/iBVjjoHRK93XGIFUBPMqfgyGSAQK6nFijafs7c/8Opleb+pcyvgkiyKb
         OESaZilDNfGZHeJws2D0hj5mT66VZIam8DS/ZZr4tB/5bhyNJNQ6Z6JSYFbXfS6btyT4
         +ev+/h1gt6j68QRsxpm8oUS5E8L0EDrFRmjhuhfJXCa0cIL1sDo2fONs9YlBMsLlyfHy
         qlA06QXubdECADYUpkh3/BxpY7PjfjTgV1OYJumpfwsJjQf7Zf+iQp2cJx+GwvZzujuR
         3hcQ==
X-Received: by 10.14.110.198 with SMTP id u46mr65063697eeg.41.1366052923146;
        Mon, 15 Apr 2013 12:08:43 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id bj2sm28412324eeb.1.2013.04.15.12.08.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 12:08:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516C4F27.30203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221294>

'git-status --ignored' lists empty untracked directories as ignored, even
though they don't have any ignored files.

When checking if a directory is already listed as untracked (i.e. shouldn't
be listed as ignored as well), don't assume that the directory has only
ignored files if it doesn't have untracked files, as the directory may be
empty.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c                      |  5 +++--
 t/t7061-wtstatus-ignore.sh | 26 ++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 1112b05..c5705e3 100644
--- a/dir.c
+++ b/dir.c
@@ -1071,7 +1071,7 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 
 	/*
 	 * We are looking for ignored files and our directory is not ignored,
-	 * check if it contains only ignored files
+	 * check if it contains untracked files (i.e. is listed as untracked)
 	 */
 	if ((dir->flags & DIR_SHOW_IGNORED) && !exclude) {
 		int ignored;
@@ -1079,7 +1079,8 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 		ignored = read_directory_recursive(dir, dirname, len, 1, simplify);
 		dir->flags |= DIR_SHOW_IGNORED;
 
-		return ignored ? ignore_directory : show_directory;
+		if (ignored)
+			return ignore_directory;
 	}
 
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
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
1.8.1.2.8026.g2b66448.dirty
