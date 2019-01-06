Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68A1211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 16:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfAFQpn (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 11:45:43 -0500
Received: from mout.web.de ([217.72.192.78]:54829 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfAFQpn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 11:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1546793133;
        bh=O517+Q5YbblqExnLmtC8PkM4DI+zsFptNKNX0La8tqw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iO8oOOLoE8G2Jtd5kACUzPEl1eVSQ2A6QK2Km/fiIavoUJw/waHlIFtDjMrMW5x3e
         s7evNaXuTHAdHZfuRgetZCbtbq9rjc0pP4AWwGw2nhLzCCqiBG64y3FZzwcQj6nRsz
         qV18FbngusjnpofOtjA3yBFCoQmpbaWWtB7mwT+8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([91.20.59.41]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCImL-1gXcxp44PZ-0095qc; Sun, 06
 Jan 2019 17:45:33 +0100
Subject: [PATCH 1/3] object-store: factor out odb_loose_cache()
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b87e7e01-baa6-6fb2-7081-0042ecd3b6b7@web.de>
Date:   Sun, 6 Jan 2019 17:45:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Oy+eQGTDOT7qvHkHWRAbqZ0f/fwyiGDSL9e2YK7vFrOaluzNDak
 xOA0mQ4h8XoWo6G0EMVSyi5NzB4AqpBkGLM7U3oHWHaiK+NTJGEzP0cb8EardNkJBphuV6Y
 sG1X+3pI4Ega1B3vt2xP0uL1KcFT32wuzCcm7U/ECvvLmY3BjNEIrY0EZLT6yLkoU7tfxNI
 c7opHN+N/DUy+xdRFOIkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C2ckw3j6Lic=:HG2S8i34G8th4UHFPnvftX
 1vvaTvaD9J18OYPQ3kkAIlF8JqTtAMAv5E4Dn2295Jq4cOWutPGW/Z0/lez2+uUF9lfHAWhNj
 EFN1/ATbVpsUeM0xcDS3I+0kLQ5r6kWZRt+Tz4nxbY72DA/XRAQ3xGzWopMcJkwLf1nFFECE7
 +GAlrxIAC8omzB1+j+RoI4s1jguOosyT1FYOTO/x3TlEVU1tBoyoTKKn6kQR1KqwbeVAkcYE6
 QcqyK1MNUpgyJOt5/XEtA4QLKtxtd+2wKWo3yObYM0n7jP2+9+kdorO7tB6AkTAXMrIbi+UDP
 C3pj1qvBojhWMMeXY4rvmpNC+NYGCQ13f/pDe9wLBzA6rDalMo4Wso4XgTl8DqyQRTfjWc6kY
 MYt67YCaWV6nkEPkUZ9KvkTL8c/WvM88HlXaulxc+qoindOCDelEvHwe25KHrOKzsKEg+cmR+
 rycHvwb5BC6V9CDCUbpF6HVZObVWEAMHwBB0nDWM0UNPjP76I3nSXT/YOCF+kC9BVtUepvx8b
 YI4dIImOVFxwDF/f6bL9XA55jKW9HuGTMQxuZT5i1FaQSE18iVLwo+FRGmxunEIKmwtF75bw2
 1BAdhc3LXP7E98HvqBU1PDaQHiFLbpQgH+5FBO72VApEYOTFFXEoCfC7EIyOe4+kIg4wImYXs
 vdtywP1WbvVvBEjB2ZdXyuLxcuqSRU87xZuCaz5WB2ky4/T6kndSpgvXHrJi2tfQsVB6GPLut
 N8aKxhuf+d0eHGRDWO49L7qfaXDNon79qj3HFVb+1CYU9jRQJn7vw9+DF2jzQWz93Vkwi1sSt
 wDPG7as8aIRF8OZmwUrYDNQlxa/I+dG3ZM/MaRWgP5t5rChFcNiBjZapoq9XOVeAniJJUzyx8
 QDU5VysyvitXT5UELAfV4z0BlG7TO9bkImIYUYFFVZZ7jNILGTYdLaujm0sh5G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add and use a function for loading the entries if a loose object
subdirectory for a given object ID.  It frees callers from deriving the
fanout key; they can use the returned oid_array reference for lookups or
forward range scans.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 object-store.h |  7 +++++++
 sha1-file.c    | 12 +++++++++---
 sha1-name.c    | 10 +++++-----
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/object-store.h b/object-store.h
index 60758efad8..7236c571c0 100644
--- a/object-store.h
+++ b/object-store.h
@@ -54,6 +54,13 @@ void add_to_alternates_memory(const char *dir);
  */
 void odb_load_loose_cache(struct object_directory *odb, int subdir_nr);
 
+/*
+ * Populate and return the loose object cache array corresponding to the
+ * given object ID.
+ */
+struct oid_array *odb_loose_cache(struct object_directory *odb,
+				  const struct object_id *oid);
+
 struct packed_git {
 	struct packed_git *next;
 	struct list_head mru;
diff --git a/sha1-file.c b/sha1-file.c
index 5a272f70de..cb8583b634 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -924,7 +924,6 @@ static int open_sha1_file(struct repository *r,
 static int quick_has_loose(struct repository *r,
 			   const unsigned char *sha1)
 {
-	int subdir_nr = sha1[0];
 	struct object_id oid;
 	struct object_directory *odb;
 
@@ -932,8 +931,7 @@ static int quick_has_loose(struct repository *r,
 
 	prepare_alt_odb(r);
 	for (odb = r->objects->odb; odb; odb = odb->next) {
-		odb_load_loose_cache(odb, subdir_nr);
-		if (oid_array_lookup(&odb->loose_objects_cache, &oid) >= 0)
+		if (oid_array_lookup(odb_loose_cache(odb, &oid), &oid) >= 0)
 			return 1;
 	}
 	return 0;
@@ -2152,6 +2150,14 @@ static int append_loose_object(const struct object_id *oid, const char *path,
 	return 0;
 }
 
+struct oid_array *odb_loose_cache(struct object_directory *odb,
+				  const struct object_id *oid)
+{
+	int subdir_nr = oid->hash[0];
+	odb_load_loose_cache(odb, subdir_nr);
+	return &odb->loose_objects_cache;
+}
+
 void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/sha1-name.c b/sha1-name.c
index b24502811b..a656481c6a 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -87,21 +87,21 @@ static int match_sha(unsigned, const unsigned char *, const unsigned char *);
 
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
-	int subdir_nr = ds->bin_pfx.hash[0];
 	struct object_directory *odb;
 
 	for (odb = the_repository->objects->odb;
 	     odb && !ds->ambiguous;
 	     odb = odb->next) {
 		int pos;
+		struct oid_array *loose_objects;
 
-		odb_load_loose_cache(odb, subdir_nr);
-		pos = oid_array_lookup(&odb->loose_objects_cache, &ds->bin_pfx);
+		loose_objects = odb_loose_cache(odb, &ds->bin_pfx);
+		pos = oid_array_lookup(loose_objects, &ds->bin_pfx);
 		if (pos < 0)
 			pos = -1 - pos;
-		while (!ds->ambiguous && pos < odb->loose_objects_cache.nr) {
+		while (!ds->ambiguous && pos < loose_objects->nr) {
 			const struct object_id *oid;
-			oid = odb->loose_objects_cache.oid + pos;
+			oid = loose_objects->oid + pos;
 			if (!match_sha(ds->len, ds->bin_pfx.hash, oid->hash))
 				break;
 			update_candidates(ds, oid);
-- 
2.20.1
