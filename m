From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] config: fix several access(NULL) calls
Date: Fri, 13 Jul 2012 10:59:54 +0200
Message-ID: <1342169994-11969-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq1ukg82st.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 13 11:00:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spbk7-0007cP-BO
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 11:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455Ab2GMJAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 05:00:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48898 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097Ab2GMJAp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 05:00:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6D8xAYb029851
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 13 Jul 2012 10:59:10 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Spbjn-0006Kq-QC; Fri, 13 Jul 2012 11:00:35 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Spbjn-000381-MP; Fri, 13 Jul 2012 11:00:35 +0200
X-Mailer: git-send-email 1.7.11.1.30.g7e1baf9.dirty
In-Reply-To: <vpq1ukg82st.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 13 Jul 2012 10:59:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6D8xAYb029851
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342774752.72615@2snt86/lnG9af7FnCdvMfA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201397>

When $HOME is unset, home_config_paths fails and returns NULL pointers
for user_config and xdg_config. Valgrind complains with Syscall param
access(pathname) points to unaddressable byte(s).

Don't call blindly access() on these variables, but test them for
NULL-ness before.

The when the XDG configuration file can be found but not $HOME/.gitconfig
requires a bit of attention. We chose to error out in "git config --set"
if $HOME is unset anyway.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

Before I forget about it, here's the patch assuming people do want to
error out when $HOME is unset. It should be functionally equivalent to
the previous one, but the code should be clearer.

 builtin/config.c | 15 +++++++++++----
 config.c         |  4 ++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index e8e1c0a..f064d6e 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -387,12 +387,19 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 		home_config_paths(&user_config, &xdg_config, "config");
 
-		if (access(user_config, R_OK) && !access(xdg_config, R_OK))
+		if (!user_config)
+			/*
+			 * Don't even try to access the xdg_config, as
+			 * unset $HOME means something is really
+			 * broken and should be fixed. Silently
+			 * writing to xdg_config may be confusing.
+			 */
+			die("$HOME not set");
+		else if (access(user_config, R_OK) &&
+			 xdg_config && !access(xdg_config, R_OK))
 			given_config_file = xdg_config;
-		else if (user_config)
-			given_config_file = user_config;
 		else
-			die("$HOME not set");
+			given_config_file = user_config;
 	}
 	else if (use_system_config)
 		given_config_file = git_etc_gitconfig();
diff --git a/config.c b/config.c
index d28a499..6b97503 100644
--- a/config.c
+++ b/config.c
@@ -940,12 +940,12 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 		found += 1;
 	}
 
-	if (!access(xdg_config, R_OK)) {
+	if (xdg_config && !access(xdg_config, R_OK)) {
 		ret += git_config_from_file(fn, xdg_config, data);
 		found += 1;
 	}
 
-	if (!access(user_config, R_OK)) {
+	if (user_config && !access(user_config, R_OK)) {
 		ret += git_config_from_file(fn, user_config, data);
 		found += 1;
 	}
-- 
1.7.11.1.30.g7e1baf9.dirty
