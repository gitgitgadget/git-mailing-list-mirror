From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] Allow cherry-pick (and revert) to add signoff line
Date: Sun, 20 Apr 2008 13:03:05 -0500
Message-ID: <1208714585-4053-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 20:03:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JndtM-00052w-2J
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 20:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbYDTSDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 14:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbYDTSDK
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 14:03:10 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:37464 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbYDTSDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 14:03:09 -0400
Received: by py-out-1112.google.com with SMTP id u52so2086387pyb.10
        for <git@vger.kernel.org>; Sun, 20 Apr 2008 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=a9YH1aAv3Qypo259c+icco9k74+Ncp8atYj0IFyxZh4=;
        b=qIKsxU6yrKprFfHGFAC6V4xg2Hw8yayceWyq/0kIrSaepoZaHf08pWLMvR0oaCf6cTeK8q0c7O3hPSzh902gRoA1y05Toum5wiQLR83vka3/Y+Yg3Nuw6Rcu+4DLBk1Wlx3PDTNjZ7/fw+/gxrBDzmBoImtjZDISikV5a1AaXdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=k+C89LjQ8IJw7I9Zee3FKYRKOlU4W1zqrYbzvANt1CzI4lHaFz13HlW2usVlwsQq//0DeaRKSRr5xnJf+V3GH7okSEAJKHYJJx02UUq7Nf5vpkWZU/KSGuxfGVJ9gH/9v4J9v8ZI6FIeunRZeGtuTiPRtYCVTUbw4cUr2Ya2xAc=
Received: by 10.35.70.17 with SMTP id x17mr8951704pyk.12.1208714588421;
        Sun, 20 Apr 2008 11:03:08 -0700 (PDT)
Received: from localhost ( [76.193.177.245])
        by mx.google.com with ESMTPS id n44sm7866994pyh.26.2008.04.20.11.03.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Apr 2008 11:03:07 -0700 (PDT)
X-Mailer: git-send-email 1.5.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79974>

I often find myself pulling patches off of other peoples trees using
cherry-pick, and following it with an immediate 'git commit --amend -s'
command. Eliminate the need for a double commit by allowing signoff on a
cherry-pick or revert.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

This is something I have done in my workflow for a long time, and it seems
like a weird omission to me. Signoffs can be done on git-am without having
a second commit, and I often have a workflow where I am picking patches from
other users' topic branches and have reviewed the patch and would like to
signoff when I pull it into my tree.

I'm not particularly happy about the 4 case if statement at the end, so I'd
be happy to clean that up if anyone has suggestions.

 builtin-revert.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 607a2f0..433d0dd 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -33,7 +33,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline;
+static int edit, no_replay, no_commit, mainline, signoff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 
@@ -53,6 +53,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
 		OPT_BOOLEAN('x', NULL, &no_replay, "append commit name when cherry-picking"),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
+		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by: header"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_END(),
 	};
@@ -404,10 +405,14 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	 */
 
 	if (!no_commit) {
-		if (edit)
+		if (edit && !signoff)
 			return execl_git_cmd("commit", "-n", NULL);
-		else
+		else if (edit)
+			return execl_git_cmd("commit", "-n", "-s", NULL);
+		else if (!signoff)
 			return execl_git_cmd("commit", "-n", "-F", defmsg, NULL);
+		else
+			return execl_git_cmd("commit", "-n", "-s", "-F", defmsg, NULL);
 	}
 	free(reencoded_message);
 
-- 
1.5.5
