From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/15] submodule--helper update_clone: respect submodule groups
Date: Tue, 26 Apr 2016 13:50:28 -0700
Message-ID: <1461703833-10350-11-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9wm-0006WI-9N
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbcDZUvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:51:01 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33796 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbcDZUu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:50:59 -0400
Received: by mail-pf0-f182.google.com with SMTP id y69so11424006pfb.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y41dLhHk+CCX8930Et/3ofJUFYnwlprg7W/pKLm3u7s=;
        b=COaCTUKhcX//TIP7Jsw9LlITFZABxOjNVadwUxa+h3p82RM/DHJ0fvc9spIq0RQl7T
         aZlOEwzqOxtaIHRLeY6/XmV6wWNqE7AxQWsk3/2OeSpmJwRSz+6BR9YJjTX2zN4MRiI0
         q6oUk+TLFYNXhScirrWNnbuwWwZ5EpYd2MkwPic8qTCiQdTpgniFAykLqeS+vhmc23AV
         73TkI6lE9gbPTGSZCwlXYYzx8XYJFlI1J/u+sutZX9UkhImwj/rAfHpv93GCCJDZfCDs
         4UvHk6Y8tqAcvPlf+tcGSzYxF3Y3ptWP4fCHQHK9J0HX1iuEYXamLIv/kG9cPP6msF89
         RWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y41dLhHk+CCX8930Et/3ofJUFYnwlprg7W/pKLm3u7s=;
        b=LTwGhEVczk3gndhLTZG3tgb7g3Jdo2wPBLsiY14Gr+aX8NYkGKnJ+vor25vn1909s4
         u5opHYRpljLPViox+W72jDqxvnzJLrpuwUITXfLJ8mGSY3vehJjwgPJ8c6JEKI12nRsx
         /EOaPN1/ir/b/E6spqkFlHdXKIuQB2U2JtHz4MVoikVpDKF03bd6NV22e0XvP3grgFRi
         8r5+pcXhsKqpOqmd3c9Q6DIVwfw/TP61vaePD7c05azsYyQCjJUOZ4dXN88V7ncL73+g
         hyJdYRGw0KrL/ToMHsE//5d63qZGKxSjhLj+WjAkBJ/74EyXUq3LJbPJySWU8n6dUVtW
         EhEA==
X-Gm-Message-State: AOPr4FVrZm0on8/18eg+hn++SjNGSWmmsiI6EN+nZwAIh+DforQyp0SB6VV31LGeZpI7Sqn8
X-Received: by 10.98.76.194 with SMTP id e63mr6556998pfj.63.1461703858609;
        Tue, 26 Apr 2016 13:50:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id qm10sm675360pac.33.2016.04.26.13.50.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:50:58 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292672>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c  | 16 ++++++++++++++++
 t/t7413-submodule--helper.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 29a345e..aa838c5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -610,6 +610,8 @@ struct submodule_update_clone {
 
 	/* Machine-readable status lines to be consumed by git-submodule.sh */
 	struct string_list projectlines;
+	/* The group specification we'll be processing. */
+	struct string_list *group;
 
 	/* If we want to stop as fast as possible and return an error */
 	unsigned quickstop : 1;
@@ -646,6 +648,9 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 
 	sub = submodule_from_path(null_sha1, ce->name);
 
+	if (!submodule_in_group(suc->group, sub))
+		goto cleanup;
+
 	if (suc->recursive_prefix)
 		displaypath = relative_path(suc->recursive_prefix,
 					    ce->name, &displaypath_sb);
@@ -771,6 +776,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	struct string_list_item *item;
 	struct pathspec pathspec;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
+	struct string_list actual_group = STRING_LIST_INIT_DUP;
 
 	struct option module_update_clone_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -810,6 +816,16 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
 		return 1;
 
+	if (!pathspec.nr) {
+		const struct string_list *group =
+			group = git_config_get_value_multi("submodule.defaultGroup");
+		if (group) {
+			for_each_string_list_item(item, group)
+				string_list_append(&actual_group, item->string);
+			suc.group = &actual_group;
+		}
+	}
+
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
diff --git a/t/t7413-submodule--helper.sh b/t/t7413-submodule--helper.sh
index ef12c63..39e469f 100755
--- a/t/t7413-submodule--helper.sh
+++ b/t/t7413-submodule--helper.sh
@@ -190,4 +190,40 @@ test_expect_success 'submodule--helper init respects groups' '
 	)
 '
 
+cat >expect <<-EOF
+160000 $submodule_sha1 0 1	sub0
+160000 $submodule_sha1 0 1	sub1
+160000 $submodule_sha1 0 1	sub3
+EOF
+
+test_expect_success 'submodule--helper update-clone respects groups' '
+	(
+		cd super_clone &&
+		git submodule init &&
+		git config --add submodule.defaultGroup *bit1 &&
+		git config --add submodule.defaultGroup ./sub0 &&
+		git submodule--helper update-clone >../actual &&
+		git config --unset-all submodule.defaultGroup
+	) &&
+	test_cmp expect actual
+'
+
+cat >expect <<-EOF
+Submodule path 'sub0': checked out '$submodule_sha1'
+Submodule path 'sub1': checked out '$submodule_sha1'
+Submodule path 'sub3': checked out '$submodule_sha1'
+EOF
+
+test_expect_success 'git submodule update respects groups' '
+	(
+		cd super_clone &&
+		git submodule deinit -f . &&
+		git config --add submodule.defaultGroup *bit1 &&
+		git config --add submodule.defaultGroup ./sub0 &&
+		git submodule update --init >../actual &&
+		git config --unset-all submodule.defaultGroup
+	) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.8.0.41.g8d9aeb3
