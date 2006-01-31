From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/2] Make the "struct tree_desc" operations available to
 others
Date: Tue, 31 Jan 2006 14:10:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601311407460.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jan 31 23:12:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F43iM-0005S2-QX
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 23:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWAaWLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 17:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWAaWLD
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 17:11:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751674AbWAaWLA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 17:11:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0VMAuDZ009911
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 14:10:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0VMAuWJ002624;
	Tue, 31 Jan 2006 14:10:56 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15356>


We have operations to "extract" and "update" a "struct tree_desc", but we 
only used them in tree-diff.c and they were static to that file.

But other tree traversal functions can use them to their advantage

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This is just infrastructure. No real changes, except for the renaming of 
the "extract()" function to make it have a more palatable name when it's
globally visible.

diff --git a/diff.h b/diff.h
index 9a0169c..32134d7 100644
--- a/diff.h
+++ b/diff.h
@@ -13,6 +13,9 @@ struct tree_desc {
 	unsigned long size;
 };
 
+extern void update_tree_entry(struct tree_desc *);
+extern const unsigned char *tree_entry_extract(struct tree_desc *, const char **, unsigned int *);
+
 struct diff_options;
 
 typedef void (*change_fn_t)(struct diff_options *options,
diff --git a/tree-diff.c b/tree-diff.c
index 382092b..d978428 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -9,7 +9,7 @@ static int nr_paths = 0;
 static const char **paths = NULL;
 static int *pathlens = NULL;
 
-static void update_tree_entry(struct tree_desc *desc)
+void update_tree_entry(struct tree_desc *desc)
 {
 	void *buf = desc->buf;
 	unsigned long size = desc->size;
@@ -21,7 +21,7 @@ static void update_tree_entry(struct tre
 	desc->size = size - len;
 }
 
-static const unsigned char *extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
+const unsigned char *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
 {
 	void *tree = desc->buf;
 	unsigned long size = desc->size;
@@ -56,8 +56,8 @@ static int compare_tree_entry(struct tre
 	const unsigned char *sha1, *sha2;
 	int cmp, pathlen1, pathlen2;
 
-	sha1 = extract(t1, &path1, &mode1);
-	sha2 = extract(t2, &path2, &mode2);
+	sha1 = tree_entry_extract(t1, &path1, &mode1);
+	sha2 = tree_entry_extract(t2, &path2, &mode2);
 
 	pathlen1 = strlen(path1);
 	pathlen2 = strlen(path2);
@@ -109,7 +109,7 @@ static int interesting(struct tree_desc 
 	if (!nr_paths)
 		return 1;
 
-	(void)extract(desc, &path, &mode);
+	(void)tree_entry_extract(desc, &path, &mode);
 
 	pathlen = strlen(path);
 	baselen = strlen(base);
@@ -167,7 +167,7 @@ static int show_entry(struct diff_option
 {
 	unsigned mode;
 	const char *path;
-	const unsigned char *sha1 = extract(desc, &path, &mode);
+	const unsigned char *sha1 = tree_entry_extract(desc, &path, &mode);
 
 	if (opt->recursive && S_ISDIR(mode)) {
 		char type[20];
