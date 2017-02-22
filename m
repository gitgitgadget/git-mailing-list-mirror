Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5557B201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 16:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbdBVQT7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 11:19:59 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:34791 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932452AbdBVQTx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 11:19:53 -0500
Received: from homiemail-a1.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id BF4A7C1D7B
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 08:19:25 -0800 (PST)
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 62C8834807B
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 08:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:in-reply-to:references:from:date:subject:to
        :content-transfer-encoding:mime-version; s=mattmccutchen.net;
         bh=J6xL7h0c5+0Nb0WN3U0hyIJogCg=; b=NLVQnsLoQx5sODXfnNxsKTKA3DyP
        2oEyDgEWHFUo4AoY4FwBMJ7N3HCVh2TjAly6ENG7JfoOcn1EqecALZxhumeo1OH+
        NqLHUGMfaXi+MXRoYJ3wQPEUZpYI2xovv9opv2kj+IbzdB3+FNka05sNMQTOlzQL
        8dSn8Gy+hKCQt5k=
Received: from main (30-86-202.dynamic.csail.mit.edu [128.30.86.202])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id 2AAE734807A
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 08:18:25 -0800 (PST)
Message-Id: <1c4a008bc43fe38da97359692bf3a30fb57ce10c.1487779910.git.matt@mattmccutchen.net>
In-Reply-To: <xmqqvas4gie9.fsf@gitster.mtv.corp.google.com>
References: <xmqqvas4gie9.fsf@gitster.mtv.corp.google.com>
From:   Matt McCutchen <matt@mattmccutchen.net>
Date:   Wed, 22 Feb 2017 11:05:57 -0500
Subject: [PATCH 3/3] fetch-pack: add specific error for fetching an
 unadvertised object
To:     git@vger.kernel.org
X-Mailer: Evolution 3.22.4 (3.22.4-2.fc25) 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enhance filter_refs (which decides whether a request for an unadvertised
object should be sent to the server) to record a new match status on the
"struct ref" when a request is not allowed, and have
report_unmatched_refs check for this status and print a special error
message, "Server does not allow request for unadvertised object".
---
 fetch-pack.c          | 42 +++++++++++++++++++++++++++---------------
 remote.h              |  9 +++++++--
 t/t5516-fetch-push.sh |  2 +-
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 7c8d44c..f12bfcd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -578,7 +578,7 @@ static void filter_refs(struct fetch_pack_args *args,
 					break; /* definitely do not have it */
 				else if (cmp == 0) {
 					keep = 1; /* definitely have it */
-					sought[i]->matched = 1;
+					sought[i]->match_status = REF_MATCHED;
 				}
 				i++;
 			}
@@ -598,22 +598,24 @@ static void filter_refs(struct fetch_pack_args *args,
 	}
 
 	/* Append unmatched requests to the list */
-	if ((allow_unadvertised_object_request &
-	    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
-		for (i = 0; i < nr_sought; i++) {
-			unsigned char sha1[20];
+	for (i = 0; i < nr_sought; i++) {
+		unsigned char sha1[20];
 
-			ref = sought[i];
-			if (ref->matched)
-				continue;
-			if (get_sha1_hex(ref->name, sha1) ||
-			    ref->name[40] != '\0' ||
-			    hashcmp(sha1, ref->old_oid.hash))
-				continue;
+		ref = sought[i];
+		if (ref->match_status != REF_NOT_MATCHED)
+			continue;
+		if (get_sha1_hex(ref->name, sha1) ||
+		    ref->name[40] != '\0' ||
+		    hashcmp(sha1, ref->old_oid.hash))
+			continue;
 
-			ref->matched = 1;
+		if ((allow_unadvertised_object_request &
+		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
+			ref->match_status = REF_MATCHED;
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
+		} else {
+			ref->match_status = REF_UNADVERTISED_NOT_ALLOWED;
 		}
 	}
 	*refs = newlist;
@@ -1100,9 +1102,19 @@ int report_unmatched_refs(struct ref **sought, int nr_sought)
 	int i, ret = 0;
 
 	for (i = 0; i < nr_sought; i++) {
-		if (!sought[i] || sought[i]->matched)
+		if (!sought[i])
 			continue;
-		error(_("no such remote ref %s"), sought[i]->name);
+		switch (sought[i]->match_status) {
+		case REF_MATCHED:
+			continue;
+		case REF_NOT_MATCHED:
+			error(_("no such remote ref %s"), sought[i]->name);
+			break;
+		case REF_UNADVERTISED_NOT_ALLOWED:
+			error(_("Server does not allow request for unadvertised object %s"),
+			      sought[i]->name);
+			break;
+		}
 		ret = 1;
 	}
 	return ret;
diff --git a/remote.h b/remote.h
index 9248811..0b9d8c4 100644
--- a/remote.h
+++ b/remote.h
@@ -89,8 +89,13 @@ struct ref {
 		force:1,
 		forced_update:1,
 		expect_old_sha1:1,
-		deletion:1,
-		matched:1;
+		deletion:1;
+
+	enum {
+		REF_NOT_MATCHED = 0, /* initial value */
+		REF_MATCHED,
+		REF_UNADVERTISED_NOT_ALLOWED
+	} match_status;
 
 	/*
 	 * Order is important here, as we write to FETCH_HEAD
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 0d13a45..78f3b8e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1099,7 +1099,7 @@ test_expect_success 'fetch exact SHA1' '
 
 		# fetching the hidden object should fail by default
 		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
-		test_i18ngrep "no such remote ref" err &&
+		test_i18ngrep "Server does not allow request for unadvertised object" err &&
 		test_must_fail git rev-parse --verify refs/heads/copy &&
 
 		# the server side can allow it to succeed
-- 
2.9.3


