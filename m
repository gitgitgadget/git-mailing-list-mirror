Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E49331F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeDJM5c (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:57:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33318 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbeDJM5b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:57:31 -0400
Received: by mail-pf0-f196.google.com with SMTP id f15so8235532pfn.0
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 05:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9uEpWlvP2JT+sK8mqQbF53p6db3c7DK9sGgt6a6HTm4=;
        b=GFMGGAkkRIZvq5Z09tS4wtYlX05no7pKhkZcCTXVIBcx2xG9VP0YTVNDGuoijVr31D
         9fjzJk4ENoEjyqmWZMSFZImoCEqI0TUjcrCEAjmfClDuLRp2w2XKMBOuqX3v51t0w0aK
         2oF/vB0l3aJEKJ5n00DuIVNI0o2Ps88Eo7iMvkba+F6SOQJ4fY5DlAC8vywt7gKchNk8
         IRMacXgJW+9saa7xSpYsHsMOf7rL2sgVIPmNWnbekGAzX88p1HmEhZrCvWNXtV3V35dZ
         asaYMhYtzmQqFkFl1ne1JagZPWbW0f43x76yb2f/PMcoz76wfppu8mxdFb3ul+M1aOO7
         o8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9uEpWlvP2JT+sK8mqQbF53p6db3c7DK9sGgt6a6HTm4=;
        b=KiJJCSxr1nCougEQWb2NkYzTQzRpnC8GJQrNwC2f6XlARx0EBHuvCa5iSq5LI4kJwS
         q6Hu4DnE9F2DYA/8koUfyjxeTwJ6i+OYQQ+qDz6njsNFC5b+qiTPxC5N/enXTYcEJ+o+
         Dzhs4gLuo0gWFwv60NklXOfKkquu0CLSyyUfafnuPxBr7oeo0BwXulPlwwb/OKZORNP9
         kydQty5kXfhygodSbJGzbAwB+hQjbIx0s5ntssqUw8anLVH+68CUwBlYqhlZuEWRePVe
         whWvYG/53pRq42LajYYbhua0Y+GxjDqTTkIKDNk2EWXSNmav+MC6puz/a/vMwmuFCCRU
         F4gw==
X-Gm-Message-State: ALQs6tDK1Ovv8geUnaaoZJbkAz/ezynocjLy0EtE/X8aU8C1eMuHMGGP
        qgDOs0puGHflAZZXmdX4Usy6SAC5a/4=
X-Google-Smtp-Source: AIpwx49ZFqmESf3Z/UwOzeBMooFGRPGE44kXMQf1ZXOYoRRk+SQGzSpe6dYAW3ZEZ4jdzL6RYpxMhg==
X-Received: by 10.98.223.16 with SMTP id u16mr281060pfg.146.1523365051151;
        Tue, 10 Apr 2018 05:57:31 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id l10sm4421666pgp.35.2018.04.10.05.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 05:57:30 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v8 13/14] commit-graph: build graph from starting commits
Date:   Tue, 10 Apr 2018 08:56:07 -0400
Message-Id: <20180410125608.39443-14-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410125608.39443-1-dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Teach git-commit-graph to read commits from stdin when the
--stdin-commits flag is specified. Commits reachable from these
commits are added to the graph. This is a much faster way to construct
the graph than inspecting all packed objects, but is restricted to
known tips.

For the Linux repository, 700,000+ commits were added to the graph
file starting from 'master' in 7-9 seconds, depending on the number
of packfiles in the repo (1, 24, or 120).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 14 +++++++++++++-
 builtin/commit-graph.c             | 27 +++++++++++++++++++++------
 commit-graph.c                     | 27 +++++++++++++++++++++++++--
 commit-graph.h                     |  4 +++-
 t/t5318-commit-graph.sh            | 13 +++++++++++++
 5 files changed, 75 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 8143cc3f07..442ac243e6 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -36,7 +36,13 @@ COMMANDS
 Write a commit graph file based on the commits found in packfiles.
 +
 With the `--stdin-packs` option, generate the new commit graph by
-walking objects only in the specified pack-indexes.
+walking objects only in the specified pack-indexes. (Cannot be combined
+with --stdin-commits.)
++
+With the `--stdin-commits` option, generate the new commit graph by
+walking commits starting at the commits specified in stdin as a list
+of OIDs in hex, one OID per line. (Cannot be combined with
+--stdin-packs.)
 
 'read'::
 
@@ -60,6 +66,12 @@ $ git commit-graph write
 $ echo <pack-index> | git commit-graph write --stdin-packs
 ------------------------------------------------
 
+* Write a graph file containing all reachable commits.
++
+------------------------------------------------
+$ git show-ref -s | git commit-graph write --stdin-commits
+------------------------------------------------
+
 * Read basic information from the commit-graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 5c70199003..b5c0b08905 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,7 +8,7 @@
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -18,13 +18,14 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
 static struct opts_commit_graph {
 	const char *obj_dir;
 	int stdin_packs;
+	int stdin_commits;
 } opts;
 
 static int graph_read(int argc, const char **argv)
@@ -79,6 +80,8 @@ static int graph_write(int argc, const char **argv)
 {
 	const char **pack_indexes = NULL;
 	int packs_nr = 0;
+	const char **commit_hex = NULL;
+	int commits_nr = 0;
 	const char **lines = NULL;
 	int lines_nr = 0;
 	int lines_alloc = 0;
@@ -89,6 +92,8 @@ static int graph_write(int argc, const char **argv)
 			N_("The object directory to store the graph")),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			N_("scan pack-indexes listed by stdin for commits")),
+		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
+			N_("start walk at commits listed by stdin")),
 		OPT_END(),
 	};
 
@@ -96,10 +101,12 @@ static int graph_write(int argc, const char **argv)
 			     builtin_commit_graph_write_options,
 			     builtin_commit_graph_write_usage, 0);
 
+	if (opts.stdin_packs && opts.stdin_commits)
+		die(_("cannot use both --stdin-commits and --stdin-packs"));
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
 
-	if (opts.stdin_packs) {
+	if (opts.stdin_packs || opts.stdin_commits) {
 		struct strbuf buf = STRBUF_INIT;
 		lines_nr = 0;
 		lines_alloc = 128;
@@ -110,13 +117,21 @@ static int graph_write(int argc, const char **argv)
 			lines[lines_nr++] = strbuf_detach(&buf, NULL);
 		}
 
-		pack_indexes = lines;
-		packs_nr = lines_nr;
+		if (opts.stdin_packs) {
+			pack_indexes = lines;
+			packs_nr = lines_nr;
+		}
+		if (opts.stdin_commits) {
+			commit_hex = lines;
+			commits_nr = lines_nr;
+		}
 	}
 
 	write_commit_graph(opts.obj_dir,
 			   pack_indexes,
-			   packs_nr);
+			   packs_nr,
+			   commit_hex,
+			   commits_nr);
 
 	return 0;
 }
diff --git a/commit-graph.c b/commit-graph.c
index 70472840a3..a59d1e387b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -551,7 +551,9 @@ static void close_reachable(struct packed_oid_list *oids)
 
 void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
-			int nr_packs)
+			int nr_packs,
+			const char **commit_hex,
+			int nr_commits)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -591,7 +593,28 @@ void write_commit_graph(const char *obj_dir,
 			close_pack(p);
 		}
 		strbuf_release(&packname);
-	} else
+	}
+
+	if (commit_hex) {
+		for (i = 0; i < nr_commits; i++) {
+			const char *end;
+			struct object_id oid;
+			struct commit *result;
+
+			if (commit_hex[i] && parse_oid_hex(commit_hex[i], &oid, &end))
+				continue;
+
+			result = lookup_commit_reference_gently(&oid, 1);
+
+			if (result) {
+				ALLOC_GROW(oids.list, oids.nr + 1, oids.alloc);
+				oidcpy(&oids.list[oids.nr], &(result->object.oid));
+				oids.nr++;
+			}
+		}
+	}
+
+	if (!pack_indexes && !commit_hex)
 		for_each_packed_object(add_packed_commits, &oids, 0);
 
 	close_reachable(&oids);
diff --git a/commit-graph.h b/commit-graph.h
index f065f0866f..fd035101b2 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -38,6 +38,8 @@ struct commit_graph *load_commit_graph_one(const char *graph_file);
 
 void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
-			int nr_packs);
+			int nr_packs,
+			const char **commit_hex,
+			int nr_commits);
 
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3bb44d0c09..c28cfb5d7f 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -177,6 +177,19 @@ test_expect_success 'build graph from latest pack with closure' '
 graph_git_behavior 'graph from pack, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'graph from pack, commit 8 vs merge 2' full commits/8 merge/2
 
+test_expect_success 'build graph from commits with closure' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git tag -a -m "merge" tag/merge merge/2 &&
+	git rev-parse tag/merge >commits-in &&
+	git rev-parse merge/1 >>commits-in &&
+	cat commits-in | git commit-graph write --stdin-commits &&
+	test_path_is_file $objdir/info/commit-graph &&
+	graph_read_expect "6"
+'
+
+graph_git_behavior 'graph from commits, commit 8 vs merge 1' full commits/8 merge/1
+graph_git_behavior 'graph from commits, commit 8 vs merge 2' full commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone --bare --no-local full bare &&
-- 
2.17.0

