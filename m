Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7E0201A7
	for <e@80x24.org>; Mon, 15 May 2017 17:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758426AbdEORce (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 13:32:34 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34376 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbdEORcc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 13:32:32 -0400
Received: by mail-pg0-f54.google.com with SMTP id u28so63402070pgn.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hOMto+hxe+yGzwSabLU/HcrQ/qmTJcIId1reHcL1eyU=;
        b=U2onsl1iM5Xt9ir2OaHI3fLqn4R3V+VD8WGFj5V5YSCbVm0IC5aZareeJuxJQqcEEF
         n/eATo9G6UbMbfRzKPyisuenI7ZUjdHkL+qEQ77KmThFyT5zElBNgkEzrL8l8Nt1f/PV
         r5N+4yFPVnkQssTe5CqQEvsyODmO+HQzoL0nNiqdYhU941WEvSUjuiqdFS0ZgvCR0g1e
         yTDwQEw2OVWKRRtJrgswvyfWIuz31YZZ9ZulaaAnA8eCH5sot2YGU7Cq4dcsRbd6IFOB
         abFXecPjWwvFR9wOfa1QcvoX+U1a5nreY7Ts7y8/PA41vBR3Po7bkH2caROANSGobbUy
         Z1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hOMto+hxe+yGzwSabLU/HcrQ/qmTJcIId1reHcL1eyU=;
        b=n+CRY3MZllPtMtBsVUHlauTaeHCnu84QRO/J7RRNijA+PzNcKS2SG7XDjfNgBV8WDu
         o+0YwSUKeTZsGN92KN2ffm+NRsPoNmoBE8MVMCwijN4Zrf6ks9eE9K8gGLSLcGCLtwEB
         h9v6JDqclyK1f+PpTv67JoyMe9swNqx1ZABT2Aze/UF8mJK96nOnpPBdvzHC3EfgjV1D
         P6rWAXWAgE+0Y3IfYRcWNENjjynTV59hFPCIUSc3SbT4JEZbCJ1ipQ+CwCgln811kQ6I
         rvYV/hT2Wc7V+EmgZIfARY2J70V4OJDPgwWLvtUHrhBW8GbymHHkeCcf5Zew3FVICTeZ
         n4hA==
X-Gm-Message-State: AODbwcD4KavwIUhep/J/CGQJFX9NTRJrhfKxvo3KVgSEzJTyFA42nkFM
        x9OtL/2Pyeme2Wjp
X-Received: by 10.99.173.71 with SMTP id y7mr7261533pgo.3.1494869551738;
        Mon, 15 May 2017 10:32:31 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k192sm21886833pgc.31.2017.05.15.10.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 10:32:30 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        peff@peff.net, gitster@pobox.com
Subject: [PATCH v7] fetch-pack: always allow fetching of literal SHA1s
Date:   Mon, 15 May 2017 10:32:20 -0700
Message-Id: <20170515173220.13103-1-jonathantanmy@google.com>
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

OK, one combined function (for lazy initialization and checking
containment in the oidset) with comment it is.

Change from v6: changed back to "tip_oids_contain", and included Peff's
comment.
---
 fetch-pack.c          | 40 ++++++++++++++++++++++++++++++++++++++--
 t/t5500-fetch-pack.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index afb8b0502..703e7ec78 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -15,6 +15,7 @@
 #include "version.h"
 #include "prio-queue.h"
 #include "sha1-array.h"
+#include "oidset.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -592,13 +593,38 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
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
+	/*
+	 * Note that this only looks at the ref lists the first time it's
+	 * called. This works out in filter_refs() because even though it may
+	 * add to "newlist" between calls, the additions will always be for
+	 * oids that are already in the set.
+	 */
+	if (!tip_oids->map.tablesize) {
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
@@ -631,7 +657,8 @@ static void filter_refs(struct fetch_pack_args *args,
 			ref->next = NULL;
 			newtail = &ref->next;
 		} else {
-			free(ref);
+			ref->next = unmatched;
+			unmatched = ref;
 		}
 	}
 
@@ -648,7 +675,9 @@ static void filter_refs(struct fetch_pack_args *args,
 			continue;
 
 		if ((allow_unadvertised_object_request &
-		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
+		     (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1)) ||
+		    tip_oids_contain(&tip_oids, unmatched, newlist,
+				     &ref->old_oid)) {
 			ref->match_status = REF_MATCHED;
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
@@ -656,6 +685,13 @@ static void filter_refs(struct fetch_pack_args *args,
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

