Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BAF62018E
	for <e@80x24.org>; Tue,  9 Aug 2016 04:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbcHIEId (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 00:08:33 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36084 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbcHIEI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 00:08:29 -0400
Received: by mail-pa0-f45.google.com with SMTP id pp5so1175012pac.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 21:08:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oXfZrre+OyqV8C6/4NW3vMpG6GIlL/UXIrLgzIBTJpQ=;
        b=V+yOcmqjv/G/yVlI9HmcDd87CjPfTN+nuypvPtA+aVY0H25Gw667Rv+2jOqpX1sIXx
         Bz8IjyYlxdKkCv5zKeUoDGCnXYxZddOQ3qY7IdtktM5Mp5PRfb/q92fWU4FHaOTrXvqq
         Jb4N9Ltjc9h8uRTYFdLhef3/xrD+pijKi8ZtT9z8iBj3R/orVDsLWVuWty5i/Sjm3kMr
         OrpfM38IB5zPQxIoh+aG30K09EZnxVrZ6OglKjM0vERDMdapwjKq0H90rad5lOLC6u9J
         XtyaE1o6Q+CoLMcz1w/MAAXIuQXTSBscQJrM7wNFarqskIGyYZrQPu3QNsBs96y3CFG1
         26SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oXfZrre+OyqV8C6/4NW3vMpG6GIlL/UXIrLgzIBTJpQ=;
        b=SsEJOeaxt2v6X2Ji9eRnVhXfl42KQliEpTZgHUnn2aQDrgfx7D3/dxD76Opr4mHt+E
         ShuIN3qMztGcoWTcSzU4EjZD5qfOrddMM+qzsPEsEPlITC+m1mtSpN6xd0T4gTT1ufxS
         bhdyr9I0UgcTOytxJMdYL/D16w/xQuTd7Mmu+viCXo5s6tXAya8AhNeZFAQIkoF80mFa
         t70PouG8jyaQm0ac6dga6CM01xB6H6scYfF6/kaaEsNRuv2JaxZ+C7Ke2H7Veebt5xu8
         cmcVfG7aqr/r7rlq0Biq1LrzvHBDk/x9sB1kfWEIgIPkzCeBWKxKwZDHD6ZERDHRsBSK
         /MWg==
X-Gm-Message-State: AEkoouvfDWQ2MF66gY4Ffbgg5I062RLFSvVNROinMFNtOOE1BgSSRTDbgqNezOHq/lgBwyPn
X-Received: by 10.66.43.164 with SMTP id x4mr68319908pal.11.1470715707787;
        Mon, 08 Aug 2016 21:08:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ad25:78d3:1e25:67ef])
        by smtp.gmail.com with ESMTPSA id t7sm51694840paz.21.2016.08.08.21.08.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 21:08:27 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 5/6] submodule update: add super-reference flag
Date:	Mon,  8 Aug 2016 21:08:06 -0700
Message-Id: <20160809040811.21408-7-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.583.gd6329be.dirty
In-Reply-To: <20160809040811.21408-1-sbeller@google.com>
References: <20160809040811.21408-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When we have a another clone of a superproject, we may want to
mirror the submodules using alternates. Introduce an option
`--super-reference` that let's a user point to another superproject,
which is assumed to have the same structure as the one they are
running the "submodule update" command from and has all submodules
checked out to borrow the submodule objects from within the other
superprojects git directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt |  8 +++++++-
 builtin/submodule--helper.c     | 14 +++++++++++++-
 git-submodule.sh                | 10 ++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bf3bb37..6f2f873 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [--[no-]recommend-shallow] [-f|--force] [--rebase|--merge]
-	      [--reference <repository>] [--depth <depth>] [--recursive]
+	      [--[super-]reference <repository>] [--depth <depth>] [--recursive]
 	      [--jobs <n>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
@@ -370,6 +370,12 @@ the submodule itself.
 	This option is only valid for add and update commands.  These
 	commands sometimes need to clone a remote repository. In this case,
 	this option will be passed to the linkgit:git-clone[1] command.
+
+--super-reference <superproject repository>::
+	This option is only valid for the update command. When update needs
+	to clone a repository, a reference will be passed to the clone command
+	that points at the submodule path inside the reference superproject.
+
 +
 *NOTE*: Do *not* use this option unless you have read the note
 for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b7710a7..ea6b27c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -584,6 +584,7 @@ struct submodule_update_clone {
 	int quiet;
 	int recommend_shallow;
 	struct string_list references;
+	struct string_list super_references;
 	const char *depth;
 	const char *recursive_prefix;
 	const char *prefix;
@@ -600,7 +601,7 @@ struct submodule_update_clone {
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, STRING_LIST_INIT_DUP, \
-	NULL, NULL, NULL, \
+	STRING_LIST_INIT_DUP, NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
 
 
@@ -715,6 +716,15 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		for_each_string_list_item(item, &suc->references)
 			argv_array_pushl(&child->args, "--reference", item->string, NULL);
 	}
+	if (suc->super_references.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &suc->super_references) {
+			strbuf_reset(&sb);
+			argv_array_pushf(&child->args, "--reference=%s/%s",
+					 relative_path(item->string, suc->prefix, &sb),
+					 sub->path);
+		}
+	}
 	if (suc->depth)
 		argv_array_push(&child->args, suc->depth);
 
@@ -835,6 +845,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			   N_("rebase, merge, checkout or none")),
 		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
 			   N_("reference repository")),
+		OPT_STRING_LIST(0, "super-reference", &suc.super_references, N_("repo"),
+			   N_("superproject of a reference repository")),
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
diff --git a/git-submodule.sh b/git-submodule.sh
index 3b412f5..17f4ace 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -34,6 +34,7 @@ command=
 branch=
 force=
 reference=
+superreference=
 cached=
 recursive=
 init=
@@ -520,6 +521,14 @@ cmd_update()
 		--reference=*)
 			reference="$1"
 			;;
+		--super-reference)
+			case "$2" in '') usage ;; esac
+			superreference="--super-reference=$2"
+			shift
+			;;
+		--super-reference=*)
+			superreference="$1"
+			;;
 		-m|--merge)
 			update="merge"
 			;;
@@ -576,6 +585,7 @@ cmd_update()
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
+		${superreference:+"$superreference"} \
 		${depth:+--depth "$depth"} \
 		${recommend_shallow:+"$recommend_shallow"} \
 		${jobs:+$jobs} \
-- 
2.9.2.572.g9d9644e.dirty

