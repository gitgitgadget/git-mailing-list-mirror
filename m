From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC] Making ce_path_match() more useful by accepting globs
Date: Sun, 25 Nov 2007 10:03:12 -0800
Message-ID: <7vr6ienqxr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus@sceptre.sasl.smtp.pobox.com,
	"Torvalds <torvalds"@linux-fundation.org
X-From: git-owner@vger.kernel.org Sun Nov 25 19:03:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwLpV-0001Xl-Mq
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 19:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbXKYSDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 13:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbXKYSDU
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 13:03:20 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34960 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbXKYSDT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 13:03:19 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C6CE52EF;
	Sun, 25 Nov 2007 13:03:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 224B899997;
	Sun, 25 Nov 2007 13:03:36 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65976>

Currently ce_path_match() only uses "the leading directory" match, and
does not understand file globs.  These do not work:

   git diff-files 't/*.sh'
   git diff-index HEAD 'xdiff/*.c'
   git update-index -g 'Documentation/howto/*.txt'

This teaches the ce_path_match(), the underlying function that are used
for checking if a given cache entry matches the given set of pathspecs,
to use the match_pathspec() from git-ls-files, which knows about glob
patterns.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Having two different behaviours of pathspec matching has been
   bothering me for quite some time.  The changes here look trivially
   correct and the result passes all the tests, but this is quite close
   to the core part of the system, and would benefit greatly from extra
   set of eyes.

   This patch does not touch the tree walker, and does not affect
   diff-tree nor ancestry pruning done in the revision traversal.  That
   however is even closer to the core and is performance critical.  It
   needs to be done carefully not to descend into trees that would never
   match needlessly.  IOW, not today.

 dir.c        |    5 +++--
 read-cache.c |   17 ++---------------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/dir.c b/dir.c
index 225fdfb..be640c9 100644
--- a/dir.c
+++ b/dir.c
@@ -98,20 +98,21 @@ int match_pathspec(const char **pathspec, const char *name, int namelen, int pre
 {
 	int retval;
 	const char *match;
+	int want_seen = !!seen;
 
 	name += prefix;
 	namelen -= prefix;
 
 	for (retval = 0; (match = *pathspec++) != NULL; seen++) {
 		int how;
-		if (retval && *seen == MATCHED_EXACTLY)
+		if (retval && seen && want_seen && *seen == MATCHED_EXACTLY)
 			continue;
 		match += prefix;
 		how = match_one(match, name, namelen);
 		if (how) {
 			if (retval < how)
 				retval = how;
-			if (*seen < how)
+			if (want_seen && *seen < how)
 				*seen = how;
 		}
 	}
diff --git a/read-cache.c b/read-cache.c
index 7db5588..767464e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -472,7 +472,7 @@ int ce_same_name(struct cache_entry *a, struct cache_entry *b)
 
 int ce_path_match(const struct cache_entry *ce, const char **pathspec)
 {
-	const char *match, *name;
+	const char *name;
 	int len;
 
 	if (!pathspec)
@@ -480,20 +480,7 @@ int ce_path_match(const struct cache_entry *ce, const char **pathspec)
 
 	len = ce_namelen(ce);
 	name = ce->name;
-	while ((match = *pathspec++) != NULL) {
-		int matchlen = strlen(match);
-		if (matchlen > len)
-			continue;
-		if (memcmp(name, match, matchlen))
-			continue;
-		if (matchlen && name[matchlen-1] == '/')
-			return 1;
-		if (name[matchlen] == '/' || !name[matchlen])
-			return 1;
-		if (!matchlen)
-			return 1;
-	}
-	return 0;
+	return !!match_pathspec(pathspec, name, len, 0, NULL);
 }
 
 /*
