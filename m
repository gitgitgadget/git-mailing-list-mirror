Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A29B20188
	for <e@80x24.org>; Wed, 10 May 2017 22:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754500AbdEJWME (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 18:12:04 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33221 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754400AbdEJWMC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 18:12:02 -0400
Received: by mail-pg0-f44.google.com with SMTP id u187so4367917pgb.0
        for <git@vger.kernel.org>; Wed, 10 May 2017 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G9vIDnAlbpxCMKj7qF0qnsRsz2X/gLMRqqJfXJhyb5Y=;
        b=NTpdNNhu9AHwhb9Tie/3zvUS4H7wQcMcbtofNmW57D3OlKL2K6q1G7t6xKjzfVZZ+j
         W2OZgflIia1Hmjd5d3dulvHy4bfPptk4ttx0875+yFGXNbLMrNejXlmv/6CuXhfeY/RJ
         0JIGZN9Outl1O6HSoKzs3JlrDzhZgil6w/vYh5oZPDNQWGupuTPBbn90SqHD2Xwf35iO
         vRCVFTiOMBgv24sE48j2vOti5ZOW410VYeiES8SrxgOcA1aVfIvXVnB+Z9kOcubFKgJg
         KTdfIeDHK8Rcz6xMFGguPtk1eDjYzAv5E3gKfisO2U6pidFM596P1Dmpz9np4gjEZXB1
         VIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G9vIDnAlbpxCMKj7qF0qnsRsz2X/gLMRqqJfXJhyb5Y=;
        b=IiiB0VO711o9kXVj0rVuLyymxErmlFy2qVAvIu2O8QvEScbelPT18gYv5X+fEK/SLh
         RtLhIY5SaJFCAmfKZjDEPsASWFovP0FXafWXGjXcgxTjgrSCsQNx0rOP4hSpHxQBVJT+
         GyIFV/mYHzrRYgnPXfRHpQ+Mn8uuQ++P3GtQg3Omy1tnda8gjPlkU4/u1lht4CXXsYTU
         ytvkeGslxRLk4bI3COipjlzMPTul3sO2NLolrCXw7SmcFNSXoO7BXicGsEJTHOdpuK6b
         5U22zofCs0Rc1tmH+LMYBmd0IbRfRI6YabPYvoXFrkvKvT9fqzCMwRYO75p+/UcUHji7
         EJQw==
X-Gm-Message-State: AODbwcCBhrN+4H16vUKtLhtpXE2l4XfYAmZIupW8EVXQIGF3SN9wV0tX
        0cEvDKJ70s2oclCz
X-Received: by 10.84.134.35 with SMTP id 32mr11088570plg.178.1494454321703;
        Wed, 10 May 2017 15:12:01 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id t187sm195543pfb.116.2017.05.10.15.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 May 2017 15:12:00 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        peff@peff.net, spearce@spearce.org
Subject: [PATCH v3] fetch-pack: always allow fetching of literal SHA1s
Date:   Wed, 10 May 2017 15:11:57 -0700
Message-Id: <20170510221157.8971-1-jonathantanmy@google.com>
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

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

Reviewers, note that the patch has been substantially rewritten.

After looking at ways to solve jrnieder's performance concerns, if we're
going to need to manage one more item of state within the function, I
might as well use my earlier idea of storing unmatched refs in its own
list instead of immediately freeing them. This version of the patch
should have much better performance characteristics.

I have also added the test requested by jrnieder (to show that
fetch-pack cannot fetch a SHA-1 if it is not advertised as a ref).

 fetch-pack.c          | 29 ++++++++++++++++++++++++++++-
 t/t5500-fetch-pack.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index afb8b0502..5cace7458 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -598,6 +598,7 @@ static void filter_refs(struct fetch_pack_args *args,
 {
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
+	struct ref *unmatched = NULL;
 	struct ref *ref, *next;
 	int i;
 
@@ -631,13 +632,15 @@ static void filter_refs(struct fetch_pack_args *args,
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
@@ -649,6 +652,25 @@ static void filter_refs(struct fetch_pack_args *args,
 
 		if ((allow_unadvertised_object_request &
 		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
+			can_append = 1;
+		} else {
+			struct ref *u;
+			/* Check all refs, including those already matched */
+			for (u = unmatched; u; u = u->next) {
+				if (!oidcmp(&ref->old_oid, &u->old_oid)) {
+					can_append = 1;
+					goto can_append;
+				}
+			}
+			for (u = newlist; u; u = u->next) {
+				if (!oidcmp(&ref->old_oid, &u->old_oid)) {
+					can_append = 1;
+					break;
+				}
+			}
+		}
+can_append:
+		if (can_append) {
 			ref->match_status = REF_MATCHED;
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
@@ -657,6 +679,11 @@ static void filter_refs(struct fetch_pack_args *args,
 		}
 	}
 	*refs = newlist;
+
+	for (ref = unmatched; ref; ref = next) {
+		next = ref->next;
+		free(ref);
+	}
 }
 
 static void mark_alternate_complete(struct object *obj)
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

