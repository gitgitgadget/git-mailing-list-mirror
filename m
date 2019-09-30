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
	by dcvr.yhbt.net (Postfix) with ESMTP id B4BA71F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbfI3VK0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:10:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36346 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732486AbfI3VK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:10:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so6303418pfr.3
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6GhKKMc42LQZvrmWjslEfVGBS5TOHNJQfKnYhcBhBAc=;
        b=Mws0J9VeeFEWdETX36nxh5chZdiWr5lxGQDXqXNcmXXxeaWPHDqwnKHP+ncj5xlnbG
         3uCm7N7m5CTmPhho7aTcXM0MFgWM9fRdsSxsZpfjmyHCx8691saecG949RWwPQfnl1Hl
         lKDEoYIfiCSTR/SzFV/lfHtrI5aD1idjKGKXnX4/Md86zxdV5Bas5uw0MOFkUI17AiW/
         a56iKq4dadgWTH9T9/PNQk7ZlPKzcpG3/BD8yHk5tT3xBk3Y1hKoY9WBAj2NAM8SQ+XY
         QitCne+fymGgI9mzSNwfl74w8ijdnCxF2IfO5mKxjVbczvdGY5OFt15+btL/1rbnRCHP
         cj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6GhKKMc42LQZvrmWjslEfVGBS5TOHNJQfKnYhcBhBAc=;
        b=sORYhrRu9kv4b7Hdp9kT25Pc7rx+Ek+EDbGVhs5/5kv92RDk6g2k37R67EVE3og0XI
         fqvrk4X0DrQFgqzTp/FHRKLaotj7pjbkLsV6nNTfN7op6LdC0zjj0/OaNzeHIuGHpVTa
         xOVFw3U6UBr0N3L0QN0SvzRQyLK0oLgSE8IPJF4ZFoWwipcH4O36YP7AqLKc9Ucsz1YV
         JSWrbhed+EokhHuL5E+fsq33u9h3tB1rjyZUAoc9v52QvvavibKJDzg29asHVoC7cdaO
         BiXvZb5LKL/xe+ecYUb+aM+x1j+o7yxO0y+yiHVINoA5TC4J+D9kaleOo20RSC4/ZEbu
         tsHg==
X-Gm-Message-State: APjAAAXEDsipWHS2PaAhdK2FBw8/0e98QCo0H9V/6DLJ7pBc4xUseCiB
        EHV0JUg4SsvU5e4fLWJS0f/ePBjyYro=
X-Google-Smtp-Source: APXvYqz97XzH6MAxRILdEXk4GJVRkRmO96AKm2kfD7Xop2na7XA89eTrmTfWgxKqWI/zglRi20+YrA==
X-Received: by 2002:a63:504b:: with SMTP id q11mr26165508pgl.188.1569877825130;
        Mon, 30 Sep 2019 14:10:25 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id w11sm13404609pfd.116.2019.09.30.14.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 14:10:24 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/8] fast-import: fix handling of deleted tags
Date:   Mon, 30 Sep 2019 14:10:12 -0700
Message-Id: <20190930211018.23633-3-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.gac739dbb79
In-Reply-To: <20190930211018.23633-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
 <20190930211018.23633-1-newren@gmail.com>
MIME-Version: 1.0
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 fast-import.c          | 29 +++++++++++++++++++++++++++++
 t/t9300-fast-import.sh | 13 +++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/fast-import.c b/fast-import.c
index b44d6a467e..546da3a938 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2793,6 +2793,35 @@ static void parse_reset_branch(const char *arg)
 		b = new_branch(arg);
 	read_next_command();
 	parse_from(b);
+	if (b->delete && !strncmp(b->name, "refs/tags/", 10)) {
+		/*
+		 * Elsewhere, we call dump_branches() before dump_tags(),
+		 * and dump_branches() will handle ref deletions first, so
+		 * in order to make sure the deletion actually takes effect,
+		 * we need to remove the tag from our list of tags to update.
+		 *
+		 * NEEDSWORK: replace list of tags with hashmap for faster
+		 * deletion?
+		 */
+		struct strbuf tag_name = STRBUF_INIT;
+		struct tag *t, *prev = NULL;
+		for (t = first_tag; t; t = t->next_tag) {
+			strbuf_reset(&tag_name);
+			strbuf_addf(&tag_name, "refs/tags/%s", t->name);
+			if (!strcmp(b->name, tag_name.buf))
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
2.23.0.264.gac739dbb79

