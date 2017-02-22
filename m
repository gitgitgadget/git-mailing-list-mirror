Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8923201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 17:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933070AbdBVR3q (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 12:29:46 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:53034 "EHLO
        homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932663AbdBVR3n (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 12:29:43 -0500
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id F32E2348070
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 09:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:in-reply-to:references:from:date:subject:to
        :content-transfer-encoding:mime-version; s=mattmccutchen.net;
         bh=ql7nxByH9Sh72+cPrTRDsw5JW0c=; b=dVFFhBaG3hoPM1a5V0i/xzFk1FNG
        wEpOmF1eyY4KtaIP9562d9y2Xl1zr7Oezpm5+B7TdGStGpb/6NeXAzKqqN3ktxV4
        SMEy1vnCXAZh/ptdmsstHwTWXj5xt0cQ7Z9If5cltSbPGaNpqFXCVf95n5KW1dZr
        IwmZByqQtR8CvCk=
Received: from main (30-86-202.dynamic.csail.mit.edu [128.30.86.202])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id B29BA34806F
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 09:29:42 -0800 (PST)
Message-Id: <4ab6641448d0905bda0f55a62c134886d94714ff.1487784184.git.matt@mattmccutchen.net>
In-Reply-To: <xmqqpoiacfqw.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoiacfqw.fsf@gitster.mtv.corp.google.com>
From:   Matt McCutchen <matt@mattmccutchen.net>
Date:   Wed, 22 Feb 2017 11:05:57 -0500
Subject: [PATCH v2 3/3] fetch-pack: add specific error for fetching an
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

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
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


