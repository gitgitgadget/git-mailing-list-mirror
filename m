Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3721420705
	for <e@80x24.org>; Fri,  9 Sep 2016 17:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753594AbcIIRhA (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 13:37:00 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33732 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbcIIRgw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 13:36:52 -0400
Received: by mail-pf0-f179.google.com with SMTP id g202so31501206pfb.0
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YmnaeZYpQ7mTIjH+/cjxBidEggqaalL4vsj9d1Bkuws=;
        b=J7znNVK6pi7ktxn1CsI1fGdRroD5oItZRLrUV5sCFAxHb2IYEa5Q20HU4qrRt2Ajhx
         looHuolW6M+We+fEGmWbGYxYTLJ5pvba6dXJtz+OO5mJ+aKE1UBpOcaKu+rBgYLIHj+n
         dk8pvk+nIJaEN01kULHxUDs7Ulq+5e8MUesdxccEFXV69cWXAhiUlo2/2OvL2ThizLKG
         K4pjXXINLjgtMhfUKF8uMhbkMgCob0yGT8V+mXbqpVMD+1p0g9vVjd46X0pbaVP3Nf+4
         NCwoJEz8UL73x0o/Gi4MP2N8tIeCOrv6PkEorkfwBqOHTdo9SKNAeV938yk970eC3LRh
         s6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YmnaeZYpQ7mTIjH+/cjxBidEggqaalL4vsj9d1Bkuws=;
        b=MvKvQuEICl8tiP7ahmTorrf5KAkgobPTJns3dyJETooDfXfWx7z1pRGQ2sDEaX8JEn
         NPiD53p3TdBJHVudHYQ5YYiurCpGYttsZK//OblA7601ANWe1/xFIExoKw5Unz/Bpzzo
         jsL6TWWIC6REKBvwqNwiWCZciNMKuvdAgw89l+NoGIHvJby8OdSImAN4UaXUXbAdLoun
         QSdHQPbHBTW93XT56yIYD8Z75gbatJ+iC3Evny7ympaHmsAwG2JOPD8kSPMWttZWP6C1
         9o55B99KxiAtYqkjinJ9L3oBgHP2kscMsV3eCcx7IKFfQX3vERHdgqJ3vPZKeQTwaHN8
         qjyw==
X-Gm-Message-State: AE9vXwPvUPQYTqA9O6Z2GoOCCRSr7nV4c7XFK9Juo8jE+ylmZ04n19kX4ViIV9jYak7ZKaOh
X-Received: by 10.98.32.200 with SMTP id m69mr8548444pfj.15.1473442611565;
        Fri, 09 Sep 2016 10:36:51 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id d5sm6759803pfc.4.2016.09.09.10.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Sep 2016 10:36:50 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>, spearce@spearce.org,
        sbeller@google.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 2/3] connect: tighten check for unexpected early hang up
Date:   Fri,  9 Sep 2016 10:36:29 -0700
Message-Id: <691658f3d805e3d8515e7b05f7f46d969b9bb301.1473441620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1473441620.git.jonathantanmy@google.com>
References: <cover.1473441620.git.jonathantanmy@google.com>
In-Reply-To: <cover.1473441620.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com> <cover.1473441620.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

A server hanging up immediately to mark access being denied does not
send any .have refs, shallow lines, or anything else before hanging
up.  If the server has sent anything, then the hangup is unexpected.

That is, if the server hangs up after a shallow line but before sending
any refs, then git should tell me so:

	fatal: The remote end hung up upon initial contact

instead of suggesting an access control problem:

	fatal: Could not read from remote repository.
	Please make sure you have the correct access rights
	and the repository exists.

Noticed while examining this code.  This case isn't likely to come up
in practice but tightening the check makes the code easier to read and
manipulate.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 connect.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index 722dc3f..0c01a49 100644
--- a/connect.c
+++ b/connect.c
@@ -43,9 +43,9 @@ int check_ref_type(const struct ref *ref, int flags)
 	return check_ref(ref->name, flags);
 }
 
-static void die_initial_contact(int got_at_least_one_head)
+static void die_initial_contact(int unexpected)
 {
-	if (got_at_least_one_head)
+	if (unexpected)
 		die("The remote end hung up upon initial contact");
 	else
 		die("Could not read from remote repository.\n\n"
@@ -115,10 +115,17 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			      struct sha1_array *shallow_points)
 {
 	struct ref **orig_list = list;
-	int got_at_least_one_head = 0;
+
+	/*
+	 * A hang-up after seeing some response from the other end
+	 * means that it is unexpected, as we know the other end is
+	 * willing to talk to us.  A hang-up before seeing any
+	 * response does not necessarily mean an ACL problem, though.
+	 */
+	int saw_response;
 
 	*list = NULL;
-	for (;;) {
+	for (saw_response = 0; ; saw_response = 1) {
 		struct ref *ref;
 		struct object_id old_oid;
 		char *name;
@@ -131,7 +138,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 				  PACKET_READ_GENTLE_ON_EOF |
 				  PACKET_READ_CHOMP_NEWLINE);
 		if (len < 0)
-			die_initial_contact(got_at_least_one_head);
+			die_initial_contact(saw_response);
 
 		if (!len)
 			break;
@@ -171,7 +178,6 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		oidcpy(&ref->old_oid, &old_oid);
 		*list = ref;
 		list = &ref->next;
-		got_at_least_one_head = 1;
 	}
 
 	annotate_refs_with_symref_info(*orig_list);
-- 
2.8.0.rc3.226.g39d4020

