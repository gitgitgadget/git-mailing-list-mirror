Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7F120248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfBVQF5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:05:57 -0500
Received: from a7-10.smtp-out.eu-west-1.amazonses.com ([54.240.7.10]:33622
        "EHLO a7-10.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727237AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=LoJPuEhVjrFPq+fTOsbdYu/HuviLyxmgK3aWfg3JjyY=;
        b=M22t/QejshRNNsjMcG4ymDZEcI3nAgLPmxuOPigtzZbIs8KTBbkzUo8gtb2QFqac
        8dBrl5Sih7ma9kEBS3s4Zn/y5FD2lYsA2jDNTS+wIbzAU4qhm/YXLwFgI8vggqbA+Fb
        tX7MGpQSfEYdxrjd3SQ55utKM/Cum5aE6GpI/Y7M=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a49-6f817c1d-5b1c-47ac-98c3-18a124a733eb-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 03/20] ref-filter: add rest formatting option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.10
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add rest option that allows to add string into ref_array_item
and then put it into specific place of the output.
We are using it now in cat-file command: user could put anything
in the input after objectname, and it will appear in the output
in place of %(rest).

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 4 ++++
 ref-filter.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 736e1f9cc38fc..46bf89b3330de 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -485,6 +485,7 @@ static struct {
 	{ "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
 	{ "then", SOURCE_NONE },
 	{ "else", SOURCE_NONE },
+	{ "rest", SOURCE_NONE },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
@@ -1623,6 +1624,9 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			else
 				v->s = xstrdup(" ");
 			continue;
+		} else if (starts_with(name, "rest")) {
+			v->s = xstrdup(ref->request_rest ? ref->request_rest : "");
+			continue;
 		} else if (starts_with(name, "align")) {
 			v->handler = align_atom_handler;
 			v->s = xstrdup("");
diff --git a/ref-filter.h b/ref-filter.h
index 4d7d36e9f522d..aaeda9f324f5c 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -40,6 +40,7 @@ struct ref_array_item {
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
+	const char *request_rest;
 	char refname[FLEX_ARRAY];
 };
 

--
https://github.com/git/git/pull/568
