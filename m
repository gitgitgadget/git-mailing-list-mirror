Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BADB71F42D
	for <e@80x24.org>; Fri, 18 May 2018 09:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeERITR (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 04:19:17 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:60934
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752973AbeERITL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 May 2018 04:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1526631549;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=m9zDejoPGzDNE39xe8elhScbIkFNME9wh84n8d3vaao=;
        b=S+hmFclwQugvkXeMLbwxuqR8tFh7g1J0+g3aqe4secAx60sskG7h4xpypb19KBSA
        QwP0SmkK9HNB4z2E/vLblZmDmR8XOiAEaS02mtShSkxBSm6B6RTgoXB/JtQP13A1lqv
        ru/0i2xYPEeh9ZA2GhXklr6O2GwOAIkjJ7RrxwzQ=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201637254c9fc-6c6958f9-5b32-44df-abbe-8455d4ca9535-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201637254c969-a346030e-0b75-41ad-8ef3-2ac7e04ba4fb-000000@eu-west-1.amazonses.com>
References: <010201637254c969-a346030e-0b75-41ad-8ef3-2ac7e04ba4fb-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 2/4] ref-filter: add objectsize:disk formatting
 option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 May 2018 08:19:09 +0000
X-SES-Outgoing: 2018.05.18-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add %(objectsize:disk) support. It is still not working for deref:
I am thinking how to support it in a more elegant way.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4008351553391..c00de58455301 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -277,10 +277,15 @@ static int objecttype_atom_parser(const struct ref_format *format, struct used_a
 }
 
 static int objectsize_atom_parser(const struct ref_format *format, struct used_atom *atom,
-				  const char *arg, struct strbuf *unused_err)
+				  const char *arg, struct strbuf *err)
 {
+	if (!arg)
+		oi_data.info.sizep = &oi_data.size;
+	else if (!strcmp(arg, "disk"))
+		oi_data.info.disk_sizep = &oi_data.disk_size;
+	else
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(objectsize) argument: %s"), arg);
 	oi_data.use_data = 1;
-	oi_data.info.sizep = &oi_data.size;
 	return 0;
 }
 
@@ -1557,9 +1562,15 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		} else if (!deref && !strcmp(name, "objecttype") && oi_data.use_data) {
 			v->s = type_name(oi_data.type);
 			continue;
-		} else if (!deref && !strcmp(name, "objectsize") && oi_data.use_data) {
-			v->value = oi_data.size;
-			v->s = xstrfmt("%lu", oi_data.size);
+		} else if (!deref && starts_with(name, "objectsize") && oi_data.use_data) {
+			if (!strcmp(name, "objectsize")) {
+				v->value = oi_data.size;
+				v->s = xstrfmt("%lu", oi_data.size);
+			} else {
+				/* It can be only objectsize:disk, we checked it in parser */
+				v->value = oi_data.disk_size;
+				v->s = xstrfmt("%lu", oi_data.disk_size);
+			}
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))

--
https://github.com/git/git/pull/493
