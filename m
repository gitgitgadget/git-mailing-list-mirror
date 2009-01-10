From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH] add is_dot_or_dotdot inline function
Date: Sat, 10 Jan 2009 15:07:50 +0300
Message-ID: <1231589270-15812-1-git-send-email-aspotashev@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 13:09:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLceS-000228-Rp
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 13:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbZAJMHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 07:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbZAJMHv
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 07:07:51 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:17348 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZAJMHu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 07:07:50 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3611925fgg.17
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 04:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=25VIaGfQuPB8yL9OdysTYs5Y+tze+k1T3CNNX7A1FgM=;
        b=YX0omS5D6zTkQ7wmelYmr+8v7rLuZ8JdsFCiyn5w706IfNI2BmeFYq+rnOas4ToN0r
         DGbyTBxvfFa1hQBlEOv95mRCS/1qe3djw+GemroGKsF7TTMQ6xHVUYnzCiCl9CjBnrNy
         7rtzlHw3Yac7+D8+tbZnvjpHwTse9YDe8sHs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PZbeNP7WpdWkWXqmEL25vPpGsoQnjPI5riHUaGp+shLMl4x30jVfBScnCV2/c100bc
         m+CJGrhEZQiYbnXQyV8uykUREmimYMkSZ/KGI0Hr7h7+W6z1i4Q8dlzvl8unH8b4LXjk
         SD/lzjjBN317ZXc7HbhZWJaDRTkBHaTYb5H5U=
Received: by 10.86.52.6 with SMTP id z6mr15072405fgz.63.1231589268188;
        Sat, 10 Jan 2009 04:07:48 -0800 (PST)
Received: from localhost.localdomain (ppp83-237-189-185.pppoe.mtu-net.ru [83.237.189.185])
        by mx.google.com with ESMTPS id 12sm16407159fgg.56.2009.01.10.04.07.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jan 2009 04:07:47 -0800 (PST)
X-Mailer: git-send-email 1.6.1.76.gc123b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105100>

A new inline function is_dot_or_dotdot is used to check if the
directory name is either "." or "..". It returns a non-zero value if
the given string is "." or "..". It's applicable to a lot of Git
source code.

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---
 builtin-count-objects.c |    5 ++---
 builtin-fsck.c          |   14 ++++----------
 builtin-prune.c         |   14 ++++----------
 builtin-rerere.c        |   11 +++++------
 dir.c                   |   12 ++++--------
 dir.h                   |    6 ++++++
 entry.c                 |    5 ++---
 remote.c                |    6 ++----
 transport.c             |    4 +---
 9 files changed, 30 insertions(+), 47 deletions(-)

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index ab35b65..62fd1f0 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -5,6 +5,7 @@
  */
 
 #include "cache.h"
+#include "dir.h"
 #include "builtin.h"
 #include "parse-options.h"
 
@@ -21,9 +22,7 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 		const char *cp;
 		int bad = 0;
 
-		if ((ent->d_name[0] == '.') &&
-		    (ent->d_name[1] == 0 ||
-		     ((ent->d_name[1] == '.') && (ent->d_name[2] == 0))))
+		if (is_dot_or_dotdot(ent->d_name))
 			continue;
 		for (cp = ent->d_name; *cp; cp++) {
 			int ch = *cp;
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 297b2c4..79b87ed 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -10,6 +10,7 @@
 #include "tree-walk.h"
 #include "fsck.h"
 #include "parse-options.h"
+#include "dir.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -395,19 +396,12 @@ static void fsck_dir(int i, char *path)
 	while ((de = readdir(dir)) != NULL) {
 		char name[100];
 		unsigned char sha1[20];
-		int len = strlen(de->d_name);
 
-		switch (len) {
-		case 2:
-			if (de->d_name[1] != '.')
-				break;
-		case 1:
-			if (de->d_name[0] != '.')
-				break;
+		if (is_dot_or_dotdot(de->d_name))
 			continue;
-		case 38:
+		if (strlen(de->d_name) == 38) {
 			sprintf(name, "%02x", i);
-			memcpy(name+2, de->d_name, len+1);
+			memcpy(name+2, de->d_name, 39);
 			if (get_sha1_hex(name, sha1) < 0)
 				break;
 			add_sha1_list(sha1, DIRENT_SORT_HINT(de));
diff --git a/builtin-prune.c b/builtin-prune.c
index 7b4ec80..545e9c1 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -5,6 +5,7 @@
 #include "builtin.h"
 #include "reachable.h"
 #include "parse-options.h"
+#include "dir.h"
 
 static const char * const prune_usage[] = {
 	"git prune [-n] [-v] [--expire <time>] [--] [<head>...]",
@@ -61,19 +62,12 @@ static int prune_dir(int i, char *path)
 	while ((de = readdir(dir)) != NULL) {
 		char name[100];
 		unsigned char sha1[20];
-		int len = strlen(de->d_name);
 
-		switch (len) {
-		case 2:
-			if (de->d_name[1] != '.')
-				break;
-		case 1:
-			if (de->d_name[0] != '.')
-				break;
+		if (is_dot_or_dotdot(de->d_name))
 			continue;
-		case 38:
+		if (strlen(de->d_name) == 38) {
 			sprintf(name, "%02x", i);
-			memcpy(name+2, de->d_name, len+1);
+			memcpy(name+2, de->d_name, 39);
 			if (get_sha1_hex(name, sha1) < 0)
 				break;
 
diff --git a/builtin-rerere.c b/builtin-rerere.c
index d4dec6b..bd8fc77 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "dir.h"
 #include "string-list.h"
 #include "rerere.h"
 #include "xdiff/xdiff.h"
@@ -59,17 +60,15 @@ static void garbage_collect(struct string_list *rr)
 	git_config(git_rerere_gc_config, NULL);
 	dir = opendir(git_path("rr-cache"));
 	while ((e = readdir(dir))) {
-		const char *name = e->d_name;
-		if (name[0] == '.' &&
-		    (name[1] == '\0' || (name[1] == '.' && name[2] == '\0')))
+		if (is_dot_or_dotdot(e->d_name))
 			continue;
-		then = rerere_created_at(name);
+		then = rerere_created_at(e->d_name);
 		if (!then)
 			continue;
-		cutoff = (has_resolution(name)
+		cutoff = (has_resolution(e->d_name)
 			  ? cutoff_resolve : cutoff_noresolve);
 		if (then < now - cutoff * 86400)
-			string_list_append(name, &to_remove);
+			string_list_append(e->d_name, &to_remove);
 	}
 	for (i = 0; i < to_remove.nr; i++)
 		unlink_rr_item(to_remove.items[i].string);
diff --git a/dir.c b/dir.c
index 0131983..3347f46 100644
--- a/dir.c
+++ b/dir.c
@@ -585,10 +585,8 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			int len, dtype;
 			int exclude;
 
-			if ((de->d_name[0] == '.') &&
-			    (de->d_name[1] == 0 ||
-			     !strcmp(de->d_name + 1, ".") ||
-			     !strcmp(de->d_name + 1, "git")))
+			if (is_dot_or_dotdot(de->d_name) ||
+			     !strcmp(de->d_name, ".git"))
 				continue;
 			len = strlen(de->d_name);
 			/* Ignore overly long pathnames! */
@@ -793,10 +791,8 @@ int remove_dir_recursively(struct strbuf *path, int only_empty)
 	len = path->len;
 	while ((e = readdir(dir)) != NULL) {
 		struct stat st;
-		if ((e->d_name[0] == '.') &&
-		    ((e->d_name[1] == 0) ||
-		     ((e->d_name[1] == '.') && e->d_name[2] == 0)))
-			continue; /* "." and ".." */
+		if (is_dot_or_dotdot(e->d_name))
+			continue;
 
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
diff --git a/dir.h b/dir.h
index 768425a..e1640a8 100644
--- a/dir.h
+++ b/dir.h
@@ -77,6 +77,12 @@ extern int file_exists(const char *);
 extern char *get_relative_cwd(char *buffer, int size, const char *dir);
 extern int is_inside_dir(const char *dir);
 
+static inline int is_dot_or_dotdot(const char *name)
+{
+	return name[0] == '.' && (name[1] == '\0' ||
+		(name[1] == '.' && name[2] == '\0')); /* "." and ".." */
+}
+
 extern void setup_standard_excludes(struct dir_struct *dir);
 extern int remove_dir_recursively(struct strbuf *path, int only_empty);
 
diff --git a/entry.c b/entry.c
index aa2ee46..5f24816 100644
--- a/entry.c
+++ b/entry.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "blob.h"
+#include "dir.h"
 
 static void create_directories(const char *path, const struct checkout *state)
 {
@@ -62,9 +63,7 @@ static void remove_subtree(const char *path)
 	*name++ = '/';
 	while ((de = readdir(dir)) != NULL) {
 		struct stat st;
-		if ((de->d_name[0] == '.') &&
-		    ((de->d_name[1] == 0) ||
-		     ((de->d_name[1] == '.') && de->d_name[2] == 0)))
+		if (is_dot_or_dotdot(de->d_name))
 			continue;
 		strcpy(name, de->d_name);
 		if (lstat(pathbuf, &st))
diff --git a/remote.c b/remote.c
index 570e112..d7079c6 100644
--- a/remote.c
+++ b/remote.c
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
+#include "dir.h"
 
 static struct refspec s_tag_refspec = {
 	0,
@@ -634,10 +635,7 @@ static struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 
 static int valid_remote_nick(const char *name)
 {
-	if (!name[0] || /* not empty */
-	    (name[0] == '.' && /* not "." */
-	     (!name[1] || /* not ".." */
-	      (name[1] == '.' && !name[2]))))
+	if (!name[0] || is_dot_or_dotdot(name))
 		return 0;
 	return !strchr(name, '/'); /* no slash */
 }
diff --git a/transport.c b/transport.c
index 56831c5..9ad4a16 100644
--- a/transport.c
+++ b/transport.c
@@ -50,9 +50,7 @@ static int read_loose_refs(struct strbuf *path, int name_offset,
 	memset (&list, 0, sizeof(list));
 
 	while ((de = readdir(dir))) {
-		if (de->d_name[0] == '.' && (de->d_name[1] == '\0' ||
-				(de->d_name[1] == '.' &&
-				 de->d_name[2] == '\0')))
+		if (is_dot_or_dotdot(de->d_name))
 			continue;
 		ALLOC_GROW(list.entries, list.nr + 1, list.alloc);
 		list.entries[list.nr++] = xstrdup(de->d_name);
-- 
1.6.1.76.gc123b.dirty
