From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/4] builtin-clone: use strbuf in clone_local() and copy_or_link_directory()
Date: Fri, 21 Nov 2008 01:45:00 +0100
Message-ID: <59af178ebb4da602253e95f46f54473f42177e09.1227227976.git.vmiklos@frugalware.org>
References: <cover.1227227976.git.vmiklos@frugalware.org>
 <6bd31bceb3840f14d747972b4858e1c5b215744d.1227227976.git.vmiklos@frugalware.org>
 <33c4500c44cb27b1bfb3ec5584c0665b0dbd7c73.1227227976.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 01:45:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3K9J-0007O6-GD
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 01:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349AbYKUAn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 19:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755406AbYKUAn7
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 19:43:59 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:47489 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293AbYKUAnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 19:43:51 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id D8505446CD3;
	Fri, 21 Nov 2008 01:43:48 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 41590148F8; Fri, 21 Nov 2008 01:45:01 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <33c4500c44cb27b1bfb3ec5584c0665b0dbd7c73.1227227976.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1227227976.git.vmiklos@frugalware.org>
References: <cover.1227227976.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101490>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-clone.c |   58 +++++++++++++++++++++++++++++-------------------------
 1 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 52b1242..8182ebd 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -183,36 +183,38 @@ static void setup_reference(const char *repo)
 	free(ref_git_copy);
 }
 
-static void copy_or_link_directory(char *src, char *dest)
+static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 {
 	struct dirent *de;
 	struct stat buf;
 	int src_len, dest_len;
 	DIR *dir;
 
-	dir = opendir(src);
+	dir = opendir(src->buf);
 	if (!dir)
-		die("failed to open %s\n", src);
+		die("failed to open %s\n", src->buf);
 
-	if (mkdir(dest, 0777)) {
+	if (mkdir(dest->buf, 0777)) {
 		if (errno != EEXIST)
-			die("failed to create directory %s\n", dest);
-		else if (stat(dest, &buf))
-			die("failed to stat %s\n", dest);
+			die("failed to create directory %s\n", dest->buf);
+		else if (stat(dest->buf, &buf))
+			die("failed to stat %s\n", dest->buf);
 		else if (!S_ISDIR(buf.st_mode))
-			die("%s exists and is not a directory\n", dest);
+			die("%s exists and is not a directory\n", dest->buf);
 	}
 
-	src_len = strlen(src);
-	src[src_len] = '/';
-	dest_len = strlen(dest);
-	dest[dest_len] = '/';
+	strbuf_addch(src, '/');
+	src_len = src->len;
+	strbuf_addch(dest, '/');
+	dest_len = dest->len;
 
 	while ((de = readdir(dir)) != NULL) {
-		strcpy(src + src_len + 1, de->d_name);
-		strcpy(dest + dest_len + 1, de->d_name);
-		if (stat(src, &buf)) {
-			warning ("failed to stat %s\n", src);
+		strbuf_setlen(src, src_len);
+		strbuf_addstr(src, de->d_name);
+		strbuf_setlen(dest, dest_len);
+		strbuf_addstr(dest, de->d_name);
+		if (stat(src->buf, &buf)) {
+			warning ("failed to stat %s\n", src->buf);
 			continue;
 		}
 		if (S_ISDIR(buf.st_mode)) {
@@ -221,17 +223,17 @@ static void copy_or_link_directory(char *src, char *dest)
 			continue;
 		}
 
-		if (unlink(dest) && errno != ENOENT)
-			die("failed to unlink %s\n", dest);
+		if (unlink(dest->buf) && errno != ENOENT)
+			die("failed to unlink %s\n", dest->buf);
 		if (!option_no_hardlinks) {
-			if (!link(src, dest))
+			if (!link(src->buf, dest->buf))
 				continue;
 			if (option_local)
-				die("failed to create link %s\n", dest);
+				die("failed to create link %s\n", dest->buf);
 			option_no_hardlinks = 1;
 		}
-		if (copy_file(dest, src, 0666))
-			die("failed to copy file to %s\n", dest);
+		if (copy_file(dest->buf, src->buf, 0666))
+			die("failed to copy file to %s\n", dest->buf);
 	}
 	closedir(dir);
 }
@@ -240,17 +242,19 @@ static const struct ref *clone_local(const char *src_repo,
 				     const char *dest_repo)
 {
 	const struct ref *ret;
-	char src[PATH_MAX];
-	char dest[PATH_MAX];
+	struct strbuf src = STRBUF_INIT;
+	struct strbuf dest = STRBUF_INIT;
 	struct remote *remote;
 	struct transport *transport;
 
 	if (option_shared)
 		add_to_alternates_file(src_repo);
 	else {
-		snprintf(src, PATH_MAX, "%s/objects", src_repo);
-		snprintf(dest, PATH_MAX, "%s/objects", dest_repo);
-		copy_or_link_directory(src, dest);
+		strbuf_addf(&src, "%s/objects", src_repo);
+		strbuf_addf(&dest, "%s/objects", dest_repo);
+		copy_or_link_directory(&src, &dest);
+		strbuf_release(&src);
+		strbuf_release(&dest);
 	}
 
 	remote = remote_get(src_repo);
-- 
1.6.0.4
