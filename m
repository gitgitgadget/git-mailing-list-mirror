From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Do "git add" as a builtin
Date: Wed, 17 May 2006 13:23:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605171321020.10823@g5.osdl.org>
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
 <7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 22:23:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgSYU-0007aA-12
	for gcvg-git@gmane.org; Wed, 17 May 2006 22:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWEQUXY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 16:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWEQUXY
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 16:23:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751079AbWEQUXY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 16:23:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HKNKtH007923
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 13:23:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HKNJ4J025195;
	Wed, 17 May 2006 13:23:19 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20239>



On Wed, 17 May 2006, Junio C Hamano wrote:
> 
> By "not seeing the point", do you mean you do not agree with
> what bba319b5 and 45e48120 tried to do to help users?

Naah, I just didn't see why, and didn't bother to go exploring.

How about this patch on top of the previous one?

		Linus

----
diff --git a/builtin-add.c b/builtin-add.c
index e815b3d..82e8f44 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -44,50 +44,89 @@ static int common_prefix(const char **pa
 	return prefix;
 }
 
-static int match(const char **pathspec, const char *name, int namelen, int prefix)
+static int match_one(const char *match, const char *name, int namelen)
 {
+	int matchlen;
+
+	/* If the match was just the prefix, we matched */
+	matchlen = strlen(match);
+	if (!matchlen)
+		return 1;
+
+	/*
+	 * If we don't match the matchstring exactly,
+	 * we need to match by fnmatch
+	 */
+	if (strncmp(match, name, matchlen))
+		return !fnmatch(match, name, 0);
+
+	/*
+	 * If we did match the string exactly, we still
+	 * need to make sure that it happened on a path
+	 * component boundary (ie either the last character
+	 * of the match was '/', or the next character of
+	 * the name was '/' or the terminating NUL.
+	 */
+	return	match[matchlen-1] == '/' ||
+		name[matchlen] == '/' ||
+		!name[matchlen];
+}
+
+static int match(const char **pathspec, const char *name, int namelen, int prefix, char *seen)
+{
+	int retval;
 	const char *match;
 
 	name += prefix;
 	namelen -= prefix;
 
-	while ((match = *pathspec++) != NULL) {
-		int matchlen;
-
+	for (retval = 0; (match = *pathspec++) != NULL; seen++) {
+		if (retval & *seen)
+			continue;
 		match += prefix;
-		matchlen = strlen(match);
-		if (!matchlen)
-			return 1;
-		if (!strncmp(match, name, matchlen)) {
-			if (match[matchlen-1] == '/')
-				return 1;
-			switch (name[matchlen]) {
-			case '/': case '\0':
-				return 1;
-			}
+		if (match_one(match, name, namelen)) {
+			retval = 1;
+			*seen = 1;
 		}
-		if (!fnmatch(match, name, 0))
-			return 1;
 	}
-	return 0;
+	return retval;
 }
 
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
 {
-	int i;
+	char *seen;
+	int i, specs;
 	struct dir_entry **src, **dst;
 
+	for (specs = 0; pathspec[specs];  specs++)
+		/* nothing */;
+	seen = xmalloc(specs);
+	memset(seen, 0, specs);
+
 	src = dst = dir->entries;
 	i = dir->nr;
 	while (--i >= 0) {
 		struct dir_entry *entry = *src++;
-		if (!match(pathspec, entry->name, entry->len, prefix)) {
+		if (!match(pathspec, entry->name, entry->len, prefix, seen)) {
 			free(entry);
 			continue;
 		}
 		*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
+
+	for (i = 0; i < specs; i++) {
+		struct stat st;
+		const char *match;
+		if (seen[i])
+			continue;
+
+		/* Existing file? We must have ignored it */
+		match = pathspec[i];
+		if (!lstat(match, &st))
+			continue;
+		die("pathspec '%s' did not match any files", match);
+	}
 }
 
 static void fill_directory(struct dir_struct *dir, const char **pathspec)
