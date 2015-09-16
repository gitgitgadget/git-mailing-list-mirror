From: Ben Boeckel <mathstuf@gmail.com>
Subject: [PATCH v5] remote: add get-url subcommand
Date: Tue, 15 Sep 2015 21:53:47 -0400
Message-ID: <1442368427-3311-1-git-send-email-mathstuf@gmail.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
Cc: git@vger.kernel.org, Ben Boeckel <mathstuf@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 16 03:54:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc1v2-0002OX-OL
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 03:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbbIPBxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 21:53:53 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33864 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbbIPBxw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 21:53:52 -0400
Received: by iofb144 with SMTP id b144so218028655iof.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 18:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3KrVRdwaN0iJI0lyk4/TfegfJkzsbqmLh3dOBJUKA4g=;
        b=q9IUU4G/5jyqm/NyA74X+ZEtmY6eEhj4RJ/TmzIO0JvkkTIPCTIE0xuJ6C+T0sutGr
         7PDtOWIR64iTLC8aDwMdmGqLG8MbSLFMzuwZAXwnffpw1QcWA34naO6ldbsGGIt6S/r0
         1kl3Ms/Ovw8wjJULxHcxQ11W6pKnt1+npYzsnOYrBObmf3M5ZWnCC70D16kYiRPXlqxR
         vy5OBVIgnmGuld+/PUjfilzUfmtmJTgjxvA1o3KCRcA1RRnVV0As2KzUgqMOE1rwJe8u
         R9iGD0gDubyCxOpeiZNV3WMN3a3qK4skyl/P8NgQTLGolmNE0+26K5yaFXiRfl2SVbrh
         v81A==
X-Received: by 10.107.15.159 with SMTP id 31mr43393216iop.159.1442368431528;
        Tue, 15 Sep 2015 18:53:51 -0700 (PDT)
Received: from localhost (196.sub-70-209-140.myvzw.com. [70.209.140.196])
        by smtp.gmail.com with ESMTPSA id qd2sm916408igb.19.2015.09.15.18.53.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2015 18:53:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.2
In-Reply-To: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277996>

Expanding `insteadOf` is a part of ls-remote --url and there is no way
to expand `pushInsteadOf` as well. Add a get-url subcommand to be able
to query both as well as a way to get all configured urls.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 Documentation/git-remote.txt | 10 ++++++++
 builtin/remote.c             | 59 ++++++++++++++++++++++++++++++++++++++++++++
 t/t5505-remote.sh            | 39 +++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

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
index 181668d..e4c3ea1 100644
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
@@ -1467,6 +1473,57 @@ static int set_branches(int argc, const char **argv)
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
+	/* else fetch mode */
+
+	/* Use the fetch URL when no push URLs were found or requested. */
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
@@ -1576,6 +1633,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = set_head(argc, argv);
 	else if (!strcmp(argv[0], "set-branches"))
 		result = set_branches(argc, argv);
+	else if (!strcmp(argv[0], "get-url"))
+		result = get_url(argc, argv);
 	else if (!strcmp(argv[0], "set-url"))
 		result = set_url(argc, argv);
 	else if (!strcmp(argv[0], "show"))
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 7a8499c..f03ba4c 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -919,6 +919,21 @@ test_expect_success 'new remote' '
 	cmp expect actual
 '
 
+get_url_test () {
+	cat >expect &&
+	test_expect_success "get-url $*" "
+		git remote get-url $* >actual &&
+		test_cmp expect actual
+	"
+}
+
+test_expect_success 'get-url on new remote' '
+	echo foo | get_url_test someremote &&
+	echo foo | get_url_test --all someremote &&
+	echo foo | get_url_test --push someremote &&
+	echo foo | get_url_test --push --all someremote
+'
+
 test_expect_success 'remote set-url bar' '
 	git remote set-url someremote bar &&
 	echo bar >expect &&
@@ -961,6 +976,13 @@ test_expect_success 'remote set-url --push zot' '
 	cmp expect actual
 '
 
+test_expect_success 'get-url with different urls' '
+	echo baz | get_url_test someremote &&
+	echo baz | get_url_test --all someremote &&
+	echo zot | get_url_test --push someremote &&
+	echo zot | get_url_test --push --all someremote
+'
+
 test_expect_success 'remote set-url --push qux zot' '
 	git remote set-url --push someremote qux zot &&
 	echo qux >expect &&
@@ -995,6 +1017,14 @@ test_expect_success 'remote set-url --push --add aaa' '
 	cmp expect actual
 '
 
+test_expect_success 'get-url on multi push remote' '
+	echo foo | get_url_test --push someremote &&
+	get_url_test --push --all someremote <<-\EOF
+	foo
+	aaa
+	EOF
+'
+
 test_expect_success 'remote set-url --push bar aaa' '
 	git remote set-url --push someremote bar aaa &&
 	echo foo >expect &&
@@ -1039,6 +1069,14 @@ test_expect_success 'remote set-url --add bbb' '
 	cmp expect actual
 '
 
+test_expect_success 'get-url on multi fetch remote' '
+	echo baz | get_url_test someremote &&
+	get_url_test --all someremote <<-\EOF
+	baz
+	bbb
+	EOF
+'
+
 test_expect_success 'remote set-url --delete .*' '
 	test_must_fail git remote set-url --delete someremote .\* &&
 	echo "YYY" >expect &&
@@ -1108,6 +1146,7 @@ test_extra_arg rename origin newname
 test_extra_arg remove origin
 test_extra_arg set-head origin master
 # set-branches takes any number of args
+test_extra_arg get-url origin newurl
 test_extra_arg set-url origin newurl oldurl
 # show takes any number of args
 # prune takes any number of args
-- 
2.5.2
