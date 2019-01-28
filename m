Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1EBB1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfA1VvM (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:51:12 -0500
Received: from 0x63.nu ([109.74.10.199]:44898 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfA1VvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:51:12 -0500
Received: from ip6-localhost ([::1] helo=moveme2.lan)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1goEXZ-0002Au-DV; Mon, 28 Jan 2019 22:34:01 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v5 5/7] pretty: add support for "valueonly" option in %(trailers)
Date:   Mon, 28 Jan 2019 22:33:35 +0100
Message-Id: <20190128213337.24752-6-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128213337.24752-1-anders@0x63.nu>
References: <20181028125025.30952-1-anders@0x63.nu>
 <20190128213337.24752-1-anders@0x63.nu>
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the new "key=" option to %(trailers) it often makes little sense to
show the key, as it by definition already is knows which trailer is
printed there. This new "valueonly" option makes it omit the key when
printing trailers.

E.g.:
 $ git show -s --pretty='%s%n%(trailers:key=Signed-off-by,valueonly)' aaaa88182
will show:
 > upload-pack: fix broken if/else chain in config callback
 > Jeff King <peff@peff.net>
 > Junio C Hamano <gitster@pobox.com>

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/pretty-formats.txt | 2 ++
 pretty.c                         | 3 ++-
 t/t4205-log-pretty-formats.sh    | 6 ++++++
 trailer.c                        | 6 ++++--
 trailer.h                        | 1 +
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d6add831c0..a920dd15b1 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -243,6 +243,8 @@ endif::git-rev-list[]
    option was given. In same way as to for `only` it can be followed
    by an equal sign and explicit value. E.g.,
    `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
+** 'valueonly[=val]': skip over the key part of the trailer line and only
+   show the value part. Also this optionally allows explicit value.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index d3dd2d6254..ed25845c98 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1391,7 +1391,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 					opts.filter_data = &filter_list;
 					opts.only_trailers = 1;
 				} else if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
-					   !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold))
+					   !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold) &&
+					   !match_placeholder_bool_arg(arg, "valueonly", &arg, &opts.value_only))
 					break;
 			}
 		}
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index d87201afbe..1ad6834781 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -673,6 +673,12 @@ test_expect_success '%(trailers:key) without value is error' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
+	git log --no-walk --pretty="format:%(trailers:key=Acked-by,valueonly)" >actual &&
+	echo "A U Thor <author@example.com>" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
diff --git a/trailer.c b/trailer.c
index d6da555cd7..d0d9e91631 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1150,8 +1150,10 @@ static void format_trailer_info(struct strbuf *out,
 			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
 				if (opts->unfold)
 					unfold_value(&val);
-
-				strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
+				if (!opts->value_only)
+					strbuf_addf(out, "%s: ", tok.buf);
+				strbuf_addbuf(out, &val);
+				strbuf_addch(out, '\n');
 			}
 			strbuf_release(&tok);
 			strbuf_release(&val);
diff --git a/trailer.h b/trailer.h
index 5255b676de..06d417fe93 100644
--- a/trailer.h
+++ b/trailer.h
@@ -72,6 +72,7 @@ struct process_trailer_options {
 	int only_input;
 	int unfold;
 	int no_divider;
+	int value_only;
 	int (*filter)(const struct strbuf *, void *);
 	void *filter_data;
 };
-- 
2.17.1

