From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 09/14] dir.c: move prep_exclude
Date: Mon, 15 Apr 2013 21:11:37 +0200
Message-ID: <516C50E9.8010603@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Apr 15 21:11:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URooa-00055s-Ms
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934963Ab3DOTLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:11:40 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48532 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934954Ab3DOTLj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:11:39 -0400
Received: by mail-ee0-f46.google.com with SMTP id d49so2465186eek.33
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=g4PkAkZs1pJ8sJqGotdJhjSZzdzwiCTOnLnHm+pIFbM=;
        b=mRlHzoUAQXjjUdDEVL6o4fw7pruVWlw4IT7nTKYzykU1ElQu4Zo0T+xyRN/4z4OCsj
         sNWujDLjm6OrT3OfdlDbthEMDXNjsOBn2yeMbs8JgKiWFRZm6BdwqZisXBW7aBVJpE4i
         9N2njXh6BGDJU+ZYbk3igdDlUJrdIGMv66upCylpyjaMItINv0lfUclUnfooPQ/tRVql
         cMtGWvyoLMmWbcxDP61EdBVW4rcC7Z17HUV/ynOyBqzt/3Fzv4l1aIs1Gm5M3PxZb07v
         tbACdJQnBLW5Di7mb1eA6a8p7HAU26LJB7Oxxj0MVRq6HAFzcg668qfmmnVDM+L83KEW
         EKGA==
X-Received: by 10.14.174.5 with SMTP id w5mr17345854eel.1.1366053098176;
        Mon, 15 Apr 2013 12:11:38 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id s47sm28356631eeg.8.2013.04.15.12.11.36
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 12:11:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516C4F27.30203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221298>

Move prep_exclude in preparation for the next patch.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c | 144 +++++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/dir.c b/dir.c
index 594307c..fcb3def 100644
--- a/dir.c
+++ b/dir.c
@@ -549,78 +549,6 @@ void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 		die("cannot use %s as an exclude file", fname);
 }
 
-/*
- * Loads the per-directory exclude list for the substring of base
- * which has a char length of baselen.
- */
-static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
-{
-	struct exclude_list_group *group;
-	struct exclude_list *el;
-	struct exclude_stack *stk = NULL;
-	int current;
-
-	if ((!dir->exclude_per_dir) ||
-	    (baselen + strlen(dir->exclude_per_dir) >= PATH_MAX))
-		return; /* too long a path -- ignore */
-
-	group = &dir->exclude_list_group[EXC_DIRS];
-
-	/* Pop the exclude lists from the EXCL_DIRS exclude_list_group
-	 * which originate from directories not in the prefix of the
-	 * path being checked. */
-	while ((stk = dir->exclude_stack) != NULL) {
-		if (stk->baselen <= baselen &&
-		    !strncmp(dir->basebuf, base, stk->baselen))
-			break;
-		el = &group->el[dir->exclude_stack->exclude_ix];
-		dir->exclude_stack = stk->prev;
-		free((char *)el->src); /* see strdup() below */
-		clear_exclude_list(el);
-		free(stk);
-		group->nr--;
-	}
-
-	/* Read from the parent directories and push them down. */
-	current = stk ? stk->baselen : -1;
-	while (current < baselen) {
-		struct exclude_stack *stk = xcalloc(1, sizeof(*stk));
-		const char *cp;
-
-		if (current < 0) {
-			cp = base;
-			current = 0;
-		}
-		else {
-			cp = strchr(base + current + 1, '/');
-			if (!cp)
-				die("oops in prep_exclude");
-			cp++;
-		}
-		stk->prev = dir->exclude_stack;
-		stk->baselen = cp - base;
-		memcpy(dir->basebuf + current, base + current,
-		       stk->baselen - current);
-		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
-		/*
-		 * dir->basebuf gets reused by the traversal, but we
-		 * need fname to remain unchanged to ensure the src
-		 * member of each struct exclude correctly
-		 * back-references its source file.  Other invocations
-		 * of add_exclude_list provide stable strings, so we
-		 * strdup() and free() here in the caller.
-		 */
-		el = add_exclude_list(dir, EXC_DIRS, strdup(dir->basebuf));
-		stk->exclude_ix = group->nr - 1;
-		add_excludes_from_file_to_list(dir->basebuf,
-					       dir->basebuf, stk->baselen,
-					       el, 1);
-		dir->exclude_stack = stk;
-		current = stk->baselen;
-	}
-	dir->basebuf[baselen] = '\0';
-}
-
 int match_basename(const char *basename, int basenamelen,
 		   const char *pattern, int prefix, int patternlen,
 		   int flags)
@@ -772,6 +700,78 @@ static struct exclude *last_exclude_matching_from_lists(struct dir_struct *dir,
 }
 
 /*
+ * Loads the per-directory exclude list for the substring of base
+ * which has a char length of baselen.
+ */
+static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
+{
+	struct exclude_list_group *group;
+	struct exclude_list *el;
+	struct exclude_stack *stk = NULL;
+	int current;
+
+	if ((!dir->exclude_per_dir) ||
+	    (baselen + strlen(dir->exclude_per_dir) >= PATH_MAX))
+		return; /* too long a path -- ignore */
+
+	group = &dir->exclude_list_group[EXC_DIRS];
+
+	/* Pop the exclude lists from the EXCL_DIRS exclude_list_group
+	 * which originate from directories not in the prefix of the
+	 * path being checked. */
+	while ((stk = dir->exclude_stack) != NULL) {
+		if (stk->baselen <= baselen &&
+		    !strncmp(dir->basebuf, base, stk->baselen))
+			break;
+		el = &group->el[dir->exclude_stack->exclude_ix];
+		dir->exclude_stack = stk->prev;
+		free((char *)el->src); /* see strdup() below */
+		clear_exclude_list(el);
+		free(stk);
+		group->nr--;
+	}
+
+	/* Read from the parent directories and push them down. */
+	current = stk ? stk->baselen : -1;
+	while (current < baselen) {
+		struct exclude_stack *stk = xcalloc(1, sizeof(*stk));
+		const char *cp;
+
+		if (current < 0) {
+			cp = base;
+			current = 0;
+		}
+		else {
+			cp = strchr(base + current + 1, '/');
+			if (!cp)
+				die("oops in prep_exclude");
+			cp++;
+		}
+		stk->prev = dir->exclude_stack;
+		stk->baselen = cp - base;
+		memcpy(dir->basebuf + current, base + current,
+		       stk->baselen - current);
+		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
+		/*
+		 * dir->basebuf gets reused by the traversal, but we
+		 * need fname to remain unchanged to ensure the src
+		 * member of each struct exclude correctly
+		 * back-references its source file.  Other invocations
+		 * of add_exclude_list provide stable strings, so we
+		 * strdup() and free() here in the caller.
+		 */
+		el = add_exclude_list(dir, EXC_DIRS, strdup(dir->basebuf));
+		stk->exclude_ix = group->nr - 1;
+		add_excludes_from_file_to_list(dir->basebuf,
+					       dir->basebuf, stk->baselen,
+					       el, 1);
+		dir->exclude_stack = stk;
+		current = stk->baselen;
+	}
+	dir->basebuf[baselen] = '\0';
+}
+
+/*
  * Loads the exclude lists for the directory containing pathname, then
  * scans all exclude lists to determine whether pathname is excluded.
  * Returns the exclude_list element which matched, or NULL for
-- 
1.8.1.2.8026.g2b66448.dirty
