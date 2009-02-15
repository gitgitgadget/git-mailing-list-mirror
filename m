From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/8] config: Don't return negative exit codes.
Date: Sun, 15 Feb 2009 11:00:59 +0200
Message-ID: <1234688460-9248-7-git-send-email-felipe.contreras@gmail.com>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-5-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-6-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 10:03:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYcuH-0000wm-4m
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 10:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbZBOJBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 04:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbZBOJB2
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 04:01:28 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:54154 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbZBOJBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 04:01:20 -0500
Received: by mail-fx0-f20.google.com with SMTP id 13so4790431fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 01:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pzF9UPLlJeDEwhQlntELanQB0sRWTZs6/Tcl/JlH/xk=;
        b=KkDQqQ49VaCwvHCuqo34qua3cGcTurLNMLkWtgVMvyqmTgNzsmq6N8ixUMu8p5aN6Q
         Xa5QJmE4j+Qi9QQwXX5RAms1iBQ1TAJ/wBzGdkrZ/ZcC+hCMd96vTSxJzJp81mDhFe2h
         Qjuz3OfpYdGbaJ5BnmBWbOp8UimP9dmAYPlO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nwr43q3nQRh1PfWV2fbzgQ0bWlyhkkZIhH0T7ua2++YMjRs6yCWgfT58VU8Qn70VVq
         yoPgsmEJRhShNnSEQEIo5Y/sQa+FoEm3nxKgNTysUrJ/PGYcGWsgvGAaaCPLtXO1oONX
         BqQk4gs5qDtw+n12W7sfQliepezNWz+JpXWso=
Received: by 10.180.222.14 with SMTP id u14mr465821bkg.141.1234688479079;
        Sun, 15 Feb 2009 01:01:19 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 31sm2684976fkt.2.2009.02.15.01.01.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 01:01:18 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234688460-9248-6-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109977>

As suggested by Johannes Schindelin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |   27 +++++++++++----------------
 1 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 3463b1c..677ae3f 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -308,6 +308,7 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 {
 	int nongit;
 	char* value;
+	int ret = 0;
 	const char *prefix = setup_git_directory_gently(&nongit);
 
 	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
@@ -392,55 +393,49 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	else if (actions & ACTION_ADD) {
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar(argv[0], value, "^$", 0);
+		ret = git_config_set_multivar(argv[0], value, "^$", 0);
 	}
 	else if (actions & ACTION_REPLACE_ALL) {
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar(argv[0], value, argv[2], 1);
+		ret = git_config_set_multivar(argv[0], value, argv[2], 1);
 	}
 	else if (actions & ACTION_GET) {
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1]);
+		ret = get_value(argv[0], argv[1]);
 	}
 	else if (actions & ACTION_GET_ALL) {
 		do_all = 1;
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1]);
+		ret = get_value(argv[0], argv[1]);
 	}
 	else if (actions & ACTION_GET_REGEXP) {
 		show_keys = 1;
 		use_key_regexp = 1;
 		do_all = 1;
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1]);
+		ret = get_value(argv[0], argv[1]);
 	}
 	else if (actions & ACTION_UNSET) {
 		check_argc(argc, 1, 2);
 		if (argc == 2)
-			return git_config_set_multivar(argv[0], NULL, argv[1], 0);
+			ret = git_config_set_multivar(argv[0], NULL, argv[1], 0);
 		else
-			return git_config_set(argv[0], NULL);
+			ret = git_config_set(argv[0], NULL);
 	}
 	else if (actions & ACTION_UNSET_ALL) {
 		check_argc(argc, 1, 2);
-		return git_config_set_multivar(argv[0], NULL, argv[1], 1);
+		ret = git_config_set_multivar(argv[0], NULL, argv[1], 1);
 	}
 	else if (actions & ACTION_RENAME_SECTION) {
-		int ret;
 		check_argc(argc, 2, 2);
 		ret = git_config_rename_section(argv[0], argv[1]);
-		if (ret < 0)
-			return ret;
 		if (ret == 0)
 			die("No such section!");
 	}
 	else if (actions & ACTION_REMOVE_SECTION) {
-		int ret;
 		check_argc(argc, 1, 1);
 		ret = git_config_rename_section(argv[0], NULL);
-		if (ret < 0)
-			return ret;
 		if (ret == 0)
 			die("No such section!");
 	}
@@ -452,8 +447,8 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 			stdout_is_tty = git_config_bool("command line", argv[0]);
 		else if (argc == 0)
 			stdout_is_tty = isatty(1);
-		return get_colorbool(argc != 1);
+		ret = get_colorbool(argc != 1);
 	}
 
-	return 0;
+	return !!ret;
 }
-- 
1.6.1.3
