From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/7] Add 'core.ignorecase' option
Date: Sat, 22 Mar 2008 10:33:37 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803221030380.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221025410.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221028170.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank <streamlake@tiscali.it>, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 18:34:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd7cC-0005dN-0V
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 18:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbYCVReB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 13:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753939AbYCVReB
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 13:34:01 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37100 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753911AbYCVReA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 13:34:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHXd1a002494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 10:33:40 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHXbLY019664;
	Sat, 22 Mar 2008 10:33:38 -0700
In-Reply-To: <alpine.LFD.1.00.0803221028170.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.756 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77832>


From: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date: Fri, 21 Mar 2008 16:52:46 -0700

..and start using it for directory entry traversal (ie "git status" will
not consider entries that match an existing entry case-insensitively to
be a new file)

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Basically all of this patch is just setting up the "ignore_case" variable 
(default to false), but this one-liner in "dir_add_name()" is the actual 
meat of it all:

	-	if (cache_name_exists(pathname, len, 0))
	+	if (cache_name_exists(pathname, len, ignore_case))

because it now means that we will ignore unknown directory entries that 
match already-known files if they match case-insensitively and we have 
core.ignorecase being set.

So this actually starts using the case insensitivity logic, but it's for a 
really quite trivial and not very interesting case. 

 cache.h       |    1 +
 config.c      |    5 +++++
 dir.c         |    2 +-
 environment.c |    1 +
 4 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index a9ddaa1..9bce723 100644
--- a/cache.h
+++ b/cache.h
@@ -407,6 +407,7 @@ extern int delete_ref(const char *, const unsigned char *sha1);
 extern int trust_executable_bit;
 extern int quote_path_fully;
 extern int has_symlinks;
+extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
diff --git a/config.c b/config.c
index 0624494..3d51868 100644
--- a/config.c
+++ b/config.c
@@ -342,6 +342,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.ignorecase")) {
+		ignore_case = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
 		return 0;
diff --git a/dir.c b/dir.c
index 7362e83..b5bfbca 100644
--- a/dir.c
+++ b/dir.c
@@ -371,7 +371,7 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 
 struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (cache_name_exists(pathname, len, 0))
+	if (cache_name_exists(pathname, len, ignore_case))
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
diff --git a/environment.c b/environment.c
index 6739a3f..5fcd5b2 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@ char git_default_name[MAX_GITNAME];
 int trust_executable_bit = 1;
 int quote_path_fully = 1;
 int has_symlinks = 1;
+int ignore_case = 0;
 int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
-- 
1.5.5.rc0.28.g61a0.dirty
