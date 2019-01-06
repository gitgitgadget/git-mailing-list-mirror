Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B4A211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 16:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfAFQvJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 11:51:09 -0500
Received: from mout.web.de ([217.72.192.78]:45877 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfAFQvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 11:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1546793468;
        bh=TjC+/jrMfVIuwuXEwMRFTnLRIzlLm1rnVMal6zc7bbk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NUoplDNlJNhMN0urT15+jsqBYdHPkzxc1/FpuqsxkYlES/LLdn4bbb9FyfnFuSifK
         HhRkAtxlnF8luZYMEuFElo+uOmK5h2EkUWGiFoJF8HdiFpGyeyki+RMlnMDrv8qIhd
         W9JNdjc4/mQ7fW+ignmB7FZVGIuhh4552CINhWB4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([91.20.59.41]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LaCbS-1h9S2u06u6-00m0uy; Sun, 06
 Jan 2019 17:45:54 +0100
Subject: [PATCH 3/3] object-store: use one oid_array per subdirectory for
 loose cache
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c8dd851f-0a18-848f-8e58-cc0ee5f8e705@web.de>
Date:   Sun, 6 Jan 2019 17:45:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a5yqLVtLJmWdbgp43UD6uhuyNEgK4HOptWU/KIeBYEfVxo3287q
 bwjFTuqCamJhzSttM2TF49pmpSMoqu7ev5VN87YiLq97Oh+8uZRuvB6SEwuNZZt1JNqLtC7
 7iag3p6cZjv+BlSwMraKj366BhAvlGBIOypKF0+YyJpD3ZvBINgCXAzbvbro3/OaZ2Z8llf
 7svlGZ90VFmHhh7rWYZeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y9P8xTMudWk=:OnzqHl6YwF0o7U0x535mnA
 N5SjXxmbs0Noyag2yjisaMeELZa+8kJT/8W5Ww0fodPoZz18uPEi52EipcwluFx6jZUb4T4RT
 RAJ/N+eul/T5wM2SLGro/jGCPdtjXmQnGBaNzqSwXrinWgdBysilwsDa0fYKl/2O2ej8BlfbG
 YBwEs54+JEr7RUvsntm8N1OccboNtcmILKE2glRO+4ptNMvcDMI3TRJICp/GDGRcDQtOarsqy
 KsxYq10x6zwU6SUs7yqlJDUgWJpGr7AF1BSJXEklRULKUaU7+Clja1trATK5Sc6PMswTwp4lC
 hGg59AEbkerwGEUK5E+4kORUpEjea7d8r6w5RlcIGXGO6ueb8vv+aN1Jm/aOc7a23U/qNyNsd
 Ymm1LWJh8UFqo8CxbDP0RhYNsKoNlsyaOhjc59ANcCW+gCXWpFg4kSXT1tRe+Ys+gj7IGxHZm
 SdjOmrxTH9tvcxFJLozvPA6WzEQNEG9VbD8BnImGXfb3R8VH0HNQs9Bq4H4NWmPq3TNqM5fmK
 ZdBZuN4et3MjWPs2Kjv8FeKhseNKBQMvlIshZlpo+2CjuWCHW5qRJXnnYXimxI4sjLwMFCeYv
 Ebm6frgSS26qFYhXc7WQkdohWpodhDfwd93rsdtdIs4tN2W7SQh0Uu9AyLrOVMKBPZi1dHhp2
 8UT+bXDEFerL02pOXn0S8lFErV+4Ee0NpH5NCgySvaAOW8r71tJ+X8cbq0C5IWLNt829EhEs3
 1gYX5xzzyYXFyxB5zfUjxDdyskmhg0dujFzywTt9CzGe0XStyzcfZxKgpDdIjOxiEDx8gunzw
 NUkmhVrXtfFQnCJ2PYBmgkAYmJx98mRQPAuZc6y7MpbC+t8gjI6rB5w7+Qtc4DepbPNaGnV5Q
 wHqwAx+MSbOzgdU3gfs5GQpWDhsSWWZLygSh50epEXDWshECupfsrvEhYz1rRB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The loose objects cache is filled one subdirectory at a time as needed.
It is stored in an oid_array, which has to be resorted after each add
operation.  So when querying a wide range of objects, the partially
filled array needs to be resorted up to 255 times, which takes over 100
times longer than sorting once.

Use one oid_array for each subdirectory.  This ensures that entries have
to only be sorted a single time.  It also avoids eight binary search
steps for each cache lookup as a small bonus.

The cache is used for collision checks for the log placeholders %h, %t
and %p, and we can see the change speeding them up in a repository with
ca. 100 objects per subdirectory:

$ git count-objects
26733 objects, 68808 kilobytes

Test                        HEAD^             HEAD
--------------------------------------------------------------------
4205.1: log with %H         0.51(0.47+0.04)   0.51(0.49+0.02) +0.0%
4205.2: log with %h         0.84(0.82+0.02)   0.60(0.57+0.03) -28.6%
4205.3: log with %T         0.53(0.49+0.04)   0.52(0.48+0.03) -1.9%
4205.4: log with %t         0.84(0.80+0.04)   0.60(0.59+0.01) -28.6%
4205.5: log with %P         0.52(0.48+0.03)   0.51(0.50+0.01) -1.9%
4205.6: log with %p         0.85(0.78+0.06)   0.61(0.56+0.05) -28.2%
4205.7: log with %h-%h-%h   0.96(0.92+0.03)   0.69(0.64+0.04) -28.1%

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 object-store.h | 2 +-
 sha1-file.c    | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index 709bf856b6..2fb6c0e4db 100644
--- a/object-store.h
+++ b/object-store.h
@@ -20,7 +20,7 @@ struct object_directory {
 	 * Be sure to call odb_load_loose_cache() before using.
 	 */
 	char loose_objects_subdir_seen[256];
-	struct oid_array loose_objects_cache;
+	struct oid_array loose_objects_cache[256];
 
 	/*
 	 * Path to the alternative object store. If this is a relative path,
diff --git a/sha1-file.c b/sha1-file.c
index 2f965b2688..c3c6e50704 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2155,7 +2155,7 @@ struct oid_array *odb_loose_cache(struct object_directory *odb,
 {
 	int subdir_nr = oid->hash[0];
 	odb_load_loose_cache(odb, subdir_nr);
-	return &odb->loose_objects_cache;
+	return &odb->loose_objects_cache[subdir_nr];
 }
 
 void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
@@ -2173,14 +2173,17 @@ void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
 				    append_loose_object,
 				    NULL, NULL,
-				    &odb->loose_objects_cache);
+				    &odb->loose_objects_cache[subdir_nr]);
 	odb->loose_objects_subdir_seen[subdir_nr] = 1;
 	strbuf_release(&buf);
 }
 
 void odb_clear_loose_cache(struct object_directory *odb)
 {
-	oid_array_clear(&odb->loose_objects_cache);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(odb->loose_objects_cache); i++)
+		oid_array_clear(&odb->loose_objects_cache[i]);
 	memset(&odb->loose_objects_subdir_seen, 0,
 	       sizeof(odb->loose_objects_subdir_seen));
 }
-- 
2.20.1
