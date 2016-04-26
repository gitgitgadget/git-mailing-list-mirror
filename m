From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/15] submodule-config: check if submodule a submodule is in a group
Date: Tue, 26 Apr 2016 13:50:23 -0700
Message-ID: <1461703833-10350-6-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9x9-0006kM-Em
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbcDZUux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:50:53 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36341 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbcDZUuv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:50:51 -0400
Received: by mail-pa0-f45.google.com with SMTP id bt5so10782655pac.3
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NHKraAUGm88/JRX3aR9W2E5Zqi6SAiGIRgLujp23HIQ=;
        b=LHQa2q70KrZ6Ge9tNbRsvROSCAjCpUbmvUaPPsdw64/Y1pxEanESnxFQfg3OVvQYWN
         HmYhjcTIX1+kt3lYZgxuPvo3bOu9NCUdPvJyv5Fhj3UkNf6Pww5u/NiwKAzj5Oggudqf
         yEp+0NBnh2A7B1HyaK3802VXuluDXrSFzoEF670ZGz5mrXHBy578C3nbOn7ec8e2u/mq
         i6Wx/gA90arN9dRHuCgZzX7QZEq3oyQojA5RMeqKgkTpB5xWQ4Nfe3LDU6E8r0JjtefJ
         gDtTZJhsANSGWQeM48FFejkwPOJVM47Ozp/HrTd5xPl40Cvozbm7wvssA0zfswJCvF5N
         aA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NHKraAUGm88/JRX3aR9W2E5Zqi6SAiGIRgLujp23HIQ=;
        b=P4IJpzC75P6bQBfVEPSJfccdL5tPVP8gCXH1ZF4E7Tic1l6ZmRDeiWPANlNp3EQEQY
         USzW2B3tRL7IKfJTkIvfdo4i3OogdgSqATeLAC9K6pI9xtiUYrnqpOiWBTWcdOg4QYFR
         pnY3F86l1SYIITMS/JZ1XdQHNxbvm0rWe9ZPfdT5G7PRzotAOpAQJsIdu5IKKkXNIM8J
         1nsFskw9DV69Pv6YFnWjDkP891jWVhnR8S4DCshlpqgFs3UUiI+pcKWrk8gmeVOnrN8r
         Nw/69ejZdqrVoUT9v0025UALfCPvW2QzEJpmtIu+FWwf1y3nLc1JqhMRsFv8lrVd8PGp
         I7YA==
X-Gm-Message-State: AOPr4FVlqfNURKSKPsaCGP2WTrvRTtPrFmm5YLXxWR4dUURUlXk7hJODjrrO+qzWMs3OzkVr
X-Received: by 10.66.217.137 with SMTP id oy9mr6563403pac.103.1461703850807;
        Tue, 26 Apr 2016 13:50:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id k65sm490785pfb.30.2016.04.26.13.50.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:50:50 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292679>

In later patches we need to tell if a submodule is in a group,
which is defined by name, path or labels.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c  | 43 ++++++++++++++++++++++-
 submodule-config.c           | 50 +++++++++++++++++++++++++++
 submodule-config.h           |  3 ++
 t/t7413-submodule--helper.sh | 81 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100755 t/t7413-submodule--helper.sh

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b6d4f27..23d7224 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -814,6 +814,46 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+int in_group(int argc, const char **argv, const char *prefix)
+{
+	const struct string_list *list;
+	struct string_list actual_list = STRING_LIST_INIT_DUP;
+	const struct submodule *sub;
+	const char *group = NULL;
+
+	struct option default_group_options[] = {
+		OPT_STRING('g', "group", &group, N_("group"),
+				N_("group specifier for submodules")),
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
+	/* Overlay the parsed .gitmodules file with .git/config */
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+
+	if (argc != 1)
+		usage(git_submodule_helper_usage[0]);
+
+	sub = submodule_from_path(null_sha1, argv[0]);
+
+	if (!group)
+		list = git_config_get_value_multi("submodule.defaultGroup");
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
@@ -826,7 +866,8 @@ static struct cmd_struct commands[] = {
 	{"update-clone", update_clone},
 	{"resolve-relative-url", resolve_relative_url},
 	{"resolve-relative-url-test", resolve_relative_url_test},
-	{"init", module_init}
+	{"init", module_init},
+	{"in-group", in_group}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/submodule-config.c b/submodule-config.c
index 0cdb47e..ebed0f2 100644
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
+		 * If no group is specified all, all submodules match to
+		 * keep traditional behavior
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
diff --git a/t/t7413-submodule--helper.sh b/t/t7413-submodule--helper.sh
new file mode 100755
index 0000000..c6939ab
--- /dev/null
+++ b/t/t7413-submodule--helper.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+# This should be merged with t7412 eventually.
+# (currently in flight as jk/submodule-c-credential)
+
+
+test_description='Basic plumbing support of submodule--helper
+
+This test verifies the submodule--helper plumbing command used to implement
+git-submodule.
+'
+
+. ./test-lib.sh
+
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
+		test_must_fail git submodule--helper in-group --group=*bit1 sub0 &&
+			       git submodule--helper in-group --group=*bit1 sub1 &&
+		test_must_fail git submodule--helper in-group --group=*bit1 sub2 &&
+			       git submodule--helper in-group --group=*bit1 sub3 &&
+
+		# test by path:
+			       git submodule--helper in-group --group=./sub0 sub0 &&
+		test_must_fail git submodule--helper in-group --group=./sub0 sub1 &&
+		test_must_fail git submodule--helper in-group --group=./sub0 sub2 &&
+		test_must_fail git submodule--helper in-group --group=./sub0 sub3 &&
+
+		# test by name:
+			       git submodule--helper in-group --group=:sub0 sub0 &&
+		test_must_fail git submodule--helper in-group --group=:sub0 sub1 &&
+		test_must_fail git submodule--helper in-group --group=:sub0 sub2 &&
+		test_must_fail git submodule--helper in-group --group=:sub0 sub3 &&
+
+		# logical OR of path and labels
+			       git submodule--helper in-group --group=*bit1,./sub0 sub0 &&
+			       git submodule--helper in-group --group=*bit1,./sub0 sub1 &&
+		test_must_fail git submodule--helper in-group --group=*bit1,./sub0 sub2 &&
+			       git submodule--helper in-group --group=*bit1,./sub0 sub3 &&
+
+		# test if the config option is picked up
+		git config --add submodule.defaultGroup *bit1 &&
+		git config --add submodule.defaultGroup ./sub0 &&
+
+			       git submodule--helper in-group sub0 &&
+			       git submodule--helper in-group sub1 &&
+		test_must_fail git submodule--helper in-group sub2 &&
+			       git submodule--helper in-group sub3
+	)
+'
+
+test_done
-- 
2.8.0.41.g8d9aeb3
