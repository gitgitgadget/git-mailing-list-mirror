Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87AB1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbfJCU1T (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:27:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43209 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCU1S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:27:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so2443867pfo.10
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjA68EJaDp/1KoTqrjA4J1/dYvTyr0t8uRhkTtuzPsg=;
        b=cV7lFAgTiBpDFjVHBYaNeuHCBhOTfD5GC1l9yVyFITbJs424611kgMKdBKku+EtKfa
         ULEi1DfOd/AJ5H+7NRbSYatDf+Ow8dKYbp9srlt++KzNSNr/Srm53J1NOQ/p2ADUnxt9
         HEL4ptVCbkOS2EKeztdQEsWbw7DicYtDMk6y0l9KqMzOOb8ic2sYZFM6gKgC3mPKMS58
         poWc3esBxsPL6FmDN8KDGb28cswt1FQHQQsywMnPdjqy9mkQaF1CXQuS37x7Rx4ehn+0
         TrWQRCpm6pWeIXMEfrwOBvSqU8wWmcIyPJx1MV57p0tm4U9Euocz3Go/Kxry8BiTHKtX
         SFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjA68EJaDp/1KoTqrjA4J1/dYvTyr0t8uRhkTtuzPsg=;
        b=AYwRTSGguJgEUxXizOyR66z/lcMJvUfww3cdvqoMwyNwROba3iFodjf3/tgQJfTcTE
         1rk7MqoH0dP6p1lzX2jpQLovnTQ/C4lI2+4hAvbXnNSO/5q6NY7s/IH1Ej/NPsNuny29
         xt0PdMNpCQw1EGoNeCtgiWurHAbOjWP1XvQIpo9Wi1jVXcdpcMx7vHs8GrJuf8IVOMpB
         8onZob/tkuwuNY3oPbngrHGUEzvVC1Jt9k8AtGNfPDSPnZyw6gwunyfTsSC3VVvcVpTn
         PVVUjXn3jGcnIxJ2UrfelB4ZkPFAlFP64olkhUEptoTOsiEaR1Z7LKnHFJ/wpm4ZgoQe
         YNWw==
X-Gm-Message-State: APjAAAWYmNYTKxOLi+Wb8iJZqynAOECmXLRptf8/WdzHjgQlLFogioee
        tKbDpvjO/g5E6ZljNqrCnSU=
X-Google-Smtp-Source: APXvYqx1wD7P2BzAcxukTqjX30hdwp7nmKjUht/xI4BhHY6hjvE/OZrpqLi1dnk03WmCgji8koTbwA==
X-Received: by 2002:a65:6844:: with SMTP id q4mr11976648pgt.274.1570134437719;
        Thu, 03 Oct 2019 13:27:17 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id c64sm4055498pfc.19.2019.10.03.13.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Oct 2019 13:27:17 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH -v3 2/8] fast-import: fix handling of deleted tags
Date:   Thu,  3 Oct 2019 13:27:03 -0700
Message-Id: <20191003202709.26279-3-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.g3b9f7f2fc6
In-Reply-To: <20191003202709.26279-1-newren@gmail.com>
References: <20190930211018.23633-1-newren@gmail.com>
 <20191003202709.26279-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If our input stream includes a tag which is later deleted, we were not
properly deleting it.  We did have a step which would delete it, but we
left a tag in the tag list noting that it needed to be updated, and the
updating of annotated tags occurred AFTER ref deletion.  So, when we
record that a tag needs to be deleted, also remove it from the list of
annotated tags to update.

While this has likely been something that has not happened in practice,
it will come up more in order to support nested tags.  For nested tags,
we either need to give temporary names to the intermediate tags and then
delete them, or else we need to use the final name for the intermediate
tags.  If we use the final name for the intermediate tags, then in order
to keep the sanity check that someone doesn't try to update the same tag
twice, we need to delete the ref after creating the intermediate tag.
So, either way nested tags imply the need to delete temporary inner tag
references.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 fast-import.c          | 27 +++++++++++++++++++++++++++
 t/t9300-fast-import.sh | 13 +++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/fast-import.c b/fast-import.c
index b44d6a467e..caae0819f5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2778,6 +2778,7 @@ static void parse_new_tag(const char *arg)
 static void parse_reset_branch(const char *arg)
 {
 	struct branch *b;
+	const char *tag_name;
 
 	b = lookup_branch(arg);
 	if (b) {
@@ -2793,6 +2794,32 @@ static void parse_reset_branch(const char *arg)
 		b = new_branch(arg);
 	read_next_command();
 	parse_from(b);
+	if (b->delete && skip_prefix(b->name, "refs/tags/", &tag_name)) {
+		/*
+		 * Elsewhere, we call dump_branches() before dump_tags(),
+		 * and dump_branches() will handle ref deletions first, so
+		 * in order to make sure the deletion actually takes effect,
+		 * we need to remove the tag from our list of tags to update.
+		 *
+		 * NEEDSWORK: replace list of tags with hashmap for faster
+		 * deletion?
+		 */
+		struct tag *t, *prev = NULL;
+		for (t = first_tag; t; t = t->next_tag) {
+			if (!strcmp(t->name, tag_name))
+				break;
+			prev = t;
+		}
+		if (t) {
+			if (prev)
+				prev->next_tag = t->next_tag;
+			else
+				first_tag = t->next_tag;
+			if (!t->next_tag)
+				last_tag = prev;
+			/* There is no mem_pool_free(t) function to call. */
+		}
+	}
 	if (command_buf.len > 0)
 		unread_command_buf = 1;
 }
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 141b7fa35e..74bc41333b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -85,6 +85,15 @@ test_expect_success 'A: create pack from stdin' '
 	An annotated tag that annotates a blob.
 	EOF
 
+	tag to-be-deleted
+	from :3
+	data <<EOF
+	Another annotated tag that annotates a blob.
+	EOF
+
+	reset refs/tags/to-be-deleted
+	from 0000000000000000000000000000000000000000
+
 	INPUT_END
 	git fast-import --export-marks=marks.out <input &&
 	git whatchanged master
@@ -157,6 +166,10 @@ test_expect_success 'A: verify tag/series-A-blob' '
 	test_cmp expect actual
 '
 
+test_expect_success 'A: verify tag deletion is successful' '
+	test_must_fail git rev-parse --verify refs/tags/to-be-deleted
+'
+
 test_expect_success 'A: verify marks output' '
 	cat >expect <<-EOF &&
 	:2 $(git rev-parse --verify master:file2)
-- 
2.23.0.264.g3b9f7f2fc6

