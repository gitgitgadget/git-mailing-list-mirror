From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/7] submodule-config: check if a submodule is in a group
Date: Tue, 10 May 2016 17:59:54 -0700
Message-ID: <1462928397-1708-5-git-send-email-sbeller@google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed May 11 03:00:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0IW1-0002HK-Cl
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 03:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbcEKBAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 21:00:15 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36046 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbcEKBAN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 21:00:13 -0400
Received: by mail-pf0-f181.google.com with SMTP id c189so12150026pfb.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 18:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O931SFfWa06dqnrv/VdfJzKh2b+l8d95n4Ny9cQqVcE=;
        b=lBvmZldWJVdJU9OQcUvlAXdzCDcKfhsD+49DKAIV81jNECNNGg3R+kPM33LI4azcxr
         jRkvXZARWNbKL1JvW97SDp/fcp9PdIAGXiTySpDgroWUh2XpznNCFCyLlGYRZOqfXsUs
         NRaskoZje4oBL6cr4v2GTOLZTlg3ZGVf9SQn79Qj8QtlyFO9ITBFsmlPX/vGzrgmjCyO
         mAtWx2qBkgH7ji8wFxBptnpb201g9O3AU63SRfa+Of6FGSs2N+xoqBXJi1/geDw3TI47
         Jz1B+JuB8Dr+oMnf62fvyW5MEs50dM5LL2++DNQ2Sw/dAq5gQXwn2Rq/CXVyop/QhPzt
         YGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O931SFfWa06dqnrv/VdfJzKh2b+l8d95n4Ny9cQqVcE=;
        b=jPchjsEBxz/SfAvRaSHpxtbV1UW2Rq2d+zet7DlRVI7JVRlcxL91f+CjvCeXIUoMAL
         p9fnJHInLXtaoNdJ+PuPRXWqH0W+qX2jQ4SqlybB6trx4isolzAy9duExTw9WOpSPAQY
         VKdLrAcs9AHuyMd91gOsxUa/ZCtugnf2XG6OaF89hFuG9sAtUE54jhk4YnqMjc3rWLGi
         RAdy+z4tJ4JKBjIW1/H7uBpLbFCcP7e2XytOoI2QYxYWtlu8yQalrHmfeiBvWyPowrLG
         qrdAgWVhhsfcanQqROYorvOVlXejNcSI6l3tPRUbBfnL3ULWxZ0+fNPyNPWejNhlnY5n
         KSjQ==
X-Gm-Message-State: AOPr4FUGax7JQzHWDnZyxsk7z07kDUbcxJglKACZLRC9HIfHUy+ueU6db/zjixAqw9fAW269
X-Received: by 10.98.47.66 with SMTP id v63mr700661pfv.67.1462928411990;
        Tue, 10 May 2016 18:00:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:69ac:db78:a0d1:60da])
        by smtp.gmail.com with ESMTPSA id p80sm7222113pfj.58.2016.05.10.18.00.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 May 2016 18:00:11 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.35.g58985d9.dirty
In-Reply-To: <1462928397-1708-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294217>

In later patches we need to tell if a submodule is in a group,
so expose a handy test function in both C and shell.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c  | 42 +++++++++++++++++++++++++++++++-
 submodule-config.c           | 50 ++++++++++++++++++++++++++++++++++++++
 submodule-config.h           |  3 +++
 t/t7412-submodule--helper.sh | 58 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d3f4684..6ffd1c1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -858,6 +858,45 @@ static int valid_label_name(int argc, const char **argv, const char *prefix)
 	      "and must contain alphanumeric characters or dashes only."));
 }
 
+static int in_group(int argc, const char **argv, const char *prefix)
+{
+	const struct string_list *list;
+	struct string_list actual_list = STRING_LIST_INIT_DUP;
+	const struct submodule *sub;
+	const char *group = NULL;
+
+	struct option default_group_options[] = {
+		OPT_STRING('g', "group", &group, N_("group"),
+				N_("comma separated group specifier for submodules")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper in-group <path>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, default_group_options,
+			     git_submodule_helper_usage, 0);
+
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+
+	if (argc != 1)
+		usage(git_submodule_helper_usage[0]);
+
+	sub = submodule_from_path(null_sha1, argv[0]);
+
+	if (!group)
+		list = git_config_get_value_multi("submodule.updateGroup");
+	else {
+		string_list_split(&actual_list, group, ',', -1);
+		list = &actual_list;
+	}
+
+	return !submodule_in_group(list, sub);
+}
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -871,7 +910,8 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url", resolve_relative_url},
 	{"resolve-relative-url-test", resolve_relative_url_test},
 	{"init", module_init},
-	{"valid-label-name", valid_label_name}
+	{"valid-label-name", valid_label_name},
+	{"in-group", in_group}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/submodule-config.c b/submodule-config.c
index 0cdb47e..7f38ebd 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -522,3 +522,53 @@ void submodule_free(void)
 	cache_free(&cache);
 	is_cache_init = 0;
 }
+
+int submodule_in_group(const struct string_list *group,
+		       const struct submodule *sub)
+{
+	int matched = 0;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!group)
+		/*
+		 * If no group is specified at all, all submodules match to
+		 * keep traditional behavior.
+		 */
+		return 1;
+
+	if (sub->labels) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, sub->labels) {
+			strbuf_reset(&sb);
+			strbuf_addf(&sb, "*%s", item->string);
+			if (string_list_has_string(group, sb.buf)) {
+				matched = 1;
+				break;
+			}
+		}
+	}
+	if (sub->path) {
+		/*
+		 * NEEDSWORK: This currently works only for
+		 * exact paths, but we want to enable
+		 * inexact matches such wildcards.
+		 */
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "./%s", sub->path);
+		if (string_list_has_string(group, sb.buf))
+			matched = 1;
+	}
+	if (sub->name) {
+		/*
+		 * NEEDSWORK: Same as with path. Do we want to
+		 * support wildcards or such?
+		 */
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, ":%s", sub->name);
+		if (string_list_has_string(group, sb.buf))
+			matched = 1;
+	}
+	strbuf_release(&sb);
+
+	return matched;
+}
diff --git a/submodule-config.h b/submodule-config.h
index d57da59..4c696cc 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -31,4 +31,7 @@ const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path);
 void submodule_free(void);
 
+int submodule_in_group(const struct string_list *group,
+		       const struct submodule *sub);
+
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
index 3af315c..042f3f5 100755
--- a/t/t7412-submodule--helper.sh
+++ b/t/t7412-submodule--helper.sh
@@ -46,4 +46,62 @@ test_expect_success 'valid-label-name fails with utf8 characters' '
 	test_i18ngrep alphanumeric actual
 '
 
+test_expect_success 'setup superproject with submodules' '
+
+	mkdir sub &&
+	(
+		cd sub &&
+		git init &&
+		test_commit test
+		test_commit test2
+	) &&
+	mkdir super &&
+	(
+		cd super &&
+		git init &&
+		git submodule add ../sub sub0 &&
+		git submodule add -l bit1 ../sub sub1 &&
+		git submodule add -l bit2 ../sub sub2 &&
+		git submodule add -l bit2 -l bit1 ../sub sub3 &&
+		git submodule add ../sub sub_name &&
+		git mv sub_name sub_path &&
+		git commit -m "add labeled submodules"
+	)
+'
+
+test_expect_success 'in-group' '
+	(
+		cd super &&
+		# we do not specify a group nor have set a default group,
+		# any submodule should be in the default group:
+		git submodule--helper in-group sub0 &&
+		git submodule--helper in-group sub1 &&
+		git submodule--helper in-group sub2 &&
+		git submodule--helper in-group sub3 &&
+
+		# test bit1:
+		test_must_fail git submodule--helper in-group --group=\*bit1 sub0 &&
+			       git submodule--helper in-group --group=\*bit1 sub1 &&
+		test_must_fail git submodule--helper in-group --group=\*bit1 sub2 &&
+			       git submodule--helper in-group --group=\*bit1 sub3 &&
+		test_must_fail git submodule--helper in-group --group=\*bit1 sub_path &&
+
+		# test by path:
+			       git submodule--helper in-group --group=./sub0 sub0 &&
+		test_must_fail git submodule--helper in-group --group=./sub0 sub1 &&
+		test_must_fail git submodule--helper in-group --group=./sub0 sub_path &&
+
+		# tests by name:
+			       git submodule--helper in-group --group=:sub0 sub0 &&
+		test_must_fail git submodule--helper in-group --group=:sub0 sub1 &&
+			       git submodule--helper in-group --group=:sub_name sub_path &&
+
+		# logical OR of path and labels
+			       git submodule--helper in-group --group=\*bit1,./sub0 sub0 &&
+			       git submodule--helper in-group --group=\*bit1,./sub0 sub1 &&
+		test_must_fail git submodule--helper in-group --group=\*bit1,./sub0 sub2 &&
+			       git submodule--helper in-group --group=\*bit1,./sub0 sub3
+	)
+'
+
 test_done
-- 
2.8.0.35.g58985d9.dirty
