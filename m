Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 045071F453
	for <e@80x24.org>; Fri,  9 Nov 2018 07:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeKIRXX (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:23:23 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:35706
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728054AbeKIRXX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Nov 2018 12:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1541749441;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=VEuTz+lFag5ioqSEaJkPHzDIljA7STiJqtBuxWWBQbw=;
        b=vxu10QGF6HTKHyZUfLWsVeMdxSpw4TgmzlwPbGC2mAI+LSrwXNMBmspZKOCk/fiv
        1qjc3FleYXRwm2uuiUIpU6cBMyvMGuEHiQ518al0gXKtFFF6aO/HO+cPZBxvL6MjcFe
        GoNi08XHctppGQ4aqqPH0rcPxSB4bRWjoRVicLIE=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
In-Reply-To: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
References: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
Subject: [RFC PATCH 1/5] ref-filter: add objectsize:disk option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 9 Nov 2018 07:44:01 +0000
X-SES-Outgoing: 2018.11.09-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add new formatting option objectsize:disk to know
exact size that object takes up on disk.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 0c45ed9d94a4b..8ba1a4e72f2c3 100644
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
 
@@ -876,11 +882,13 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 			name++;
 		if (!strcmp(name, "objecttype"))
 			v->s = xstrdup(type_name(oi->type));
-		else if (!strcmp(name, "objectsize")) {
+		else if (!strcmp(name, "objectsize:disk")) {
+			v->value = oi->disk_size;
+			v->s = xstrfmt("%lld", (long long)oi->disk_size);
+		} else if (!strcmp(name, "objectsize")) {
 			v->value = oi->size;
 			v->s = xstrfmt("%lu", oi->size);
-		}
-		else if (deref)
+		} else if (deref)
 			grab_objectname(name, &oi->oid, v, &used_atom[i]);
 	}
 }

--
https://github.com/git/git/pull/552
