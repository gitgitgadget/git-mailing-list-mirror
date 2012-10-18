From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/5] branch: factor out check_branch_commit()
Date: Thu, 18 Oct 2012 14:02:51 +0200
Message-ID: <507FEFEB.4030406@lsrfire.ath.cx>
References: <CALKQrgfnvV+1XHjeSytj+LxkAabZJK3hewxH7WT0nkX-ewOKUA@mail.gmail.com> <507D315E.8040101@lsrfire.ath.cx> <7vr4oytn4q.fsf@alter.siamese.dyndns.org> <507FEF0B.1060309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Miklos Vajna <vmiklos@suse.cz>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 14:03:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOooj-0003un-Tx
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 14:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab2JRMDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 08:03:01 -0400
Received: from india601.server4you.de ([85.25.151.105]:44733 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab2JRMDA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 08:03:00 -0400
Received: from [192.168.2.105] (p4FFDA222.dip.t-dialin.net [79.253.162.34])
	by india601.server4you.de (Postfix) with ESMTPSA id 34E9123E;
	Thu, 18 Oct 2012 14:02:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <507FEF0B.1060309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207997>

Move the code to perform checks on the tip commit of a branch
to its own function.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/branch.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ffd2684..852019e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -154,10 +154,28 @@ static int branch_merged(int kind, const char *name,
 	return merged;
 }
 
+static int check_branch_commit(const char *branchname, const char *refname,
+			       unsigned char *sha1, struct commit *head_rev,
+			       int kinds, int force)
+{
+	struct commit *rev = lookup_commit_reference(sha1);
+	if (!rev) {
+		error(_("Couldn't look up commit object for '%s'"), refname);
+		return -1;
+	}
+	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
+		error(_("The branch '%s' is not fully merged.\n"
+		      "If you are sure you want to delete it, "
+		      "run 'git branch -D %s'."), branchname, branchname);
+		return -1;
+	}
+	return 0;
+}
+
 static int delete_branches(int argc, const char **argv, int force, int kinds,
 			   int quiet)
 {
-	struct commit *rev, *head_rev = NULL;
+	struct commit *head_rev = NULL;
 	unsigned char sha1[20];
 	char *name = NULL;
 	const char *fmt;
@@ -206,17 +224,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		rev = lookup_commit_reference(sha1);
-		if (!rev) {
-			error(_("Couldn't look up commit object for '%s'"), name);
-			ret = 1;
-			continue;
-		}
-
-		if (!force && !branch_merged(kinds, bname.buf, rev, head_rev)) {
-			error(_("The branch '%s' is not fully merged.\n"
-			      "If you are sure you want to delete it, "
-			      "run 'git branch -D %s'."), bname.buf, bname.buf);
+		if (check_branch_commit(bname.buf, name, sha1, head_rev, kinds,
+					force)) {
 			ret = 1;
 			continue;
 		}
-- 
1.7.12
