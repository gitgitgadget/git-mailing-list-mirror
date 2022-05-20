Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89281C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 11:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348816AbiETL50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 07:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348813AbiETL5V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 07:57:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2470B3A72A
        for <git@vger.kernel.org>; Fri, 20 May 2022 04:57:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e28so10595410wra.10
        for <git@vger.kernel.org>; Fri, 20 May 2022 04:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6OrsXmXK95A+w6Ek0qnAAejm6WXcxCopqACOmZP8hw=;
        b=lSM1h8eIY+ejUE1QQRmdPNNcyjFAePYTDEktt+jM30DuLaPOhO3As0oO+eTIkPIsP2
         sUR7dGK1X+1/IgCaV3W4TqJhzT+5HQDVAWpyTwSwWu6AnoPy1TQ0NU8H1vHgqNZLor7J
         Bo439x+SpT4cPBKXnAdr5spkT4gM/OkWz+2lG2aed/wvftNsyF74DU+qk/+b0Licjf+s
         ncXy5SPB1wbfQZfkox3D5JJ2HKfpSdT77xrjdC5J3CEW8aWrkqb6Ygo15E4G3trXzyoL
         BOK5vacsIDEH9a3b/qJVf3P+w5fhLIilGv+hQta3QFbd64MqXN9d3jBw2KrXpXs/9JHr
         fOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6OrsXmXK95A+w6Ek0qnAAejm6WXcxCopqACOmZP8hw=;
        b=OW3Qd+tdlsCr+ufyDw+/yEjk5AAIJfpkO4XDHdHTiePYAsJWCh/00Mcr+cepefywLu
         1eus7811Vzz0PpRvmkwlrUIY+CE1UIgSSDXXXR1QkvspR1rx1PNWUL1QcYL8sTQ3EP2x
         pLaYGPLp80bc1JoA4FuK7B/Om5yMm2Z6AfQsm0qc9XWWvCLRqC26Q/CHlYOsyM7bEAJD
         BMoizC3jyhJnMn/XpLawdxWFzf57C5PRrFXl/tWqSuhsTl8KQum6QAgNAH9vqA22SZlh
         W7Z4PjDZIvPdhIXc848Xi1vP/UQF+TzUZnLbJ8vaC1JOYRzvyvtkmXWO5V3DhcNBlaLZ
         c6RA==
X-Gm-Message-State: AOAM530BWNayzmsoWWSKZOXPyn4mGKy3QTM+tqlZQGi8oaUkzsRl+yYe
        nf4eCoQT5CnApCDsJypVJ1wDmwS+UKDhuw==
X-Google-Smtp-Source: ABdhPJx8aigmaRJT1eVpa2fSXgPNoTTagRB/reFeWDU53AnQBKZMCfWCbZj+mJCtGE9Api30sOH1Bg==
X-Received: by 2002:a05:6000:2ad:b0:20e:796f:cc62 with SMTP id l13-20020a05600002ad00b0020e796fcc62mr2879805wry.200.1653047836231;
        Fri, 20 May 2022 04:57:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q5-20020adfaa45000000b0020c5253d8desm2217037wrd.42.2022.05.20.04.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:57:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] cocci: add and apply a rule to find "unused" variables
Date:   Fri, 20 May 2022 13:57:05 +0200
Message-Id: <patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.960.g7a4e2fc85c9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a coccinelle rule to remove variable initialization followed by
calling a "release" function. This rule automatically finds the sort
of issue patched in[1], and more.

We happened to only have occurrences of strbuf_release() matching this
rule, but manual testing reveals that it'll find e.g. the same pattern
if "string_list_clear()" were used instead.

1. https://lore.kernel.org/git/042d624b8159364229e95d35e9309f12b67f8173.1652977582.git.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This overlaps but cleanly merges with the small series that [1] is in,
but just adding a coccinelle rule to catch this seemed like a good
thing to have. We even have another such case in builtin/merge.c, near
the change made in [1]!

FWIW I wrote this working rule too, but there were no in-tree hits for
it, so I didn't include it:

	// Unused declaration + malloc + free()
	@@
	identifier I;
	type T;
	// malloc(), xmalloc(), calloc() etc.
	identifier MALLOC =~ "^x?[mc]alloc$";
	@@

	(
	- T *I;
	  ... when != I
	- I = MALLOC(...);
	|
	- T *I = MALLOC(...);
	)
	  ... when != I
	- free(I);

 builtin/fetch.c                 |  3 +--
 builtin/merge.c                 |  4 ----
 builtin/repack.c                |  2 --
 contrib/coccinelle/unused.cocci | 15 +++++++++++++++
 diff.c                          |  2 --
 5 files changed, 16 insertions(+), 10 deletions(-)
 create mode 100644 contrib/coccinelle/unused.cocci

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3791f09ed5..600c28fdb75 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1113,7 +1113,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			      struct fetch_head *fetch_head, struct worktree **worktrees)
 {
 	int url_len, i, rc = 0;
-	struct strbuf note = STRBUF_INIT, err = STRBUF_INIT;
+	struct strbuf note = STRBUF_INIT;
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
@@ -1281,7 +1281,6 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 
  abort:
 	strbuf_release(&note);
-	strbuf_release(&err);
 	free(url);
 	return rc;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index f178f5a3ee1..bb6b0580659 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -375,7 +375,6 @@ static void reset_hard(const struct object_id *oid, int verbose)
 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	struct strbuf sb = STRBUF_INIT;
 	const char *args[] = { "stash", "apply", NULL, NULL };
 
 	if (is_null_oid(stash))
@@ -391,7 +390,6 @@ static void restore_state(const struct object_id *head,
 	 */
 	run_command_v_opt(args, RUN_GIT_CMD);
 
-	strbuf_release(&sb);
 	refresh_cache(REFRESH_QUIET);
 }
 
@@ -501,7 +499,6 @@ static void merge_name(const char *remote, struct strbuf *msg)
 {
 	struct commit *remote_head;
 	struct object_id branch_head;
-	struct strbuf buf = STRBUF_INIT;
 	struct strbuf bname = STRBUF_INIT;
 	struct merge_remote_desc *desc;
 	const char *ptr;
@@ -589,7 +586,6 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		oid_to_hex(&remote_head->object.oid), remote);
 cleanup:
 	free(found_ref);
-	strbuf_release(&buf);
 	strbuf_release(&bname);
 }
 
diff --git a/builtin/repack.c b/builtin/repack.c
index d1a563d5b65..52f8450f1be 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -609,7 +609,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
-	struct string_list rollback = STRING_LIST_INIT_NODUP;
 	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
@@ -955,7 +954,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 
 	string_list_clear(&names, 0);
-	string_list_clear(&rollback, 0);
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
 	clear_pack_geometry(geometry);
diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
new file mode 100644
index 00000000000..52c23e15310
--- /dev/null
+++ b/contrib/coccinelle/unused.cocci
@@ -0,0 +1,15 @@
+// Unused init assignment + release()
+@@
+identifier I;
+type T;
+constant INIT =~ "_INIT";
+// stbuf_release(), string_list_clear() etc.
+identifier REL1 =~ "^[a-z_]*_(release|clear|free)$";
+// release_patch(), clear_pathspec() etc.
+identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
+@@
+
+- T I = INIT;
+  <+... when != \( I \| &I \)
+- \( REL1 \| REL2 \)(&I, ...);
+  ...+>
diff --git a/diff.c b/diff.c
index ef7159968b6..57997937071 100644
--- a/diff.c
+++ b/diff.c
@@ -1289,7 +1289,6 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 {
 	static const char *nneof = " No newline at end of file\n";
 	const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
-	struct strbuf sb = STRBUF_INIT;
 
 	enum diff_symbol s = eds->s;
 	const char *line = eds->line;
@@ -1521,7 +1520,6 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	default:
 		BUG("unknown diff symbol");
 	}
-	strbuf_release(&sb);
 }
 
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
-- 
2.36.1.960.g7a4e2fc85c9

