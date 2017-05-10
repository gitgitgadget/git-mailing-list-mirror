Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EA1220188
	for <e@80x24.org>; Wed, 10 May 2017 16:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbdEJQoo (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 12:44:44 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34488 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbdEJQon (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 12:44:43 -0400
Received: by mail-pf0-f170.google.com with SMTP id e64so539637pfd.1
        for <git@vger.kernel.org>; Wed, 10 May 2017 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jDKBfYGzXTQ2PDAzDSzDRlucggLitr86OHWhIPjS67s=;
        b=u8mttZnVD5514zzWSZAutMtkoeTqWlfxIV0fZq/IGmMHDeCjDUJj6K67SLs6eGiOJC
         5yGNtzWaQDCtZCh0c3zQoIEC17a8Ue/P5xOr8X7ljiWZRfDQ3ZhdWdvbQq5zFHB+wdOL
         QsYmnTLCNDpm94k6h2uQ2HjTCSDtWkc/RqZ5Yql0ITpCVsR/SDaPsFqrC0O+sdngdCj3
         fqPWhAxYSkE7uT9Oi7qLj8K9goYYiHqqbj1lMxrHHgsgtPa1DwkdrKGrIJObKwzmsvv0
         Pc5PJp+HqmcN+isS6fTUwoguUgxCIu5tKGAbvBBW96/bgKFJ4bTagg0GnputDfhoVlU5
         j/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jDKBfYGzXTQ2PDAzDSzDRlucggLitr86OHWhIPjS67s=;
        b=PN1PDNVkQ4Z9lWq2UpBS8Z4VUye+bb8kFWKqoMO9n+cLABhaVkyr6Ok0A7gMKfgFQm
         Y6qYXZ/DZ2+fNH7UVGLeH7XgxsGxJSbDpM4NhCRlDh7AA8UOLU7JpHHcUC18guVZAqPc
         QsuapzgOPwRA21ztDyiT9c+PO+uF+rIyvwbuCW0vLZaA6a0XIuAMRGlGSCstqIz7BaJU
         7sSC5yjjuQrdC8wHwhkCQL8YXjUF1V+J78k1plmBuW4fQUDiOyWNqhy1drwNSlJbf1/6
         KksKHRzzngv613oS9lXpy26U5plZKGqkF3Fh/zKH5SriucwqOetpiCzTjwlA48ejYPM/
         3Uig==
X-Gm-Message-State: AODbwcAq9SMxqyIV/4ydJ9valFSX7gT4lKUz9r9OURew3k3VBxeRDf3s
        hpK8CN5rjQFG4baP
X-Received: by 10.99.147.5 with SMTP id b5mr7394304pge.218.1494434682152;
        Wed, 10 May 2017 09:44:42 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id n65sm6920972pga.8.2017.05.10.09.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 May 2017 09:44:40 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, spearce@spearce.org,
        peff@peff.net
Subject: [PATCH v2] fetch-pack: always allow fetching of literal SHA1s
Date:   Wed, 10 May 2017 09:44:32 -0700
Message-Id: <20170510164432.5447-1-jonathantanmy@google.com>
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

Thanks, peff, for your suggestions. Changes from v1:
 - updated commit message to explain a bit of the context
 - use parse_oid_hex instead of get_oid_hex to avoid the constant 40

peff also suggested a possible optimization in computing is_literal_sha1
outside the loop. After some thought, I don't think that it takes that
much time in the general case where the ref name starts with "refs/",
because parse_oid_hex will see the "r" (which is not in "[0-9a-f]") and
immediately return. So I left it as-is.

 fetch-pack.c          | 31 +++++++++++++++++--------------
 t/t5500-fetch-pack.sh |  6 ++++++
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index afb8b0502..d4b57b9ba 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -592,6 +592,15 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
 	}
 }
 
+static int is_literal_sha1(const struct ref *ref)
+{
+	struct object_id oid;
+	const char *end;
+	return !parse_oid_hex(ref->name, &oid, &end) &&
+	       !*end &&
+	       !oidcmp(&oid, &ref->old_oid);
+}
+
 static void filter_refs(struct fetch_pack_args *args,
 			struct ref **refs,
 			struct ref **sought, int nr_sought)
@@ -601,7 +610,6 @@ static void filter_refs(struct fetch_pack_args *args,
 	struct ref *ref, *next;
 	int i;
 
-	i = 0;
 	for (ref = *refs; ref; ref = next) {
 		int keep = 0;
 		next = ref->next;
@@ -610,15 +618,14 @@ static void filter_refs(struct fetch_pack_args *args,
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
 
@@ -637,14 +644,10 @@ static void filter_refs(struct fetch_pack_args *args,
 
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

