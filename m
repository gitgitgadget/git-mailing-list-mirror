Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AC141F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 12:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbeGMM62 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 08:58:28 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:34162
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727482AbeGMM61 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Jul 2018 08:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1531485836;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=lIvodM+dF7juFiBp8Nv00/Vqx2hQTgzDgzjDvwBsej8=;
        b=gRGjXqM5UnUetqSp35qfVUl1ZcIpSZUTFGb7/IRj5awWH/VzPkCML8R9M0E1pyiP
        xvPcfrslUC4HyQHqXCOcDj431DOcmPifF39REpzgkWkREt7NbBDU4k5zGaWuukTfyzj
        ZLwOsxTBeXylblo1wODA20mrTrsNvyyJ/LWFYjlY=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016493ab53df-b6a5c87b-d9e3-40c0-b125-7843a38103f1-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016493ab5347-c0429041-6e66-4550-894c-2d500cb2ed8e-000000@eu-west-1.amazonses.com>
References: <0102016493ab5347-c0429041-6e66-4550-894c-2d500cb2ed8e-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 2/4] ref-filter: fill empty fields with empty values
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Jul 2018 12:43:56 +0000
X-SES-Outgoing: 2018.07.13-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atoms like "align" or "end" do not have string representation.
Earlier we had to go and parse whole object with a hope that we
could fill their string representations. It's easier to fill them
with an empty string before we start to work with whole object.

It is important to mention that we fill only these atoms that must
contain nothing. So, if we could not fill the atom because, for example,
the object is missing, we leave it with NULL.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8611c24fd57d1..27733ef013bed 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1497,6 +1497,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			refname = get_symref(atom, ref);
 		else if (starts_with(name, "upstream")) {
 			const char *branch_name;
+			v->s = "";
 			/* only local branches may have an upstream */
 			if (!skip_prefix(ref->refname, "refs/heads/",
 					 &branch_name))
@@ -1509,6 +1510,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			continue;
 		} else if (atom->u.remote_ref.push) {
 			const char *branch_name;
+			v->s = "";
 			if (!skip_prefix(ref->refname, "refs/heads/",
 					 &branch_name))
 				continue;
@@ -1549,22 +1551,26 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			continue;
 		} else if (starts_with(name, "align")) {
 			v->handler = align_atom_handler;
+			v->s = "";
 			continue;
 		} else if (!strcmp(name, "end")) {
 			v->handler = end_atom_handler;
+			v->s = "";
 			continue;
 		} else if (starts_with(name, "if")) {
 			const char *s;
-
+			v->s = "";
 			if (skip_prefix(name, "if:", &s))
 				v->s = xstrdup(s);
 			v->handler = if_atom_handler;
 			continue;
 		} else if (!strcmp(name, "then")) {
 			v->handler = then_atom_handler;
+			v->s = "";
 			continue;
 		} else if (!strcmp(name, "else")) {
 			v->handler = else_atom_handler;
+			v->s = "";
 			continue;
 		} else
 			continue;

--
https://github.com/git/git/pull/520
