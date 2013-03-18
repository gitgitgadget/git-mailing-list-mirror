From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 8/8] dir.c: git-status: avoid is_excluded checks for tracked
 files
Date: Mon, 18 Mar 2013 21:29:27 +0100
Message-ID: <51477927.9090500@gmail.com>
References: <514775FA.9080304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 21:29:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHggv-0002PU-GB
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 21:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145Ab3CRU3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 16:29:30 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47316 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454Ab3CRU32 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 16:29:28 -0400
Received: by mail-ee0-f46.google.com with SMTP id e49so2866307eek.33
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 13:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=9JDR8TnbxR6++Cw5HPrOmj5mMeKWHrcjQnZlWRgjleU=;
        b=LEOvJ4RjiIm+ec6ns98u0+7c0LTW6K62jMW+3em7FxAw8Jei1embHP2H6a62ewDJ40
         GojK73LkLaXpsmkJXo8o2n+2AFXxNPfqA/LYvlaKHGpiigHkuoT/YI1okv/DOUMKIS/s
         53WwAPRleMRqdmfANM7CTF/Xq+qw+abGYiBti83a64GeVUohpX0pImSHDLBpm/GXMUq4
         62PBaZnCDfmM196H03WDIQF1aC8OnkTX6m8Y4uq0eRNgywaf/8CYh8/A+/7gx+OSXvv+
         4h76IVhrIDxKrC3gtTDDDK3n3jiNxQhtlvB7HSUA2mJ3OpNYy3zl/q4In0VJLo3nptIA
         y/ZQ==
X-Received: by 10.14.211.65 with SMTP id v41mr52290016eeo.33.1363638567818;
        Mon, 18 Mar 2013 13:29:27 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id h5sm29288654eem.1.2013.03.18.13.29.26
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 13:29:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <514775FA.9080304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218447>

Checking if a file is in the index is much faster (hashtable lookup) than
checking if the file is excluded (linear search over exclude patterns).

Skip is_excluded checks for files: move the cache_name_exists check from
treat_file to treat_one_path and return early if the file is tracked.

This can safely be done as all other code paths also return path_ignored
for tracked files, and dir_add_ignored skips tracked files as well.

There's just one line left in treat_file, so move this to treat_one_path
as well.

Here's some performance data for git-status from the linux and WebKit
repos (best of 10 runs on a Debian Linux on SSD, core.preloadIndex=true):

       |    status      | status --ignored
       | linux | WebKit | linux | WebKit
-------+-------+--------+-------+---------
before | 0.218 |  1.583 | 0.321 |  2.579
after  | 0.156 |  0.988 | 0.202 |  1.279
gain   | 1.397 |  1.602 | 1.589 |  2.016

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/dir.c b/dir.c
index 086a169..c159000 100644
--- a/dir.c
+++ b/dir.c
@@ -1026,28 +1026,6 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 }
 
 /*
- * Decide what to do when we find a file while traversing the
- * filesystem. Mostly two cases:
- *
- *  1. We are looking for ignored files
- *   (a) File is ignored, include it
- *   (b) File is in ignored path, include it
- *   (c) File is not ignored, exclude it
- *
- *  2. Other scenarios, include the file if not excluded
- *
- * Return 1 for exclude, 0 for include.
- */
-static int treat_file(struct dir_struct *dir, struct strbuf *path, int exclude)
-{
-	/* Always exclude indexed files */
-	if (index_name_exists(&the_index, path->buf, path->len, ignore_case))
-		return 1;
-
-	return exclude == !(dir->flags & DIR_SHOW_IGNORED);
-}
-
-/*
  * This is an inexact early pruning of any recursive directory
  * reading - if the path cannot possibly be in the pathspec,
  * return true, and we'll skip it early.
@@ -1170,7 +1148,16 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
 {
-	int exclude = is_excluded(dir, path->buf, &dtype);
+	int exclude;
+	if (dtype == DT_UNKNOWN)
+		dtype = get_dtype(de, path->buf, path->len);
+
+	/* Always exclude indexed files */
+	if (dtype != DT_DIR &&
+	    cache_name_exists(path->buf, path->len, ignore_case))
+		return path_ignored;
+
+	exclude = is_excluded(dir, path->buf, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 	    && exclude_matches_pathspec(path->buf, path->len, simplify))
 		dir_add_ignored(dir, path->buf, path->len);
@@ -1182,9 +1169,6 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
 		return path_ignored;
 
-	if (dtype == DT_UNKNOWN)
-		dtype = get_dtype(de, path->buf, path->len);
-
 	switch (dtype) {
 	default:
 		return path_ignored;
@@ -1201,7 +1185,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		break;
 	case DT_REG:
 	case DT_LNK:
-		if (treat_file(dir, path, exclude))
+		if (exclude == !(dir->flags & DIR_SHOW_IGNORED))
 			return path_ignored;
 		break;
 	}
-- 
1.8.1.2.8021.g7e51819
