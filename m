Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59759C2D0A3
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 19:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBADE2225E
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 19:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgKPTBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 14:01:11 -0500
Received: from out0.migadu.com ([94.23.1.103]:47512 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgKPTBL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 14:01:11 -0500
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 14:01:10 EST
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1605552928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9IpKeQmlGyJyU2GAJRZRDQdfTQ5J9UofhkEjqowKlHI=;
        b=cZ+Vr3RGDs4bmz5ADeG7fpcdQNJmB3gAZA3YOSe582E5tPadtm+EKUf98EcsvYiHYALFVj
        xSsdUjauIHYk1kRxLMLrB9XL6xzzpAT1nU12qQjqGq8DL97WnR3X2FMSMzD57bfEI752Ej
        dMENKSzOjJ9JauNKUK4IrMq4X25mGEArH7vdKHSROOv/C/Nr/2IknPOTW43/8mSGV5FV5T
        Zr+bm2gvCTk0BH23lrcPLMDtmY5Cg/ka8j9G8nVJqb7aJSN2aewN4XG5ZitHl6WPG6MNEz
        FSWCdpQ5YpNGz6CJUlONTcxJxzUqCo2jQbVxflp4G11aB/jVbwgLhAlxfucThA==
From:   Drew DeVault <sir@cmpwn.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>, lanodan <contact+git@hacktivis.me>
Subject: [PATCH] help.c: add advice.correctTypos option
Date:   Mon, 16 Nov 2020 13:55:21 -0500
Message-Id: <20201116185521.2276-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows users to disable guessing the commands or options that they
meant to use.
---
Questions:

- Is advice.* the right namespace?
- How should this interact with help.autocorrect?

 Documentation/config/advice.txt |  2 ++
 help.c                          | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index acbd0c09aa..135d1345af 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -119,4 +119,6 @@ advice.*::
 	addEmptyPathspec::
 		Advice shown if a user runs the add command without providing
 		the pathspec parameter.
+	correctTypos::
+		Detect typos and suggest corrections.
 --
diff --git a/help.c b/help.c
index 919cbb9206..c35c4c99da 100644
--- a/help.c
+++ b/help.c
@@ -515,10 +515,16 @@ static const char bad_interpreter_advice[] =
 
 const char *help_unknown_cmd(const char *cmd)
 {
-	int i, n, best_similarity = 0;
+	int i, n, best_similarity = 0, enable = 1;
 	struct cmdnames main_cmds, other_cmds;
 	struct cmdname_help *common_cmds;
 
+	git_config_get_bool("advice.correctTypos", &enable);
+	if (!enable) {
+		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
+		exit(1);
+	}
+
 	memset(&main_cmds, 0, sizeof(main_cmds));
 	memset(&other_cmds, 0, sizeof(other_cmds));
 	memset(&aliases, 0, sizeof(aliases));
@@ -705,11 +711,18 @@ static struct string_list guess_refs(const char *ref)
 NORETURN void help_unknown_ref(const char *ref, const char *cmd,
 			       const char *error)
 {
-	int i;
-	struct string_list suggested_refs = guess_refs(ref);
+	int i, enable = 1;
+	struct string_list suggested_refs;
 
 	fprintf_ln(stderr, _("%s: %s - %s"), cmd, ref, error);
 
+	git_config_get_bool("advice.correctTypos", &enable);
+	if (!enable) {
+		exit(1);
+	}
+
+	suggested_refs = guess_refs(ref);
+
 	if (suggested_refs.nr > 0) {
 		fprintf_ln(stderr,
 			   Q_("\nDid you mean this?",
-- 
2.29.2

