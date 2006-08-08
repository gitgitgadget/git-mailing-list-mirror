From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Racy git: avoid having to be always too careful
Date: Tue, 8 Aug 2006 17:43:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608081659320.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0607310945490.4168@g5.osdl.org>
 <7virl7e8ed.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 17:43:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GATjx-0008On-2I
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 17:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWHHPnZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 11:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWHHPnY
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 11:43:24 -0400
Received: from mail.gmx.de ([213.165.64.20]:14000 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964972AbWHHPnW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 11:43:22 -0400
Received: (qmail invoked by alias); 08 Aug 2006 15:43:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 08 Aug 2006 17:43:21 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virl7e8ed.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25071>

Hi,

On Sat, 5 Aug 2006, Junio C Hamano wrote:

> Immediately after a bulk checkout, most of the paths in the
> working tree would have the same timestamp as the index file,
> and this would force ce_match_stat() to take slow path for all
> of them.  When writing an index file out, if many of the paths
> have very new (read: the same timestamp as the index file being
> written out) timestamp, we are better off delaying the return
> from the command, to make sure that later command to touch the
> working tree files will leave newer timestamps than recorded in
> the index, thereby avoiding to take the slow path.

This makes "make test" dog slow. How about making this overrideable?
(It is just a guess, but I _think_ that the sleeping is worse than having 
to check the files with the same time stamp again and again -- a "git 
status" will help that).

"make test" without this patch:

	real    9m59.314s
	user    0m36.580s
	sys     0m39.290s

"make test" with this patch:

	real    1m36.429s
	user    0m37.410s
	sys     0m40.460s

-- 8< --
[PATCH] read-cache: optionally disable being cautious with racy caches

By setting the environment variable GIT_RISK_RACY_CACHE or the config
variable core.riskRacyCache, the sleeping (to avoid a racy cache) is
disabled. This is also used for "make test", drastically reducing the
needed time.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Documentation/config.txt |    4 ++++
 Documentation/git.txt    |    5 +++++
 cache.h                  |    1 +
 config.c                 |    4 ++++
 environment.c            |    1 +
 read-cache.c             |    3 ++-
 t/test-lib.sh            |    2 ++
 7 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d89916b..b61fd91 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -103,6 +103,10 @@ core.legacyheaders::
 	database directly (where the "http://" and "rsync://" protocols
 	count as direct access).
 
+core.riskRacyCache::
+	A boolean which allows to disable the 1-second sleeping to avoid
+	a racy cache.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/Documentation/git.txt b/Documentation/git.txt
index ba525d3..ff464e8 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -649,6 +649,11 @@ other
 	stderr telling about alias expansion, built-in command
 	execution and external command execution.
 
+'GIT_RISK_RACY_CACHE'::
+	If this variable is set, gitlink:git-read-cache[1] will never
+	sleep to avoid a racy cache by making the timestamps of the index
+	file newer than the files referenced in the index.
+
 Discussion[[Discussion]]
 ------------------------
 include::README[]
diff --git a/cache.h b/cache.h
index 19fdef6..e8bbe6d 100644
--- a/cache.h
+++ b/cache.h
@@ -174,6 +174,7 @@ #define REFRESH_UNMERGED	0x0002	/* allow
 #define REFRESH_QUIET		0x0004	/* be quiet about it */
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
 extern int refresh_cache(unsigned int flags);
+extern int risk_racy_cache;
 
 struct lock_file {
 	struct lock_file *next;
diff --git a/config.c b/config.c
index c6e6f6a..4ab9329 100644
--- a/config.c
+++ b/config.c
@@ -291,6 +291,10 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
+	if (!strcmp(var, "core.riskracycache")) {
+		risk_racy_cache = git_config_bool(var, value);
+	}
+
 	if (!strcmp(var, "user.name")) {
 		strlcpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
diff --git a/environment.c b/environment.c
index 1ce3411..a481fc4 100644
--- a/environment.c
+++ b/environment.c
@@ -24,6 +24,7 @@ const char *apply_default_whitespace = N
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
 int pager_in_use;
 int pager_use_color = 1;
+int risk_racy_cache = 0;
 
 static int dyn_git_object_dir, dyn_git_index_file, dyn_git_graft_file;
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
diff --git a/read-cache.c b/read-cache.c
index d64b503..f20dac5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1021,7 +1021,8 @@ int write_cache(int newfd, struct cache_
 	 * This assumes that nobody is touching the working tree while
 	 * we are updating the index.
 	 */
-	if (20 < recent || entries <= recent * 4) {
+	if (!risk_racy_cache && !getenv("GIT_RISK_RACY_CACHE") &&
+			(20 < recent || entries <= recent * 4)) {
 		now = fstat(newfd, &st) ? 0 : st.st_mtime;
 		while (now && !fstat(newfd, &st) && st.st_mtime <= now) {
 			struct timespec rq, rm;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b6d119a..3b6882d 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -197,6 +197,8 @@ # t/ subdirectory and are run in trash s
 PATH=$(pwd)/..:$PATH
 GIT_EXEC_PATH=$(pwd)/..
 export PATH GIT_EXEC_PATH
+GIT_RISK_RACY_CACHE=1
+export GIT_RISK_RACY_CACHE
 
 # Similarly use ../compat/subprocess.py if our python does not
 # have subprocess.py on its own.
-- 
1.4.2.rc3.g6b27
