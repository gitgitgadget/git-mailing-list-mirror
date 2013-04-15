From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 08/14] dir.c: factor out parts of last_exclude_matching
 for later reuse
Date: Mon, 15 Apr 2013 21:11:02 +0200
Message-ID: <516C50C6.7070902@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Apr 15 21:11:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URoo2-0004Hj-By
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934947Ab3DOTLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:11:05 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:63505 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932892Ab3DOTLE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:11:04 -0400
Received: by mail-ee0-f47.google.com with SMTP id t10so2377549eei.20
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 12:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4k1zvNcwMa06OMSJbL7tcYpIQq4Ss+GalWECJaSIs1k=;
        b=RdPgttkRzVObfvOssP6wHsI+jTTN6BJIPLMCvnGZonmYwAE0Lb6Rs+Ezlz+JMC8K35
         pWL5hUOsjhNpH5iG1H5DigJNAoeWYsI9LKLwUznSeKkNSMoT6HnXjg2OUyyu64o0Dc+R
         bKvdfBBAnaRmvozAAyWwGSJ2TkhAmlQrKIVHiOaZRqaw4HMknfzg/zV3cNufC75xtgEW
         avd+5xejWKs6d4zEjMmaB8f0em2MrYCfri+b5l36FZloXGKz1G9ZxZq0g0DrWRR5v8Ns
         VX2IPVHCw7CVg4qTfgBuMWGJ5fPTtxz3WBCUr/SobeUGkUCadRoGTe/KP5mzK0YKalVk
         zwmQ==
X-Received: by 10.14.87.199 with SMTP id y47mr41893953eee.17.1366053062813;
        Mon, 15 Apr 2013 12:11:02 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id s47sm28352215eeg.8.2013.04.15.12.11.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 12:11:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516C4F27.30203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221297>

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/dir.c b/dir.c
index f10fb69..594307c 100644
--- a/dir.c
+++ b/dir.c
@@ -751,6 +751,26 @@ int is_excluded_from_list(const char *pathname,
 	return -1; /* undecided */
 }
 
+static struct exclude *last_exclude_matching_from_lists(struct dir_struct *dir,
+		const char *pathname, int pathlen, const char *basename,
+		int *dtype_p)
+{
+	int i, j;
+	struct exclude_list_group *group;
+	struct exclude *exclude;
+	for (i = EXC_CMDL; i <= EXC_FILE; i++) {
+		group = &dir->exclude_list_group[i];
+		for (j = group->nr - 1; j >= 0; j--) {
+			exclude = last_exclude_matching_from_list(
+				pathname, pathlen, basename, dtype_p,
+				&group->el[j]);
+			if (exclude)
+				return exclude;
+		}
+	}
+	return NULL;
+}
+
 /*
  * Loads the exclude lists for the directory containing pathname, then
  * scans all exclude lists to determine whether pathname is excluded.
@@ -762,25 +782,13 @@ static struct exclude *last_exclude_matching(struct dir_struct *dir,
 					     int *dtype_p)
 {
 	int pathlen = strlen(pathname);
-	int i, j;
-	struct exclude_list_group *group;
-	struct exclude *exclude;
 	const char *basename = strrchr(pathname, '/');
 	basename = (basename) ? basename+1 : pathname;
 
 	prep_exclude(dir, pathname, basename-pathname);
 
-	for (i = EXC_CMDL; i <= EXC_FILE; i++) {
-		group = &dir->exclude_list_group[i];
-		for (j = group->nr - 1; j >= 0; j--) {
-			exclude = last_exclude_matching_from_list(
-				pathname, pathlen, basename, dtype_p,
-				&group->el[j]);
-			if (exclude)
-				return exclude;
-		}
-	}
-	return NULL;
+	return last_exclude_matching_from_lists(dir, pathname, pathlen,
+			basename, dtype_p);
 }
 
 /*
-- 
1.8.1.2.8026.g2b66448.dirty
