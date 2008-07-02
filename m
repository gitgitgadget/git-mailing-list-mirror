From: Bart Trojanowski <bart@jukie.net>
Subject: [PATCH] prevent checkout from creating branches that start with a
	dash
Date: Wed, 2 Jul 2008 11:01:28 -0400
Message-ID: <20080702150128.GH26300@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 17:09:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE3xe-0006rq-6t
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 17:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722AbYGBPIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 11:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754699AbYGBPIf
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 11:08:35 -0400
Received: from tau.jukie.net ([216.239.93.128]:55975 "EHLO tau.jukie.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693AbYGBPIf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 11:08:35 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jul 2008 11:08:34 EDT
Received: by tau.jukie.net (Postfix, from userid 1000)
	id 30782C019F1; Wed,  2 Jul 2008 11:01:28 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87150>

It was previously possible to create a -f branch with git-checkout, which
could not be used or deleted.

        $ git checkout -b -f master
        Switched to a new branch "-f"

Signed-off-by: Bart Trojanowski <bart@jukie.net>
---
 branch.c           |   11 +++++++++++
 branch.h           |    5 +++++
 builtin-checkout.c |    4 ++++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/branch.c b/branch.c
index 56e9492..c25e362 100644
--- a/branch.c
+++ b/branch.c
@@ -170,3 +170,14 @@ void remove_branch_state(void)
 	unlink(git_path("MERGE_MSG"));
 	unlink(git_path("SQUASH_MSG"));
 }
+
+int validate_branch_name(const char *branch_name)
+{
+	if (!*branch_name)
+		return -1;
+
+	if (*branch_name == '-')
+		return -1;
+
+	return 0;
+}
diff --git a/branch.h b/branch.h
index 9f0c2a2..13999ba 100644
--- a/branch.h
+++ b/branch.h
@@ -21,4 +21,9 @@ void create_branch(const char *head, const char *name, const char *start_name,
  */
 void remove_branch_state(void);
 
+/*
+ * Check if the branch name given is well formed.  Returns 0 on success.
+ */
+int validate_branch_name(const char *branch_name);
+
 #endif
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 93ea69b..f425646 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -553,6 +553,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.force && opts.merge)
 		die("git checkout: -f and -m are incompatible");
 
+	if (opts.new_branch && validate_branch_name(opts.new_branch))
+		die("git checkout: '%s' does not look like a valid branch name",
+				opts.new_branch);
+
 	if (argc) {
 		const char **pathspec = get_pathspec(prefix, argv);
 
-- 
1.5.6.1.109.ga974cd.dirty
