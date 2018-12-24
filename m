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
	by dcvr.yhbt.net (Postfix) with ESMTP id ECA7020A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 13:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeLXNYc (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 08:24:32 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:45136
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbeLXNYc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Dec 2018 08:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1545657870;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=YWpxiWy87APy4CoRq/gxvhwxiu+Lf1AP4P+1msMcCpw=;
        b=NIRLU9aaCsS+1L3FHR+vy3Pzx21lmfIAdPTe5hYq2ygTG0W7tO2LeeExVB6yvnop
        i/lCE10eJ3P+LjMOdgSqqqxBAZkh+QZCHiYT2gt5SZJecXYR14XxfwGwAV08ilwL+lf
        VURDE7E4Kz8IVI8kL46aIfS1usfzpi5K4y1kxUxA=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020167e06368cb-7c85a9f8-c94c-47a6-9068-929e11104cec-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020167e063687c-37a43a09-0a5f-4335-8c21-ec15a0a67882-000000@eu-west-1.amazonses.com>
References: <01020167e063687c-37a43a09-0a5f-4335-8c21-ec15a0a67882-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 2/6] ref-filter: add check for negative file size
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Dec 2018 13:24:30 +0000
X-SES-Outgoing: 2018.12.24-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we have negative file size, we are doing something wrong.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index fd95547676047..45c558bcbd521 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1491,6 +1491,8 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 				     OBJECT_INFO_LOOKUP_REPLACE))
 		return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
 				       oid_to_hex(&oi->oid), ref->refname);
+	if (oi->info.disk_sizep && oi->disk_size < 0)
+		BUG("Object size is less than zero.");
 
 	if (oi->info.contentp) {
 		*obj = parse_object_buffer(the_repository, &oi->oid, oi->type, oi->size, oi->content, &eaten);

--
https://github.com/git/git/pull/552
