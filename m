Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC731F859
	for <e@80x24.org>; Sat,  6 Aug 2016 22:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbcHFWDr (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 18:03:47 -0400
Received: from mout.web.de ([212.227.15.14]:50295 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbcHFWDq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 18:03:46 -0400
Received: from [192.168.178.36] ([79.213.116.69]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MCqWJ-1bN1JN3ZRb-009i7Q; Sat, 06 Aug 2016 17:41:02
 +0200
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use strbuf_add_unique_abbrev() for adding short hashes
Message-ID: <57A6050D.50200@web.de>
Date:	Sat, 6 Aug 2016 17:41:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:LujBUqxq/LRl/rshBIdTR4A+jxyOA04eTksa1SKM5AkPXyCtrEK
 n9hyF7k9L4OJ6XOn1kOv6ApKvGvb4VxlVogc6Xtq3whQdUDsWAtcWGkFTtes/cNOB1TAWfa
 s3+WoylYLs2Y0pwdFkDRuT2D+D0b6YQrTVCteBtYXsMKtpbvw8p8Gpdv1I+eq/dAKFu5DtV
 HfpmZwcKXvM62r1PuF+mw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:74MMDDu4uDU=:B1Nuw7MbWcp35EPX7eC8Wt
 wErbVT2MmEwy9cJosFXraEMQ4jKT8uhfM0zlqjXp1WLh0zAbJLff/Sz9XcMRFJ2niClR7pVeh
 VjBoD3FottiocrXKjVIL+HVSs8jGgmqreBLwUCZowfeLNZppHTLwGssS3UdTYSywUpRn95fy4
 dDA0AyNTBCxsDlzrKkGDJ+S62tiDL8FPnUMnZKZDDxYjPgrnW6K3eK67aKMpR/7ntLCWUPugM
 62k1yg8LsLKM3R8FNEhg33vTiTU3staxH1IRaT1ZULqStdSps2U5nfwhA1yQ9ekePh3kdV96+
 sUDU6QLBfNnMwbInjdNSWhCidwr0nwjuw0V0ZhlDm3zmScBLCM+oVJTcA0yA7Gjt+Q081f4Of
 g8S7Bb0ww6rEH+yTTO7fAJYFAGPwJ3WYfmPCSts1E+IJEDYK/sWEOWbpIJ3Wn5rVDMtyanLVI
 2Q3s4E13GyCt9npDJLz9owvWYVw6G6F5giGs7SRb1vWZz8T0T1Csun1j38e8OKSS8TyrR3FYe
 camcA4/aG2q1y1v07fIM19oovA08ClsaMEdJTBxalV/PdooNFICK+0Od820IyNLM51Y5keGlC
 sTeeriqr5G9HA+j9dqzifaXhILirr8LHIIsC6Lj354zf4pdfImo08z28ukh2oJWG8ZsCEZdq7
 j7X9RAEIrllpAfT5vHUC0B3Gqye1rjQQnKiBiU49QhFcW5YWpxxkyh6i6A28Zmg1xHPJqXwFH
 tdI8UJyKD6MRkF0nbaEZCMjzh7lozSoeUIhUZ0iA6ySo22yD2iJdSG+Lruai7QYqKCaNhKckc
 vsndvRn
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Call strbuf_add_unique_abbrev() to add abbreviated hashes to strbufs
instead of taking detours through find_unique_abbrev() and its static
buffer.  This is shorter and a bit more efficient.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/checkout.c |  3 +--
 pretty.c           | 13 ++++++-------
 transport.c        | 11 ++++-------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 27c1a05..0a7d24c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -703,8 +703,7 @@ static int add_pending_uninteresting_ref(const char *refname,
 static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
 {
 	strbuf_addstr(sb, "  ");
-	strbuf_addstr(sb,
-		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
+	strbuf_add_unique_abbrev(sb, commit->object.oid.hash, DEFAULT_ABBREV);
 	strbuf_addch(sb, ' ');
 	if (!parse_commit(commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, sb);
diff --git a/pretty.c b/pretty.c
index 9fa42c2..9609afb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1143,8 +1143,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 			return 1;
 		}
-		strbuf_addstr(sb, find_unique_abbrev(commit->object.oid.hash,
-						     c->pretty_ctx->abbrev));
+		strbuf_add_unique_abbrev(sb, commit->object.oid.hash,
+					 c->pretty_ctx->abbrev);
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
 		return 1;
@@ -1154,8 +1154,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	case 't':		/* abbreviated tree hash */
 		if (add_again(sb, &c->abbrev_tree_hash))
 			return 1;
-		strbuf_addstr(sb, find_unique_abbrev(commit->tree->object.oid.hash,
-						     c->pretty_ctx->abbrev));
+		strbuf_add_unique_abbrev(sb, commit->tree->object.oid.hash,
+					 c->pretty_ctx->abbrev);
 		c->abbrev_tree_hash.len = sb->len - c->abbrev_tree_hash.off;
 		return 1;
 	case 'P':		/* parent hashes */
@@ -1171,9 +1171,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		for (p = commit->parents; p; p = p->next) {
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
-			strbuf_addstr(sb, find_unique_abbrev(
-					p->item->object.oid.hash,
-					c->pretty_ctx->abbrev));
+			strbuf_add_unique_abbrev(sb, p->item->object.oid.hash,
+						 c->pretty_ctx->abbrev);
 		}
 		c->abbrev_parent_hashes.len = sb->len -
 		                              c->abbrev_parent_hashes.off;
diff --git a/transport.c b/transport.c
index 4ba48b0..557f399 100644
--- a/transport.c
+++ b/transport.c
@@ -321,11 +321,6 @@ static void print_ref_status(char flag, const char *summary, struct ref *to, str
 	}
 }
 
-static const char *status_abbrev(unsigned char sha1[20])
-{
-	return find_unique_abbrev(sha1, DEFAULT_ABBREV);
-}
-
 static void print_ok_ref_status(struct ref *ref, int porcelain)
 {
 	if (ref->deletion)
@@ -340,7 +335,8 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 		char type;
 		const char *msg;
 
-		strbuf_addstr(&quickref, status_abbrev(ref->old_oid.hash));
+		strbuf_add_unique_abbrev(&quickref, ref->old_oid.hash,
+					 DEFAULT_ABBREV);
 		if (ref->forced_update) {
 			strbuf_addstr(&quickref, "...");
 			type = '+';
@@ -350,7 +346,8 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 			type = ' ';
 			msg = NULL;
 		}
-		strbuf_addstr(&quickref, status_abbrev(ref->new_oid.hash));
+		strbuf_add_unique_abbrev(&quickref, ref->new_oid.hash,
+					 DEFAULT_ABBREV);
 
 		print_ref_status(type, quickref.buf, ref, ref->peer_ref, msg, porcelain);
 		strbuf_release(&quickref);
-- 
2.9.2

