From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Clean up git-ls-file directory walking library interface
Date: Tue, 16 May 2006 19:46:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605161944480.10823@g5.osdl.org>
References: <Pine.LNX.4.64.0605161859050.16475@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed May 17 04:46:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgC3P-0000Iw-M7
	for gcvg-git@gmane.org; Wed, 17 May 2006 04:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWEQCqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 22:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWEQCqY
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 22:46:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48035 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751168AbWEQCqY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 22:46:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4H2kHtH031457
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 May 2006 19:46:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4H2kGd1032346;
	Tue, 16 May 2006 19:46:17 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605161859050.16475@g5.osdl.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20157>


This moves the code to add the per-directory ignore files for the base
directory into the library routine.

That not only allows us to turn the function push_exclude_per_directory() 
static again, it also simplifies the library interface a lot (the caller 
no longer needs to worry about any of the per-directory exclude files at 
all).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 dir.c      |   28 +++++++++++++++++++++++++++-
 dir.h      |    2 --
 ls-files.c |   22 +---------------------
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/dir.c b/dir.c
index 3f41a5d..d40b62e 100644
--- a/dir.c
+++ b/dir.c
@@ -78,7 +78,7 @@ void add_excludes_from_file(struct dir_s
 		die("cannot use %s as an exclude file", fname);
 }
 
-int push_exclude_per_directory(struct dir_struct *dir, const char *base, int baselen)
+static int push_exclude_per_directory(struct dir_struct *dir, const char *base, int baselen)
 {
 	char exclude_file[PATH_MAX];
 	struct exclude_list *el = &dir->exclude_list[EXC_DIRS];
@@ -289,6 +289,32 @@ static int cmp_name(const void *p1, cons
 
 int read_directory(struct dir_struct *dir, const char *path, const char *base, int baselen)
 {
+	/*
+	 * Make sure to do the per-directory exclude for all the
+	 * directories leading up to our base.
+	 */
+	if (baselen) {
+		if (dir->exclude_per_dir) {
+			char *p, *pp = xmalloc(baselen+1);
+			memcpy(pp, base, baselen+1);
+			p = pp;
+			while (1) {
+				char save = *p;
+				*p = 0;
+				push_exclude_per_directory(dir, pp, p-pp);
+				*p++ = save;
+				if (!save)
+					break;
+				p = strchr(p, '/');
+				if (p)
+					p++;
+				else
+					p = pp + baselen;
+			}
+			free(pp);
+		}
+	}
+
 	read_directory_recursive(dir, path, base, baselen);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	return dir->nr;
diff --git a/dir.h b/dir.h
index e8fc441..4f65f57 100644
--- a/dir.h
+++ b/dir.h
@@ -44,7 +44,5 @@ extern int excluded(struct dir_struct *,
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *which);
-extern int push_exclude_per_directory(struct dir_struct *,
-				      const char *base, int baselen);
 
 #endif
diff --git a/ls-files.c b/ls-files.c
index 89941a3..dfe1481 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -215,28 +215,8 @@ static void show_files(struct dir_struct
 		const char *path = ".", *base = "";
 		int baselen = prefix_len;
 
-		if (baselen) {
+		if (baselen)
 			path = base = prefix;
-			if (dir->exclude_per_dir) {
-				char *p, *pp = xmalloc(baselen+1);
-				memcpy(pp, prefix, baselen+1);
-				p = pp;
-				while (1) {
-					char save = *p;
-					*p = 0;
-					push_exclude_per_directory(dir, pp, p-pp);
-					*p++ = save;
-					if (!save)
-						break;
-					p = strchr(p, '/');
-					if (p)
-						p++;
-					else
-						p = pp + baselen;
-				}
-				free(pp);
-			}
-		}
 		read_directory(dir, path, base, baselen);
 		if (show_others)
 			show_other_files(dir);
