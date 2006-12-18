X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] git-branch: deleting remote branches in new layout
Date: Mon, 18 Dec 2006 17:08:04 +1100
Message-ID: <45863044.4040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 06:08:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
X-Enigmail-Version: 0.94.1.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34717>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwBfl-0006FB-9s for gcvg-git@gmane.org; Mon, 18 Dec
 2006 07:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753349AbWLRGIM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 01:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbWLRGIL
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 01:08:11 -0500
Received: from pecan-mail.exetel.com.au ([220.233.0.8]:57649 "EHLO
 pecan.exetel.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
 id S1753349AbWLRGIL (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 01:08:11 -0500
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95]
 helo=[192.168.64.35]) by pecan.exetel.com.au with esmtp (Exim 4.63)
 (envelope-from <qtonthat@gmail.com>) id 1GwBfU-0004qY-Co for
 git@vger.kernel.org; Mon, 18 Dec 2006 17:08:08 +1100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Now that remote branches are in refs/remotes/, branch -D needs to know
where to find them.

Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---
 builtin-branch.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 560309c..b2f0aae 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -95,6 +95,8 @@ static void delete_branches(int argc, const char **argv, int force)
 	unsigned char sha1[20];
 	char *name;
 	int i;
+	char ** s;
+	static char * branches_dir[] = {"refs/heads", "refs/remotes", NULL};
 
 	if (!force) {
 		head_rev = lookup_commit_reference(head_sha1);
@@ -105,8 +107,12 @@ static void delete_branches(int argc, const char **argv, int force)
 		if (!strcmp(head, argv[i]))
 			die("Cannot delete the branch you are currently on.");
 
-		name = xstrdup(mkpath("refs/heads/%s", argv[i]));
-		if (!resolve_ref(name, sha1, 1, NULL))
+		for (s = branches_dir; *s != NULL; s++) {
+			name = xstrdup(mkpath("%s/%s", *s, argv[i]));
+			if (resolve_ref(name, sha1, 1, NULL))
+				break;
+		}
+		if (*s == NULL)
 			die("Branch '%s' not found.", argv[i]);
 
 		rev = lookup_commit_reference(sha1);
-- 
1.4.4.1.GIT
