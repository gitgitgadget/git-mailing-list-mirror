From: Bart Trojanowski <bart@jukie.net>
Subject: [PATCH] Add git-rev-list --invert-match
Date: Wed, 19 Sep 2007 22:52:25 -0400
Message-ID: <20070920025225.GA12076@jukie.net>
References: <20070919202615.GK3076@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 04:52:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYC9Z-00078x-Iv
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 04:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbXITCw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 22:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbXITCw2
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 22:52:28 -0400
Received: from tachyon.jukie.net ([205.150.199.214]:49309 "EHLO jukie.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751691AbXITCw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 22:52:27 -0400
Received: from tau.jukie.net ([10.10.10.211]:34997)
	by jukie.net with esmtp (Exim 4.50)
	id 1IYC9S-0007Hp-7v
	for git@vger.kernel.org; Wed, 19 Sep 2007 22:52:26 -0400
Received: by tau.jukie.net (Postfix, from userid 1000)
	id 2C2B0A75991; Wed, 19 Sep 2007 22:52:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070919202615.GK3076@jukie.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58749>

Example usage:

  git log --invert-match --grep="uninteresting"

  This command will prune out all commits that match the grep pattern.

How it works:

  The --invert-match flag sets invert_match, in rev_info.  This boolean
  is later checked in commit_match() and if set it inverts the result of
  grep_buffer().

Signed-off-by: Bart Trojanowski <bart@jukie.net>
---

This patch includes the Documentation update I missed in the first
patch.

 Documentation/git-rev-list.txt |    6 ++++++
 revision.c                     |   11 ++++++++++-
 revision.h                     |    3 ++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 7cd0e89..f7a4891 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -29,6 +29,7 @@ SYNOPSIS
 	     [ \--(author|committer|grep)=<pattern> ]
 	     [ \--regexp-ignore-case | \-i ]
 	     [ \--extended-regexp | \-E ]
+	     [ \--invert-match ]
 	     [ \--date={local|relative|default|iso|rfc|short} ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
@@ -238,6 +239,11 @@ limiting may be applied.
 	Consider the limiting patterns to be extended regular expressions
 	instead of the default basic regular expressions.
 
+--invert-match::
+
+	Show those parts of history that do not match any of the regular
+        expression patterns.
+
 --remove-empty::
 
 	Stop when a given path disappears from the tree.
diff --git a/revision.c b/revision.c
index 33d092c..57b2d0f 100644
--- a/revision.c
+++ b/revision.c
@@ -1182,6 +1182,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				regflags |= REG_ICASE;
 				continue;
 			}
+			if (!strcmp(arg, "--invert-match")) {
+				revs->invert_match = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--all-match")) {
 				all_match = 1;
 				continue;
@@ -1383,11 +1387,16 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
+	int result;
+
 	if (!opt->grep_filter)
 		return 1;
-	return grep_buffer(opt->grep_filter,
+
+	result = grep_buffer(opt->grep_filter,
 			   NULL, /* we say nothing, not even filename */
 			   commit->buffer, strlen(commit->buffer));
+
+	return opt->invert_match ? !result : result;
 }
 
 static struct commit *get_revision_1(struct rev_info *revs)
diff --git a/revision.h b/revision.h
index 98a0a8f..ead04a7 100644
--- a/revision.h
+++ b/revision.h
@@ -48,7 +48,8 @@ struct rev_info {
 			parents:1,
 			reverse:1,
 			cherry_pick:1,
-			first_parent_only:1;
+			first_parent_only:1,
+			invert_match:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
-- 
1.5.3.1.154.g734e65
