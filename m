From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] Teach update-index about --ignore-submodules
Date: Wed, 14 May 2008 18:03:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141803370.30431@racer>
References: <alpine.DEB.1.00.0805141802480.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 14 19:04:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwKP8-0007wv-9s
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 19:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbYENRDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 13:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbYENRDo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 13:03:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:41665 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753223AbYENRDo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 13:03:44 -0400
Received: (qmail invoked by alias); 14 May 2008 17:03:42 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp047) with SMTP; 14 May 2008 19:03:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Zmq4cpVRZul8BgO5/ldNhBVyO1wKU35N76/91oK
	+1ng0/3qPGb1iJ
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0805141802480.30431@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82114>


Like with the diff machinery, update-index should sometimes just
ignore submodules (e.g. to determine a clean state before a rebase).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-update-index.txt |    5 +++++
 builtin-update-index.c             |    4 ++++
 cache.h                            |    1 +
 read-cache.c                       |    4 ++++
 4 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 66be18e..0664060 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	     [--cacheinfo <mode> <object> <file>]\*
 	     [--chmod=(+|-)x]
 	     [--assume-unchanged | --no-assume-unchanged]
+	     [--ignore-submodules]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin]
@@ -54,6 +55,10 @@ OPTIONS
         default behavior is to error out.  This option makes
         git-update-index continue anyway.
 
+--ignore-submodules:
+	Do not try to update submodules.  This option is only respected
+	when passed before --refresh.
+
 --unmerged::
         If --refresh finds unmerged changes in the index, the default
         behavior is to error out.  This option makes git-update-index
diff --git a/builtin-update-index.c b/builtin-update-index.c
index a8795d3..d4c85c0 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -593,6 +593,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				refresh_flags |= REFRESH_QUIET;
 				continue;
 			}
+			if (!strcmp(path, "--ignore-submodules")) {
+				refresh_flags |= REFRESH_IGNORE_SUBMODULES;
+				continue;
+			}
 			if (!strcmp(path, "--add")) {
 				allow_add = 1;
 				continue;
diff --git a/cache.h b/cache.h
index c761915..3d4e8e7 100644
--- a/cache.h
+++ b/cache.h
@@ -393,6 +393,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_UNMERGED	0x0002	/* allow unmerged */
 #define REFRESH_QUIET		0x0004	/* be quiet about it */
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
+#define REFRESH_IGNORE_SUBMODULES	0x0008	/* ignore submodules */
 extern int refresh_index(struct index_state *, unsigned int flags, const char **pathspec, char *seen);
 
 struct lock_file {
diff --git a/read-cache.c b/read-cache.c
index 8b467f8..bc03981 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -942,6 +942,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 	int allow_unmerged = (flags & REFRESH_UNMERGED) != 0;
 	int quiet = (flags & REFRESH_QUIET) != 0;
 	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
+	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
 	unsigned int options = really ? CE_MATCH_IGNORE_VALID : 0;
 
 	for (i = 0; i < istate->cache_nr; i++) {
@@ -949,6 +950,9 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 		int cache_errno = 0;
 
 		ce = istate->cache[i];
+		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
+			continue;
+
 		if (ce_stage(ce)) {
 			while ((i < istate->cache_nr) &&
 			       ! strcmp(istate->cache[i]->name, ce->name))
-- 
1.5.5.1.375.g1becb
