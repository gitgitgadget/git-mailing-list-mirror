Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BACC72027C
	for <e@80x24.org>; Thu, 13 Jul 2017 23:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753135AbdGMXuF (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:50:05 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59680 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752802AbdGMXtg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jul 2017 19:49:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C5E4F280B1;
        Thu, 13 Jul 2017 23:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499989774;
        bh=lvwZO5yQbwHlE7zc4bp+NwN2Oc8tOa6r7GxkhWEL3VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tzkjJyyrhByWqag4/ljpkkq/k+apBPuNHgY627hAxdhdFqujScVyh1vtnSTsT+7CW
         4mZ4y4uVbXGA3KY3Wq/qQZNd018orPnE5ekDzeZ+zrwIeZSzJAoBeLj6CRvi9Ba4Ib
         Qstfj2H7f5zBNgI+I6SWCxRdT+UV2rIMa/UdrBmurKMIrfBHAlJUNUHV1mJcYocDI4
         UtnMybPVTlyS+ZiaLhobwtsaHYrNND5tmrp7Pa508hie//hVWmUEgqerolnkGt3Ukw
         7R/HFDGc1oU0QtMmGsYE/53J5ihKg3Jk5X9Aw1YwQn2w0C9d4DK3WHpaAe20UgGmj5
         G5IG/bd2H3DxRssTD67h3UDnvlBVt+Y6oomRdcKtdaRk3u+nzjIDQtGdyZfCl+fc1A
         j+O9dMEWDMXkMOpfOStFf3fFJEjZuzmHtg0ykPtdtUiC8iOB9ZnbXwfd8kolq1EVkP
         ccv3Evc6FJ4RR1wYrzXYIEMZYoXPooeY2T4mDce9rqYR8GJijOj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 04/13] remote: convert struct push_cas to struct object_id
Date:   Thu, 13 Jul 2017 23:49:21 +0000
Message-Id: <20170713234930.949612-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170713234930.949612-1-sandals@crustytoothpaste.net>
References: <20170713234930.949612-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This gets rid of one use of get_sha1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote.c | 6 +++---
 remote.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index d87482573d..9da9040bf0 100644
--- a/remote.c
+++ b/remote.c
@@ -2294,8 +2294,8 @@ static int parse_push_cas_option(struct push_cas_option *cas, const char *arg, i
 	if (!*colon)
 		entry->use_tracking = 1;
 	else if (!colon[1])
-		hashclr(entry->expect);
-	else if (get_sha1(colon + 1, entry->expect))
+		oidclr(&entry->expect);
+	else if (get_oid(colon + 1, &entry->expect))
 		return error("cannot parse expected object name '%s'", colon + 1);
 	return 0;
 }
@@ -2342,7 +2342,7 @@ static void apply_cas(struct push_cas_option *cas,
 			continue;
 		ref->expect_old_sha1 = 1;
 		if (!entry->use_tracking)
-			hashcpy(ref->old_oid_expect.hash, cas->entry[i].expect);
+			oidcpy(&ref->old_oid_expect, &entry->expect);
 		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
 			oidclr(&ref->old_oid_expect);
 		return;
diff --git a/remote.h b/remote.h
index 6c28cd3e4b..2ecf4c8c74 100644
--- a/remote.h
+++ b/remote.h
@@ -282,7 +282,7 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
 struct push_cas_option {
 	unsigned use_tracking_for_rest:1;
 	struct push_cas {
-		unsigned char expect[20];
+		struct object_id expect;
 		unsigned use_tracking:1;
 		char *refname;
 	} *entry;
