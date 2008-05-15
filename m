From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add support for GIT_CEILING_DIRECTORIES
Date: Thu, 15 May 2008 23:29:47 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805152327440.30431@racer>
References: <482C85C8.90804@facebook.com> <alpine.DEB.1.00.0805151958180.30431@racer> <alpine.DEB.1.00.0805152055280.30431@racer> <482CA693.3060602@facebook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:31:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwly8-0003Ps-6w
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 00:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512AbYEOW3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 18:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754341AbYEOW3q
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 18:29:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:40662 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753072AbYEOW3p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 18:29:45 -0400
Received: (qmail invoked by alias); 15 May 2008 22:29:43 -0000
Received: from R322b.r.pppool.de (EHLO racer.local) [89.54.50.43]
  by mail.gmx.net (mp028) with SMTP; 16 May 2008 00:29:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186AtM8YhY6hrb62pSudyZtHKDbvA11b3FcDT+Zli
	zF52zjq4auech/
X-X-Sender: gene099@racer
In-Reply-To: <482CA693.3060602@facebook.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82235>

Hi,

On Thu, 15 May 2008, David Reiss wrote:

> longest_prefix is just a textual check.  It doesn't verify that the prefix
> is actually a full directory component of the cwd.

Okay.

> Also, I think it is better to move the 'chdir("..")' after the do loop, 
> so that git won't even chdir up into the ceiling directory.  This 
> actually doesn't matter to me, but I figured that it might be nice for 
> someone.

I'd rather go with the minimal diff, unless there is a good reason to 
change it.

> Finally, just a small thing.  The documentation still says 
> "GIT_CEILING_DIRS".

Okay.

How about this on top (still pretty simple):

---

 Documentation/git.txt          |    2 +-
 path.c                         |   10 ++++++++--
 t/t1504-ceiling-directories.sh |    8 ++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index a12d1f8..e4413bf 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -415,7 +415,7 @@ git so take care if using Cogito etc.
 	This can also be controlled by the '--work-tree' command line
 	option and the core.worktree configuration variable.
 
-'GIT_CEILING_DIRS'::
+'GIT_CEILING_DIRECTORIES'::
 	If set (to a colon delimited list of absolute directories), Git
 	will refuse to look for the .git/ directory further when hitting
 	one of those directories (otherwise it would traverse the parent
diff --git a/path.c b/path.c
index c0d7364..a097ecc 100644
--- a/path.c
+++ b/path.c
@@ -358,13 +358,18 @@ const char *make_absolute_path(const char *path)
 	return buf;
 }
 
+static int is_separator(char c)
+{
+	return !c || c == '/';
+}
+
 int longest_prefix(const char *path, const char *prefix_list)
 {
 	int max_length = 0, length = 0, i;
 
 	for (i = 0; prefix_list[i]; i++)
 		if (prefix_list[i] == ':') {
-			if (length > max_length)
+			if (length > max_length && is_separator(path[length]))
 				max_length = length;
 			length = 0;
 		}
@@ -374,5 +379,6 @@ int longest_prefix(const char *path, const char *prefix_list)
 			else
 				length = -1;
 		}
-	return max_length > length ? max_length : length;
+	return max_length > length || !is_separator(path[length]) ?
+		max_length : length;
 }
diff --git a/t/t1504-ceiling-directories.sh b/t/t1504-ceiling-directories.sh
index 1d8ef0b..6c8757d 100644
--- a/t/t1504-ceiling-directories.sh
+++ b/t/t1504-ceiling-directories.sh
@@ -43,4 +43,12 @@ test_expect_success 'with matching ceiling directories' '
 
 '
 
+test_expect_success 'with non-directory prefix' '
+
+	GIT_CEILING_DIRECTORIES="$CWD/sub" &&
+	export GIT_CEILING_DIRECTORIES &&
+	(cd subdir && git rev-parse --git-dir)
+
+'
+
 test_done
