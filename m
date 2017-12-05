Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 678AF20954
	for <e@80x24.org>; Tue,  5 Dec 2017 00:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbdLEAHq (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 19:07:46 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42366 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdLEAHp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 19:07:45 -0500
Received: by mail-pf0-f194.google.com with SMTP id d23so9811478pfe.9
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 16:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GsT16vpaKEWomrJLrmS6lwBm1ALhMzX6+y0hZB3h4Ig=;
        b=T7bZ+USMbx22AD/wmiwAVMig6KzYZidDpxN1zDXa+nWSsGa9bsv79k4FSyxu+6OA75
         6pXNlxBpky7IiewDZ45hEbvbzFgixSs1TBlkax/BsGYLk/gBrfw7Yv6EdmhBlrHHnXKK
         9F06AIIwABtizGqmi9qrM5ygS+GJGAwLEg7TXsm1haHKm5FCfrvipslY581yJ7yj94IA
         HGKmPPU0xPRkAHP14su82PKVWiPzIvNr8deZXeKfBu5c67tHW5Xiz+UyENGEqd7nR3lQ
         K6ofnkQrIFj/D7GVKBvSEH+zERpRmhRyl3zztIJKUnumz6ObVQDvCEOcKA3MeruYhLS5
         b3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GsT16vpaKEWomrJLrmS6lwBm1ALhMzX6+y0hZB3h4Ig=;
        b=t/AXa7QYh+jtjipESwbkSJ9tfKDfErjQtTYbXCSHQH9+CpEAQzRgFlz3y9UzW5f99p
         VvTimsbw0HYudaK7xFku0nrxiTRY+cMRfYoKJf+2vtrYo9hyHE1aqsNzh179mpafkYrv
         OwDqtsL5Nws7iBU6pKzhMTHgIrBSacBe/NRgx1V6mF8aAT7Q3r2pWfTbJszwg5DI7wAa
         pID/9Brsr7zEmJqEUTFACP+1srIH9PpEnOkSphQHkHT2YUWE+/wV8/dPRg/QGq6Olg9K
         QJLkhM3wq6/FxDrgbC800xIWv+pQGWNSqRXkDgejomKSiAGFGVGTwLNometq3xGT6Dlw
         d3Nw==
X-Gm-Message-State: AJaThX5dia32MrDFHrRZZXmVOK9LHB/y/QPS/chlpekx39m9umb+ktjc
        iK35iyWoWdKNPc4PKKLtO66bjyLTkuc=
X-Google-Smtp-Source: AGs4zMbADj7GaqK8+YSOeAZi5JlKTb/cgWFoLifOaNFFQ0V/Ea4x4CgvJnbe7GSa56IqLpwHMTHA+Q==
X-Received: by 10.84.168.98 with SMTP id e89mr15932841plb.417.1512432464116;
        Mon, 04 Dec 2017 16:07:44 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id e22sm23517524pfb.176.2017.12.04.16.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 16:07:42 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2] pathspec: only match across submodule boundaries when requested
Date:   Mon,  4 Dec 2017 16:07:34 -0800
Message-Id: <20171205000734.69530-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171128232237.54453-1-bmwill@google.com>
References: <20171128232237.54453-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 74ed43711fd (grep: enable recurse-submodules to work on <tree>
objects, 2016-12-16) taught 'tree_entry_interesting()' to be able to
match across submodule boundaries in the presence of wildcards.  This is
done by performing literal matching up to the first wildcard and then
punting to the submodule itself to perform more accurate pattern
matching.  Instead of introducing a new flag to request this behavior,
commit 74ed43711fd overloaded the already existing 'recursive' flag in
'struct pathspec' to request this behavior.

This leads to a bug where whenever any other caller has the 'recursive'
flag set as well as a pathspec with wildcards that all submodules will
be indicated as matches.  One simple example of this is:

	git init repo
	cd repo

	git init submodule
	git -C submodule commit -m initial --allow-empty

	touch "[bracket]"
	git add "[bracket]"
	git commit -m bracket
	git add submodule
	git commit -m submodule

	git rev-list HEAD -- "[bracket]"

Fix this by introducing the new flag 'recurse_submodules' in 'struct
pathspec' and using this flag to determine if matches should be allowed
to cross submodule boundaries.

This fixes https://github.com/git-for-windows/git/issues/1371.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/grep.c                |  1 +
 pathspec.h                    |  1 +
 t/t4208-log-magic-pathspec.sh | 19 +++++++++++++++++++
 tree-walk.c                   |  5 +++--
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5a6cfe6b4..3ca4ac80d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1015,6 +1015,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		       prefix, argv + i);
 	pathspec.max_depth = opt.max_depth;
 	pathspec.recursive = 1;
+	pathspec.recurse_submodules = !!recurse_submodules;
 
 #ifndef NO_PTHREADS
 	if (list.nr || cached || show_in_pager)
diff --git a/pathspec.h b/pathspec.h
index 6420d1080..099a170c2 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -24,6 +24,7 @@ struct pathspec {
 	int nr;
 	unsigned int has_wildcard:1;
 	unsigned int recursive:1;
+	unsigned int recurse_submodules:1;
 	unsigned magic;
 	int max_depth;
 	struct pathspec_item {
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 935df6a65..a1705f70c 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -93,4 +93,23 @@ test_expect_success 'command line pathspec parsing for "git log"' '
 	git log --merge -- a
 '
 
+test_expect_success 'tree_entry_interesting does not match past submodule boundaries' '
+	test_when_finished "rm -rf repo submodule" &&
+	git init submodule &&
+	test_commit -C submodule initial &&
+	git init repo &&
+	>"repo/[bracket]" &&
+	git -C repo add "[bracket]" &&
+	test_tick &&
+	git -C repo commit -m bracket &&
+	git -C repo rev-list HEAD -- "[bracket]" >expect &&
+
+	git -C repo submodule add ../submodule &&
+	test_tick &&
+	git -C repo commit -m submodule &&
+
+	git -C repo rev-list HEAD -- "[bracket]" >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/tree-walk.c b/tree-walk.c
index 684f0e337..63a87ed66 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1011,7 +1011,8 @@ static enum interesting do_match(const struct name_entry *entry,
 				 * character.  More accurate matching can then
 				 * be performed in the submodule itself.
 				 */
-				if (ps->recursive && S_ISGITLINK(entry->mode) &&
+				if (ps->recurse_submodules &&
+				    S_ISGITLINK(entry->mode) &&
 				    !ps_strncmp(item, match + baselen,
 						entry->path,
 						item->nowildcard_len - baselen))
@@ -1060,7 +1061,7 @@ static enum interesting do_match(const struct name_entry *entry,
 		 * character.  More accurate matching can then
 		 * be performed in the submodule itself.
 		 */
-		if (ps->recursive && S_ISGITLINK(entry->mode) &&
+		if (ps->recurse_submodules && S_ISGITLINK(entry->mode) &&
 		    !ps_strncmp(item, match, base->buf + base_offset,
 				item->nowildcard_len)) {
 			strbuf_setlen(base, base_offset + baselen);
-- 
2.15.1.424.g9478a66081-goog

