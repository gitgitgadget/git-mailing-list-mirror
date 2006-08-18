From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git-apply: document remaining options in the man page
Date: Fri, 18 Aug 2006 10:45:45 +0200
Message-ID: <20060818084545.GB4717@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 18 10:46:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDzzU-0004Bb-2R
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 10:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWHRIqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 04:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWHRIqE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 04:46:04 -0400
Received: from [130.225.96.91] ([130.225.96.91]:24507 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751213AbWHRIqC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 04:46:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id D88B97700C8
	for <git@vger.kernel.org>; Fri, 18 Aug 2006 10:45:49 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01017-05 for <git@vger.kernel.org>; Fri, 18 Aug 2006 10:45:47 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 7A5507700CD
	for <git@vger.kernel.org>; Fri, 18 Aug 2006 10:45:45 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id C7FD66DF835
	for <git@vger.kernel.org>; Fri, 18 Aug 2006 10:44:35 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 5E091629F5; Fri, 18 Aug 2006 10:45:45 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25635>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

[ On top of next if that matters. ]

I'm not sure if I got the --exclude note right, which says that running
apply from a subdirectory automatically excludes files outside the
subdirectory. As I mention below it looks like this excluding is only
done when --index or --cached is specified. It led me to investigate a
bit further and I think I might have found an issue or two.

I was playing with the prefix checking in use_patch() to try and see if
I could break it. I noticed that the patch filename will be prefixed
with the prefix, but not the paths in the patch. This means that if I
apply a patch created with a non-git diff for a file in a directory
with a name longer than the changed file it will not be applied, e.g.
git-am.txt in Documentation. So

	v1.4.2-g169bec6:git/Documentation > git apply --index git-am.diff

will silently drop the change. Or maybe it is just me who doesn't know
how to see diffs in the index (git-diff-index reports no change to
Documentation/git-am.txt). The code from use_patch():

        if (0 < prefix_length) { /* strlen("Documentation") = 13 */
		int pathlen = strlen("git-am.txt"); /* = 10 */
		if (pathlen <= prefix_length ||
		    memcmp(prefix, pathname, prefix_length))
			return 0;
	}

Anyway, the prefix check is only ever performed when using --index or
--cached. These options doesn't seem to support being run from a
subdirectories if the patch is given on stdin:

	v1.4.2-g169bec6:git/Documentation > git apply --cached < git-am.diff
	fatal: unable to create '.git/index': No such file or directory

I can make a follow-up patch if this is the way it's supposed to work.
In that case a better error message might be good to clearify things.

Lastly, `log -S<option>` is so great when doing these man pages updates
and you, like me, don't know the code very well, since you can "just"
paraphrase the commit message that will sometimes also describe the
scenario where the option is applicable. :)

 Documentation/git-apply.txt |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f1ab1f9..33d63a4 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -10,9 +10,9 @@ SYNOPSIS
 --------
 [verse]
 'git-apply' [--stat] [--numstat] [--summary] [--check] [--index] [--apply]
-	  [--no-add] [--index-info] [--allow-binary-replacement]
-	  [--reverse] [-z] [-pNUM]
-	  [-CNUM] [--whitespace=<nowarn|warn|error|error-all|strip>]
+	  [--no-add] [--index-info] [--allow-binary-replacement | --binary]
+	  [-R | --reverse] [-z] [-pNUM] [-CNUM] [--inaccurate-eof] [--cached]
+	  [--whitespace=<nowarn|warn|error|error-all|strip>] [--exclude=PATH]
 	  [<patch>...]
 
 DESCRIPTION
@@ -56,6 +56,11 @@ OPTIONS
 	up-to-date, it is flagged as an error.  This flag also
 	causes the index file to be updated.
 
+--cached::
+	Apply a patch without touching the working tree. Instead, take the
+	cached data, apply the patch, and store the result in the index,
+	without using the working tree. This implies '--index'.
+
 --index-info::
 	Newer git-diff output has embedded 'index information'
 	for each blob to help identify the original version that
@@ -63,7 +68,7 @@ OPTIONS
 	the original version of the blob is available locally,
 	outputs information about them to the standard output.
 
---reverse::
+-R, --reverse::
 	Apply the patch in reverse.
 
 -z::
@@ -97,7 +102,7 @@ OPTIONS
 	the result with this option, which would apply the
 	deletion part but not addition part.
 
---allow-binary-replacement::
+--allow-binary-replacement, --binary::
 	When applying a patch, which is a git-enhanced patch
 	that was prepared to record the pre- and post-image object
 	name in full, and the path being patched exactly matches
@@ -108,6 +113,13 @@ OPTIONS
 	result.  This allows binary files to be patched in a
 	very limited way.
 
+--exclude=<path-pattern>::
+	Don't apply changes to files matching the given path pattern. This can
+	be useful when importing patchsets, where you want to exclude certain
+	files or directories. Note, if you run git-apply from a subdirectory
+	it will automatically exclude changes for files outside the
+	subdirectory.
+
 --whitespace=<option>::
 	When applying a patch, detect a new or modified line
 	that ends with trailing whitespaces (this includes a
@@ -128,6 +140,12 @@ OPTIONS
 * `strip` outputs warnings for a few such errors, strips out the
   trailing whitespaces and applies the patch.
 
+--inacurate-eof::
+	Under certain circumstances, some versions of diff do not correctly
+	detect a missing new-line at the end of the file. As a result, patches
+	created by such diff programs do not record incomplete lines
+	correctly. This option adds support for applying such patches by
+	working around this bug.
 
 Configuration
 -------------

-- 
Jonas Fonseca
