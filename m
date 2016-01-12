From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 17/21] clone: use child_process for recursive checkouts
Date: Mon, 11 Jan 2016 20:22:16 -0500
Message-ID: <1452561740-8668-18-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:23:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIng8-0003ZI-Ri
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761926AbcALBXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:23:11 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34828 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761881AbcALBWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:52 -0500
Received: by mail-qk0-f173.google.com with SMTP id n135so233503743qka.2
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=OxgdvAqaprtnMiscavz8VkpZ9OhPrGCz/k/5/r4+wfk=;
        b=1yxBeTispmMQWsmkriE10UV3p9wpRcL4pxSKqNQlZEeUeGggPsJYAU9WfjGppWR0nT
         EyJOeo4S0x/RQwf6v7tYGt43+CVX1OEMBeTv3bLO68sDeMhQ94jVw0GW7qx3Ez2OKvmB
         b9/wFQCWs/wpK9Bs+SieVMxpQULxC/jBSeuEb2gC3FGm+Xn+NDYSekmSbtM1V2/NiD4i
         WjXZDp+wmDS/p6rWY/cG+OTgQfNQERieIIoIDzQ/8Njck80dUmnFm4I/yal+XBAR026u
         ycPNyGnEryim8+OMj2FXQcVmF59zrcoFRf6b5XfLYtsST8wX7iKW99xSNKmcOvxVYTe2
         EJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=OxgdvAqaprtnMiscavz8VkpZ9OhPrGCz/k/5/r4+wfk=;
        b=Js7ygWbkc/bPAQmbHPduHO9VrB2RGkyQvq9cegdiACcRx2ISL+tHzQX8Em9YUnPBSF
         W++4d+A9KTZ5WDGwMGwwUp4QIIo6jFFRFI/OS/1nScXMMosFSA46L8BIuhmDchSVbzTO
         8GP17IgHAxkclWaPUpUpP1dfm61mIxaaUbYlBaVME+yHSs7xXiG8JNfS4GZwu/4QiVDk
         3/99HsquYLwiU34BCqWG75quL+9IBESvBeQV5vpITcytBL9KOhF2AXXv90nvH0NIv4EI
         SHIoYAHdefV5QOHnog8FV4EY5wsAO/YzSNYoEMMZBOqrpf9X8XNQ9vNxrleCO6HvTp41
         1/yA==
X-Gm-Message-State: ALoCoQmsYt2aEuY6Rx3u0t0/Ese8sAVrI3iYISGjmSZvVXCbOR9cCYFOf437qMYFyQF1BzZ7XDQSTTmffGRuYXnkWnsWIYSsaw==
X-Received: by 10.55.73.74 with SMTP id w71mr169609610qka.60.1452561771443;
        Mon, 11 Jan 2016 17:22:51 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:50 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283752>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/clone.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index caae43e..53c2834 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -95,10 +95,6 @@ static struct option builtin_clone_options[] = {
 	OPT_END()
 };
 
-static const char *argv_submodule[] = {
-	"submodule", "update", "--init", "--recursive", NULL
-};
-
 static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
 {
 	static char *suffix[] = { "/.git", "", ".git/.git", ".git" };
@@ -724,8 +720,14 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive)
-		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+	if (!err && option_recursive) {
+		struct child_process cmd = CHILD_PROCESS_INIT;
+
+		cmd.git_cmd = 1;
+		argv_array_pushl(&cmd.args, "submodule", "update",
+				 "--init", "--recursive", NULL);
+		err = run_command(&cmd);
+	}
 
 	return err;
 }
-- 
2.4.2.749.g730654d-twtrsrc
