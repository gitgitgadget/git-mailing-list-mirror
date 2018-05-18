Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B901F42D
	for <e@80x24.org>; Fri, 18 May 2018 09:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbeERITS (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 04:19:18 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:36890
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752975AbeERITL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 May 2018 04:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1526631549;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=T7iEOzaQImokFKnG4Bn7lFnH/fwv6Qvd22smyMjDG/8=;
        b=JVkj31CWuLDpyOFWCJnlNV9qlhBf0ZrJwPtinsWM3sY8y3/R7mPUHMqm9NrSlQ+w
        zzfb99v0bJkG8DG9YfSykf0v+kdQMW2sGX8QSowzX5uYm5YEdlz2zYNQyQ6U4L2s9E1
        z+5YCZYjd8hY3D5NsjiRz/erGgkavRy2NnsE2Z/Y=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201637254ca34-c7632c6b-dcab-439f-a2fb-cf270a881534-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201637254c969-a346030e-0b75-41ad-8ef3-2ac7e04ba4fb-000000@eu-west-1.amazonses.com>
References: <010201637254c969-a346030e-0b75-41ad-8ef3-2ac7e04ba4fb-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 4/4] ref-filter: add deltabase formatting option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 May 2018 08:19:09 +0000
X-SES-Outgoing: 2018.05.18-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add %(deltabase) support. It is still not working for deref:
I am thinking how to support it in a more elegant way.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index c00de58455301..989ccdb356a32 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -276,6 +276,14 @@ static int objecttype_atom_parser(const struct ref_format *format, struct used_a
 	return 0;
 }
 
+static int deltabase_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				  const char *arg, struct strbuf *unused_err)
+{
+	oi_data.use_data = 1;
+	oi_data.info.delta_base_sha1 = oi_data.delta_base_oid.hash;
+	return 0;
+}
+
 static int objectsize_atom_parser(const struct ref_format *format, struct used_atom *atom,
 				  const char *arg, struct strbuf *err)
 {
@@ -409,6 +417,7 @@ static struct {
 	{ "objecttype", FIELD_STR, objecttype_atom_parser },
 	{ "objectsize", FIELD_ULONG, objectsize_atom_parser },
 	{ "objectname", FIELD_STR, objectname_atom_parser },
+	{ "deltabase", FIELD_STR, deltabase_atom_parser },
 	{ "tree" },
 	{ "parent" },
 	{ "numparent", FIELD_ULONG },
@@ -1572,6 +1581,9 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				v->s = xstrfmt("%lu", oi_data.disk_size);
 			}
 			continue;
+		} else if (!deref && !strcmp(name, "deltabase") && oi_data.use_data) {
+			v->s = xstrdup(oid_to_hex(&oi_data.delta_base_oid));
+			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
 				v->s = "*";

--
https://github.com/git/git/pull/493
