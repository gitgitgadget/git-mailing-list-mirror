From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Display 'theirs' branch name when possible in merge.
Date: Sat, 23 Dec 2006 03:44:47 -0500
Message-ID: <20061223084447.GB10203@spearce.org>
References: <6115ec06459724c7c37c355805462cb61715e9c5.1166863413.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 09:44:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy2Uz-00012p-AZ
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 09:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbWLWIou (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 03:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbWLWIou
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 03:44:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40603 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbWLWIou (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 03:44:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy2UR-0006TY-Nm; Sat, 23 Dec 2006 03:44:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0E5C120FB65; Sat, 23 Dec 2006 03:44:47 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <6115ec06459724c7c37c355805462cb61715e9c5.1166863413.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35303>

Displaying the SHA1 of 'their' branch (the branch being merged into
the current branch) is not nearly as friendly as just displaying
the name of that branch, especially if that branch is already local
to this repository.

git-merge now sets the environment variable 'GITHEAD_%(sha1)=%(name)'
for each argument it gets passed, making the actual input name that
resolved to the commit '%(sha1)' easily available to the invoked
merge strategy.

git-merge-recursive makes use of these environment variables when
they are available by using '%(name)' whenever it outputs the commit
identification rather than '%(sha1)'.  This is most obvious in the
conflict hunks created by xdl_merge:

  $ git mege sideb~1
  <<<<<<< HEAD:INSTALL
     Good!
  =======
     Oops.
  >>>>>>> sideb~1:INSTALL

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-merge.sh      |    2 ++
 merge-recursive.c |   17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index a17aa2c..5c2d03b 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -266,6 +266,8 @@ do
 	remotehead=$(git-rev-parse --verify "$remote"^0 2>/dev/null) ||
 	    die "$remote - not something we can merge"
 	remoteheads="${remoteheads}$remotehead "
+	eval GITHEAD_$remotehead='"$remote"'
+	export GITHEAD_$remotehead
 done
 set x $remoteheads ; shift
 
diff --git a/merge-recursive.c b/merge-recursive.c
index abebb95..a96821c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1263,6 +1263,18 @@ static struct commit *get_ref(const char *ref)
 	return (struct commit *)object;
 }
 
+static char* better_branch_name(const char *branch)
+{
+	static char githead_env[8 + 40 + 1];
+	char* name;
+
+	if (strlen(branch) != 40)
+		return branch;
+	sprintf(githead_env, "GITHEAD_%s", branch);
+	name = getenv(githead_env);
+	return name ? name : branch;
+}
+
 int main(int argc, char *argv[])
 {
 	static const char *bases[2];
@@ -1293,11 +1305,14 @@ int main(int argc, char *argv[])
 
 	branch1 = argv[++i];
 	branch2 = argv[++i];
-	printf("Merging %s with %s\n", branch1, branch2);
 
 	h1 = get_ref(branch1);
 	h2 = get_ref(branch2);
 
+	branch1 = better_branch_name(branch1);
+	branch2 = better_branch_name(branch2);
+	printf("Merging %s with %s\n", branch1, branch2);
+
 	if (bases_count == 1) {
 		struct commit *ancestor = get_ref(bases[0]);
 		clean = merge(h1, h2, branch1, branch2, 0, ancestor, &result);
-- 
1.4.4.3.g87d8
