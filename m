From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 5/8] dir.c: move prep_exclude and factor out parts of last_exclude_matching
Date: Mon, 18 Mar 2013 21:28:55 +0100
Message-ID: <51477907.7030302@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Mar 18 21:29:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHggP-000239-7j
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 21:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab3CRU26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 16:28:58 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:61995 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454Ab3CRU25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 16:28:57 -0400
Received: by mail-ee0-f42.google.com with SMTP id b47so2735744eek.1
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=dTJrBszN/pQIumrcrfuIHk9qbGrOlBKXi2AHbkJCQfY=;
        b=nwxeih4jf7M+Pu+/TTobWIx8iS4NgFjBtQyfVV9yzC0VzuUuNDTl8nc9QUC1O+NWWA
         gR+rbnkfjFqBM/IwWdh6CuRmwSbFvM41ooI65/H8qnBqP9G0eUwa4Due1etIJ/zY8jsd
         jJCbs71TlbA4uLYdNNZjO5PjiqvzzFUKSh4TyLbHGoCjhQTMmw5tCvDrWI4/UzZPEDZq
         tNK9aLCXcN1vqxr+/UAvprPpqEAN7CCgNNj7TlvrjYBgqlG/Q69eQfbVXNNf9S3kstfc
         L+Ly4BKuVJek/VU38PZ9o40UgYwGiEGinO+uryrTjqOBdLxdE19AtXgpDWWKWH3wv8lZ
         zM6w==
X-Received: by 10.14.202.71 with SMTP id c47mr52179631eeo.39.1363638536072;
        Mon, 18 Mar 2013 13:28:56 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id h5sm29286131eem.1.2013.03.18.13.28.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 13:28:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <514775FA.9080304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218444>

Move code around in preparation for the next patch.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c | 181 ++++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 94 insertions(+), 87 deletions(-)

diff --git a/dir.c b/dir.c
index 64457db..417feaa 100644
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
@@ -751,25 +679,13 @@ int is_excluded_from_list(const char *pathname,
 	return -1; /* undecided */
 }
 
-/*
- * Loads the exclude lists for the directory containing pathname, then
- * scans all exclude lists to determine whether pathname is excluded.
- * Returns the exclude_list element which matched, or NULL for
- * undecided.
- */
-static struct exclude *last_exclude_matching(struct dir_struct *dir,
-					     const char *pathname,
-					     int *dtype_p)
+static struct exclude *last_exclude_matching_from_lists(struct dir_struct *dir,
+		const char *pathname, int pathlen, const char *basename,
+		int *dtype_p)
 {
-	int pathlen = strlen(pathname);
 	int i, j;
 	struct exclude_list_group *group;
 	struct exclude *exclude;
-	const char *basename = strrchr(pathname, '/');
-	basename = (basename) ? basename+1 : pathname;
-
-	prep_exclude(dir, pathname, basename-pathname);
-
 	for (i = EXC_CMDL; i <= EXC_FILE; i++) {
 		group = &dir->exclude_list_group[i];
 		for (j = group->nr - 1; j >= 0; j--) {
@@ -781,6 +697,97 @@ static struct exclude *last_exclude_matching(struct dir_struct *dir,
 		}
 	}
 	return NULL;
+};
+
+/*
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
+ * Loads the exclude lists for the directory containing pathname, then
+ * scans all exclude lists to determine whether pathname is excluded.
+ * Returns the exclude_list element which matched, or NULL for
+ * undecided.
+ */
+static struct exclude *last_exclude_matching(struct dir_struct *dir,
+					     const char *pathname,
+					     int *dtype_p)
+{
+	int pathlen = strlen(pathname);
+	const char *basename = strrchr(pathname, '/');
+	basename = (basename) ? basename+1 : pathname;
+
+	prep_exclude(dir, pathname, basename-pathname);
+	return last_exclude_matching_from_lists(dir, pathname, pathlen,
+			basename, dtype_p);
 }
 
 /*
-- 
1.8.1.2.8021.g7e51819
