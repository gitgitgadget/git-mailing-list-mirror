Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2E181F404
	for <e@80x24.org>; Thu,  8 Mar 2018 12:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755494AbeCHMGv (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 07:06:51 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43287 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755026AbeCHMGu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 07:06:50 -0500
Received: by mail-pf0-f196.google.com with SMTP id j2so2242304pff.10
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 04:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WcBVKMP79u56Ge9KnkCQAfCVxv/pGa0T2wKqQRtPHFE=;
        b=Us9fQ7o/Gg3c+lGHe1XdU5N9OrSSSwk7M+50uQaS9UNW4f/3UZubaODUsJEJQetDxb
         T3rKbmdcJ28LTMeRom+U7J7HqVGBKfSt0UwEv8aQKm1s+3YyBKKd0TcokdRvxAKDKYyO
         O1HP3qnS2NrNwp0hcnMt59JTP8vs9y9gfdGBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WcBVKMP79u56Ge9KnkCQAfCVxv/pGa0T2wKqQRtPHFE=;
        b=YBv8jtBfdI8hMc/3kMtgOrdf+OJGBi3RuqFCBigECY1hXEaFGiSWaJAL4JG5P2Z6lt
         APdgmZPSOtkQJQmEiVINr4w+6kommPUpvotuOuT00Z9Y7gsRbWFFBa+Twr4saOhS4YZu
         Cua2IUWj8qoWrLPLJVZCK6vTanludcu6eS2xx88oeDvSaW64XXu5w9gItzkfs2oFBzkt
         QrrhnO3/Fmla9wNSE+foreFjBaNisjllwwGOfjZ0nJ8TUD0p6hNCPMv8FxmOiQLTDy5W
         GF3r/gh3mBwNWCaEo4U7J0xLZkv6me3UdnV7qr7RyNZ5f2jmcsAlwCFhQQtFJwUgI6tz
         +2Cg==
X-Gm-Message-State: APf1xPBPK68yAN4FTuAkeXewo3Rj4ewyk1ADbWLzuj6+WoIKEOksXWr6
        u3mybJtACaVnzq4Ag+o6kOrs3H6FTrY=
X-Google-Smtp-Source: AG47ELuS7GO2VyuvyIbN02D2gHL+nIV4Jr2rbpdaLu2Lv2QECRmUtuje4MLabwc/dqIDWhrzkV/9bw==
X-Received: by 10.98.49.135 with SMTP id x129mr25982502pfx.75.1520510809774;
        Thu, 08 Mar 2018 04:06:49 -0800 (PST)
Received: from tikuta.tok.corp.google.com ([2401:fa00:4:1002:bd1d:996:abff:29d])
        by smtp.gmail.com with ESMTPSA id e83sm43335283pfk.148.2018.03.08.04.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 04:06:49 -0800 (PST)
From:   Takuto Ikuta <tikuta@chromium.org>
To:     git@vger.kernel.org
Cc:     Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH] fetch-pack.c: use oidset to check existence of loose object
Date:   Thu,  8 Mar 2018 21:06:39 +0900
Message-Id: <20180308120639.109438-1-tikuta@chromium.org>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In repository having large number of refs, lstat for non-existing loose
objects makes `git fetch` slow.

This patch stores existing loose objects in hashmap beforehand and use
it to check existence instead of using lstat.

With this patch, the number of lstat calls in `git fetch` is reduced
from 411412 to 13794 for chromium repository.

I took time stat of `git fetch` disabling quickfetch for chromium
repository 3 time on linux with SSD.
* with this patch
8.105s
8.309s
7.640s
avg: 8.018s

* master
12.287s
11.175s
12.227s
avg: 11.896s

On my MacBook Air which has slower lstat.
* with this patch
14.501s

* master
1m16.027s

`git fetch` on slow disk will be improved largely.

Signed-off-by: Takuto Ikuta <tikuta@chromium.org>
---
 cache.h      |  2 ++
 fetch-pack.c | 22 +++++++++++++++++++---
 sha1_file.c  |  3 +++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index d06932ed0..db38db40e 100644
--- a/cache.h
+++ b/cache.h
@@ -1773,6 +1773,8 @@ struct object_info {
 #define OBJECT_INFO_SKIP_CACHED 4
 /* Do not retry packed storage after checking packed and loose storage */
 #define OBJECT_INFO_QUICK 8
+/* Do not check loose object */
+#define OBJECT_INFO_SKIP_LOOSE 16
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 
 /*
diff --git a/fetch-pack.c b/fetch-pack.c
index d97461296..1658487f7 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -711,6 +711,15 @@ static void mark_alternate_complete(struct object *obj)
 	mark_complete(&obj->oid);
 }
 
+static int add_loose_objects_to_set(const struct object_id *oid,
+				    const char *path,
+				    void *data)
+{
+	struct oidset* set = (struct oidset*)(data);
+	oidset_insert(set, oid);
+	return 0;
+}
+
 static int everything_local(struct fetch_pack_args *args,
 			    struct ref **refs,
 			    struct ref **sought, int nr_sought)
@@ -719,16 +728,21 @@ static int everything_local(struct fetch_pack_args *args,
 	int retval;
 	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
+	struct oidset loose_oid_set = OIDSET_INIT;
+
+	for_each_loose_object(add_loose_objects_to_set, &loose_oid_set, 0);
 
 	save_commit_buffer = 0;
 
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
+		unsigned int flag = OBJECT_INFO_QUICK;
 
-		if (!has_object_file_with_flags(&ref->old_oid,
-						OBJECT_INFO_QUICK))
-			continue;
+		if (!oidset_contains(&loose_oid_set, &ref->old_oid))
+			flag |= OBJECT_INFO_SKIP_LOOSE;
 
+		if (!has_object_file_with_flags(&ref->old_oid, flag))
+			continue;
 		o = parse_object(&ref->old_oid);
 		if (!o)
 			continue;
@@ -744,6 +758,8 @@ static int everything_local(struct fetch_pack_args *args,
 		}
 	}
 
+	oidset_clear(&loose_oid_set);
+
 	if (!args->no_dependents) {
 		if (!args->deepen) {
 			for_each_ref(mark_complete_oid, NULL);
diff --git a/sha1_file.c b/sha1_file.c
index 1b94f39c4..c903cbcec 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1262,6 +1262,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		if (find_pack_entry(real, &e))
 			break;
 
+		if (flags & OBJECT_INFO_SKIP_LOOSE)
+			return -1;
+
 		/* Most likely it's a loose object. */
 		if (!sha1_loose_object_info(real, oi, flags))
 			return 0;
-- 
2.16.2

