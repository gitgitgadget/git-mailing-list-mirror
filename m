From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Sat, 12 Jan 2008 14:01:09 +0100
Message-ID: <4788BA15.3050804@lsrfire.ath.cx>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <200801120926.14307.ismail@pardus.org.tr> <7vejcnwl85.fsf@gitster.siamese.dyndns.org> <200801120947.48602.ismail@pardus.org.tr> <20080112090432.GA6134@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Ismail_D=F6nmez?= <ismail@pardus.org.tr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 14:02:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDg0d-0000ZH-4Q
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 14:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763642AbYALNBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 08:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763641AbYALNBr
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 08:01:47 -0500
Received: from india601.server4you.de ([85.25.151.105]:54318 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762306AbYALNBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 08:01:46 -0500
Received: from [10.0.1.201] (p57B7FF5E.dip.t-dialin.net [87.183.255.94])
	by india601.server4you.de (Postfix) with ESMTP id ABBFB2F8064;
	Sat, 12 Jan 2008 14:01:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20080112090432.GA6134@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70313>

Jeff King schrieb:
> Thus allocating "seen" based upon just argc is wrong, since
> if argc == 0, then we still have one pathspec, the prefix,
> but we don't allocate any space in "seen".

Yes, all the other callers count the number of elements in pathspec
and allocate seen accordingly.  We could do that.  Or we could
extend match_pathspec() to allow seen to be a NULL pointer, for
those cases where this result isn't needed.

This patch is for discussion, only, because it touches central,
non-buggy code and where in bugfix only mode.  And I'm not really
sure git-clean ignoring non-matching pathspecs (as it does now,
even without this patch) is really what we want.

 builtin-clean.c |    8 +-------
 dir.c           |   26 ++++++++++++++++----------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 6cad8ea..40d976c 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -35,7 +35,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	const char *path, *base;
 	static const char **pathspec;
 	int prefix_offset = 0;
-	char *seen = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet),
 		OPT__DRY_RUN(&show_only),
@@ -89,9 +88,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	read_directory(&dir, path, base, baselen, pathspec);
 	strbuf_init(&directory, 0);
 
-	if (pathspec)
-		seen = xmalloc(argc);
-
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		int len, pos, matches;
@@ -125,9 +121,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			continue;
 
 		if (pathspec) {
-			memset(seen, 0, argc);
 			matches = match_pathspec(pathspec, ent->name, ent->len,
-						 baselen, seen);
+						 baselen, NULL);
 		} else {
 			matches = 0;
 		}
@@ -165,7 +160,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			unlink(ent->name);
 		}
 	}
-	free(seen);
 
 	strbuf_release(&directory);
 	return 0;
diff --git a/dir.c b/dir.c
index 3e345c2..6af70ac 100644
--- a/dir.c
+++ b/dir.c
@@ -88,32 +88,38 @@ static int match_one(const char *match, const char *name, int namelen)
 
 /*
  * Given a name and a list of pathspecs, see if the name matches
- * any of the pathspecs.  The caller is also interested in seeing
- * all pathspec matches some names it calls this function with
- * (otherwise the user could have mistyped the unmatched pathspec),
- * and a mark is left in seen[] array for pathspec element that
- * actually matched anything.
+ * any of the pathspecs.
+ * If the caller is interested in which of the pathspecs matched,
+ * seen needs to point to a char array with as many members as there
+ * are pathspecs.  A mark is left at the nth element of the nth
+ * pathspec matched the name.  The marks are not reset, so the
+ * caller can check, after matching a list of files, if there are
+ * any unmatched pathspecs (which might have been mistyped).
  */
 int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen)
 {
-	int retval;
-	const char *match;
+	int retval = 0;
 
 	name += prefix;
 	namelen -= prefix;
 
-	for (retval = 0; (match = *pathspec++) != NULL; seen++) {
+	while (*pathspec) {
+		const char *match = *pathspec++;
 		int how;
-		if (retval && *seen == MATCHED_EXACTLY)
+
+		if (retval && seen && *seen == MATCHED_EXACTLY)
 			continue;
+
 		match += prefix;
 		how = match_one(match, name, namelen);
 		if (how) {
 			if (retval < how)
 				retval = how;
-			if (*seen < how)
+			if (seen && *seen < how)
 				*seen = how;
 		}
+		if (seen)
+			seen++;
 	}
 	return retval;
 }
