From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/3] Keep track of whether a pack is local or not
Date: Thu, 13 Oct 2005 14:26:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510131426180.23590@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 13 23:28:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQAbH-0005Nk-9L
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 23:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVJMV0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 17:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbVJMV0w
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 17:26:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2498 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964860AbVJMV0v (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 17:26:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9DLQb4s023919
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Oct 2005 14:26:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9DLQaQ7003018;
	Thu, 13 Oct 2005 14:26:36 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10090>


If we want to re-pack just local packfiles, we need to know whether a
particular object is local or not.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/cache.h b/cache.h
index 1a7e047..3286582 100644
--- a/cache.h
+++ b/cache.h
@@ -313,6 +313,7 @@ extern struct packed_git {
 	void *pack_base;
 	unsigned int pack_last_used;
 	unsigned int pack_use_cnt;
+	int pack_local;
 	unsigned char sha1[20];
 	char pack_name[0]; /* something like ".git/objects/pack/xxxxx.pack" */
 } *packed_git;
@@ -352,7 +353,7 @@ extern struct packed_git *find_sha1_pack
 
 extern int use_packed_git(struct packed_git *);
 extern void unuse_packed_git(struct packed_git *);
-extern struct packed_git *add_packed_git(char *, int);
+extern struct packed_git *add_packed_git(char *, int, int);
 extern int num_packed_objects(const struct packed_git *p);
 extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
 extern int find_pack_entry_one(const unsigned char *, struct pack_entry *, struct packed_git *);
diff --git a/sha1_file.c b/sha1_file.c
index f059004..e456799 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -416,7 +416,7 @@ int use_packed_git(struct packed_git *p)
 	return 0;
 }
 
-struct packed_git *add_packed_git(char *path, int path_len)
+struct packed_git *add_packed_git(char *path, int path_len, int local)
 {
 	struct stat st;
 	struct packed_git *p;
@@ -444,6 +444,7 @@ struct packed_git *add_packed_git(char *
 	p->pack_base = NULL;
 	p->pack_last_used = 0;
 	p->pack_use_cnt = 0;
+	p->pack_local = local;
 	return p;
 }
 
@@ -484,7 +485,7 @@ void install_packed_git(struct packed_gi
 	packed_git = pack;
 }
 
-static void prepare_packed_git_one(char *objdir)
+static void prepare_packed_git_one(char *objdir, int local)
 {
 	char path[PATH_MAX];
 	int len;
@@ -506,7 +507,7 @@ static void prepare_packed_git_one(char 
 
 		/* we have .idx.  Is it a file we can map? */
 		strcpy(path + len, de->d_name);
-		p = add_packed_git(path, len + namelen);
+		p = add_packed_git(path, len + namelen, local);
 		if (!p)
 			continue;
 		p->next = packed_git;
@@ -522,11 +523,11 @@ void prepare_packed_git(void)
 
 	if (run_once)
 		return;
-	prepare_packed_git_one(get_object_directory());
+	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
 		alt->name[0] = 0;
-		prepare_packed_git_one(alt->base);
+		prepare_packed_git_one(alt->base, 0);
 	}
 	run_once = 1;
 }
diff --git a/verify-pack.c b/verify-pack.c
index 80b60a6..c99db9d 100644
--- a/verify-pack.c
+++ b/verify-pack.c
@@ -15,12 +15,12 @@ static int verify_one_pack(char *arg, in
 			len--;
 		}
 		/* Should name foo.idx now */
-		if ((g = add_packed_git(arg, len)))
+		if ((g = add_packed_git(arg, len, 1)))
 			break;
 		/* No?  did you name just foo? */
 		strcpy(arg + len, ".idx");
 		len += 4;
-		if ((g = add_packed_git(arg, len)))
+		if ((g = add_packed_git(arg, len, 1)))
 			break;
 		return error("packfile %s not found.", arg);
 	}
