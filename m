From: Ben Boeckel <mathstuf@gmail.com>
Subject: [PATCH v3] remote: add get-url subcommand
Date: Tue,  4 Aug 2015 10:56:38 -0400
Message-ID: <1438700198-4942-1-git-send-email-mathstuf@gmail.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
Cc: Ben Boeckel <mathstuf@gmail.com>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 04 16:56:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMde8-0004rR-PQ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 16:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934534AbbHDO4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 10:56:48 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:32998 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934267AbbHDO4p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 10:56:45 -0400
Received: by igbpg9 with SMTP id pg9so94655428igb.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xlgIouFlQbPV7DB+zASQoisQRpToHQueVKGEVKjGxJ0=;
        b=0OGPLYDah2uk6u9fd4eWA76fwGvSdMZcT06YBLdXaU938qWLhgcDZGomqrh5zi8VoA
         KhXlGRTnEUKQ7zsA7geeAIyC2mB8nl/GEz0ktjb3GkZTAjT/nFLG/StDBxKAMXSKggOO
         vES5GXdKbc6sMsT+rtjZ0iKMVseOE5l8NjHKOtHXW1owuMsMp2LZedfL+b45UWqT4JTD
         oxkTBcFm21L3XT0Kr7CDgpEvoH6pjDGIFg4UhE0c3Chs/6KANR5vqoDCxzmBLgRh2e45
         fzbu6MkGbFVJ+LmWF+SCLgYBBQ+XJI/7vsw26tK38TLsHcc5fvSIqTDuz4NXN6JH2yyu
         yghQ==
X-Received: by 10.50.126.42 with SMTP id mv10mr4241453igb.66.1438700204671;
        Tue, 04 Aug 2015 07:56:44 -0700 (PDT)
Received: from megas (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id o19sm1215687igi.14.2015.08.04.07.56.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Aug 2015 07:56:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275327>

Expanding `insteadOf` is a part of ls-remote --url and there is no way
to expand `pushInsteadOf` as well. Add a get-url subcommand to be able
to query both as well as a way to get all configured urls.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 Documentation/git-remote.txt | 10 ++++++++
 builtin/remote.c             | 54 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 4c6d6de..3c9bf45 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 'git remote remove' <name>
 'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
 'git remote set-branches' [--add] <name> <branch>...
+'git remote get-url' [--push] [--all] <name>
 'git remote set-url' [--push] <name> <newurl> [<oldurl>]
 'git remote set-url --add' [--push] <name> <newurl>
 'git remote set-url --delete' [--push] <name> <url>
@@ -131,6 +132,15 @@ The named branches will be interpreted as if specified with the
 With `--add`, instead of replacing the list of currently tracked
 branches, adds to that list.
 
+'get-url'::
+
+Retrieves the URLs for a remote. Configurations for `insteadOf` and
+`pushInsteadOf` are expanded here. By default, only the first URL is listed.
++
+With '--push', push URLs are queried rather than fetch URLs.
++
+With '--all', all URLs for the remote will be listed.
+
 'set-url'::
 
 Changes URLs for the remote. Sets first URL for remote <name> that matches
diff --git a/builtin/remote.c b/builtin/remote.c
index f4a6ec9..904869a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -18,6 +18,7 @@ static const char * const builtin_remote_usage[] = {
 	N_("git remote prune [-n | --dry-run] <name>"),
 	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
 	N_("git remote set-branches [--add] <name> <branch>..."),
+	N_("git remote get-url [--push] [--all] <name>"),
 	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
 	N_("git remote set-url --add <name> <newurl>"),
 	N_("git remote set-url --delete <name> <url>"),
@@ -65,6 +66,11 @@ static const char * const builtin_remote_update_usage[] = {
 	NULL
 };
 
+static const char * const builtin_remote_geturl_usage[] = {
+	N_("git remote get-url [--push] [--all] <name>"),
+	NULL
+};
+
 static const char * const builtin_remote_seturl_usage[] = {
 	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
 	N_("git remote set-url --add <name> <newurl>"),
@@ -1497,6 +1503,52 @@ static int set_branches(int argc, const char **argv)
 	return set_remote_branches(argv[0], argv + 1, add_mode);
 }
 
+static int get_url(int argc, const char **argv)
+{
+	int i, push_mode = 0, all_mode = 0;
+	const char *remotename = NULL;
+	struct remote *remote;
+	const char **url;
+	int url_nr;
+	struct option options[] = {
+		OPT_BOOL('\0', "push", &push_mode,
+			 N_("query push URLs rather than fetch URLs")),
+		OPT_BOOL('\0', "all", &all_mode,
+			 N_("return all URLs")),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_geturl_usage, 0);
+
+	if (argc != 1)
+		usage_with_options(builtin_remote_geturl_usage, options);
+
+	remotename = argv[0];
+
+	if (!remote_is_configured(remotename))
+		die(_("No such remote '%s'"), remotename);
+	remote = remote_get(remotename);
+
+	if (push_mode) {
+		url = remote->pushurl;
+		url_nr = remote->pushurl_nr;
+	} else {
+		url = remote->url;
+		url_nr = remote->url_nr;
+	}
+
+	if (!url_nr)
+		die(_("no URLs configured for remote '%s'"), remotename);
+
+	if (all_mode) {
+		for (i = 0; i < url_nr; i++)
+			printf_ln("%s", url[i]);
+	} else {
+		printf_ln("%s", *url);
+	}
+
+	return 0;
+}
+
 static int set_url(int argc, const char **argv)
 {
 	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
@@ -1606,6 +1658,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = set_head(argc, argv);
 	else if (!strcmp(argv[0], "set-branches"))
 		result = set_branches(argc, argv);
+	else if (!strcmp(argv[0], "get-url"))
+		result = get_url(argc, argv);
 	else if (!strcmp(argv[0], "set-url"))
 		result = set_url(argc, argv);
 	else if (!strcmp(argv[0], "show"))
-- 
2.1.0
