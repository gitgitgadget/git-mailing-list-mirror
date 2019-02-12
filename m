Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B06A1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfBLBXh (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34322 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727137AbfBLBXf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:35 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A74AC60899;
        Tue, 12 Feb 2019 01:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934613;
        bh=u4Oz/WO5+HhIy4BmxYdkaenf1TjVyDZL9RnBd377Dvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Pcng5MEFTaZ7rcXILUoxAW2ONMNVeN6GqWEayfdpTdFJD/A1+FPe+sEiEBpa7ezGh
         53eE6yBZTgL77rpBtJD1oTE+fA/5TSvZ6nodFegIaSmu9O7gtkxXEEqYqGEY+fp1IB
         lslPjqm16ttUGtlIf+muQLgCp1uE5BWSKtg0rENIfUOt3sLpRTToha1ji/OVzCjYFE
         ia2sryZR7ktnA4EfHoR/kWulZe8sphoKhn5qj0xRVu+dMyTzoFGzGohG36/d/vX/nj
         saim8U/In7rY/YshF9Ig7viwvVXGDAx4QLLYz1c1GtP7BTcdejRfUt1DQgI2BvczOz
         r/Sq1nvto3jWpZa0/TPzxmdCROaSWC7gqwEzBCCzSJ6Q4GgKrClDkTYSa72uTiuNGC
         E9TdLfdIUs6kNUXXZLWrkC2BL1Hv5dMe1PZacTQGy41hMKOpI9Rm6+xC/9Ay98trDQ
         D4QQ85L+yEuAi27vSJ4qZ9jLKIhmdFtOalvgSbsX7vi2SeMlOr0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 18/31] http-push: remove remaining uses of sha1_to_hex
Date:   Tue, 12 Feb 2019 01:22:43 +0000
Message-Id: <20190212012256.1005924-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since sha1_to_hex is limited to SHA-1, switch all remaining uses of it
in this file to hash_to_hex or oid_to_hex.  Modify update_remote to take
a pointer to struct object_id, and since we don't modify that parameter
in the function, set it to be const as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-push.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/http-push.c b/http-push.c
index c4e5142bc9..f675a96316 100644
--- a/http-push.c
+++ b/http-push.c
@@ -316,7 +316,7 @@ static void start_fetch_packed(struct transfer_request *request)
 	}
 
 	fprintf(stderr,	"Fetching pack %s\n",
-		sha1_to_hex(target->hash));
+		hash_to_hex(target->hash));
 	fprintf(stderr, " which contains %s\n", oid_to_hex(&request->obj->oid));
 
 	preq = new_http_pack_request(target, repo->url);
@@ -1374,7 +1374,7 @@ static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 	return count;
 }
 
-static int update_remote(unsigned char *sha1, struct remote_lock *lock)
+static int update_remote(const struct object_id *oid, struct remote_lock *lock)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
@@ -1383,7 +1383,7 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 
 	dav_headers = get_dav_token_headers(lock, DAV_HEADER_IF);
 
-	strbuf_addf(&out_buffer.buf, "%s\n", sha1_to_hex(sha1));
+	strbuf_addf(&out_buffer.buf, "%s\n", oid_to_hex(oid));
 
 	slot = get_active_slot();
 	slot->results = &results;
@@ -1948,7 +1948,7 @@ int cmd_main(int argc, const char **argv)
 		run_request_queue();
 
 		/* Update the remote branch if all went well */
-		if (aborted || !update_remote(ref->new_oid.hash, ref_lock))
+		if (aborted || !update_remote(&ref->new_oid, ref_lock))
 			rc = 1;
 
 		if (!rc)
