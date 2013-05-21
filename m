From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] push: factor out the detached HEAD error message
Date: Tue, 21 May 2013 23:53:18 +0530
Message-ID: <1369160600-22337-2-git-send-email-artagnon@gmail.com>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 21 20:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UerFP-0008Qz-TI
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 20:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475Ab3EUSZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 14:25:07 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:58695 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab3EUSZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 14:25:05 -0400
Received: by mail-pd0-f179.google.com with SMTP id q11so893292pdj.10
        for <git@vger.kernel.org>; Tue, 21 May 2013 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jKTeA68/sBftaXWn46fLGeIpPWaUjath7QdOBOjsbqU=;
        b=y4UcgPEOP2Q3+kOCA+Pk05t0W7Wq2/MLKuQY9QZ52DugSFuQkTnTfC/9iUrWClvsGe
         N7lh4oJuk0Fu3C1fEYUUPjnhHuERRRzwDAX97PFbE9//Ip8g+yQToPjZ3aFkvx7tSnYV
         FPQv6hLvR5LKBWCyhi/KtdpmGOzyRsnAgiglO/jHIJaYpWmLHnmEu/AFXeEKSxlxpf9r
         bfAvDxep3xrHJEr2Ve0zARTZpycZQAR1AwKXsNOOsn4zVPuzt8UL7J2cmdlg6UbkwGYP
         mHDfCY/zNQBat7xvicImW8QO/N2HDXFYYJ86xh1GG7/IEoVYjWz99zTwwSNkuqOO7pu5
         AEDg==
X-Received: by 10.66.231.7 with SMTP id tc7mr4482918pac.143.1369160704708;
        Tue, 21 May 2013 11:25:04 -0700 (PDT)
Received: from localhost.localdomain ([122.164.25.100])
        by mx.google.com with ESMTPSA id l4sm3680889pbo.6.2013.05.21.11.25.02
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 May 2013 11:25:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.7.gc1ff30b
In-Reply-To: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225062>

With push.default set to upstream or simple, and a detached HEAD, git
push prints the following error:

  $ git push
  fatal: You are not currently on a branch.
  To push the history leading to the current (detached HEAD)
  state now, use

    git push ram HEAD:<name-of-remote-branch>

This error is not unique to upstream or simple: current cannot push with
a detached HEAD either.  So, factor out the error string in preparation
for using it in current.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/push.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 909c34d..ef3aa97 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -113,17 +113,19 @@ static NORETURN int die_push_simple(struct branch *branch, struct remote *remote
 	    remote->name, branch->name, advice_maybe);
 }
 
+static const char message_detached_head_die[] =
+	N_("You are not currently on a branch.\n"
+	   "To push the history leading to the current (detached HEAD)\n"
+	   "state now, use\n"
+	   "\n"
+	   "    git push %s HEAD:<name-of-remote-branch>\n");
+
 static void setup_push_upstream(struct remote *remote, int simple)
 {
 	struct strbuf refspec = STRBUF_INIT;
 	struct branch *branch = branch_get(NULL);
 	if (!branch)
-		die(_("You are not currently on a branch.\n"
-		    "To push the history leading to the current (detached HEAD)\n"
-		    "state now, use\n"
-		    "\n"
-		    "    git push %s HEAD:<name-of-remote-branch>\n"),
-		    remote->name);
+		die(_(message_detached_head_die), remote->name);
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 		die(_("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
-- 
1.8.3.rc3.7.gc1ff30b
