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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F9511F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 08:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbeGIIM5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 04:12:57 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:37938
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751048AbeGIIMz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Jul 2018 04:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1531123974;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=xWMnc+MwXOIyDH6v0yJCRZM60j75IwdUGWy6wftzZIg=;
        b=tROgk7NdqPW6DK3jf/YJT040E0dmBOhEuioOh0Z8fwhtFZuCDAtXSO+OAG7/NGnl
        Weq7CpSRI9g1SmlUB2ZWMMsFpLP/WBcBGKTC54fU7rdIpM2zK/nH6BXmAVWS1l06/nW
        Ya4lBreiFF4wMRL7eRbRjxlhV2GrbKMKtIxztN3w=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201647e19c191-8c24e128-8822-4c77-b3bf-60fe17ecb62b-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201647e19c0f0-68cd728f-c86a-4be2-be6b-fd7e19e930fa-000000@eu-west-1.amazonses.com>
References: <010201647e19c0f0-68cd728f-c86a-4be2-be6b-fd7e19e930fa-000000@eu-west-1.amazonses.com>
Subject: [PATCH 2/4] ref-filter: add empty values to technical fields
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 9 Jul 2018 08:12:54 +0000
X-SES-Outgoing: 2018.07.09-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atoms like "align" or "end" do not have string representation.
Earlier we had to go and parse whole object with a hope that we
could fill their string representations. It's easier to fill them
with an empty string before we start to work with whole object.

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
