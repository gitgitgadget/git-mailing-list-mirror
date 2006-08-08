From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Racy git: avoid having to be always too careful
Date: Wed, 9 Aug 2006 01:44:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608090143410.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0607310945490.4168@g5.osdl.org>
 <7virl7e8ed.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0608081659320.1800@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6zrw352.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0608090030080.1800@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vpsfau8qn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 01:44:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAbFA-0003zX-QJ
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 01:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWHHXoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 19:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWHHXoN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 19:44:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:20378 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030339AbWHHXoM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 19:44:12 -0400
Received: (qmail invoked by alias); 08 Aug 2006 23:44:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 09 Aug 2006 01:44:10 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsfau8qn.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25101>

Hi,

On Tue, 8 Aug 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Okay, how about 100 paths? And make _this_ a config variable?
> 
> Actually, I have a better patch I'll be pushing out in "next"
> this evening.

Pity. I just whipped up this patch...

-- 8< --
[PATCH] read-cache: introduce core.racyThreshold

The expensive sleep is done only when there are more than 100 updated
files now. This number is overrideable by the core.racyThreshold variable.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Documentation/config.txt |    5 +++++
 cache.h                  |    1 +
 config.c                 |    5 +++++
 environment.c            |    1 +
 read-cache.c             |    2 +-
 5 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d89916b..f428fb5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -103,6 +103,11 @@ core.legacyheaders::
 	database directly (where the "http://" and "rsync://" protocols
 	count as direct access).
 
+core.racyThreshold::
+	The number of files which need to be updated at least, before
+	read-cache sleeps to make the timestamps of these files and the
+	timestamp of the index file distinct.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/cache.h b/cache.h
index 19fdef6..8c0a830 100644
--- a/cache.h
+++ b/cache.h
@@ -193,6 +193,7 @@ extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
 extern int zlib_compression_level;
+extern int racy_threshold;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index c6e6f6a..01b8c23 100644
--- a/config.c
+++ b/config.c
@@ -291,6 +291,11 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
+	if (!strcmp(var, "core.racythreshold")) {
+		racy_threshold = git_config_int(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		strlcpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
diff --git a/environment.c b/environment.c
index 1ce3411..3656f36 100644
--- a/environment.c
+++ b/environment.c
@@ -24,6 +24,7 @@ const char *apply_default_whitespace = N
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
 int pager_in_use;
 int pager_use_color = 1;
+int racy_threshold = 100;
 
 static int dyn_git_object_dir, dyn_git_index_file, dyn_git_graft_file;
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
diff --git a/read-cache.c b/read-cache.c
index d64b503..42a3f78 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1021,7 +1021,7 @@ int write_cache(int newfd, struct cache_
 	 * This assumes that nobody is touching the working tree while
 	 * we are updating the index.
 	 */
-	if (20 < recent || entries <= recent * 4) {
+	if (racy_threshold < recent) {
 		now = fstat(newfd, &st) ? 0 : st.st_mtime;
 		while (now && !fstat(newfd, &st) && st.st_mtime <= now) {
 			struct timespec rq, rm;
-- 
1.4.2.rc3.gfa72-dirty
