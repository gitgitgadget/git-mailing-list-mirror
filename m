From: Linus Torvalds <torvalds@osdl.org>
Subject: git-fsck-objects: lacking default references should not be fatal
Date: Tue, 29 Aug 2006 11:47:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608291141140.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 29 20:48:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI8ce-0007W6-5g
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 20:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWH2Srg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 14:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbWH2Srg
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 14:47:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965126AbWH2Srg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Aug 2006 14:47:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7TIlVnW003778
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 29 Aug 2006 11:47:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7TIlUbY023819;
	Tue, 29 Aug 2006 11:47:31 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.432 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26213>


The comment added says it all: if we have lost all references in a git 
archive, git-fsck-objects should still work, so instead of dying it should 
just notify the user about that condition.

This change was triggered by me just doing a "git-init-db" and then 
populating that empty git archive with a pack/index file to look at it. 
Having git-fsck-objects not work just because I didn't have any references 
handy was rather irritating, since part of the reason for running 
git-fsck-objects in the first place was to _find_ the missing references.

However, "--unreachable" really doesn't make sense in that situation, and 
we want to turn it off to protect anybody who uses the old "git prune" 
shell-script (rather than the modern built-in). The old pruning script 
used to remove all objects that were reported as unreachable, and without 
any refs, that obviously means everything - not worth it.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

diff --git a/fsck-objects.c b/fsck-objects.c
index ae0ec8d..24286de 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -425,8 +425,23 @@ static int fsck_handle_ref(const char *r
 static void get_default_heads(void)
 {
 	for_each_ref(fsck_handle_ref);
-	if (!default_refs)
-		die("No default references");
+
+	/*
+	 * Not having any default heads isn't really fatal, but
+	 * it does mean that "--unreachable" no longer makes any
+	 * sense (since in this case everything will obviously
+	 * be unreachable by definition.
+	 *
+	 * Showing dangling objects is valid, though (as those
+	 * dangling objects are likely lost heads).
+	 *
+	 * So we just print a warning about it, and clear the
+	 * "show_unreachable" flag.
+	 */
+	if (!default_refs) {
+		error("No default references");
+		show_unreachable = 0;
+	}
 }
 
 static void fsck_object_dir(const char *path)
