Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D421F21847
	for <e@80x24.org>; Wed,  2 May 2018 02:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeEBCVD (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 22:21:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37992 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750994AbeEBCU7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 22:20:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E239060129;
        Wed,  2 May 2018 02:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525227658;
        bh=BlYcTAdDRdY/oCGKMDO2hrx2L2ZgA9Qcrb0B6jepGS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tEDcnEiLP/42fceEHJGit3+8NWjUVyeQFFKSD6rGgkAfJt18t6eUE3oJBFHztc2n5
         SEh+zEBRvGtvBftXfZcMCEXIUCkQVwLEs/c7Q5FHkwCOSkxCmNbuwl1zvmC66bRB6y
         NaisvKgYdikmbxIx0bpa7TmQRQHXXclilgn2p/DCfa3Uwj5MeZQUFv8wTdFOoyee51
         GLXN4dkJnn4EEyjixRLCjoEtMTa/gUAYcj/WF5CoVTmSAy4PWZyztTQJVTnAheelLv
         W3f893Kcfiys3g6lPLjp2R7lEgBUpf/7vytBvo+c0Y2UzmPiH/82Nik17vFjgI9bJ/
         B/bWrlag5V6RLco21RioUeYr0IRIZHueYS9bFQvcHNghZlW/OUymXhnI4JRhifg1Yx
         azZe3JlYHneb7AqsV8Nx8QKGRyOG7UnM7RdgipAOcjECfQ1UUaXGxgUXxQAU01uExw
         ofcjjT+7hYiYPwTb6H0x+AUQj4bRjoZo/WoFRRBUiYIN4lcjABQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Patrick Hemmer <git@stormcloud9.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] format-patch: make cover letters always text/plain
Date:   Wed,  2 May 2018 02:20:52 +0000
Message-Id: <20180502022052.939511-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180501000214.833766-1-sandals@crustytoothpaste.net>
References: <20180501000214.833766-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When formatting a series of patches using --attach and --cover-letter,
the cover letter lacks the closing MIME boundary, violating RFC 2046.
Certain clients, such as Thunderbird, discard the message body in such a
case.

Since the cover letter is just one part and sending it as
multipart/mixed is not very useful, always emit it as text/plain,
avoiding the boundary problem altogether.

Reported-by: Patrick Hemmer <git@stormcloud9.net>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Changes from v1:
* Switch from rm -r to rm -fr.

 builtin/log.c           | 2 +-
 log-tree.c              | 7 ++++---
 log-tree.h              | 3 ++-
 t/t4014-format-patch.sh | 9 +++++++++
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 71f68a3e4f..24868ed070 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1019,7 +1019,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
 		return;
 
-	log_write_email_headers(rev, head, &pp.after_subject, &need_8bit_cte);
+	log_write_email_headers(rev, head, &pp.after_subject, &need_8bit_cte, 0);
 
 	for (i = 0; !need_8bit_cte && i < nr; i++) {
 		const char *buf = get_commit_buffer(list[i], NULL);
diff --git a/log-tree.c b/log-tree.c
index d1c0bedf24..9f5eb346a4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -362,7 +362,8 @@ void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
 
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
-			     int *need_8bit_cte_p)
+			     int *need_8bit_cte_p,
+			     int maybe_multipart)
 {
 	const char *extra_headers = opt->extra_headers;
 	const char *name = oid_to_hex(opt->zero_commit ?
@@ -385,7 +386,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			       opt->ref_message_ids->items[i].string);
 		graph_show_oneline(opt->graph);
 	}
-	if (opt->mime_boundary) {
+	if (opt->mime_boundary && maybe_multipart) {
 		static char subject_buffer[1024];
 		static char buffer[1024];
 		struct strbuf filename =  STRBUF_INIT;
@@ -610,7 +611,7 @@ void show_log(struct rev_info *opt)
 
 	if (cmit_fmt_is_mail(opt->commit_format)) {
 		log_write_email_headers(opt, commit, &extra_headers,
-					&ctx.need_8bit_cte);
+					&ctx.need_8bit_cte, 1);
 		ctx.rev = opt;
 		ctx.print_email_subject = 1;
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
diff --git a/log-tree.h b/log-tree.h
index deba035187..e668628074 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -27,7 +27,8 @@ void format_decorations_extended(struct strbuf *sb, const struct commit *commit,
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
-			     int *need_8bit_cte_p);
+			     int *need_8bit_cte_p,
+			     int maybe_multipart);
 void load_ref_decorations(struct decoration_filter *filter, int flags);
 
 #define FORMAT_PATCH_NAME_MAX 64
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 482112ca33..6ea08fd5e9 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1661,6 +1661,15 @@ test_expect_success 'format-patch --base with --attach' '
 	test_write_lines 1 2 >expect &&
 	test_cmp expect actual
 '
+test_expect_success 'format-patch --attach cover-letter only is non-multipart' '
+	test_when_finished "rm -fr patches" &&
+	git format-patch -o patches --cover-letter --attach=mimemime --base=HEAD~ -1 &&
+	! egrep "^--+mimemime" patches/0000*.patch &&
+	egrep "^--+mimemime$" patches/0001*.patch >output &&
+	test_line_count = 2 output &&
+	egrep "^--+mimemime--$" patches/0001*.patch >output &&
+	test_line_count = 1 output
+'
 
 test_expect_success 'format-patch --pretty=mboxrd' '
 	sp=" " &&
