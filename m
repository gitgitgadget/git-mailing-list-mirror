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
	by dcvr.yhbt.net (Postfix) with ESMTP id EB29A1F454
	for <e@80x24.org>; Thu, 18 Oct 2018 07:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeJRP2f (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 11:28:35 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:60344
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727423AbeJRP2f (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Oct 2018 11:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1539847734;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=BzGa32BmXVTw8g08JkM7+DeO+ZhGX++zkPQUjCyzkP4=;
        b=UJXnNDr5vAXYWrDJDVtTWH71FVkpwPyimrv822GuHFw035MWLl91mspvU2ktwg2Y
        43RCAO3x96kUp90R6Io3PMhwXBZFtYhMMM7joDZ5fvhuQWw7GX2G9E2JXuW/10/335e
        ZRO3bKBSEEG/dmdeu+bS8Mb93Gp76IkUNwr2nzes=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201668613c3de-23d41696-1476-4949-9834-a31adeb0650e-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
References: <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 1/3] ref-filter: free memory from used_atom
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Oct 2018 07:28:54 +0000
X-SES-Outgoing: 2018.10.18-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Release memory from used_atom variable for reducing number of memory
leaks.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index e1bcb4ca8a197..70f1d13ab3beb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1996,6 +1996,10 @@ void ref_array_clear(struct ref_array *array)
 {
 	int i;
 
+	for (i = 0; i < used_atom_cnt; i++)
+		free((char *)used_atom[i].name);
+	FREE_AND_NULL(used_atom);
+	used_atom_cnt = 0;
 	for (i = 0; i < array->nr; i++)
 		free_array_item(array->items[i]);
 	FREE_AND_NULL(array->items);

--
https://github.com/git/git/pull/538
