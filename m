Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60BB820193
	for <e@80x24.org>; Thu, 11 Aug 2016 23:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbcHKXO0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 19:14:26 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33461 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbcHKXOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 19:14:25 -0400
Received: by mail-pf0-f182.google.com with SMTP id y134so2922702pfg.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 16:14:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ntVI9/OCEqUB+k8n7O2F4L1+oTs8bXZ5lNaxQaRL9s=;
        b=ecLosTcN4kgU/q4gR2SDzVpfsuvyKssW3oFxDIcHeoSpaPwSDZ7OX0oK+x+OeMG2WD
         4vUnqSmQ0KqAuQYkzo5OdLAuN+Hco4D4G9ew2LWRORIi98LcR//tiR9v+eydinZoYzFc
         rQBcoKZYohq2oLqqnQXL4WV5mzE7VGYBdn1aupptgpDp9ImXbVInr8oBSuq1iEnXglHQ
         LXUDY+p8RQyQFEoUmN4nv4JjhzUJV8F3n1JZGGy8EdxzIeYq6DzdAFZnvAdh/CDi69uS
         Be3dc9iBiAhK3QIeRmf1TAcWixHftP1s0EIk5MWIfaFVq04ROCMVnP2mrUjjAkpne8UO
         HhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ntVI9/OCEqUB+k8n7O2F4L1+oTs8bXZ5lNaxQaRL9s=;
        b=AjPv0e9QZo84obEIAKQb6PrcMrzyh4HhZ7if/R7fcGlUdu6ehyShA1MiZpDaRWjdIO
         zZ/J/OGwSzw44FZhkpgf7aiDWmwA0TB37zGu33Bb/rHUa43pcp3tId5Ulwn3LjxSl5m8
         3kTcaWVP3NMJ9QfNWuafqXjW1luEjJNpeU9llIgsLz1SlX3rrzD68RJyS8D5WYF84bmM
         MJChUaDlJJ3whWWu46djQyAWxKLfx84482kTbAuWY5f2ndUDfQoYPnwU2hwrxl6fa/RE
         kdoc7B8jfwpfB3HjWlNzFPc2D+rb/G0yX+heJNVILrxgHEaPBEkpEiOa03tCtTMXS5cz
         Sm1g==
X-Gm-Message-State: AEkoousUr+f/a0ZxaUxinwTrbnGeCLkEXFxVwC+/ARJz/nxEp9BISingeQtRFIlCu4swZg3a
X-Received: by 10.98.138.153 with SMTP id o25mr21668245pfk.80.1470957264279;
        Thu, 11 Aug 2016 16:14:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2879:1504:a6e4:e441])
        by smtp.gmail.com with ESMTPSA id k78sm7702040pfa.78.2016.08.11.16.14.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 16:14:23 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 7/8] clone: implement optional references
Date:	Thu, 11 Aug 2016 16:14:04 -0700
Message-Id: <20160811231405.17318-8-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.737.g4a14654
In-Reply-To: <20160811231405.17318-1-sbeller@google.com>
References: <20160811231405.17318-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In a later patch we want to try to create alternates for submodules,
but they might not exist in the referenced superproject. So add a way
to skip the non existing references and report them.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt |  5 ++++-
 builtin/clone.c             | 29 ++++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index ec41d3d..e316c4b 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -90,13 +90,16 @@ If you want to break the dependency of a repository cloned with `-s` on
 its source repository, you can simply run `git repack -a` to copy all
 objects from the source repository into a pack in the cloned repository.
 
---reference <repository>::
+--reference[-if-able] <repository>::
 	If the reference repository is on the local machine,
 	automatically setup `.git/objects/info/alternates` to
 	obtain objects from the reference repository.  Using
 	an already existing repository as an alternate will
 	require fewer objects to be copied from the repository
 	being cloned, reducing network and local storage costs.
+	When using the `--reference-if-able`, a non existing
+	directory is skipped with a warning instead of aborting
+	the clone.
 +
 *NOTE*: see the NOTE for the `--shared` option, and also the
 `--dissociate` option.
diff --git a/builtin/clone.c b/builtin/clone.c
index 7ccbdef..fdb2ca9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -51,6 +51,7 @@ static int option_progress = -1;
 static enum transport_family family;
 static struct string_list option_config = STRING_LIST_INIT_NODUP;
 static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
+static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
 
@@ -81,6 +82,8 @@ static struct option builtin_clone_options[] = {
 		   N_("directory from which templates will be used")),
 	OPT_STRING_LIST(0, "reference", &option_required_reference, N_("repo"),
 			N_("reference repository")),
+	OPT_STRING_LIST(0, "reference-if-able", &option_optional_reference,
+			N_("repo"), N_("reference repository")),
 	OPT_BOOL(0, "dissociate", &option_dissociate,
 		 N_("use --reference only while cloning")),
 	OPT_STRING('o', "origin", &option_origin, N_("name"),
@@ -283,13 +286,20 @@ static void strip_trailing_slashes(char *dir)
 static int add_one_reference(struct string_list_item *item, void *cb_data)
 {
 	struct strbuf sb = STRBUF_INIT;
+	int *required = cb_data;
 	char *ref_git = compute_alternate_path(item->string, &sb);
 
-	if (!ref_git)
-		die("%s", sb.buf);
-
-	strbuf_addf(&sb, "%s/objects", ref_git);
-	add_to_alternates_file(sb.buf);
+	if (!ref_git) {
+		if (*required)
+			die("%s", sb.buf);
+		else
+			fprintf(stderr,
+				_("info: Could not add alternate for '%s': %s\n"),
+				item->string, sb.buf);
+	} else {
+		strbuf_addf(&sb, "%s/objects", ref_git);
+		add_to_alternates_file(sb.buf);
+	}
 
 	strbuf_release(&sb);
 	return 0;
@@ -297,7 +307,12 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 
 static void setup_reference(void)
 {
-	for_each_string_list(&option_required_reference, add_one_reference, NULL);
+	int required = 1;
+	for_each_string_list(&option_required_reference,
+			     add_one_reference, &required);
+	required = 0;
+	for_each_string_list(&option_optional_reference,
+			     add_one_reference, &required);
 }
 
 static void copy_alternates(struct strbuf *src, struct strbuf *dst,
@@ -949,7 +964,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
-	if (option_required_reference.nr)
+	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
 	fetch_pattern = value.buf;
-- 
2.9.2.737.g4a14654

