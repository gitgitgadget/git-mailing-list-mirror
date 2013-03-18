From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 6/8] dir.c: unify is_excluded and is_path_excluded APIs
Date: Mon, 18 Mar 2013 21:29:02 +0100
Message-ID: <5147790E.1090107@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Mar 18 21:29:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHggY-0002AJ-Lj
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 21:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840Ab3CRU3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 16:29:06 -0400
Received: from mail-ea0-f172.google.com ([209.85.215.172]:57096 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454Ab3CRU3E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 16:29:04 -0400
Received: by mail-ea0-f172.google.com with SMTP id d10so2686486eaj.17
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=jElboiCQ3ZvOUj+6n/ChQND5YdcFK1r/A/vjcOeeVzk=;
        b=xfflEPkcI15BeU02yGir37paUCgdZwPSYZyBq6tOGOyJcXyHeVBrDjlOwFhqYmjJGh
         /UGzAIL3iXGAASDL+42Y0gR9Ma/17mb60ir/zGjW49nltmuE8kxkWqrUr7ebja9vsCFU
         ScnqDUBde+ZfH0/ON81zLRFktFslD1RXpVmIEXhaZwceohjQk14RPyZQisRsCnt3sMTf
         uWpay/3Cu3j3HRdfDQB8aJLrTAxWbk5E/IfjmFKNHXz5G0SgQruf7eohEpfkWAYhjbG9
         lWjAfCbNs2+1Rf3mojnvO3M6+H9XuE4f6yUJ9RRBixyyTGFFvpEGvvdUl6SBuPtdMAl1
         ywTw==
X-Received: by 10.14.219.7 with SMTP id l7mr52844541eep.12.1363638543208;
        Mon, 18 Mar 2013 13:29:03 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id f47sm29263618eep.13.2013.03.18.13.29.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 13:29:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <514775FA.9080304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218445>

The is_excluded and is_path_excluded APIs are very similar, except for a
few noteworthy differences:

is_excluded doesn't handle ignored directories, results for paths within
ignored directories are incorrect. This is probably based on the premise
that recursive directory scans should stop at ignored directories, which
is no longer true (in certain cases, read_directory_recursive currently
calls is_excluded *and* is_path_excluded to get correct ignored state).

is_excluded caches parsed .gitignore files of the last directory in struct
dir_struct. If the directory changes, it finds a common parent directory
and is very careful to drop only as much state as necessary. On the other
hand, is_excluded will also read and parse .gitignore files in already
ignored directories, which are completely irrelevant.

is_path_excluded correctly handles ignored directories by checking if any
component in the path is excluded. As it uses is_excluded internally, this
unfortunately forces is_excluded to drop and re-read all .gitignore files,
as there is no common parent directory for the root dir.

is_path_excluded tracks state in a separate struct path_exclude_check,
which is essentially a wrapper of dir_struct with two more fields. However,
as is_path_excluded also modifies dir_struct, it is not possible to e.g.
use multiple path_exclude_check structures with the same dir_struct in
parallel. The additional structure just unnecessarily complicates the API.

Teach is_excluded / prep_exclude about ignored directories: whenever
entering a new directory, first check if the entire directory is excluded.
Remember the excluded state in dir_struct. Don't traverse into already
ignored directories (i.e. don't read irrelevant .gitignore files).

Directories could also be excluded by exclude patterns specified on the
command line or .git/info/exclude, so we cannot simply skip prep_exclude
entirely if there's no .gitignore file name (dir_struct.exclude_per_dir).
Move this check to just before acutally reading the file.

is_path_excluded is now equivalent to is_excluded, so we can simply
redirect to it (the public API is cleaned up in the next patch).

The performance impact of the additional ignored check per directory is
hardly noticeable when reading directories recursively (e.g. 'git status').
However, performance of git commands using the is_path_excluded API (e.g.
'git ls-files --cached --ignored --exclude-standard') is greatly improved
as this no longer re-reads .gitignore files on each call.

Here's some performance data from the linux and WebKit repos (best of 10
runs on a Debian Linux on SSD, core.preloadIndex=true):

       | ls-files -ci   |    status      | status --ignored
       | linux | WebKit | linux | WebKit | linux | WebKit
-------+-------+--------+-------+--------+-------+---------
before | 0.506 |  6.539 | 0.212 |  1.555 | 0.323 |  2.541
after  | 0.080 |  1.191 | 0.218 |  1.583 | 0.321 |  2.579
gain   | 6.325 |  5.490 | 0.972 |  0.982 | 1.006 |  0.985

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c | 106 ++++++++++++++++++++++++++----------------------------------------
 dir.h |   6 ++--
 2 files changed, 45 insertions(+), 67 deletions(-)

diff --git a/dir.c b/dir.c
index 417feaa..16fee2c 100644
--- a/dir.c
+++ b/dir.c
@@ -710,10 +710,6 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	struct exclude_stack *stk = NULL;
 	int current;
 
-	if ((!dir->exclude_per_dir) ||
-	    (baselen + strlen(dir->exclude_per_dir) >= PATH_MAX))
-		return; /* too long a path -- ignore */
-
 	group = &dir->exclude_list_group[EXC_DIRS];
 
 	/* Pop the exclude lists from the EXCL_DIRS exclude_list_group
@@ -725,12 +721,17 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			break;
 		el = &group->el[dir->exclude_stack->exclude_ix];
 		dir->exclude_stack = stk->prev;
+		dir->exclude = NULL;
 		free((char *)el->src); /* see strdup() below */
 		clear_exclude_list(el);
 		free(stk);
 		group->nr--;
 	}
 
+	/* Skip traversing into sub directories if the parent is excluded */
+	if (dir->exclude)
+		return;
+
 	/* Read from the parent directories and push them down. */
 	current = stk ? stk->baselen : -1;
 	while (current < baselen) {
@@ -749,22 +750,43 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		}
 		stk->prev = dir->exclude_stack;
 		stk->baselen = cp - base;
+		stk->exclude_ix = group->nr;
+		el = add_exclude_list(dir, EXC_DIRS, NULL);
 		memcpy(dir->basebuf + current, base + current,
 		       stk->baselen - current);
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
+
+		/* Abort if the directory is excluded */
+		if (stk->baselen) {
+			int dt = DT_DIR;
+			dir->basebuf[stk->baselen - 1] = 0;
+			dir->exclude = last_exclude_matching_from_lists(dir,
+				dir->basebuf, stk->baselen - 1,
+				dir->basebuf + current, &dt);
+			dir->basebuf[stk->baselen - 1] = '/';
+			if (dir->exclude) {
+				dir->basebuf[stk->baselen] = 0;
+				dir->exclude_stack = stk;
+				return;
+			}
+		}
+
+		/* Try to read per-directory file unless path is too long */
+		if (dir->exclude_per_dir &&
+		    stk->baselen + strlen(dir->exclude_per_dir) < PATH_MAX) {
+			strcpy(dir->basebuf + stk->baselen,
+					dir->exclude_per_dir);
+			/*
+			 * dir->basebuf gets reused by the traversal, but we
+			 * need fname to remain unchanged to ensure the src
+			 * member of each struct exclude correctly
+			 * back-references its source file.  Other invocations
+			 * of add_exclude_list provide stable strings, so we
+			 * strdup() and free() here in the caller.
+			 */
+			el->src = strdup(dir->basebuf);
+			add_excludes_from_file_to_list(dir->basebuf,
+					dir->basebuf, stk->baselen, el, 1);
+		}
 		dir->exclude_stack = stk;
 		current = stk->baselen;
 	}
@@ -786,6 +808,8 @@ static struct exclude *last_exclude_matching(struct dir_struct *dir,
 	basename = (basename) ? basename+1 : pathname;
 
 	prep_exclude(dir, pathname, basename-pathname);
+	if (dir->exclude)
+		return dir->exclude;
 	return last_exclude_matching_from_lists(dir, pathname, pathlen,
 			basename, dtype_p);
 }
@@ -808,13 +832,10 @@ void path_exclude_check_init(struct path_exclude_check *check,
 			     struct dir_struct *dir)
 {
 	check->dir = dir;
-	check->exclude = NULL;
-	strbuf_init(&check->path, 256);
 }
 
 void path_exclude_check_clear(struct path_exclude_check *check)
 {
-	strbuf_release(&check->path);
 }
 
 /*
@@ -830,49 +851,6 @@ struct exclude *last_exclude_matching_path(struct path_exclude_check *check,
 					   const char *name, int namelen,
 					   int *dtype)
 {
-	int i;
-	struct strbuf *path = &check->path;
-	struct exclude *exclude;
-
-	/*
-	 * we allow the caller to pass namelen as an optimization; it
-	 * must match the length of the name, as we eventually call
-	 * is_excluded() on the whole name string.
-	 */
-	if (namelen < 0)
-		namelen = strlen(name);
-
-	/*
-	 * If path is non-empty, and name is equal to path or a
-	 * subdirectory of path, name should be excluded, because
-	 * it's inside a directory which is already known to be
-	 * excluded and was previously left in check->path.
-	 */
-	if (path->len &&
-	    path->len <= namelen &&
-	    !memcmp(name, path->buf, path->len) &&
-	    (!name[path->len] || name[path->len] == '/'))
-		return check->exclude;
-
-	strbuf_setlen(path, 0);
-	for (i = 0; name[i]; i++) {
-		int ch = name[i];
-
-		if (ch == '/') {
-			int dt = DT_DIR;
-			exclude = last_exclude_matching(check->dir,
-							path->buf, &dt);
-			if (exclude) {
-				check->exclude = exclude;
-				return exclude;
-			}
-		}
-		strbuf_addch(path, ch);
-	}
-
-	/* An entry in the index; cannot be a directory with subentries */
-	strbuf_setlen(path, 0);
-
 	return last_exclude_matching(check->dir, name, dtype);
 }
 
diff --git a/dir.h b/dir.h
index c3eb4b5..cd166d0 100644
--- a/dir.h
+++ b/dir.h
@@ -110,9 +110,11 @@ struct dir_struct {
 	 *
 	 * exclude_stack points to the top of the exclude_stack, and
 	 * basebuf contains the full path to the current
-	 * (sub)directory in the traversal.
+	 * (sub)directory in the traversal. Exclude points to the
+	 * matching exclude struct if the directory is excluded.
 	 */
 	struct exclude_stack *exclude_stack;
+	struct exclude *exclude;
 	char basebuf[PATH_MAX];
 };
 
@@ -156,8 +158,6 @@ extern int match_pathname(const char *, int,
  */
 struct path_exclude_check {
 	struct dir_struct *dir;
-	struct exclude *exclude;
-	struct strbuf path;
 };
 extern void path_exclude_check_init(struct path_exclude_check *, struct dir_struct *);
 extern void path_exclude_check_clear(struct path_exclude_check *);
-- 
1.8.1.2.8021.g7e51819
