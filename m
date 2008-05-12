From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Make the exit code of add_file_to_index actually useful
Date: Mon, 12 May 2008 19:57:45 +0200
Message-ID: <20080512175745.GC3128@steel.home>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <alpine.LSU.1.00.0803021555500.22527@racer.site> <7vtzjpoye6.fsf@gitster.siamese.dyndns.org> <20080512175654.GB3128@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 12 19:58:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvcIH-0006sx-AQ
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 19:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260AbYELR5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 13:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049AbYELR5s
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 13:57:48 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:15056 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbYELR5r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 13:57:47 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+BInc
Received: from tigra.home (Fab5c.f.strato-dslnet.de [195.4.171.92])
	by post.webmailer.de (klopstock mo11) (RZmta 16.34)
	with ESMTP id 00251bk4CHDuca ; Mon, 12 May 2008 19:57:45 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 318B2277BD;
	Mon, 12 May 2008 19:57:45 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4437856D28; Mon, 12 May 2008 19:57:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080512175654.GB3128@steel.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81888>

Update the programs which used the function (as add_file_to_cache).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-add.c    |    6 ++++--
 builtin-commit.c |    7 ++++---
 builtin-mv.c     |    3 ++-
 read-cache.c     |    6 +++---
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 4a91e3e..4d72ab6 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -94,7 +94,8 @@ static void update_callback(struct diff_queue_struct *q,
 		case DIFF_STATUS_UNMERGED:
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
-			add_file_to_cache(path, verbose);
+			if (add_file_to_cache(path, verbose))
+				die("updating files failed");
 			break;
 		case DIFF_STATUS_DELETED:
 			remove_file_from_cache(path);
@@ -254,7 +255,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 
 	for (i = 0; i < dir.nr; i++)
-		add_file_to_cache(dir.entries[i]->name, verbose);
+		if (add_file_to_cache(dir.entries[i]->name, verbose))
+			die("adding files failed");
 
  finish:
 	if (active_cache_changed) {
diff --git a/builtin-commit.c b/builtin-commit.c
index a65c2b8..ae29d35 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -178,9 +178,10 @@ static void add_remove_files(struct path_list *list)
 		struct stat st;
 		struct path_list_item *p = &(list->items[i]);
 
-		if (!lstat(p->path, &st))
-			add_to_cache(p->path, &st, 0);
-		else
+		if (!lstat(p->path, &st)) {
+			if (add_to_cache(p->path, &st, 0))
+				die("updating files failed");
+		} else
 			remove_file_from_cache(p->path);
 	}
 }
diff --git a/builtin-mv.c b/builtin-mv.c
index 94f6dd2..fb8ffb4 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -256,7 +256,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		for (i = 0; i < added.nr; i++) {
 			const char *path = added.items[i].path;
-			add_file_to_cache(path, verbose);
+			if (add_file_to_cache(path, verbose))
+				die("updating index entries failed");
 		}
 
 		for (i = 0; i < deleted.nr; i++)
diff --git a/read-cache.c b/read-cache.c
index 0382804..8b467f8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -470,7 +470,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
 
 	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
-		die("%s: can only add regular files, symbolic links or git-directories", path);
+		return error("%s: can only add regular files, symbolic links or git-directories", path);
 
 	namelen = strlen(path);
 	if (S_ISDIR(st_mode)) {
@@ -505,12 +505,12 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		return 0;
 	}
 	if (index_path(ce->sha1, path, st, 1))
-		die("unable to index file %s", path);
+		return error("unable to index file %s", path);
 	if (ignore_case && alias && different_name(ce, alias))
 		ce = create_alias_ce(ce, alias);
 	ce->ce_flags |= CE_ADDED;
 	if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
-		die("unable to add %s to index",path);
+		return error("unable to add %s to index",path);
 	if (verbose)
 		printf("add '%s'\n", path);
 	return 0;
-- 
1.5.5.1.184.g5bee
