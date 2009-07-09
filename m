From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Too many 'stat' calls by git-status on Windows
Date: Wed, 8 Jul 2009 19:04:42 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 04:04:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOj0H-0004hp-Pb
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 04:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757069AbZGICEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 22:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756304AbZGICEq
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 22:04:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33407 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756200AbZGICEp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 22:04:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6924gDL021303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Jul 2009 19:04:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6924gRu025693;
	Wed, 8 Jul 2009 19:04:42 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090707000500.GA5594@dpotapov.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122929>



On Tue, 7 Jul 2009, Dmitry Potapov wrote:
> 
> It appears that the second 'stat' for files on Windows caused by lack
> of d_type in dirent. When I recompiled the Linux version with
> NO_D_TYPE_IN_DIRENT = YesPlease, I got the same result for files.
> (Still I am not sure what caused those extra stat calls for
> directory, maybe, it is Cygwin specific...)
> 
> The question is whether it is possible to avoid this redundant 'stat'
> for files on system that do not have d_type in dirent or that would
> require too much modification? Is it possible to use the cache where
> d_stat is not available provided that the entry is marked as uptodate?

Hmm. Sure. Something like this?

		Linus

---
 dir.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 74b3bbf..aaf269b 100644
--- a/dir.c
+++ b/dir.c
@@ -17,7 +17,7 @@ struct path_simplify {
 static int read_directory_recursive(struct dir_struct *dir,
 	const char *path, const char *base, int baselen,
 	int check_only, const struct path_simplify *simplify);
-static int get_dtype(struct dirent *de, const char *path);
+static int get_dtype(struct dirent *de, const char *path, int pathlen);
 
 int common_prefix(const char **pathspec)
 {
@@ -307,7 +307,7 @@ static int excluded_1(const char *pathname,
 
 			if (x->flags & EXC_FLAG_MUSTBEDIR) {
 				if (*dtype == DT_UNKNOWN)
-					*dtype = get_dtype(NULL, pathname);
+					*dtype = get_dtype(NULL, pathname, pathlen);
 				if (*dtype != DT_DIR)
 					continue;
 			}
@@ -547,14 +547,18 @@ static int in_pathspec(const char *path, int len, const struct path_simplify *si
 	return 0;
 }
 
-static int get_dtype(struct dirent *de, const char *path)
+static int get_dtype(struct dirent *de, const char *path, int pathlen)
 {
 	int dtype = de ? DTYPE(de) : DT_UNKNOWN;
+	struct cache_entry *ce;
 	struct stat st;
 
 	if (dtype != DT_UNKNOWN)
 		return dtype;
-	if (lstat(path, &st))
+	ce = cache_name_exists(path, pathlen, 0);
+	if (ce && ce_uptodate(ce))
+		st.st_mode = ce->ce_mode;
+	else if (lstat(path, &st))
 		return dtype;
 	if (S_ISREG(st.st_mode))
 		return DT_REG;
@@ -613,7 +617,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 				continue;
 
 			if (dtype == DT_UNKNOWN)
-				dtype = get_dtype(de, fullname);
+				dtype = get_dtype(de, fullname, baselen + len);
 
 			/*
 			 * Do we want to see just the ignored files?
