From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv2 5/9] branch, commit, name-rev: ease up boolean conditions
Date: Wed, 31 Jul 2013 18:28:33 +0200
Message-ID: <1375288117-1576-6-git-send-email-stefanbeller@googlemail.com>
References: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 18:29:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ZGo-00084w-Mt
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 18:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178Ab3GaQ2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 12:28:37 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:43462 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759783Ab3GaQ2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 12:28:34 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so467434eek.26
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Eh/DmuU/nKSVk77nBqqUPM5MUXSmSs9TXfv22Ydl5BY=;
        b=vOLYEw4lOKgPx5KNI+1tvSJ+09f3fLvMLcSgNbnH2zKYct13TWEMgeWMfOux6cc5ZJ
         ub0D9AlC1VnJecLo5CzYK5gZNXuklp1hglnO8OeaQyHUJVCbS559jMiGTwJmStjdmSPW
         yw1kWTdZNjG+RQBfgclUKh5Jh1r+rgtxlqgYADlzyaqZbQ1Ux6tcjFPaqdGFAaWhjdWc
         nt44u3fyPvT+1adGwVi7zNq1XldeCkHri9tr8UB+uFqNOj1Y6RwW+3Q9+DSwh7xwZfcB
         4pnswOB6W9byZNDWOF8TJyIZVMeQT19Qdje7cJ8aJozsACiCtR8A/wQw3bv6dh3OTvKA
         +Tdg==
X-Received: by 10.15.54.67 with SMTP id s43mr69927272eew.133.1375288113035;
        Wed, 31 Jul 2013 09:28:33 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id bb14sm3692275eeb.17.2013.07.31.09.28.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 09:28:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
In-Reply-To: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231425>

Now that the variables are readin by OPT_BOOL, which makes sure
to have the values being 0 or 1 after reading, we do not need
the double negation to map any other value to 1 for integer
variables.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/branch.c   | 3 ++-
 builtin/commit.c   | 2 +-
 builtin/name-rev.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4daed0b..33ba1fb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -872,7 +872,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (with_commit || merge_filter != NO_FILTER)
 		list = 1;
 
-	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!unset_upstream > 1)
+	if (delete + rename + force_create + list + unset_upstream +
+	    !!new_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (abbrev == -1)
diff --git a/builtin/commit.c b/builtin/commit.c
index c20426b..b0f86c8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1072,7 +1072,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (patch_interactive)
 		interactive = 1;
 
-	if (!!also + !!only + !!all + !!interactive > 1)
+	if (also + only + all + interactive > 1)
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
 	if (argc == 0 && (also || (only && !amend)))
 		die(_("No paths with --include/--only does not make sense."));
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index a908a34..20fcf8c 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -331,7 +331,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
-	if (!!all + !!transform_stdin + !!argc > 1) {
+	if (all + transform_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
 		usage_with_options(name_rev_usage, opts);
 	}
-- 
1.8.4.rc0.1.g8f6a3e5
