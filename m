Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F951F404
	for <e@80x24.org>; Fri,  9 Mar 2018 13:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932189AbeCINOO (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 08:14:14 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34674 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbeCINOL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 08:14:11 -0500
Received: by mail-pf0-f193.google.com with SMTP id j20so1270217pfi.1
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 05:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sqoXplQvklzMuDgNxNr5KNEl7Iv3RWE8cBnqtH1ugwY=;
        b=V7vE6myX1ZRJFPT3n8yUT8l7JQVpfav4Dtf1GTsl7rr6jv8YUkIHzIE50Zbez5nmOb
         /LrbyVnG261F6xkW36qGtCP3jr7oyJXN8ROJ1fa9qjVHWYUvgtiVmfiFESMJHuGbWfzQ
         uOcDuOA8eLdXyNOOsJp1v+6XENRDe8uVYL4uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sqoXplQvklzMuDgNxNr5KNEl7Iv3RWE8cBnqtH1ugwY=;
        b=bO+P1rzZUoAV0l7KSk9WTns/TbP8ikeEl9xSZXmC2XoSl0s1dHsHDAo5pF5LSiSWnE
         BHZ2AxpIfYYJovt+Uetbb9DNr5tEclVmTOh6fiQFR1RcHdm3SR+8sCY5FJfbp38UjO78
         iwXt0qro4rT/gOGdqN14Rsy5wyZ63l6j/gvunhAW2YTVLv6Tqa7YoBK7M3f8TUgIclaV
         CrCU1tb4MjsYBFX6ZsZ8YYQjCRW5uvVPJmxsDImWADDpC6/CXr4WYyUvQaRNg4EblHol
         v4LWA/SRWVIdFPwOsiVVocvgkm9Kn1n47aLWZhqNOItJqVFCfCj2i0tP5/7EAW4zmX2r
         rMqw==
X-Gm-Message-State: APf1xPCkfOoTktsPasDl2xb0yiGchaoXOFQY4phYHE9tvWQuvgq0DUMM
        yvuv+hEq0YsfqFs2uB13fgr1vCEpMWk=
X-Google-Smtp-Source: AG47ELsiop8GNIXFtwAyTTAiiFAcnQWZMNMbB7E+yHuAlmxwndB/6aDwJMubPMjneYPL6t3eLEuokw==
X-Received: by 10.101.65.131 with SMTP id a3mr23868149pgq.270.1520601250765;
        Fri, 09 Mar 2018 05:14:10 -0800 (PST)
Received: from tikuta.tok.corp.google.com ([2401:fa00:4:1002:bd1d:996:abff:29d])
        by smtp.gmail.com with ESMTPSA id b5sm3255132pfc.12.2018.03.09.05.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 05:14:10 -0800 (PST)
From:   Takuto Ikuta <tikuta@chromium.org>
To:     git@vger.kernel.org
Cc:     Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH v2 1/1] fetch-pack.c: use oidset to check existence of loose object
Date:   Fri,  9 Mar 2018 22:11:36 +0900
Message-Id: <20180309131136.219303-2-tikuta@chromium.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309131136.219303-1-tikuta@chromium.org>
References: <xmqqr2ouwgsd.fsf@gitster-ct.c.googlers.com>
 <20180309131136.219303-1-tikuta@chromium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In repository having large number of remote refs, because to check
existence of each refs in local repository, 'git fetch' ends up doing a
lot of lstat(2) calls to see if it exists in loose form, which makes it
slow.

This patch enumerates loose objects in hashmap beforehand and uses it to
check existence instead of using lstat(2) to improve performance of
fetch-pack for repositories having large number of remote refs compared
to the number of loose objects.

With this patch, the number of lstat(2) calls in `git fetch` is reduced
from 411412 to 13794 for chromium repository, it has more than 480000
remote refs.

I took time stat of `git fetch` disabling quickfetch, so that fetch-pack
runs, for chromium repository 3 time on linux with SSD.
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

On my MacBook Air which has slower lstat(2).
* with this patch
14.501s

* master
1m16.027s

`git fetch` on slow disk will be improved largely.

Signed-off-by: Takuto Ikuta <tikuta@chromium.org>
---
 cache.h      |  2 ++
 fetch-pack.c | 26 +++++++++++++++++++++++---
 sha1_file.c  |  3 +++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index d06932ed0..6a72f54d7 100644
--- a/cache.h
+++ b/cache.h
@@ -1773,6 +1773,8 @@ struct object_info {
 #define OBJECT_INFO_SKIP_CACHED 4
 /* Do not retry packed storage after checking packed and loose storage */
 #define OBJECT_INFO_QUICK 8
+/* Do not check loose object */
+#define OBJECT_INFO_IGNORE_LOOSE 16
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 
 /*
diff --git a/fetch-pack.c b/fetch-pack.c
index d97461296..ef8b93424 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -711,6 +711,14 @@ static void mark_alternate_complete(struct object *obj)
 	mark_complete(&obj->oid);
 }
 
+static int add_loose_objects_to_set(const struct object_id *oid,
+				    const char *path,
+				    void *data)
+{
+	oidset_insert(data, oid);
+	return 0;
+}
+
 static int everything_local(struct fetch_pack_args *args,
 			    struct ref **refs,
 			    struct ref **sought, int nr_sought)
@@ -719,16 +727,26 @@ static int everything_local(struct fetch_pack_args *args,
 	int retval;
 	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
+	struct oidset loose_oid_set = OIDSET_INIT;
+
+	/* Enumerate all loose objects. */
+	for_each_loose_object(add_loose_objects_to_set, &loose_oid_set, 0);
 
 	save_commit_buffer = 0;
 
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
+		unsigned int flag = OBJECT_INFO_QUICK;
 
-		if (!has_object_file_with_flags(&ref->old_oid,
-						OBJECT_INFO_QUICK))
-			continue;
+		if (!oidset_contains(&loose_oid_set, &ref->old_oid)) {
+			/* I know this does not exist in the loose form,
+			 * so check if it exists in a non-loose form.
+			 */
+			flag |= OBJECT_INFO_IGNORE_LOOSE;
+		}
 
+		if (!has_object_file_with_flags(&ref->old_oid, flag))
+			continue;
 		o = parse_object(&ref->old_oid);
 		if (!o)
 			continue;
@@ -744,6 +762,8 @@ static int everything_local(struct fetch_pack_args *args,
 		}
 	}
 
+	oidset_clear(&loose_oid_set);
+
 	if (!args->no_dependents) {
 		if (!args->deepen) {
 			for_each_ref(mark_complete_oid, NULL);
diff --git a/sha1_file.c b/sha1_file.c
index 1b94f39c4..c0a197947 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1262,6 +1262,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		if (find_pack_entry(real, &e))
 			break;
 
+		if (flags & OBJECT_INFO_IGNORE_LOOSE)
+			return -1;
+
 		/* Most likely it's a loose object. */
 		if (!sha1_loose_object_info(real, oi, flags))
 			return 0;
-- 
2.16.2

