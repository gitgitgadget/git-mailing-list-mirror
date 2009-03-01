From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] git-init: inject some sanity to the option parser
Date: Sat, 28 Feb 2009 16:03:40 -0800
Message-ID: <1235865822-14625-2-git-send-email-gitster@pobox.com>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 01:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdZBq-000803-Gk
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 01:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbZCAADx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 19:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754942AbZCAADw
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 19:03:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbZCAADv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 19:03:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E5D1A9D252
	for <git@vger.kernel.org>; Sat, 28 Feb 2009 19:03:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 35E509D250 for
 <git@vger.kernel.org>; Sat, 28 Feb 2009 19:03:46 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.99.g9f3bb
In-Reply-To: <1235865822-14625-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 701A145A-05F4-11DE-879B-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111803>

The parsing loop was a mess full of side effects.

This commit separates the loop that parses and understand the options
given, and the part that makes side effects based on given options.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-init-db.c |   35 ++++++++++++++++++++++++-----------
 1 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index ee3911f..9628803 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -377,27 +377,40 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *git_dir;
 	const char *template_dir = NULL;
 	unsigned int flags = 0;
+	const char *shared_given = NULL;
+	int bare_given = 0;
 	int i;
 
-	for (i = 1; i < argc; i++, argv++) {
-		const char *arg = argv[1];
+	/* Parse without side effects that is hard to undo or unparse */
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
 		if (!prefixcmp(arg, "--template="))
-			template_dir = arg+11;
-		else if (!strcmp(arg, "--bare")) {
-			static char git_dir[PATH_MAX+1];
-			is_bare_repository_cfg = 1;
-			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir,
-						sizeof(git_dir)), 0);
-		} else if (!strcmp(arg, "--shared"))
-			init_shared_repository = PERM_GROUP;
+			template_dir = arg + 11;
+		else if (!strcmp(arg, "--bare"))
+			bare_given = 1;
+		else if (!strcmp(arg, "--shared"))
+			shared_given = "";
 		else if (!prefixcmp(arg, "--shared="))
-			init_shared_repository = git_config_perm("arg", arg+9);
+			shared_given = arg + 9;
 		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
 			flags |= INIT_DB_QUIET;
 		else
 			usage(init_db_usage);
 	}
 
+	if (bare_given) {
+		static char git_dir[PATH_MAX+1];
+		is_bare_repository_cfg = 1;
+		setenv(GIT_DIR_ENVIRONMENT,
+		       getcwd(git_dir, sizeof(git_dir)), 0);
+	}
+
+	if (shared_given)
+		init_shared_repository =
+			((!*shared_given)
+			 ? PERM_GROUP
+			 : git_config_perm("arg", shared_given));
+
 	/*
 	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
 	 * without --bare.  Catch the error early.
-- 
1.6.2.rc2.99.g9f3bb
