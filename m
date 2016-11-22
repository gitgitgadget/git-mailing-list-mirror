Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A612021E
	for <e@80x24.org>; Tue, 22 Nov 2016 18:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756108AbcKVSrx (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 13:47:53 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34147 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755477AbcKVSro (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 13:47:44 -0500
Received: by mail-pf0-f180.google.com with SMTP id c4so5361913pfb.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 10:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eCQNdPLK/ImLdWAYiZtwqIySCWi2BbUA3U1JiGM5Fdw=;
        b=PYqaqWnryXoM+J6q6Ae9qdN2Q2UWbqkLSxOphGRbkqiWDCctHbb3xf+aWd+nkXrPoq
         oRVH0CJwFEGawr4oreE4+jXpIzFZnDDpHBJvi8cILj9toUc7W47rlztlhzYDPPofZHl/
         /O3MNfB2akTe1cbQaR3MNAD7TvBQZZqslEXxuMRd83ZICDo1VHuDcfJM0Hjmu64A5Sis
         +YwgUt6VvbagctKCud95GJAblbGcMDEIj9q6VK5+J5hHyGm8FDqZvrhrwdisznJTdn5i
         YysoGs7Du+vDozUafiWYN9qF/OVnyaxhu8ZpAEdx7hIk/RQyIF4jru713OOneW4oPVLy
         p6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eCQNdPLK/ImLdWAYiZtwqIySCWi2BbUA3U1JiGM5Fdw=;
        b=Zv0ohwLvKyFAiytdBU2ogfdew1ujvBoEjbHbbFTeBywQHRAjks1u/CqqVAFPpczsbi
         sO1WqEtKQuURpazN/KLFPa0S1BDydU1mgXg4rqpx8D0x9r5NGSGWmi5CAUQbSswxdZJV
         BwEh9PkRvFXqXj/SoT1bZcLcj3BxbCO6VTDM8Sf0VeWZFPIPv6+p0fb7wfVWgiSS3odS
         v82i7joW3mbEsZpdtq1Xso5635DHxOPeKPXO66V+WIk7/BCAqtqI57RrsUqiGHLk+rZr
         yo2ybLhMgIn26KQz1lQVOdlqluatc1h2oeInmZZR/qkEIGTtaKkaZtzBkBNpIuJFHOzQ
         EwZw==
X-Gm-Message-State: AKaTC03vW9tLGu7G4VSzrpFd4wtFteQuONUCZ32nMI9afbV5732D+suWPF3veJDbtVyvUPvr
X-Received: by 10.98.160.29 with SMTP id r29mr27412223pfe.103.1479840406546;
        Tue, 22 Nov 2016 10:46:46 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id w5sm46932072pfl.31.2016.11.22.10.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 10:46:45 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v5 0/6] recursively grep across submodules
Date:   Tue, 22 Nov 2016 10:46:31 -0800
Message-Id: <1479840397-68264-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479499135-64269-1-git-send-email-bmwill@google.com>
References: <1479499135-64269-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Major change in v5 is to use tree_is_interesting api instead of the vanilla
pathspec code for submodules.  This is to fix the issue in the last seires
where I mix the two types.  More tests were also added to ensure that the
changes to the pathspec code functioned properly.

Brandon Williams (6):
  submodules: add helper functions to determine presence of submodules
  submodules: load gitmodules file from commit sha1
  grep: add submodules as a grep source type
  grep: optionally recurse into submodules
  grep: enable recurse-submodules to work on <tree> objects
  grep: search history of moved submodules

 Documentation/git-grep.txt         |  14 ++
 builtin/grep.c                     | 386 ++++++++++++++++++++++++++++++++++---
 cache.h                            |   2 +
 config.c                           |   8 +-
 git.c                              |   2 +-
 grep.c                             |  16 +-
 grep.h                             |   1 +
 submodule-config.c                 |   6 +-
 submodule-config.h                 |   3 +
 submodule.c                        |  50 +++++
 submodule.h                        |   3 +
 t/t7814-grep-recurse-submodules.sh | 241 +++++++++++++++++++++++
 tree-walk.c                        |  28 +++
 13 files changed, 729 insertions(+), 31 deletions(-)
 create mode 100755 t/t7814-grep-recurse-submodules.sh

-- interdiff based on 'bw/grep-recurse-submodules'

diff --git a/builtin/grep.c b/builtin/grep.c
index 052f605..2c727ef 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -698,6 +698,8 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
 		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
 			   submodule_path_match(pathspec, name.buf, NULL)) {
 			hit |= grep_submodule(opt, NULL, ce->name, ce->name);
+		} else {
+			continue;
 		}
 
 		if (ce_stage(ce)) {
@@ -734,17 +736,10 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		int te_len = tree_entry_len(&entry);
 
 		if (match != all_entries_interesting) {
-			strbuf_setlen(&name, name_base_len);
 			strbuf_addstr(&name, base->buf + tn_len);
-
-			if (recurse_submodules && S_ISGITLINK(entry.mode)) {
-				strbuf_addstr(&name, entry.path);
-				match = submodule_path_match(pathspec, name.buf,
-							     NULL);
-			} else {
-				match = tree_entry_interesting(&entry, &name,
-							       0, pathspec);
-			}
+			match = tree_entry_interesting(&entry, &name,
+						       0, pathspec);
+			strbuf_setlen(&name, name_base_len);
 
 			if (match == all_entries_not_interesting)
 				break;
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 7d66716..0507771 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -127,6 +127,34 @@ test_expect_success 'grep tree and pathspecs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'grep tree and pathspecs' '
+	cat >expect <<-\EOF &&
+	HEAD:submodule/a:foobar
+	HEAD:submodule/sub/a:foobar
+	EOF
+
+	git grep -e "bar" --recurse-submodules HEAD -- "submodule*a" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep tree and more pathspecs' '
+	cat >expect <<-\EOF &&
+	HEAD:submodule/a:foobar
+	EOF
+
+	git grep -e "bar" --recurse-submodules HEAD -- "submodul?/a" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep tree and more pathspecs' '
+	cat >expect <<-\EOF &&
+	HEAD:submodule/sub/a:foobar
+	EOF
+
+	git grep -e "bar" --recurse-submodules HEAD -- "submodul*/sub/a" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'grep recurse submodule colon in name' '
 	git init parent &&
 	test_when_finished "rm -rf parent" &&
diff --git a/tree-walk.c b/tree-walk.c
index 828f435..ff77605 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1004,6 +1004,19 @@ static enum interesting do_match(const struct name_entry *entry,
 				 */
 				if (ps->recursive && S_ISDIR(entry->mode))
 					return entry_interesting;
+
+				/*
+				 * When matching against submodules with
+				 * wildcard characters, ensure that the entry
+				 * at least matches up to the first wild
+				 * character.  More accurate matching can then
+				 * be performed in the submodule itself.
+				 */
+				if (ps->recursive && S_ISGITLINK(entry->mode) &&
+				    !ps_strncmp(item, match + baselen,
+						entry->path,
+						item->nowildcard_len - baselen))
+					return entry_interesting;
 			}
 
 			continue;
@@ -1040,6 +1053,21 @@ static enum interesting do_match(const struct name_entry *entry,
 			strbuf_setlen(base, base_offset + baselen);
 			return entry_interesting;
 		}
+
+		/*
+		 * When matching against submodules with
+		 * wildcard characters, ensure that the entry
+		 * at least matches up to the first wild
+		 * character.  More accurate matching can then
+		 * be performed in the submodule itself.
+		 */
+		if (ps->recursive && S_ISGITLINK(entry->mode) &&
+		    !ps_strncmp(item, match, base->buf + base_offset,
+				item->nowildcard_len)) {
+			strbuf_setlen(base, base_offset + baselen);
+			return entry_interesting;
+		}
+
 		strbuf_setlen(base, base_offset + baselen);
 
 		/*

-- 
2.8.0.rc3.226.g39d4020

