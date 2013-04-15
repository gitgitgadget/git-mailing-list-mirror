From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 12/14] dir.c: git-status: avoid is_excluded checks for
 tracked files
Date: Mon, 15 Apr 2013 21:13:35 +0200
Message-ID: <516C515F.1070206@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Apr 15 21:13:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URoqU-0007eR-NN
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935006Ab3DOTNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:13:39 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:45758 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934987Ab3DOTNi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:13:38 -0400
Received: by mail-ea0-f180.google.com with SMTP id d10so2332585eaj.39
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=SsJ1vWDgr/sJPyOLHS4tIOHQ8v2ceU8eEKQvibgv9u4=;
        b=h5JxzZknGOJe2NoqOfKjXuXLr4yaFy7StUVCX4dp6ev5llYFeqMB8fFmVws8lGvU4e
         kCubgj4moovoR2yws5Uu58sDp3ZhmCa6+YKXFyA0UmmevF4sptznHhvebIREVHCx0Pi1
         AN1wNDQt2aoKmmqHP9MpRiJxrNahLCN7GwZkquM70PxZ7g22HPSyRKEZxvj4jbAfYkdh
         kCv7sIQaJVv6kXGPyw9PUln7zPu5GNPy3LdS9K45rrU/A4SxhbE9ZXGwj+VzEw+B+jPm
         w/H9O2Prb/GMYCk25eru/ZZ6pOBIXpiofxaM7LV3TKPnf9j3VkzmLa6tloAeQlWIEByU
         HHqg==
X-Received: by 10.15.45.136 with SMTP id b8mr65613381eew.11.1366053217093;
        Mon, 15 Apr 2013 12:13:37 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id bk42sm28413757eeb.3.2013.04.15.12.13.35
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 12:13:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516C4F27.30203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221302>

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
index 67313bd..5ae5722 100644
--- a/dir.c
+++ b/dir.c
@@ -1023,28 +1023,6 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
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
@@ -1167,7 +1145,16 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
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
@@ -1179,9 +1166,6 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
 		return path_ignored;
 
-	if (dtype == DT_UNKNOWN)
-		dtype = get_dtype(de, path->buf, path->len);
-
 	switch (dtype) {
 	default:
 		return path_ignored;
@@ -1198,7 +1182,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		break;
 	case DT_REG:
 	case DT_LNK:
-		if (treat_file(dir, path, exclude))
+		if (exclude == !(dir->flags & DIR_SHOW_IGNORED))
 			return path_ignored;
 		break;
 	}
-- 
1.8.1.2.8026.g2b66448.dirty
