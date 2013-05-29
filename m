From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] push: fail early with detached HEAD and current
Date: Thu, 30 May 2013 00:51:50 +0530
Message-ID: <1369855311-23367-3-git-send-email-artagnon@gmail.com>
References: <1369855311-23367-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 29 21:23:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhlyF-0002LA-8K
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 21:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966286Ab3E2TX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 15:23:27 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:36768 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965810Ab3E2TXY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 15:23:24 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so9644733pbc.3
        for <git@vger.kernel.org>; Wed, 29 May 2013 12:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=01p0eLF4kpikADEhYeXMS4EHtzpAcC4wV6GEG0QI4/c=;
        b=C2C2pbcY8DapMEDHJJnHQKt3KSqChSC2gW6Tlna4CkImBcEOenypazvpZaTOtSLPo7
         GHRnqvnjJjt+utvvt46ed/lJW/iy/l1GXeRpfraZLD4osgMA1EQa6Lz74eggEH2SgFen
         6f6y7Ytt3xfO/FGRdmj8YhATPAL+QhB3dgdfRgegZAag/EteprHthHaJKYcxBEsts9SD
         UBa7Fsh3CTnzI3uJDSFxiEuGDqW84oL5FyA6MMIvLgwVfIVAwIij3q2nf8nbYU5/qWhb
         yKPPR2L8UhHRfOvI/EyGu6C12KOlZH3TwDwoVEsldzBlTq6Cs7QaoK/U9TptshH6SPMl
         wBbw==
X-Received: by 10.66.163.5 with SMTP id ye5mr4893612pab.60.1369855403542;
        Wed, 29 May 2013 12:23:23 -0700 (PDT)
Received: from localhost.localdomain ([122.164.41.150])
        by mx.google.com with ESMTPSA id xu10sm41059620pab.3.2013.05.29.12.23.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 12:23:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.12.gbd56588
In-Reply-To: <1369855311-23367-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225870>

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
1.8.3.12.gbd56588
