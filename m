From: Jason Holden <jason.k.holden@gmail.com>
Subject: [PATCH 1/2] Add option to not delete a .git directory in remove_dir_recursively()
Date: Mon, 29 Jun 2009 22:10:44 -0400
Message-ID: <1246327845-22718-2-git-send-email-jason.k.holden@gmail.com>
References: <1246327845-22718-1-git-send-email-jason.k.holden@gmail.com>
Cc: Jason Holden <jason.k.holden@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 04:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLSoa-0005dY-OY
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 04:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089AbZF3CLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 22:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754511AbZF3CLL
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 22:11:11 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:61503 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbZF3CLK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 22:11:10 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1947627qwb.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 19:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Wz1K3+pfkkSNaMqAcxYd6TOK7ZMNNjViN5/bvNZZ5bk=;
        b=C/IEdTuwCzJCZDI9eHfF5RamoTTDvZ2l4QXjl+KOrE/iwM6kZuIStx+VoiABImtq8D
         gmxX1f36SfqDUUaf+tS9EFtQmF2ujHHjz8Z6Tmmj0BKx96vpfAzaWpESileucGy/vhtB
         xPV7HCPtuhaToTM8J9Ga/pYjS0UgfOqym+BW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JQjfYpO+1E5Y+OGjNygHIdxZ1tznYNdNDqY68VC3Q11UENO14REc0Jw1F8XPFuHo3A
         nOd6sJu5bq8++UMACvtf+yEwYtds64qWTYsjh1ck1/meQ24O02A+k3rO5y6ewNw/75OG
         T9baEFUpY71tRuREJp1r1GgK/59za5tv2MOCo=
Received: by 10.224.60.142 with SMTP id p14mr2783045qah.20.1246327872172;
        Mon, 29 Jun 2009 19:11:12 -0700 (PDT)
Received: from localhost (c-75-69-254-77.hsd1.nh.comcast.net [75.69.254.77])
        by mx.google.com with ESMTPS id 26sm4129745qwa.17.2009.06.29.19.11.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 19:11:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.207.ga8208
In-Reply-To: <1246327845-22718-1-git-send-email-jason.k.holden@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122481>

Because all existing calls to remove_dir_recursively() do not
currently have this protection, default all existing calls
to 0 (to not keep .git directories)

Signed-off-by: Jason Holden <jason.k.holden@gmail.com>
---
 builtin-clean.c |    2 +-
 builtin-clone.c |    4 ++--
 dir.c           |   17 +++++++++++++++--
 dir.h           |    2 +-
 refs.c          |    2 +-
 transport.c     |    4 ++--
 6 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 1c1b6d2..cd82407 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -141,7 +141,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				   (matches == MATCHED_EXACTLY)) {
 				if (!quiet)
 					printf("Removing %s\n", qname);
-				if (remove_dir_recursively(&directory, 0) != 0) {
+				if (remove_dir_recursively(&directory, 0, 0) != 0) {
 					warning("failed to remove '%s'", qname);
 					errors++;
 				}
diff --git a/builtin-clone.c b/builtin-clone.c
index 2ceacb7..0c00c87 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -304,12 +304,12 @@ static void remove_junk(void)
 		return;
 	if (junk_git_dir) {
 		strbuf_addstr(&sb, junk_git_dir);
-		remove_dir_recursively(&sb, 0);
+		remove_dir_recursively(&sb, 0, 0);
 		strbuf_reset(&sb);
 	}
 	if (junk_work_tree) {
 		strbuf_addstr(&sb, junk_work_tree);
-		remove_dir_recursively(&sb, 0);
+		remove_dir_recursively(&sb, 0, 0);
 		strbuf_reset(&sb);
 	}
 }
diff --git a/dir.c b/dir.c
index bbfcb56..eadcddd 100644
--- a/dir.c
+++ b/dir.c
@@ -800,7 +800,7 @@ int is_empty_dir(const char *path)
 	return ret;
 }
 
-int remove_dir_recursively(struct strbuf *path, int only_empty)
+int remove_dir_recursively(struct strbuf *path, int only_empty, int keep_dot_git)
 {
 	DIR *dir = opendir(path->buf);
 	struct dirent *e;
@@ -812,6 +812,19 @@ int remove_dir_recursively(struct strbuf *path, int only_empty)
 		strbuf_addch(path, '/');
 
 	len = path->len;
+
+	if (keep_dot_git) {
+		char end_of_path[6]; /* enough space for ".git/"*/
+		memset(end_of_path, '\0', 6);
+		if (len >= 5) {
+			strncpy(end_of_path, path->buf + len - 5, 5);
+			if (strcmp(end_of_path, ".git/") == 0) {
+				printf("********Found .git!!!!  Skipping delete\n");
+				return 0;
+			}
+		}
+	}
+
 	while ((e = readdir(dir)) != NULL) {
 		struct stat st;
 		if (is_dot_or_dotdot(e->d_name))
@@ -822,7 +835,7 @@ int remove_dir_recursively(struct strbuf *path, int only_empty)
 		if (lstat(path->buf, &st))
 			; /* fall thru */
 		else if (S_ISDIR(st.st_mode)) {
-			if (!remove_dir_recursively(path, only_empty))
+			if (!remove_dir_recursively(path, only_empty, keep_dot_git))
 				continue; /* happy */
 		} else if (!only_empty && !unlink(path->buf))
 			continue; /* happy, too */
diff --git a/dir.h b/dir.h
index 541286a..8273bb9 100644
--- a/dir.h
+++ b/dir.h
@@ -89,7 +89,7 @@ static inline int is_dot_or_dotdot(const char *name)
 extern int is_empty_dir(const char *dir);
 
 extern void setup_standard_excludes(struct dir_struct *dir);
-extern int remove_dir_recursively(struct strbuf *path, int only_empty);
+extern int remove_dir_recursively(struct strbuf *path, int only_empty, int keep_dot_git);
 
 /* tries to remove the path with empty directories along it, ignores ENOENT */
 extern int remove_path(const char *path);
diff --git a/refs.c b/refs.c
index 24438c6..4ddb361 100644
--- a/refs.c
+++ b/refs.c
@@ -820,7 +820,7 @@ static int remove_empty_directories(const char *file)
 	strbuf_init(&path, 20);
 	strbuf_addstr(&path, file);
 
-	result = remove_dir_recursively(&path, 1);
+	result = remove_dir_recursively(&path, 1, 0);
 
 	strbuf_release(&path);
 
diff --git a/transport.c b/transport.c
index 501a77b..067d6b1 100644
--- a/transport.c
+++ b/transport.c
@@ -196,7 +196,7 @@ static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 	insert_packed_refs(temp_dir.buf, &tail);
 	strbuf_setlen(&temp_dir, temp_dir_len);
 
-	if (remove_dir_recursively(&temp_dir, 0))
+	if (remove_dir_recursively(&temp_dir, 0, 0))
 		warning ("Error removing temporary directory %s.",
 				temp_dir.buf);
 
@@ -342,7 +342,7 @@ static int rsync_transport_push(struct transport *transport,
 		result = error("Could not push to %s",
 				rsync_url(transport->url));
 
-	if (remove_dir_recursively(&temp_dir, 0))
+	if (remove_dir_recursively(&temp_dir, 0, 0))
 		warning ("Could not remove temporary directory %s.",
 				temp_dir.buf);
 
-- 
1.6.3.2.207.ga8208
