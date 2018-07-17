Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8AD71F597
	for <e@80x24.org>; Tue, 17 Jul 2018 08:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbeGQIyZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 04:54:25 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:59122
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728288AbeGQIyY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Jul 2018 04:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1531815777;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=lIvodM+dF7juFiBp8Nv00/Vqx2hQTgzDgzjDvwBsej8=;
        b=wKprpm92zcw2o4mkVsiK6oHSKPIUkxkt9qWfcYKfZ4mSFl0Q7MkSSgHRRzk5cjrn
        HYOD0ujIZe3kKWJD8sMTWbBc2npejMfcCHqY8cJGj0l/wHrjpQqbAeOLjUN8uysOIq/
        mHw7JKAW8pPL+FFOI6hyK43a+pXzbRCQW7jHWqkM=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020164a755d3c7-816ad44e-37cf-4b30-9d02-65e3d31c06f3-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020164a755d376-b1b86aec-5d26-4d6c-8f8f-2adbb6a8ed65-000000@eu-west-1.amazonses.com>
References: <01020164a755d376-b1b86aec-5d26-4d6c-8f8f-2adbb6a8ed65-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 2/5] ref-filter: fill empty fields with empty values
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Jul 2018 08:22:57 +0000
X-SES-Outgoing: 2018.07.17-54.240.7.11
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
