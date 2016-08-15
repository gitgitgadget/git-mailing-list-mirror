Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 468F21F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 21:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbcHOVx6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:53:58 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33262 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbcHOVxy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:53:54 -0400
Received: by mail-pa0-f53.google.com with SMTP id ti13so19496168pac.0
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 14:53:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QVrQMsy+9+p3qyotOlsyk5kBMPgu3mipvOTXsMjAF0I=;
        b=VZ2SUs7ToVtKHKPW7EieIvImOWhFKj6a2tQjoYp2Uih9TK6xf2m5VfpUQxO7IQPTvA
         fPStWmLy5WTTJ+2QWF6jeoNfFisGRSYJ0Fr8Cz9ryKZyuBOooXDqBKluHoeeUSBcgJrg
         CIhF3bjLiPIw160T2LnbtCSjJcraLb6eu68vxmuUkl5C4uMmE//AdN0txvFpYSpj1VNP
         1lnVgaxeVGNjGXFefXVMBLksyETC/JpLzFuDy5EIX9fL5SBST+ZVscynYiF4bCBvbS0G
         loAmh7HzHhy3LYvH+0xCnOXFsPdDF9s9KgDFbVCVLjymeZuJqSAXsbL9+9YFa9BVuEoP
         2mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QVrQMsy+9+p3qyotOlsyk5kBMPgu3mipvOTXsMjAF0I=;
        b=FjafVU1jJc/AqduQ4fhJWIJV/3Ydpl4mCwjEGSCZSA0+YDAORJAU5zH1R9bYs4FlJT
         1UlNvbSJDjKRZwKnHbGjopPNew4Y5nv5JWpgzaqxP4TssLI2M4JZAssSLQ4yfxHJ/L9U
         H5/gZ6IautzwxHE2GETY3XtjVP6dkF7UKvLwFOxzlQHZ4SrCvH4SxlIU2al+0XZhf8yy
         QHD1w2aH77Szso7v2lQOqW40/QMG6qEj8HMF/+PYE0M8KrscIKfZGYGfRd+Mj6JTJvL9
         tl970j5HPPESJ8hyEGsR2qPXFq4f1tzKCvXeTNEH994S5CzflKOrEXII6Kq0Wd5s3/jm
         Ht4g==
X-Gm-Message-State: AEkooutgIlpBs6uLgj5CPj2AEaV+uqjUMsHlZ/tnA3MC/+7ryqm10KI7YePibst0DL2gAo1L
X-Received: by 10.66.100.202 with SMTP id fa10mr57655801pab.106.1471298032837;
        Mon, 15 Aug 2016 14:53:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fd0c:5bce:d30d:9f4d])
        by smtp.gmail.com with ESMTPSA id 84sm33660481pfp.59.2016.08.15.14.53.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 14:53:52 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 7/8] clone: implement optional references
Date:	Mon, 15 Aug 2016 14:53:26 -0700
Message-Id: <20160815215327.15682-8-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.730.g525ad04.dirty
In-Reply-To: <20160815215327.15682-1-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com>
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
 builtin/clone.c             | 35 +++++++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 11 deletions(-)

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
index ef5db7c..0182665 100644
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
@@ -283,24 +286,36 @@ static void strip_trailing_slashes(char *dir)
 static int add_one_reference(struct string_list_item *item, void *cb_data)
 {
 	struct strbuf err = STRBUF_INIT;
-	struct strbuf sb = STRBUF_INIT;
+	int *required = cb_data;
 	char *ref_git = compute_alternate_path(item->string, &err);
 
-	if (!ref_git)
-		die("%s", err.buf);
-
-	strbuf_addf(&sb, "%s/objects", ref_git);
-	add_to_alternates_file(sb.buf);
+	if (!ref_git) {
+		if (*required)
+			die("%s", err.buf);
+		else
+			fprintf(stderr,
+				_("info: Could not add alternate for '%s': %s\n"),
+				item->string, err.buf);
+	} else {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addf(&sb, "%s/objects", ref_git);
+		add_to_alternates_file(sb.buf);
+		strbuf_release(&sb);
+	}
 
-	free(ref_git);
 	strbuf_release(&err);
-	strbuf_release(&sb);
+	free(ref_git);
 	return 0;
 }
 
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
@@ -952,7 +967,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
-	if (option_required_reference.nr)
+	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
 	fetch_pattern = value.buf;
-- 
2.9.2.730.g525ad04.dirty

