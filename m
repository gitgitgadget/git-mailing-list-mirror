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
	by dcvr.yhbt.net (Postfix) with ESMTP id 744EC1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 06:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfAJGcS (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 01:32:18 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:50814
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727129AbfAJGcS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Jan 2019 01:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1547101936;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=wVvp7NHMbM3bcJTUP0vIt0ibMUbK7NwcSS5tJ6u2KYQ=;
        b=T8/nsqQ3Q9N1kiYOEtnHTuZw/wqBbbrCKLQNh/+e2eksaQQIvw2aHtaNl18Axkbf
        6NcWptMEoq2MArkUk1dfH2gtySJxGZ1donHk7rwTR0wwI2fsdky4BIAAQiXasflmS+V
        wuJBr18DL6aXkdstT03Su1W+F3g3BmqYysq1LgqU=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016836761be3-b35028e3-800e-4f54-b608-55cebf6feaa9-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016836761b8b-8616fc01-3489-4e53-a5b7-cd4b52e20e01-000000@eu-west-1.amazonses.com>
References: <0102016836761b8b-8616fc01-3489-4e53-a5b7-cd4b52e20e01-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 2/6] ref-filter: add check for negative file size
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Jan 2019 06:32:16 +0000
X-SES-Outgoing: 2019.01.10-54.240.7.19
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
index ecef4b47c751c..57f3789d1040d 100644
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
