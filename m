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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2866020248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfBVQGG (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:06:06 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:35508
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=HHIaEKc3cOW1xLxquc2x2Tl+9OeDk+HErwTQLdy9mz4=;
        b=K3PfZKHtbR8Fj0s9TRgb42dAEUzk9fqWXTBEWobAlME+0rIPcNSu6S8FgTEyQwMy
        TNoqagPMQ79sh9i6722Stv1QlolDi/BHDP4FOKlXHZFBBnZejLdHnqGtp3q+w/pMtJZ
        8dN2w4iHhE+PQHXfFtrvmWlvNLDA1yg4NfMAzfLA=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a6a-10a18ba5-b1f4-4514-b76d-9b213d6c51e8-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 15/20] ref-filter: add raw formatting option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add new formatting option %(raw), it means that we want to print
all the file without any changes. It will help further
to migrate all cat-file formatting logic from cat-file
to ref-filter. For now, we just treat it as the empty string.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 68d9741a56468..bb963a4110fb2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -208,6 +208,15 @@ static int remote_ref_atom_parser(const struct ref_format *format, struct used_a
 	return 0;
 }
 
+static int raw_atom_parser(const struct ref_format *format, struct used_atom *atom,
+			   const char *arg, struct strbuf *err)
+{
+	if (arg)
+		return strbuf_addf_ret(err, -1, _("%%(raw) does not take arguments"));
+	oi.info.typep = &oi.type;
+	return 0;
+}
+
 static int objecttype_atom_parser(const struct ref_format *format, struct used_atom *atom,
 				  const char *arg, struct strbuf *err)
 {
@@ -478,6 +487,7 @@ static struct {
 	{ "then", SOURCE_NONE },
 	{ "else", SOURCE_NONE },
 	{ "rest", SOURCE_NONE },
+	{ "raw", SOURCE_NONE, FIELD_STR, raw_atom_parser },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
@@ -1619,6 +1629,9 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		} else if (starts_with(name, "rest")) {
 			v->s = xstrdup(ref->request_rest ? ref->request_rest : "");
 			continue;
+		} else if (!strcmp(name, "raw")) {
+			v->s = xstrdup("");
+			continue;
 		} else if (starts_with(name, "align")) {
 			v->handler = align_atom_handler;
 			v->s = xstrdup("");

--
https://github.com/git/git/pull/568
