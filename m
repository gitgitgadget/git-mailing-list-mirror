Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618E91F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752891AbeBEL1q (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:27:46 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:41060
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752612AbeBEL1k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 06:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1517830059;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=loNOHdjoQ5wlnzbCqYluGYFXFhdSyc5jtBxCkRVhKNA=;
        b=Ci5ZseDMx3+tb0Kl5xLAFJd4hqNZFIA8c/EdYOYdD1OLiBRCCQkE7dy3X62nKTl4
        yi7J3xsy9cFZoyMzasOOWZ8iFmeATz/eevyhRLSErZZtkIH+IrINmZCqSPHBc1zJ2bK
        q7zDwnO2Ydvy0NFCDYfFQ/s63n/YilfMd6tfep8w=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016165b8b4bd-0dc70183-2c3d-4c12-8fb0-7a9685b278b8-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
References: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 22/25] ref-filter: work with objectsize:disk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 5 Feb 2018 11:27:39 +0000
X-SES-Outgoing: 2018.02.05-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make a temporary solution for commands that could use
objectsize:disk atom.
It's better to fill it with value or give an error if there is no value
for this atom, but as a first solution we do dothing.
It means that if objectsize:disk is used, we put an empty string there.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index aa15dd0b4723e..b21358aea476b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -826,8 +826,10 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->value = sz;
 			v->s = xstrfmt("%lu", sz);
 		} else if (!strcmp(name, "objectsize:disk")) {
-			v->value = cat_file_info.disk_size;
-			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)v->value);
+			if (is_cat) {
+				v->value = cat_file_info.disk_size;
+				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)v->value);
+			}
 		} else if (deref)
 			grab_objectname(name, obj->oid.hash, v, &used_atom[i]);
 	}

--
https://github.com/git/git/pull/452
