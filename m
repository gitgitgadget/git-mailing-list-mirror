Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156502018E
	for <e@80x24.org>; Sat,  6 Aug 2016 22:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbcHFWda (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 18:33:30 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35347 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbcHFWd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 18:33:29 -0400
Received: by mail-pa0-f41.google.com with SMTP id iw10so102568035pac.2
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 15:33:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oXfZrre+OyqV8C6/4NW3vMpG6GIlL/UXIrLgzIBTJpQ=;
        b=jIEx7T9NdWzlA/YKr1r4RvuRSAsZctqdJ+iZot24+VMY0FGCZJ9KxbYnxbO+Xqv112
         D33RGyymq6WouGQLh11f3RVssg4zIVSyQQfZaFuAHXHJ++H4aPE1+sDILDA4Qh3rb7BS
         YZ0dUNBmsNa/kH3QCX944GuyYaf9fi2bpRlABSaufJPqfVQeugIY/6oZ42J127FqVJKg
         GeKjJxaDdwmKLkTu2EgudvmSGnbvlJaiw/7YgYWDK0j13jAMtBscrCncSa3MMWHRdCRQ
         p+N0JBs3P6MABnZAYRyUArHw2BBhLckHQwPx1LqrXk2N/nG6dn6WHPNm1YbTizFopmad
         c6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oXfZrre+OyqV8C6/4NW3vMpG6GIlL/UXIrLgzIBTJpQ=;
        b=ZecG7geewqDit3l+BFbcQdmMdzNyoKzGAJzSSwGeMCLKCDhPmkJKWL3HaEqkG3mKAL
         a+AjcND/bSu8fNYiNzDBkefWlcLk4jUXd62gv0cAZKG9w4SY7lSQtAqPtQ9N0SyNA4U+
         bnx+re3SWRDQyE5DONcB00OPIthdgGWFuPkbS++/ULGJB35IakqTDTi3npYX+3Wruoxc
         Og7VtwXrVqQ2KQ5Vepy7mWP+oZupF0XXaYB8YYuFILpvC8TejseXmocUBguShIMKWBgp
         gFTr8mBixLbMhi0tXzHznH+QiZCnR1/CUlNHZEQiKoSdDrJ37zIlGRKBGscYh6yuJt25
         GtbQ==
X-Gm-Message-State: AEkoousyl4jMkp9MliIu+zfYz1A/3NbVRqrlCLlO9pB+pZtkIbh2Y3gbY6hTGHny4ez4vA3j
X-Received: by 10.67.7.165 with SMTP id dd5mr140353371pad.124.1470446621762;
        Fri, 05 Aug 2016 18:23:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c0da:b815:bea9:a8ab])
        by smtp.gmail.com with ESMTPSA id vt10sm30709739pab.43.2016.08.05.18.23.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 18:23:41 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com, Jens.Lehmann@web.de
Cc:	git@vger.kernel.org, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 5/6] submodule update: add super-reference flag
Date:	Fri,  5 Aug 2016 18:23:17 -0700
Message-Id: <20160806012318.17968-6-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
In-Reply-To: <20160806012318.17968-1-sbeller@google.com>
References: <20160806012318.17968-1-sbeller@google.com>
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

