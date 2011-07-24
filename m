From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 3/9] bisect: implement support for --ignore-checkout-failure option
Date: Sun, 24 Jul 2011 15:57:48 +1000
Message-ID: <1311487074-25070-4-git-send-email-jon.seymour@gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 07:58:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkrhw-0007mm-VZ
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 07:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab1GXF6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 01:58:19 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56778 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab1GXF6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 01:58:14 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6276942pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 22:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4TD+YZzE13YB/u7rQJRQOlW8w1RIN3qZka82L5cy8sQ=;
        b=JZHPQHsp0TZMb4r0hT9Tkuml+k8HW5R80N7Rqr1gSsxetX/9so6zUjDx+iARcC0UnK
         paWywx/IYEHEKqW+IGNWH3qC8Finyz+MEpJe895POAUei4iH/2p2viUlt7bKEd8/slr0
         Wyn2YOASCcRhIk1UlPS8+Ue5qCtkqHbxG+F4s=
Received: by 10.68.66.133 with SMTP id f5mr4869747pbt.240.1311487094681;
        Sat, 23 Jul 2011 22:58:14 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id b4sm3359124pba.43.2011.07.23.22.58.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 22:58:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g96e0b.dirty
In-Reply-To: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177719>

If the option is not specified, git bisect has the current behaviour
in case of checkout failure. Specifically, it will exit immediately
with a non-zero status code.

With this commit, we allow checkout failures of damaged trees
to be ignored. To allow the bisect to proceed, as expected we
fall back to updating the HEAD ref directly.

This will leave the working tree and index in an inconsistent state, but
the user of --ignore-checkout-failure should expect that.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 bisect.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/bisect.c b/bisect.c
index ce04092..993c48b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -24,6 +24,7 @@ struct argv_array {
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
+static const char *argv_update_ref[] = {"update-ref", "--no-deref", "HEAD", NULL, NULL};
 static int module_ignore_checkout_failure = 0;
 
 /* bits #0-15 in revision.h */
@@ -716,8 +717,18 @@ static int bisect_checkout(char *bisect_rev_hex)
 
 	argv_checkout[2] = bisect_rev_hex;
 	res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
-	if (res)
+	if (res) {
+	  if (!module_ignore_checkout_failure) {
 		exit(res);
+	  } else {
+	    fprintf(stderr, "warn: checkout failed. Updating HEAD directly. The working tree and index may be inconsistent.\n");
+	    argv_update_ref[3] = bisect_rev_hex;
+	    res = run_command_v_opt(argv_update_ref, RUN_GIT_CMD);
+	    if (res) {
+	      die("update-ref --no-deref HEAD failed on %s", bisect_rev_hex);
+	    }
+	  }
+	}
 
 	argv_show_branch[1] = bisect_rev_hex;
 	return run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
-- 
1.7.6.347.g96e0b.dirty
