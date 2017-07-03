Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC5E201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 18:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753594AbdGCSz4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:55:56 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52968 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752233AbdGCSzs (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2017 14:55:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 97259280B1;
        Mon,  3 Jul 2017 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499108147;
        bh=blCre5SH+tA+K/QYqdIje5hYhg2VjFpTGAHaqYOP7Zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zUoDu8eLnCNpKH4xzGi1Juw5BWS4OZrBg8MoTwOwDZgOLeBW9WIUWrv9pxrGwmXJF
         d0Kl6CibYu0WyQVi5rBT2A5EYGs7OsX0oItsSWc8mRLygvhs7/Nbl+/C3dqRi39Kkd
         6j6qQBTN1Ny++vsse9I7q/Mgs+Hb+JDpBMPJTUIFWOK4kyF0Vie/Zm5esGAr44JQUo
         3ld54e4lYQHqkEzTK/jvXL48sfjEMdr4xlSGkg+LcaNgN0wKGbmfqxANmjkRwgpXyO
         3s3u/SUdHOY2G4FgB/2ekfZdhCtGc5jsMKuE4/3v2Pz0eCjk9uhS0bVFZS6p4ECM6F
         /agqrEvQX92AYQBtBFoRHO8hZ/f3mS4y1pkuu9hMg3176q1l5OlQdWVOUG5u9xSujl
         y7YExy0OqxX44vCzAfUlEPfhMXSuITY0m1BmVRMHuRixhCJpqM3j6k8CaHh48GOkA+
         OjThr6d56wmvKFQD1vjLyUlPDg2HyPkMx4C6+3/PCx4KhhSNh2Y
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 04/12] remote: convert struct push_cas to struct object_id
Date:   Mon,  3 Jul 2017 18:55:25 +0000
Message-Id: <20170703185533.51530-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.753.g7f5404b18
In-Reply-To: <20170703185533.51530-1-sandals@crustytoothpaste.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
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
index d87482573..9da9040bf 100644
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
index 6c28cd3e4..2ecf4c8c7 100644
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
