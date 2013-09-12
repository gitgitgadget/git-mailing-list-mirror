From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 1/3] commit: factor status configuration is a helper function
Date: Thu, 12 Sep 2013 12:50:04 +0200
Message-ID: <1378983006-3980-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: javierdo1@gmail.com, jrnieder@gmail.com, judge.packham@gmail.com,
	peff@peff.net, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 12 12:50:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK4Tr-0004C6-P8
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 12:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab3ILKu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 06:50:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50552 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819Ab3ILKuY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 06:50:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8CAo77c013806
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Sep 2013 12:50:07 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VK4TQ-0002AG-6a; Thu, 12 Sep 2013 12:50:08 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VK4TP-00013D-RD; Thu, 12 Sep 2013 12:50:07 +0200
X-Mailer: git-send-email 1.8.4.8.g834017f
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 12 Sep 2013 12:50:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8CAo77c013806
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1379587812.48035@5KME0K7O4uJh57/2FXyy9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234647>

cmd_commit and cmd_status use very similar code to initialize the
wt_status structure. Factor this code into a function to ensure future
changes will keep both versions consistent.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
New patch, as discussed with Peff.

 builtin/commit.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 60812b5..dc957a9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -163,6 +163,14 @@ static void determine_whence(struct wt_status *s)
 		s->whence = whence;
 }
 
+static void status_init_config(struct wt_status *s, config_fn_t fn)
+{
+	wt_status_prepare(s);
+	gitmodules_config();
+	git_config(fn, s);
+	determine_whence(s);
+}
+
 static void rollback_index_files(void)
 {
 	switch (commit_style) {
@@ -1246,10 +1254,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_status_usage, builtin_status_options);
 
-	wt_status_prepare(&s);
-	gitmodules_config();
-	git_config(git_status_config, &s);
-	determine_whence(&s);
+	status_init_config(&s, git_status_config);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
 			     builtin_status_usage, 0);
@@ -1490,11 +1495,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
 
-	wt_status_prepare(&s);
-	gitmodules_config();
-	git_config(git_commit_config, &s);
+	status_init_config(&s, git_commit_config);
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
-	determine_whence(&s);
 	s.colopts = 0;
 
 	if (get_sha1("HEAD", sha1))
-- 
1.8.4.8.g834017f
