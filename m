Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8BB1FDEA
	for <e@80x24.org>; Tue,  9 May 2017 18:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754423AbdEISUt (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 14:20:49 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33629 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754543AbdEISUr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 14:20:47 -0400
Received: by mail-pg0-f45.google.com with SMTP id u187so3712061pgb.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xR6QtVWf7AngFF024gFK6jBQF7SdowgduQVeYaITHmw=;
        b=OhpfaPMt2qqhgdm+a3J2EgbmCbYw9zgP2wXrl4CB0SQlN9KcNTXQgGaoHuOGimkO0R
         QmzemPqWrlepAim51oUEAIXw7dcjIkj/XDH9kxPsqykjamDMnHRcSI73h9VMfa8Qa1r/
         CdYAoZ6Y4axes3gGkmkUbk/ntRt8iA+Ofe9Q5Y9/QbptH/UNf9AIrQDNxtc9X/UaUnRz
         pckAL2olZlsvulRKjQ3ZsWSnOoXhA+K7aKOUEji6w84DEbqXy27tej80l7adoWpH+vf/
         Mg6Idrn13TLqM44nQlYpdOG7EhvuMo6lUo1cqHVsXk4zozIwEG83SIVlUxtnZjAtsXqz
         y68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xR6QtVWf7AngFF024gFK6jBQF7SdowgduQVeYaITHmw=;
        b=j5o4wYk6gFOedz87zCTo0gF6Bp9BBg67OaexhArLeRSI2FsF6I4mY4Xjeu5YFOqYGQ
         ELUbc907qPSy1KSJS2oCZS4bt0bZU4KRzvZHX0ccBnrG2SvCjIJoUswJpjhQwp9WeYTQ
         fovSDrKsx7T67P/Sxdwai86ep5kEEB8X2jahPfYm5gFWOWpWzwdWas5PSp0oiUz194yY
         pbGvtAdJmZVbKF5s6hK4dqXghq0hCP7wvF+IBiNGtzLnYoB+aTGXeyFbT9hQ3cR9lNNQ
         ShNH1KoygP/+TKN1mzCkumVkBrh1iwDwoZyulHAs7KtzmxJvWxYlQG+aTT5muUfNqkkG
         Efng==
X-Gm-Message-State: AODbwcAt+RGwqGeaaheMGRY3PEviJUFYKlkpwola2KO9l/+fka73TqIM
        cLHDKSY3FQVde1Bq
X-Received: by 10.99.49.11 with SMTP id x11mr1634621pgx.128.1494354046798;
        Tue, 09 May 2017 11:20:46 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id n85sm1195951pfi.101.2017.05.09.11.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 11:20:45 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] fetch-pack: always allow fetching of literal SHA1s
Date:   Tue,  9 May 2017 11:20:42 -0700
Message-Id: <20170509182042.28389-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fetch-pack, when fetching a literal SHA-1 from a server that is not
configured with uploadpack.allowtipsha1inwant (or similar), always
returns an error message of the form "Server does not allow request for
unadvertised object %s". However, it is sometimes the case that such
object is advertised.

Teach fetch-pack to also check the SHA-1s of the refs in the received
ref advertisement if a literal SHA-1 was given by the user.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c          | 30 ++++++++++++++++--------------
 t/t5500-fetch-pack.sh |  6 ++++++
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index afb8b0502..180405dff 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -592,6 +592,14 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
 	}
 }
 
+static int is_literal_sha1(const struct ref *ref)
+{
+	struct object_id oid;
+	return !get_oid_hex(ref->name, &oid) &&
+	       !ref->name[40] &&
+	       !oidcmp(&oid, &ref->old_oid);
+}
+
 static void filter_refs(struct fetch_pack_args *args,
 			struct ref **refs,
 			struct ref **sought, int nr_sought)
@@ -601,7 +609,6 @@ static void filter_refs(struct fetch_pack_args *args,
 	struct ref *ref, *next;
 	int i;
 
-	i = 0;
 	for (ref = *refs; ref; ref = next) {
 		int keep = 0;
 		next = ref->next;
@@ -610,15 +617,14 @@ static void filter_refs(struct fetch_pack_args *args,
 		    check_refname_format(ref->name, 0))
 			; /* trash */
 		else {
-			while (i < nr_sought) {
-				int cmp = strcmp(ref->name, sought[i]->name);
-				if (cmp < 0)
-					break; /* definitely do not have it */
-				else if (cmp == 0) {
-					keep = 1; /* definitely have it */
-					sought[i]->match_status = REF_MATCHED;
+			for (i = 0; i < nr_sought; i++) {
+				struct ref *s = sought[i];
+				if (!strcmp(ref->name, s->name) ||
+				    (is_literal_sha1(s) &&
+				     !oidcmp(&ref->old_oid, &s->old_oid))) {
+					keep = 1;
+					s->match_status = REF_MATCHED;
 				}
-				i++;
 			}
 		}
 
@@ -637,14 +643,10 @@ static void filter_refs(struct fetch_pack_args *args,
 
 	/* Append unmatched requests to the list */
 	for (i = 0; i < nr_sought; i++) {
-		unsigned char sha1[20];
-
 		ref = sought[i];
 		if (ref->match_status != REF_NOT_MATCHED)
 			continue;
-		if (get_sha1_hex(ref->name, sha1) ||
-		    ref->name[40] != '\0' ||
-		    hashcmp(sha1, ref->old_oid.hash))
+		if (!is_literal_sha1(ref))
 			continue;
 
 		if ((allow_unadvertised_object_request &
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index b5865b385..d87983bc2 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -547,6 +547,12 @@ test_expect_success 'fetch-pack can fetch a raw sha1' '
 	git fetch-pack hidden $(git -C hidden rev-parse refs/hidden/one)
 '
 
+test_expect_success 'fetch-pack can fetch a raw sha1 that is advertised as a ref' '
+	git init server &&
+	test_commit -C server 4 &&
+	git fetch-pack server $(git -C server rev-parse refs/heads/master)
+'
+
 check_prot_path () {
 	cat >expected <<-EOF &&
 	Diag: url=$1
-- 
2.13.0.rc2.291.g57267f2277-goog

