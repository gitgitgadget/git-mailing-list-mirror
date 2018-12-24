Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D56220A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 13:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbeLXNYh (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 08:24:37 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:44964
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbeLXNYc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Dec 2018 08:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1545657870;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=9YGepsMJUdpPw7b1C2yYCMIfHA1NSvuWSKGGBpzSG+o=;
        b=SOKHbojMmKri5wbv6frIdT4aCswFlFYCiT0tQoLH+69pW96GxvlhgFHLoIU93eA3
        qQNolvGgnOUpb5eqBgHbxS9C4jynHFcJSdSAvhQRrJYGNjKpNwLpsBApLvxWus05Gyv
        2KXpq7H64LL7UuhMaBaa4KvuwL8CTBKZYqPZW7gw=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020167e063687c-37a43a09-0a5f-4335-8c21-ec15a0a67882-000000@eu-west-1.amazonses.com>
In-Reply-To: <CAL21BmnmfxpMgbW_Yz9D=FVZk_AzWF0uyrNZeSGPCs63PH1oag@mail.gmail.com>
References: <CAL21BmnmfxpMgbW_Yz9D=FVZk_AzWF0uyrNZeSGPCs63PH1oag@mail.gmail.com>
Subject: [PATCH v2 1/6] ref-filter: add objectsize:disk option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Dec 2018 13:24:30 +0000
X-SES-Outgoing: 2018.12.24-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add new formatting option objectsize:disk to know
exact size that object takes up on disk.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 5de616befe46e..fd95547676047 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -231,12 +231,18 @@ static int objecttype_atom_parser(const struct ref_format *format, struct used_a
 static int objectsize_atom_parser(const struct ref_format *format, struct used_atom *atom,
 				  const char *arg, struct strbuf *err)
 {
-	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(objectsize) does not take arguments"));
-	if (*atom->name == '*')
-		oi_deref.info.sizep = &oi_deref.size;
-	else
-		oi.info.sizep = &oi.size;
+	if (!arg) {
+		if (*atom->name == '*')
+			oi_deref.info.sizep = &oi_deref.size;
+		else
+			oi.info.sizep = &oi.size;
+	} else if (!strcmp(arg, "disk")) {
+		if (*atom->name == '*')
+			oi_deref.info.disk_sizep = &oi_deref.disk_size;
+		else
+			oi.info.disk_sizep = &oi.disk_size;
+	} else
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(objectsize) argument: %s"), arg);
 	return 0;
 }
 
@@ -880,7 +886,10 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 			name++;
 		if (!strcmp(name, "objecttype"))
 			v->s = xstrdup(type_name(oi->type));
-		else if (!strcmp(name, "objectsize")) {
+		else if (!strcmp(name, "objectsize:disk")) {
+			v->value = oi->disk_size;
+			v->s = xstrfmt("%"PRIuMAX, (intmax_t)oi->disk_size);
+		} else if (!strcmp(name, "objectsize")) {
 			v->value = oi->size;
 			v->s = xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
 		}

--
https://github.com/git/git/pull/552
