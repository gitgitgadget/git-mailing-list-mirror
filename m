Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F440201A0
	for <e@80x24.org>; Thu, 11 May 2017 21:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752954AbdEKVOU (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 17:14:20 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33752 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdEKVOT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 17:14:19 -0400
Received: by mail-pf0-f174.google.com with SMTP id e193so19614888pfh.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 14:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bP3Qv4BGoCRDZjDNZ/MBlap2aimcgkA9xGzghM/8NQg=;
        b=Wcn2+OqSsUjLqEdxO0Qz8b1w2HXEnrpYeOYF9ppLTgW5+H6Q3egx5YuLrdvAt5Obu+
         b1Q1XTjHAUkobMuWhTfRe4sazl0vXFa1B44W6DRilmH4gwTB0qgmQXSrNrTSi/ZeEIqN
         kf0fT8VahvXXqj8yxTFzxqKzOsCXH5u04pId9VP/4ZGIvFbu2sV1MoY41w1PInuS7t8Z
         dlMiMiZoXJcF4xCnYNDtBINTinLdkKUBTX2aY7Bx6hdNecM7XSD41jDKSOmpEvY8Yt4R
         FCCoFPAp8bSjv1zgYYXfxgCO0jzYd/BoyLLWH6/rIG5ZUErd21AwOqR5oW9MmuA7cVKH
         uklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bP3Qv4BGoCRDZjDNZ/MBlap2aimcgkA9xGzghM/8NQg=;
        b=IIpPAASSJrr/z5YkBKhhHhyDyRqKZEMxgY/YimKApEbnawle6fFfc8enlF3m+AOS5x
         S3vDQ21JZwwNoF9SX+Y1LJk2mb8TFaRFP4Wnm/ESdEdmWN7DAsWEAN815gWzIGL2RjGd
         VLG6BQyQ6thIDcUNXsRNqHD6ZSdmWq0xVB2rMwwNEpCLWxQj4+rt2XngiMEyxlG/Fryz
         DCX324BgxPDg84jMRsjecI1YHaic5SzR9/2zJk5vmS6GNXscntbOGOH5nd5W5T1RBITA
         9EnDdRVwrNLVNLfC7LPmboL4MdxTWVGk6Nsl7pSsZ7ss/4WVvDFoKzo+bd5b7V9v8Is4
         tCiQ==
X-Gm-Message-State: AODbwcCkx7aRK8BTKLjoS/G1ou9prfHVgXsqvMR0Qne41/TC+xutF3he
        FSwQQXt0vBprLWE4
X-Received: by 10.84.174.197 with SMTP id r63mr702380plb.67.1494537248463;
        Thu, 11 May 2017 14:14:08 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id q64sm2035466pfi.69.2017.05.11.14.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 14:14:07 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v4] fetch-pack: always allow fetching of literal SHA1s
Date:   Thu, 11 May 2017 14:14:03 -0700
Message-Id: <20170511211403.5252-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170509182042.28389-1-jonathantanmy@google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fetch-pack, when fetching a literal SHA-1 from a server that is not
configured with uploadpack.allowtipsha1inwant (or similar), always
returns an error message of the form "Server does not allow request for
unadvertised object %s". However, it is sometimes the case that such
object is advertised. This situation would occur, for example, if a user
or a script was provided a SHA-1 instead of a branch or tag name for
fetching, and wanted to invoke "git fetch" or "git fetch-pack" using
that SHA-1.

Teach fetch-pack to also check the SHA-1s of the refs in the received
ref advertisement if a literal SHA-1 was given by the user.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

Thanks, peff. I've incorporated your suggestions - I don't feel very
strongly about this, but I guess it's worthwhile to avoid the quadratic
behavior if we can.

Also incorporated Jonathan Nieder's suggestion about the placement of
the last line. The relevant function is also factored out (following
peff's suggestion).
---
 fetch-pack.c          | 36 +++++++++++++++++++++++++++++++++++-
 t/t5500-fetch-pack.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index afb8b0502..1adb1a6c2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -15,6 +15,7 @@
 #include "version.h"
 #include "prio-queue.h"
 #include "sha1-array.h"
+#include "oidset.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -592,13 +593,22 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
 	}
 }
 
+static void add_refs_to_oidset(struct oidset *oids, const struct ref *refs)
+{
+	for (; refs; refs = refs->next)
+		oidset_insert(oids, &refs->old_oid);
+}
+
 static void filter_refs(struct fetch_pack_args *args,
 			struct ref **refs,
 			struct ref **sought, int nr_sought)
 {
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
+	struct ref *unmatched = NULL;
 	struct ref *ref, *next;
+	struct oidset tip_oids = OIDSET_INIT;
+	int tip_oids_initialized = 0;
 	int i;
 
 	i = 0;
@@ -631,13 +641,15 @@ static void filter_refs(struct fetch_pack_args *args,
 			ref->next = NULL;
 			newtail = &ref->next;
 		} else {
-			free(ref);
+			ref->next = unmatched;
+			unmatched = ref;
 		}
 	}
 
 	/* Append unmatched requests to the list */
 	for (i = 0; i < nr_sought; i++) {
 		unsigned char sha1[20];
+		int can_append = 0;
 
 		ref = sought[i];
 		if (ref->match_status != REF_NOT_MATCHED)
@@ -649,6 +661,21 @@ static void filter_refs(struct fetch_pack_args *args,
 
 		if ((allow_unadvertised_object_request &
 		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
+			can_append = 1;
+		} else {
+			if (!tip_oids_initialized) {
+				/*
+				 * Check all refs, including those already
+				 * matched
+				 */
+				add_refs_to_oidset(&tip_oids, unmatched);
+				add_refs_to_oidset(&tip_oids, newlist);
+				tip_oids_initialized = 1;
+			}
+			can_append = oidset_contains(&tip_oids, &ref->old_oid);
+		}
+
+		if (can_append) {
 			ref->match_status = REF_MATCHED;
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
@@ -656,6 +683,13 @@ static void filter_refs(struct fetch_pack_args *args,
 			ref->match_status = REF_UNADVERTISED_NOT_ALLOWED;
 		}
 	}
+
+	oidset_clear(&tip_oids);
+	for (ref = unmatched; ref; ref = next) {
+		next = ref->next;
+		free(ref);
+	}
+
 	*refs = newlist;
 }
 
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index b5865b385..80a1a3239 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -547,6 +547,41 @@ test_expect_success 'fetch-pack can fetch a raw sha1' '
 	git fetch-pack hidden $(git -C hidden rev-parse refs/hidden/one)
 '
 
+test_expect_success 'fetch-pack can fetch a raw sha1 that is advertised as a ref' '
+	rm -rf server client &&
+	git init server &&
+	test_commit -C server 1 &&
+
+	git init client &&
+	git -C client fetch-pack ../server \
+		$(git -C server rev-parse refs/heads/master)
+'
+
+test_expect_success 'fetch-pack can fetch a raw sha1 overlapping a named ref' '
+	rm -rf server client &&
+	git init server &&
+	test_commit -C server 1 &&
+	test_commit -C server 2 &&
+
+	git init client &&
+	git -C client fetch-pack ../server \
+		$(git -C server rev-parse refs/tags/1) refs/tags/1
+'
+
+test_expect_success 'fetch-pack cannot fetch a raw sha1 that is not advertised as a ref' '
+	rm -rf server &&
+
+	git init server &&
+	test_commit -C server 5 &&
+	git -C server tag -d 5 &&
+	test_commit -C server 6 &&
+
+	git init client &&
+	test_must_fail git -C client fetch-pack ../server \
+		$(git -C server rev-parse refs/heads/master^) 2>err &&
+	test_i18ngrep "Server does not allow request for unadvertised object" err
+'
+
 check_prot_path () {
 	cat >expected <<-EOF &&
 	Diag: url=$1
-- 
2.13.0.rc2.291.g57267f2277-goog

