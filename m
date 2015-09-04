From: Ben Boeckel <mathstuf@gmail.com>
Subject: [PATCH v4] remote: add get-url subcommand
Date: Fri,  4 Sep 2015 10:30:24 -0400
Message-ID: <1441377024-23832-1-git-send-email-mathstuf@gmail.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
Cc: Ben Boeckel <mathstuf@gmail.com>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 04 16:30:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXs0k-00064V-P8
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 16:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933029AbbIDOaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 10:30:35 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36350 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932924AbbIDOae (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 10:30:34 -0400
Received: by ioii196 with SMTP id i196so25560322ioi.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 07:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Oqy/HcSOxatT7C699caPFIs7YuTMVdb6LlGXIEsek0I=;
        b=lF5cQtUWIxbyrkoA+28k6eNPUPGqyZc+t1FiPcaUN9MpKSDq8ulgD3ntGEZz7bpW+V
         yFOF0wGyPraeG7TQcs0WKt+wD5L/9ZI5agg1mNBjWLI0bnlXU+HprRhOlOp3ULZzNxoN
         bM1P9cqUn38V5ylrfqVJrSY423AI2oGwaMkIvuXZK31xavPaveLMZn6/br/lOxbW7e3z
         slQBVO3vG7nwA1WNnvQo20g4a7o1zsPltryD92lsM4R65ou99o9vU7LbZRTojpkMn/Lh
         KkjOWMR3gWHZ9G/QQsHusew7AZRkwT1lq2iGkYaHXgFL2x7KYkBqmIO7+5/zyfNrzKK7
         /ihQ==
X-Received: by 10.107.10.165 with SMTP id 37mr7564436iok.120.1441377033286;
        Fri, 04 Sep 2015 07:30:33 -0700 (PDT)
Received: from megas (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id lp3sm1494831igb.12.2015.09.04.07.30.31
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Sep 2015 07:30:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.1.g397396c.dirty
In-Reply-To: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277313>

Expanding `insteadOf` is a part of ls-remote --url and there is no way
to expand `pushInsteadOf` as well. Add a get-url subcommand to be able
to query both as well as a way to get all configured urls.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 Documentation/git-remote.txt | 10 ++++++++
 builtin/remote.c             | 58 ++++++++++++++++++++++++++++++++++++++++++++
 t/t5505-remote.sh            | 53 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)

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
index 181668d..192b9cb 100644
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
@@ -1467,6 +1473,56 @@ static int set_branches(int argc, const char **argv)
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
+	url_nr = 0;
+	if (push_mode) {
+		url = remote->pushurl;
+		url_nr = remote->pushurl_nr;
+	}
+
+	/* Fall back to the fetch URL if no push URLs are set. */
+	if (!url_nr) {
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
@@ -1576,6 +1632,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = set_head(argc, argv);
 	else if (!strcmp(argv[0], "set-branches"))
 		result = set_branches(argc, argv);
+	else if (!strcmp(argv[0], "get-url"))
+		result = get_url(argc, argv);
 	else if (!strcmp(argv[0], "set-url"))
 		result = set_url(argc, argv);
 	else if (!strcmp(argv[0], "show"))
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 7a8499c..2cfd3cb 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -919,6 +919,18 @@ test_expect_success 'new remote' '
 	cmp expect actual
 '
 
+test_expect_success 'get-url on new remote' '
+	echo foo >expect &&
+	git remote get-url someremote >actual &&
+	cmp expect actual &&
+	git remote get-url --all someremote >actual &&
+	cmp expect actual &&
+	git remote get-url --push someremote >actual &&
+	cmp expect actual &&
+	git remote get-url --push --all someremote >actual &&
+	cmp expect actual
+'
+
 test_expect_success 'remote set-url bar' '
 	git remote set-url someremote bar &&
 	echo bar >expect &&
@@ -961,6 +973,24 @@ test_expect_success 'remote set-url --push zot' '
 	cmp expect actual
 '
 
+test_expect_success 'get-url with different urls' '
+	echo baz >expect &&
+	echo "YYY" >>expect &&
+	echo baz >>expect &&
+	echo "YYY" >>expect &&
+	echo zot >>expect &&
+	echo "YYY" >>expect &&
+	echo zot >>expect &&
+	git remote get-url someremote >actual &&
+	echo "YYY" >>actual &&
+	git remote get-url --all someremote >>actual &&
+	echo "YYY" >>actual &&
+	git remote get-url --push someremote >>actual &&
+	echo "YYY" >>actual &&
+	git remote get-url --push --all someremote >>actual &&
+	cmp expect actual
+'
+
 test_expect_success 'remote set-url --push qux zot' '
 	git remote set-url --push someremote qux zot &&
 	echo qux >expect &&
@@ -995,6 +1025,17 @@ test_expect_success 'remote set-url --push --add aaa' '
 	cmp expect actual
 '
 
+test_expect_success 'get-url on multi push remote' '
+	echo foo >expect &&
+	echo "YYY" >>expect &&
+	echo foo >>expect &&
+	echo aaa >>expect &&
+	git remote get-url --push someremote >actual &&
+	echo "YYY" >>actual &&
+	git remote get-url --push --all someremote >>actual &&
+	cmp expect actual
+'
+
 test_expect_success 'remote set-url --push bar aaa' '
 	git remote set-url --push someremote bar aaa &&
 	echo foo >expect &&
@@ -1039,6 +1080,17 @@ test_expect_success 'remote set-url --add bbb' '
 	cmp expect actual
 '
 
+test_expect_success 'get-url on multi fetch remote' '
+	echo baz >expect &&
+	echo "YYY" >>expect &&
+	echo baz >>expect &&
+	echo bbb >>expect &&
+	git remote get-url someremote >actual &&
+	echo "YYY" >>actual &&
+	git remote get-url --all someremote >>actual &&
+	cmp expect actual
+'
+
 test_expect_success 'remote set-url --delete .*' '
 	test_must_fail git remote set-url --delete someremote .\* &&
 	echo "YYY" >expect &&
@@ -1108,6 +1160,7 @@ test_extra_arg rename origin newname
 test_extra_arg remove origin
 test_extra_arg set-head origin master
 # set-branches takes any number of args
+test_extra_arg get-url origin newurl
 test_extra_arg set-url origin newurl oldurl
 # show takes any number of args
 # prune takes any number of args
-- 
2.5.0.1.g397396c.dirty
