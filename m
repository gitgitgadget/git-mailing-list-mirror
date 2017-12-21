Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21A11F424
	for <e@80x24.org>; Thu, 21 Dec 2017 19:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754848AbdLUTJT (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 14:09:19 -0500
Received: from siwi.pair.com ([209.68.5.199]:14369 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752678AbdLUTJS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 14:09:18 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 99AC8844E5;
        Thu, 21 Dec 2017 14:09:17 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 30117844E1;
        Thu, 21 Dec 2017 14:09:17 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 1/5] core.aheadbehind: add new config setting
Date:   Thu, 21 Dec 2017 19:09:05 +0000
Message-Id: <20171221190909.62995-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171221190909.62995-1-git@jeffhostetler.com>
References: <20171221190909.62995-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Created core.aheadbehind config setting and core_ahead_behind
global variable.  This value defaults to true.

This value will be used in the next few commits as the default value
for the --ahead-behind parameter.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config.txt | 8 ++++++++
 cache.h                  | 1 +
 config.c                 | 5 +++++
 environment.c            | 1 +
 4 files changed, 15 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9593bfa..c78d6be 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -895,6 +895,14 @@ core.abbrev::
 	abbreviated object names to stay unique for some time.
 	The minimum length is 4.
 
+core.aheadbehind::
+	If true, tells commands like status and branch to print ahead and
+	behind counts for the branch relative to its upstream branch.
+	This computation may be very expensive when there is a great
+	distance between the two branches.  If false, these commands
+	only print that the two branches refer to different commits.
+	Defaults to true.
+
 add.ignoreErrors::
 add.ignore-errors (deprecated)::
 	Tells 'git add' to continue adding files when some files cannot be
diff --git a/cache.h b/cache.h
index 6440e2b..5757d8f 100644
--- a/cache.h
+++ b/cache.h
@@ -735,6 +735,7 @@ extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
+extern int core_ahead_behind;
 extern const char *apply_default_whitespace;
 extern const char *apply_default_ignorewhitespace;
 extern const char *git_attributes_file;
diff --git a/config.c b/config.c
index c38401a..6a4b49c 100644
--- a/config.c
+++ b/config.c
@@ -1241,6 +1241,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.aheadbehind")) {
+		core_ahead_behind = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 8289c25..5822c15 100644
--- a/environment.c
+++ b/environment.c
@@ -25,6 +25,7 @@ int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
+int core_ahead_behind = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
 const char *git_commit_encoding;
-- 
2.9.3

