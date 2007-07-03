From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Add core.pager config variable.
Date: Tue, 3 Jul 2007 14:18:11 -0400
Message-ID: <20070703181811.GA17966@Hermes.local>
References: <Pine.LNX.4.64.0707031729370.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 20:18:19 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5mx5-0003mk-Al
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 20:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802AbXGCSSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 14:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755711AbXGCSSN
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 14:18:13 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:51108 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbXGCSSM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 14:18:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 898641FFC02E;
	Tue,  3 Jul 2007 18:18:11 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707031729370.4071@racer.site>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51519>

This adds a configuration variable that performs the same function as,
but is overridden by, GIT_PAGER.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 Since Johannes agrees, core.pager it is.  :-)

 Documentation/config.txt |    4 ++++
 cache.h                  |    1 +
 config.c                 |    5 +++++
 environment.c            |    1 +
 pager.c                  |    2 ++
 5 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1d96adf..d319359 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -281,6 +281,10 @@ core.excludesfile::
 	of files which are not meant to be tracked.  See
 	gitlink:gitignore[5].
 
+core.pager::
+	The command that git will use to paginatee output.  Can be overridden
+	with the `GIT_PAGER` environment variable.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/cache.h b/cache.h
index 0d23a25..e64071e 100644
--- a/cache.h
+++ b/cache.h
@@ -546,6 +546,7 @@ extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char
 
 /* pager.c */
 extern void setup_pager(void);
+extern char *pager_program;
 extern int pager_in_use;
 extern int pager_use_color;
 
diff --git a/config.c b/config.c
index 4de8926..561ee3b 100644
--- a/config.c
+++ b/config.c
@@ -387,6 +387,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.pager")) {
+		pager_program = xstrdup(value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 1c2773f..f83fb9e 100644
--- a/environment.c
+++ b/environment.c
@@ -30,6 +30,7 @@ int core_compression_seen;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 16 * 1024 * 1024;
+char *pager_program;
 int pager_in_use;
 int pager_use_color = 1;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
diff --git a/pager.c b/pager.c
index 5f280ab..3bfed02 100644
--- a/pager.c
+++ b/pager.c
@@ -32,6 +32,8 @@ void setup_pager(void)
 	if (!isatty(1))
 		return;
 	if (!pager)
+		pager = pager_program;
+	if (!pager)
 		pager = getenv("PAGER");
 	if (!pager)
 		pager = "less";
-- 
1.5.3.rc0
