From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 5/5] branch.c: Relax unnecessary requirement on upstream's remote ref name
Date: Sun,  8 Sep 2013 22:58:15 +0200
Message-ID: <1378673895-23127-6-git-send-email-johan@herland.net>
References: <1378464042-17476-1-git-send-email-johan@herland.net>
 <1378673895-23127-1-git-send-email-johan@herland.net>
Cc: Per Cederqvist <cederp@opera.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 08 22:58:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIm47-00039V-NX
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 22:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab3IHU6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 16:58:36 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:40331 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab3IHU6d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 16:58:33 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so4259503lab.39
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 13:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WftjMUDyW4vj4UJxhk8mVYgtlnt4udifTGPfVdE++vQ=;
        b=b8/SwHOZrHE2h7GDYTT076BUfJQMKcTK/PgXTXX7aO2FnakdiV10IBZeyvCK1wCJW6
         05fO4zdQILLDaf4eYbD40veWtGsLpaD32ZZIH5PYN8KZTP5rAcFLU3Liz1YPH1XUzT2K
         X0zUVr1HnW6Rmwm5+eutW5Gx2oTLih+6VIS82gV220BbRk3djg/V9AouVjp7hD5nGpa5
         AjJYH7oEdGCrlFO+JEt/NUzf25ryUhnjNwTQ0XdIoXczB6fkDBuF/u3ssuweRoa9SHCe
         tCPFENXNaPAQ1DcEBiYoZQ3MeyXKcYvBFrVXi87sBT4D1Yrgn8tPxeTkpfMuYQiqu2ty
         OtQA==
X-Received: by 10.112.143.3 with SMTP id sa3mr13236844lbb.12.1378673912558;
        Sun, 08 Sep 2013 13:58:32 -0700 (PDT)
Received: from beta.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPSA id vo1sm4292384lbb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 13:58:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1378673895-23127-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234268>

From: Per Cederqvist <cederp@opera.com>

When creating an upstream relationship, we use the configured remotes and
their refspecs to determine the upstream configuration settings
branch.<name>.remote and branch.<name>.merge. However, if the matching
refspec does not have refs/heads/<something> on the remote side, we end
up rejecting the match, and failing the upstream configuration.

It could be argued that when we set up an branch's upstream, we want that
upstream to also be a proper branch in the remote repo. Although this is
typically the common case, there are cases (as demonstrated by the previous
patch in this series) where this requirement prevents a useful upstream
relationship from being formed. Furthermore:

 - We have fundamentally no say in how the remote repo have organized its
   branches. The remote repo may put branches (or branch-like constructs
   that are insteresting for downstreams to track) outside refs/heads/*.

 - The user may intentionally want to track a non-branch from a remote
   repo, by using a branch and configured upstream in the local repo.

Relaxing the checking to only require a matching remote/refspec allows the
testcase introduced in the previous patch to succeed, and has no negative
effect on the rest of the test suite.

This patch fixes a behavior (arguably a regression) first introduced in
41c21f2 (branch.c: Validate tracking branches with refspecs instead of
refs/remotes/*) on 2013-04-21 (released in >= v1.8.3.2).

Signed-off-by: Johan Herland <johan@herland.net>
---
 branch.c          | 3 +--
 t/t3200-branch.sh | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index c5c6984..2d15c19 100644
--- a/branch.c
+++ b/branch.c
@@ -203,8 +203,7 @@ static int check_tracking_branch(struct remote *remote, void *cb_data)
 	struct refspec query;
 	memset(&query, 0, sizeof(struct refspec));
 	query.dst = tracking_branch;
-	return !(remote_find_tracking(remote, &query) ||
-		 prefixcmp(query.src, "refs/heads/"));
+	return !remote_find_tracking(remote, &query);
 }
 
 static int validate_remote_tracking_branch(char *ref)
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 4031693..f010303 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -871,7 +871,7 @@ test_expect_success '--merged catches invalid object names' '
 	test_must_fail git branch --merged 0000000000000000000000000000000000000000
 '
 
-test_expect_failure 'tracking with unexpected .fetch refspec' '
+test_expect_success 'tracking with unexpected .fetch refspec' '
 	git init a &&
 	(
 		cd a &&
-- 
1.8.3.GIT
