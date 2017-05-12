Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505D1201A7
	for <e@80x24.org>; Fri, 12 May 2017 20:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758084AbdELUp5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 16:45:57 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34903 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756671AbdELUp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 16:45:56 -0400
Received: by mail-pg0-f43.google.com with SMTP id q125so15766905pgq.2
        for <git@vger.kernel.org>; Fri, 12 May 2017 13:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3hIHyGCLJCUKVO1YDvo1a/wVHd8GC1OJxj7cvNbpt7g=;
        b=jnqHI9Z1AGUVCgx0KXIqKLOJqm1Ss3JCWdn9loBZbIoqE0AWUILZ5tktVHpDwDU0JK
         /BG5CszoxvKTF3sw9MNOwhpRY2Xo50PykPDpBjXnzFUGS0I3ZiBzvqobs2kjgcXsyn6N
         lx6hg2Wqe+bVcrsxDWEA/vAcCLYqKbweT5k1q/8AN/QIFtIxl0rSNe/QCHrMUXzeRjwg
         9t/uth/ZaA3joZkbiJK5WQ4slTjQIn4iKLdu6ZHXPp09rhH0FYdhUT64FPnIiK0xHIPy
         fkdXTeexyEDeewp3+ysWvvaLvKOmSAL5nRi5gqT0wzt99OhH+H6KIIFb4k9YAyU5efxj
         cGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3hIHyGCLJCUKVO1YDvo1a/wVHd8GC1OJxj7cvNbpt7g=;
        b=UFrXXC8+6Qv69ANRwa2Q3OgKDHx63yFgGwh4CSzN7g38kX534gg2nuwTRL5AC0rvZM
         /xev9bYKQVIJXVQdHU/WMfRXCoYIRosYzAkUCmLFWAVPyygHsWbvAVQ75GaM9Aijzmbb
         60Z1k/qjhfuHWuIRBEV5RBCAOQlKu9eegeSccFer5zmYbd2cRxHOXMFV8LzUTRaPh/DH
         u+ILA6PE6iBg4o3oxMOBVq5s052QLbQRzZNsz8a5vqdMhdIwRTbhLNNfagIxvSDN32Qm
         kdWU2hR5xrww/abuL56G+4QDxLnuwV30p/BcOx5mjtV5PLcYtzPBKOw5cgYg/M31VclU
         iCdg==
X-Gm-Message-State: AODbwcB+r3sMDUxYcGCm4l0+DuZVpNZi4bsdkpFUJpkyp35p+62x8BlM
        tYQufmBPoD4fwucb
X-Received: by 10.99.55.65 with SMTP id g1mr6425238pgn.208.1494621955547;
        Fri, 12 May 2017 13:45:55 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id l85sm7038084pfg.123.2017.05.12.13.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 May 2017 13:45:54 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        peff@peff.net, gitster@pobox.com
Subject: [PATCH v5] fetch-pack: always allow fetching of literal SHA1s
Date:   Fri, 12 May 2017 13:45:50 -0700
Message-Id: <20170512204550.10373-1-jonathantanmy@google.com>
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

Change from v5: used "ensure_tip_oids_initialized" function instead.
This removes some of the muddiness (e.g. with newlist being modified
after the function).

I used an "int" return type for ensure_tip_oids_initialized so that I
could chain with "&&", but "void" and chaining with "," is also possible
(but I don't see much use of the comma operator in Git code).
---
 fetch-pack.c          | 35 +++++++++++++++++++++++++++++++++--
 t/t5500-fetch-pack.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index afb8b0502..f05f48d7b 100644
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
+static int ensure_tip_oids_initialized(struct oidset *tip_oids,
+				       struct ref *unmatched,
+				       struct ref *newlist)
+{
+	if (!tip_oids->map.tablesize) {
+		add_refs_to_oidset(tip_oids, unmatched);
+		add_refs_to_oidset(tip_oids, newlist);
+	}
+	return 1;
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
 
@@ -648,7 +669,10 @@ static void filter_refs(struct fetch_pack_args *args,
 			continue;
 
 		if ((allow_unadvertised_object_request &
-		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
+		     (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1)) ||
+		    (ensure_tip_oids_initialized(&tip_oids, unmatched,
+						 newlist) &&
+		     oidset_contains(&tip_oids, &ref->old_oid))) {
 			ref->match_status = REF_MATCHED;
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
@@ -656,6 +680,13 @@ static void filter_refs(struct fetch_pack_args *args,
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

