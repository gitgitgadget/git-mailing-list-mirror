Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE3C81F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 20:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754756AbcIIURt (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 16:17:49 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34716 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754169AbcIIURp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 16:17:45 -0400
Received: by mail-pa0-f42.google.com with SMTP id to9so31397457pac.1
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 13:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YmnaeZYpQ7mTIjH+/cjxBidEggqaalL4vsj9d1Bkuws=;
        b=DHTgEJfWPNobQr12QCX3c2ifwrZrLn5Cg6dvjVxEK4QnetPfzdvfoqWsfAAepNDogD
         ALTObvdj1vszmKKkf4yf4OsU6yo4VrK29IOznx1Yo6La1C1kbPUWBM94le7tbo44nX7h
         hqzsCYJFCWIOafdmK1wqzaWqeJXG2dfzUiP3DGckM+5S4zlbEEi7H8iPdIcBK7GDCRX2
         wdJmdCWCWG75EQV88+quCK/wlxvSkE2HymXMaexjARJdW4aLJ2nBfIYE1+qeecLDkrDw
         hivETMxU7HmlwuHhWW48qKmiSruupsAKrjzGFXDrBjcjJmawKIkkVFt4WXiuzwpudLQL
         DStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YmnaeZYpQ7mTIjH+/cjxBidEggqaalL4vsj9d1Bkuws=;
        b=Wi4Rolib5w5kyzqVfLIFOGDEClJa3ZkwNX/bKwgbbWJNep3HuVR6AtPeE+hibDk8Km
         G/6d+HPfwalyRDqTU4EgqAcFryLwQiLX+zX3jwhA+RnS9Zk8J2UdPTMIWUrqno0slAqo
         O15W9wPdahAeQTLGRJ5WF3oAYRgXGFUNVtxbiAH4HYHua43PdMR9yTA+tHc0+J6H0a/z
         Do7BP4w+fNN5IosQ1EuC8IJoVn6nsKwNNETI39A2WrVCkt+jzHvkUQ5D3Z5UHO9zm6s5
         WHwqwkUzD08et/mAdrcpCdgv/JvX30xHi3e6w14uFlu4wQjZr4Vqfbr0O3SCVyaBNvFR
         opuQ==
X-Gm-Message-State: AE9vXwO5OYtdtFyQ9Z5nkAE/z77LTpDtpZGoJtHFzcJXVlYmygb+CXua7nv8ioiETsoU1N8a
X-Received: by 10.66.160.226 with SMTP id xn2mr8734112pab.41.1473452264714;
        Fri, 09 Sep 2016 13:17:44 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id s1sm7203690paz.47.2016.09.09.13.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Sep 2016 13:17:43 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>, gitster@pobox.com
Subject: [PATCH v5 2/3] connect: tighten check for unexpected early hang up
Date:   Fri,  9 Sep 2016 13:17:36 -0700
Message-Id: <691658f3d805e3d8515e7b05f7f46d969b9bb301.1473452153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1473452153.git.jonathantanmy@google.com>
References: <cover.1473452153.git.jonathantanmy@google.com>
In-Reply-To: <cover.1473452153.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com> <cover.1473452153.git.jonathantanmy@google.com>
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

