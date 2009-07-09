From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have an
 up-to-date cache entry
Date: Wed, 8 Jul 2009 19:43:50 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 04:44:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOjcg-0005kU-7c
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 04:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792AbZGICo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 22:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757531AbZGICo2
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 22:44:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52916 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757305AbZGICo1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 22:44:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n692hoht024621
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Jul 2009 19:43:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n692ho0q009842;
	Wed, 8 Jul 2009 19:43:50 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122933>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Jul 2009 19:31:49 -0700
Subject: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have an up-to-date cache entry

On filesystems without d_type, we can look at the cache entry first.
Doing an lstat() can be expensive.

Reported by Dmitry Potapov for Cygwin.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is the same patch I already sent Dmitry, but now it applies on top of 
the cleaned-up read_directory_recursive() code.

 dir.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index b0671f5..8a9e7d8 100644
--- a/dir.c
+++ b/dir.c
@@ -16,7 +16,7 @@ struct path_simplify {
 
 static int read_directory_recursive(struct dir_struct *dir, const char *path, int len,
 	int check_only, const struct path_simplify *simplify);
-static int get_dtype(struct dirent *de, const char *path);
+static int get_dtype(struct dirent *de, const char *path, int len);
 
 static int common_prefix(const char **pathspec)
 {
@@ -326,7 +326,7 @@ static int excluded_1(const char *pathname,
 
 			if (x->flags & EXC_FLAG_MUSTBEDIR) {
 				if (*dtype == DT_UNKNOWN)
-					*dtype = get_dtype(NULL, pathname);
+					*dtype = get_dtype(NULL, pathname, pathlen);
 				if (*dtype != DT_DIR)
 					continue;
 			}
@@ -566,14 +566,18 @@ static int in_pathspec(const char *path, int len, const struct path_simplify *si
 	return 0;
 }
 
-static int get_dtype(struct dirent *de, const char *path)
+static int get_dtype(struct dirent *de, const char *path, int len)
 {
 	int dtype = de ? DTYPE(de) : DT_UNKNOWN;
+	struct cache_entry *ce;
 	struct stat st;
 
 	if (dtype != DT_UNKNOWN)
 		return dtype;
-	if (lstat(path, &st))
+	ce = cache_name_exists(path, len, 0);
+	if (ce && ce_uptodate(ce))
+		st.st_mode = ce->ce_mode;
+	else if (lstat(path, &st))
 		return dtype;
 	if (S_ISREG(st.st_mode))
 		return DT_REG;
@@ -633,7 +637,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *base, in
 				continue;
 
 			if (dtype == DT_UNKNOWN)
-				dtype = get_dtype(de, path);
+				dtype = get_dtype(de, path, len);
 
 			/*
 			 * Do we want to see just the ignored files?
-- 
1.6.3.3.412.gf581d
