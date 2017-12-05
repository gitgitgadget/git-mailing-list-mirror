Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F23A20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 16:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbdLEQ7O (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:59:14 -0500
Received: from siwi.pair.com ([209.68.5.199]:45176 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752143AbdLEQ7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:59:12 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EB930844E5;
        Tue,  5 Dec 2017 11:59:11 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 702B8844DE;
        Tue,  5 Dec 2017 11:59:11 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        christian.couder@gmail.com
Subject: [PATCH v6 01/12] extension.partialclone: introduce partial clone extension
Date:   Tue,  5 Dec 2017 16:58:43 +0000
Message-Id: <20171205165854.64979-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205165854.64979-1-git@jeffhostetler.com>
References: <20171205165854.64979-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Introduce new repository extension option:
    `extensions.partialclone`

See the update to Documentation/technical/repository-version.txt
in this patch for more information.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/repository-version.txt | 12 ++++++++++++
 cache.h                                        |  2 ++
 environment.c                                  |  1 +
 setup.c                                        |  7 ++++++-
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 00ad379..e03eacc 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -86,3 +86,15 @@ for testing format-1 compatibility.
 When the config key `extensions.preciousObjects` is set to `true`,
 objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 `git repack -d`).
+
+`partialclone`
+~~~~~~~~~~~~~~
+
+When the config key `extensions.partialclone` is set, it indicates
+that the repo was created with a partial clone (or later performed
+a partial fetch) and that the remote may have omitted sending
+certain unwanted objects.  Such a remote is called a "promisor remote"
+and it promises that all such omitted objects can be fetched from it
+in the future.
+
+The value of this key is the name of the promisor remote.
diff --git a/cache.h b/cache.h
index 6440e2b..35e3f5e 100644
--- a/cache.h
+++ b/cache.h
@@ -860,10 +860,12 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
+extern char *repository_format_partial_clone;
 
 struct repository_format {
 	int version;
 	int precious_objects;
+	char *partial_clone; /* value of extensions.partialclone */
 	int is_bare;
 	char *work_tree;
 	struct string_list unknown_extensions;
diff --git a/environment.c b/environment.c
index 8289c25..e52aab3 100644
--- a/environment.c
+++ b/environment.c
@@ -27,6 +27,7 @@ int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
+char *repository_format_partial_clone;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 const char *apply_default_whitespace;
diff --git a/setup.c b/setup.c
index 03f51e0..58536bd 100644
--- a/setup.c
+++ b/setup.c
@@ -420,7 +420,11 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			data->precious_objects = git_config_bool(var, value);
-		else
+		else if (!strcmp(ext, "partialclone")) {
+			if (!value)
+				return config_error_nonbool(var);
+			data->partial_clone = xstrdup(value);
+		} else
 			string_list_append(&data->unknown_extensions, ext);
 	} else if (strcmp(var, "core.bare") == 0) {
 		data->is_bare = git_config_bool(var, value);
@@ -463,6 +467,7 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 	}
 
 	repository_format_precious_objects = candidate.precious_objects;
+	repository_format_partial_clone = candidate.partial_clone;
 	string_list_clear(&candidate.unknown_extensions, 0);
 	if (!has_common) {
 		if (candidate.is_bare != -1) {
-- 
2.9.3

