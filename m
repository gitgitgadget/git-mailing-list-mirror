From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [RFC] Detached-HEAD reminder on commit?
Date: Tue,  2 Sep 2008 21:31:45 +0200
Message-ID: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 21:32:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KabcW-0001Hq-O9
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 21:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbYIBTbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 15:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbYIBTbt
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 15:31:49 -0400
Received: from smtp-4.orange.nl ([193.252.22.249]:11786 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518AbYIBTbs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 15:31:48 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6306.online.nl (SMTP Server) with ESMTP id 71F2C7000089
	for <git@vger.kernel.org>; Tue,  2 Sep 2008 21:31:46 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6306.online.nl (SMTP Server) with ESMTP id 24A957000086
	for <git@vger.kernel.org>; Tue,  2 Sep 2008 21:31:45 +0200 (CEST)
X-ME-UUID: 20080902193146150.24A957000086@mwinf6306.online.nl
X-Mailer: git-send-email 1.6.0.rc1.288.g5b89f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94695>

Sometimes I work on a detached HEAD and then forget about it. If I then create
some commits and checkout another branch, I have to dig through my reflog to
find the older commits. I know that "git commit" adds has a "Not currently on
any branch", but it's not very noticeable and also doesn't work when you
specify a commit message on the command line.

I suggest to add some extra output to the STDOUT after a commit if we're on a
detached HEAD. The quick patch below adds output like:

Vienna:git pieter$ ./git commit --allow-empty -m"test"
Created commit 6ce62c8b: test
You are on a detached head, so this commit has not been recorded in a branch.
If you don't want to lose this commit, checkout a branch and then run:
	git merge 6ce62c8bfcfb341106f3587d1c141c3955c2544c

Are there any comments to this / strong opinions against such a change?

- Pieter

diff --git a/builtin-commit.c b/builtin-commit.c
index ec65ac5..bfe25f9 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -845,6 +845,8 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 {
        struct rev_info rev;
        struct commit *commit;
+       unsigned char sha[20];
+       const char* head = resolve_ref("HEAD", sha, 0, NULL);
 
        commit = lookup_commit(sha1);
        if (!commit)
@@ -877,6 +879,15 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
                printf("%s\n", buf.buf);
                strbuf_release(&buf);
        }
+
+       /* Are we on a detached HEAD? */
+       if (!strcmp("HEAD", head))
+               printf("You are on a detached head, so this commit "
+                       "has not been recorded in a branch.\n"
+                       "If you don't want to lose this commit, checkout a "
+                       "branch and then run:\n"
+                       "       git merge %s\n", sha1_to_hex(sha1));
+
 }
 
 static int git_commit_config(const char *k, const char *v, void *cb)
