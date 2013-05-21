From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] push: fail early with detached HEAD and current
Date: Tue, 21 May 2013 23:53:19 +0530
Message-ID: <1369160600-22337-3-git-send-email-artagnon@gmail.com>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 21 20:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UerFQ-0008Qz-Jo
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 20:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab3EUSZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 14:25:09 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:38684 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab3EUSZH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 14:25:07 -0400
Received: by mail-pb0-f43.google.com with SMTP id ma3so898809pbc.16
        for <git@vger.kernel.org>; Tue, 21 May 2013 11:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wYQ5uwy9SiGPh6VSpHaRNPpYW1K+GuaaZ3RooM43unk=;
        b=lCJP1NWXwewLVk43zGLRJiBHXP9GZJytvcqn2V21whHf08JxvoBAOS+NQhw8ukJ1Bw
         jlDqZTPORFvBp/wBI5TKEBvTpPsDxDkXsYf+zPuQ8dyqKY/VOuXfAR8F9x5P5InIYWPD
         yAMwuc0SoPeoIwTIk9B0Bjt0RPYyyHJ4h9u70nEH98KRWGT/8IUvGjMVRb5cWJEY8vYJ
         2zuNTIjDoGX+GSyakav/w7V8TwPc9qIgCZx+CxbVCZm3T49gXgrIZBPh09urUdAjQuPW
         YDZqruAZnL0hmAVikqxXhVk1rfMVDUnMdNLr5EQR8EYz6lc08lTn6+j2XQnSgrdALmW4
         EJrA==
X-Received: by 10.68.13.168 with SMTP id i8mr4048381pbc.86.1369160706594;
        Tue, 21 May 2013 11:25:06 -0700 (PDT)
Received: from localhost.localdomain ([122.164.25.100])
        by mx.google.com with ESMTPSA id l4sm3680889pbo.6.2013.05.21.11.25.04
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 May 2013 11:25:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.7.gc1ff30b
In-Reply-To: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225061>

Setting push.default to current adds the refspec "HEAD" for the
transport layer to handle.  If "HEAD" doesn't resolve to a branch (and
since no refspec rhs is specified), the push fails after some time with
a cryptic error message:

  $ git push
  error: unable to push to unqualified destination: HEAD
  The destination refspec neither matches an existing ref on the remote nor
  begins with refs/, and we are unable to guess a prefix based on the source ref.
  error: failed to push some refs to 'git@github.com:artagnon/git'

Fail early with a nicer error message:

  $ git push
  fatal: You are not currently on a branch.
  To push the history leading to the current (detached HEAD)
  state now, use

    git push ram HEAD:<name-of-remote-branch>

Just like in the upstream and simple cases.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/push.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/push.c b/builtin/push.c
index ef3aa97..a79038c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -175,6 +175,8 @@ static void warn_unspecified_push_default_configuration(void)
 
 static void setup_default_push_refspecs(struct remote *remote)
 {
+	struct branch *branch = branch_get(NULL);
+
 	switch (push_default) {
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
@@ -194,6 +196,8 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
+		if (!branch)
+			die(_(message_detached_head_die), remote->name);
 		add_refspec("HEAD");
 		break;
 
-- 
1.8.3.rc3.7.gc1ff30b
