From: Junio C Hamano <gitster@pobox.com>
Subject: Re:* [BUG] "git clean" does not pay attention to its parameters
Date: Tue, 04 Dec 2007 23:55:41 -0800
Message-ID: <7veje1zibm.fsf@gitster.siamese.dyndns.org>
References: <200712050654.lB56scKk000311@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 08:57:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izp85-00055p-7a
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 08:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbXLEHzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 02:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbXLEHzw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 02:55:52 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55138 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211AbXLEHzv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 02:55:51 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 200212EF;
	Wed,  5 Dec 2007 02:56:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5E0D89B423;
	Wed,  5 Dec 2007 02:56:07 -0500 (EST)
In-Reply-To: <200712050654.lB56scKk000311@mi0.bluebottle.com> (Nanako
	Shiraishi's message of "Wed, 5 Dec 2007 15:54:06 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67119>

Nanako Shiraishi <nanako3@bluebottle.com> writes:

> In a repository with LaTeX documents, I tried to see what *.aux files are left behind after formatting, by running "git clean -n" with the latest git (1.5.3.7-1005-gdada0c1):
>
>   % git clean -n '*.aux'
>
> This however showed more than just '*.aux' files.  With the released version 1.5.3.6, the output is correctly limited to the files that match the pattern.

Yuck.  People actually use git-clean?

But thanks for reporting.

Comparing the corresponding part from builtin-ls-files.c and what
builtin-clean.c does, it does look broken.

Does this patch help?  I am not sure why the directory side of the code
is written that way, but I have a suspicion that "was a directory
explicitly given as one of the pathspec" check is also bogus, although I
did not touch that part.

-- >8 --
[PATCH] git-clean: Honor pathspec.

git-clean "*.rej" should attempt to look at only paths that match
pattern "*.rej", but rewrite to C broke it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-clean.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 56ae4eb..7dd901e 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -27,13 +27,14 @@ static int git_clean_config(const char *var, const char *value)
 
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
-	int j;
+	int i;
 	int show_only = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, baselen = 0, config_set = 0;
 	struct strbuf directory;
 	struct dir_struct dir;
 	const char *path, *base;
 	static const char **pathspec;
+	char *seen = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet),
 		OPT__DRY_RUN(&show_only),
@@ -85,12 +86,17 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	read_directory(&dir, path, base, baselen, pathspec);
 	strbuf_init(&directory, 0);
 
-	for (j = 0; j < dir.nr; ++j) {
-		struct dir_entry *ent = dir.entries[j];
-		int len, pos, specs;
+	if (pathspec) {
+		for (i = 0; pathspec[i]; i++)
+			; /* nothing */
+		seen = xmalloc();
+	}
+
+	for (i = 0; i < dir.nr; i++) {
+		struct dir_entry *ent = dir.entries[i];
+		int len, pos;
 		struct cache_entry *ce;
 		struct stat st;
-		char *seen;
 
 		/*
 		 * Remove the '/' at the end that directory
@@ -114,15 +120,13 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			int matched_path = 0;
 			strbuf_addstr(&directory, ent->name);
 			if (pathspec) {
-				for (specs =0; pathspec[specs]; ++specs)
-					/* nothing */;
-				seen = xcalloc(specs, 1);
-				/* Check if directory was explictly passed as
-				 * pathspec.  If so we want to remove it */
+				/*
+				 * Check if directory was explictly passed as
+				 * pathspec. If so we want to remove it.
+				 */
 				if (match_pathspec(pathspec, ent->name, ent->len,
 						   baselen, seen))
 					matched_path = 1;
-				free(seen);
 			}
 			if (show_only && (remove_directories || matched_path)) {
 				printf("Would remove %s\n", directory.buf);
@@ -138,6 +142,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			}
 			strbuf_reset(&directory);
 		} else {
+			if (pathspec &&
+			    !match_pathspec(pathspec, ent->name, ent->len,
+					    baselen, seen))
+				continue; /* excluded */
 			if (show_only) {
 				printf("Would remove %s\n", ent->name);
 				continue;
@@ -147,6 +155,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			unlink(ent->name);
 		}
 	}
+	free(seen);
 
 	strbuf_release(&directory);
 	return 0;
-- 
1.5.3.7-2115-geb804
