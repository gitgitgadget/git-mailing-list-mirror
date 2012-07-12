From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] config: fix several access(NULL) calls
Date: Thu, 12 Jul 2012 14:04:20 +0200
Message-ID: <1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 12 14:04:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpI8b-0005WB-Bn
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 14:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933765Ab2GLMEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 08:04:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47315 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933759Ab2GLMEp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 08:04:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6CC31HV000413
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Jul 2012 14:03:01 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SpI8K-0007V0-2E; Thu, 12 Jul 2012 14:04:36 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SpI8J-0001y0-Sg; Thu, 12 Jul 2012 14:04:35 +0200
X-Mailer: git-send-email 1.7.11.1.29.g0e8593d.dirty
In-Reply-To: <877gu9wh05.fsf@thomas.inf.ethz.ch>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 12 Jul 2012 14:03:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6CC31HV000413
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342699385.1991@ulXD61Iseh8/IbJw/bv9cg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201356>

When $HOME is unset, home_config_paths fails and returns NULL pointers
for user_config and xdg_config. Valgrind complains with Syscall param
access(pathname) points to unaddressable byte(s).

Don't call blindly access() on these variables, but test them for
NULL-ness before.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> This patch causes valgrind warnings in t1300.81 (get --path copes with
> unset $HOME) about passing NULL to access():

Indeed. The following patch should fix it.

 builtin/config.c | 3 ++-
 config.c         | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index e8e1c0a..67945b2 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -387,7 +387,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 		home_config_paths(&user_config, &xdg_config, "config");
 
-		if (access(user_config, R_OK) && !access(xdg_config, R_OK))
+		if (user_config && access(user_config, R_OK) &&
+		    xdg_config && !access(xdg_config, R_OK))
 			given_config_file = xdg_config;
 		else if (user_config)
 			given_config_file = user_config;
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
1.7.11.1.29.g0e8593d.dirty
