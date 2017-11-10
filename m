Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148111F43C
	for <e@80x24.org>; Fri, 10 Nov 2017 11:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbdKJLKN (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 06:10:13 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:48847 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbdKJLKH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 06:10:07 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id D7C7etmv6mITaD7CIeDJlN; Fri, 10 Nov 2017 11:10:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510312207;
        bh=40uJqUNMwFGnTUizyVzoHG44mItDvXPp2rjDQ3lw29Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Nee8yeQJWwA6/k9XQsWcd7y8Zuw3v2hngy9SKlkttdCvIhnExOp3zh1cRybEcXafw
         I2/KExX5jPr5q2CDUKEp9oXpLL7fBCMR0CKtUHguUWcoR41IHXdP01P9Maa9X29uOU
         SCuHJFT3h1uRfjcCqN1JUAxF47JCI3nbtZkLGyrc=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=LPvblEiyalS0-xaKrEMA:9
 a=WvTkkSPvCFsiir6j:21 a=xAt_lYRgs9lS18oS:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 6/9] sequencer: don't die in print_commit_summary()
Date:   Fri, 10 Nov 2017 11:09:46 +0000
Message-Id: <20171110110949.328-7-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171110110949.328-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171110110949.328-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfBsyC58hcmn+DGG0IREPT1kNow+inMJv0elQBjFI4U+D+2tIeSLbikOpxTDlTOwND4NqJ+BZh+DOQSfGZ521D4wkoAUJolk3B6I9kkvAg4pvEEOjqg4h
 3JlawtO3a+oBmtCBolPW+tuZXWoa0mMJXxHTYYuFA7kv/AOUTeb6dD4OjkyLCQV/xLBUXtMXAV/d103pqbjRnRfutn+DiGhheFQWzs8Cit0slxLSMHLlrJKY
 hdc+8L0DAMfne6V+2pL7nfEdpjMzTVjz/lgP3vxDhe7yk4Lx7I+zZAjiOoHq73DA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Return an error rather than dying so that the sequencer can exit
cleanly once it starts committing without forking 'git commit'

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c |  3 ++-
 sequencer.c      | 17 +++++++++++------
 sequencer.h      |  4 ++--
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 22d260197e84a828f984575cfa92789391531ca3..e924d8a14c8532a78d072420aeb662ce616181a4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1598,7 +1598,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			flags |= SUMMARY_INITIAL_COMMIT;
 		if (author_date_is_interesting())
 			flags |= SUMMARY_SHOW_AUTHOR_DATE;
-		print_commit_summary(prefix, &oid, flags);
+		if (print_commit_summary(prefix, &oid, flags))
+			exit(128);
 	}
 
 	UNLEAK(err);
diff --git a/sequencer.c b/sequencer.c
index 03207db71821c0c3d1c442d3b01b11e3b010367e..61bb75352202cf896ffec41e972f366e94d569c1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -877,8 +877,8 @@ static const char *implicit_ident_advice(void)
 
 }
 
-void print_commit_summary(const char *prefix, const struct object_id *oid,
-			  unsigned int flags)
+int print_commit_summary(const char *prefix, const struct object_id *oid,
+			 unsigned int flags)
 {
 	struct rev_info rev;
 	struct commit *commit;
@@ -887,12 +887,13 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	struct pretty_print_context pctx = {0};
 	struct strbuf author_ident = STRBUF_INIT;
 	struct strbuf committer_ident = STRBUF_INIT;
+	int ret = 0;
 
 	commit = lookup_commit(oid);
 	if (!commit)
-		die(_("couldn't look up newly created commit"));
+		return error(_("couldn't look up newly created commit"));
 	if (parse_commit(commit))
-		die(_("could not parse newly created commit"));
+		return error(_("could not parse newly created commit"));
 
 	strbuf_addstr(&format, "format:%h] %s");
 
@@ -936,8 +937,10 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	diff_setup_done(&rev.diffopt);
 
 	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
-	if (!head)
-		die_errno(_("unable to resolve HEAD after creating commit"));
+	if (!head) {
+		ret = error_errno(_("unable to resolve HEAD after creating commit"));
+		goto out;
+	}
 	if (!strcmp(head, "HEAD"))
 		head = _("detached HEAD");
 	else
@@ -950,7 +953,9 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 		log_tree_commit(&rev, commit);
 	}
 
+out:
 	strbuf_release(&format);
+	return ret;
 }
 
 static int is_original_commit_empty(struct commit *commit)
diff --git a/sequencer.h b/sequencer.h
index 8e0dbe59bbc1ccd3847454faf8bd09d5ca1ff93a..e4040cac08cb69c9b91db3fe77ae392c8d6d0f50 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -78,6 +78,6 @@ void commit_post_rewrite(const struct commit *current_head,
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-void print_commit_summary(const char *prefix, const struct object_id *oid,
-			  unsigned int flags);
+int print_commit_summary(const char *prefix, const struct object_id *oid,
+			 unsigned int flags);
 #endif
-- 
2.15.0

