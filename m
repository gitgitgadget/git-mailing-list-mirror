Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030EA201A0
	for <e@80x24.org>; Thu, 11 May 2017 22:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756232AbdEKWbB (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 18:31:01 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34912 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdEKWbA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 18:31:00 -0400
Received: by mail-pg0-f44.google.com with SMTP id q125so1579509pgq.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=watZjRhV8Ss6UDLdn/6qkgZDA/4WUdaCJBSU6RVI1HM=;
        b=E2PeJK6htZ6I4ynMQHTatq7mGtQ2WLm9DQUGmxgY9ZJxsKEoe86+9XiX48lrgDuZYw
         hRn7LOCY5b0YPhpR2JkriDdDC5WgeeUoifGY8rIYoKfT+FzaQv/2AGd5BG8QdQ3KyRac
         DH6DODNaUhbp5i96NdfYjAsc/JbqJVNLiuSlek0mNDqLJIv8yiZHHBnLTwiqqMFSiKZW
         ccNKSqG63J78wOwIQWX59xoyOaiI2X8SVkv66t4+Ef86i1IFKh9FPSRlQiq986zh5DKx
         E6309T8DPyyV2Zx0k9b3EtIideOlqa8ksYpHt1AmjEcidX5SZ4YoTbxIIJgw+JdcBNGa
         /g6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=watZjRhV8Ss6UDLdn/6qkgZDA/4WUdaCJBSU6RVI1HM=;
        b=T8gN0EQH4E6LXzKufHDwcu5dKlnu9R9ZDcJmTrmsClVlJPW5My2EAGiHx6LLI1yRMQ
         35hCPcbot6KHSujlziyiqrnRGD4u8ZEev4bCjl0k/NVoudtQ3jYO1BKnSkMA0+Ut1ghu
         uE/zx3m82KhFAhAXlSxMTR/jVExrYBsBRdAmr8Xn3Dvqguo4laG5zAvfNxCAWji/5F3v
         LOmX3ST9dld9ztsdocbyD4DEcGmf/48CKIwrKz1GLRGLMB42vPtbYsth+noj1N7sCc9H
         g4nNDKLJ6ebBw5As8CoLpZaN+R/+Y6s+qAQ1tekatkPyZk//EDXla8hnh+lzDcNQVU3A
         y1qA==
X-Gm-Message-State: AODbwcCM5lzzRen+Nvrh3HU8DaipShL013S68Z0jIiGSCctcd0KMyCpk
        WZKmxf2nvD6LOCxY
X-Received: by 10.99.4.3 with SMTP id 3mr884466pge.86.1494541859812;
        Thu, 11 May 2017 15:30:59 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id b90sm1926987pfj.19.2017.05.11.15.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 15:30:58 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v5] fetch-pack: always allow fetching of literal SHA1s
Date:   Thu, 11 May 2017 15:30:54 -0700
Message-Id: <20170511223054.25239-1-jonathantanmy@google.com>
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

Change from v4: incorporated Jonathan Nieder's suggestion about using
another function. There is no oidset_is_empty, so I checked for a
presence of a member variable instead.
---
 fetch-pack.c          | 34 ++++++++++++++++++++++++++++++++--
 t/t5500-fetch-pack.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index afb8b0502..9dd430a65 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -15,6 +15,7 @@
 #include "version.h"
 #include "prio-queue.h"
 #include "sha1-array.h"
+#include "oidset.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -592,13 +593,32 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
 	}
 }
 
+static void add_refs_to_oidset(struct oidset *oids, struct ref *refs)
+{
+	for (; refs; refs = refs->next)
+		oidset_insert(oids, &refs->old_oid);
+}
+
+static int tip_oids_contain(struct oidset *tip_oids,
+			    struct ref *unmatched, struct ref *newlist,
+			    const struct object_id *id)
+{
+	if (!tip_oids->map.cmpfn) {
+		add_refs_to_oidset(tip_oids, unmatched);
+		add_refs_to_oidset(tip_oids, newlist);
+	}
+	return oidset_contains(tip_oids, id);
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
 	int i;
 
 	i = 0;
@@ -631,7 +651,8 @@ static void filter_refs(struct fetch_pack_args *args,
 			ref->next = NULL;
 			newtail = &ref->next;
 		} else {
-			free(ref);
+			ref->next = unmatched;
+			unmatched = ref;
 		}
 	}
 
@@ -648,7 +669,9 @@ static void filter_refs(struct fetch_pack_args *args,
 			continue;
 
 		if ((allow_unadvertised_object_request &
-		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
+		     (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1)) ||
+		    tip_oids_contain(&tip_oids, unmatched, newlist,
+				     &ref->old_oid)) {
 			ref->match_status = REF_MATCHED;
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
@@ -656,6 +679,13 @@ static void filter_refs(struct fetch_pack_args *args,
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

