From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git performance on OS X
Date: Sat, 19 Apr 2008 14:22:38 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804191341210.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sat Apr 19 23:24:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnKXW-0006To-7v
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 23:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760096AbYDSVXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 17:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760191AbYDSVXT
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 17:23:19 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45948 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759698AbYDSVXS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2008 17:23:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JLMdtt027426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Apr 2008 14:22:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JLMcl9000899;
	Sat, 19 Apr 2008 14:22:39 -0700
In-Reply-To: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79921>



On Sat, 19 Apr 2008, Pieter de Bie wrote:
> 
> It appears that on large initial imports, git add * is a lot slower than git
> add .

"git add *" is actually fundamentally different from "git add .", and 
yeah, you should generally use the latter.

The reason? The argument list is actually something different from what 
you think it is. For git, it's a "pathspec", so what actualy happens is 
that in *both* cases, it will really traverse the whole tree, and then 
match every file it finds against the pathspec.

So think of the arguments not as a file list, but as a random bunch of 
patterns to match against the files you have!

Which is why the cost is actually approximately O(n*m), where "n" is the 
size of the working tree, and "m" is the number of pathspecs.

So the reason "git add ." is fast is actually that "m" in that case is 
just 1 (just one trivial pattern), and then "git add *" is slow because 
"m" is large (lots of complicated patterns). In both cases, 'n' is the 
same (== the whole set of files in your working tree).

Now, it has some trivial optimizations, so that if the all the patterns in 
the pathspec begin with the same base directory, it will only look at that 
base directory, which is why

	git add drivers/block/*

is much faster than

	git add *

even though they both have a fair number of pattners (ie 'm' is roughly 
the same, but now it has basically artificially limited 'n' to just a 
subset of the tree). When you do "git add *", there is obviously no 
such trivial subset - '*' is not going to limit the pattern space to just 
a small part of the subtree!

I do agree that the git behavior is kind of odd, but it's very consistent 
with all the other uses of pathspecs in git, and we've never optimized it 
a lot simply because nobody normally _should_ do "git add *" with a lot of 
files.

If you want to see the worst-case, do

	git add $(git ls-files)

which basically means that it's O(n^2) in the number of files we track 
(regardless of depth). Because remember: the arguments to git add are not 
something we just iterate over - we always iterate over the whole tree, 
and then the arguments are just patterns that we then match that tree 
against.

And yeah, we could create a few other optimization heuristics that would 
almost certainly speed up those worst cases by a huge amount. The logic is 
all in "match_pathspec()" (where the "prefix" count is just the common 
prefix that we don't even need to match because of the trivial "under this 
tree" optimization).

Notice how match_pathspec() just walks over the whole pathspec (that's 
your argument list), and how we call this for every single file we find 
(after we've done .gitignore handling etc).

Anyway, here's a trivial patch that doesn't change this fundamental fact, 
but that avoids doing anything *expensive* until we've done some cheap 
initial tests. It may or may not help your test-case, but it's pretty 
simple and it matches the other git optimizations in this area (ie 
"conceptually handle the general case, but optimize the simple cases where 
we can exit early")

Notice how this patch doesn' actually change the fundamental O(n^2) 
behaviour, but it makes it much cheaper by generally avoiding the 
expensive 'fnmatch' and 'strlen/strncmp' when they are obviously not 
needed.

		Linus

---
 dir.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 63715c9..8d45321 100644
--- a/dir.c
+++ b/dir.c
@@ -52,6 +52,11 @@ int common_prefix(const char **pathspec)
 	return prefix;
 }
 
+static inline int special_char(unsigned char c1)
+{
+	return !c1 || c1 == '*' || c1 == '[' || c1 == '?';
+}
+
 /*
  * Does 'match' matches the given name?
  * A match is found if
@@ -69,14 +74,27 @@ static int match_one(const char *match, const char *name, int namelen)
 	int matchlen;
 
 	/* If the match was just the prefix, we matched */
-	matchlen = strlen(match);
-	if (!matchlen)
+	if (!*match)
 		return MATCHED_RECURSIVELY;
 
+	for (;;) {
+		unsigned char c1 = *match;
+		unsigned char c2 = *name;
+		if (special_char(c1))
+			break;
+		if (c1 != c2)
+			return 0;
+		match++;
+		name++;
+		namelen--;
+	}
+	
+
 	/*
 	 * If we don't match the matchstring exactly,
 	 * we need to match by fnmatch
 	 */
+	matchlen = strlen(match);
 	if (strncmp(match, name, matchlen))
 		return !fnmatch(match, name, 0) ? MATCHED_FNMATCH : 0;
 
