Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69081FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 17:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbdBJRb2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 12:31:28 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:51001 "EHLO
        homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751460AbdBJRb1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Feb 2017 12:31:27 -0500
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 67955348077
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 09:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=from
        :date:subject:to:content-transfer-encoding:message-id:
        mime-version; s=mattmccutchen.net; bh=mPLHNlnPC1K7BBHcuEtTEKgvyA
        4=; b=ESFSIy8Mdjon5rTNOzu4NgWNbJWV0ROOU3pJcq7zHvy9FKz6m0Ac8YdtI9
        UbDnR1BU8Hcdji8rXzUW20Baw0otn59mn9znIYoqJQ2VNAvJM6fLmdBq9/Tjw5jp
        F0VAlvS+PZXZdBJYf57VHQG043vqaZ+usOvjSYe+i5oAWE1G0=
Received: from main (30-86-202.dynamic.csail.mit.edu [128.30.86.202])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id 28A7034807B
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 09:30:30 -0800 (PST)
From:   Matt McCutchen <matt@mattmccutchen.net>
Date:   Fri, 10 Feb 2017 12:26:33 -0500
Subject: [PATCH] fetch: print an error when declining to request an
 unadvertised object
To:     git@vger.kernel.org
X-Mailer: Evolution 3.22.4 (3.22.4-2.fc25) 
Content-Transfer-Encoding: 7bit
Message-ID: <1486747828.17272.5.camel@mattmccutchen.net>
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently "git fetch REMOTE SHA1" silently exits 1 if the server doesn't
allow requests for unadvertised objects by sha1.  Change it to print a
meaningful error message.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---

The fetch code looks unbelievably complicated to me and I don't understand all
the cases that can arise.  Hopefully this patch is an acceptable solution to the
problem.

 fetch-pack.c          | 31 ++++++++++++++++---------------
 t/t5516-fetch-push.sh |  3 ++-
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 601f077..117874c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -598,23 +598,24 @@ static void filter_refs(struct fetch_pack_args *args,
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
+		if (ref->matched)
+			continue;
+		if (get_sha1_hex(ref->name, sha1) ||
+		    ref->name[40] != '\0' ||
+		    hashcmp(sha1, ref->old_oid.hash))
+			continue;
 
-			ref->matched = 1;
-			*newtail = copy_ref(ref);
-			newtail = &(*newtail)->next;
-		}
+		if (!(allow_unadvertised_object_request &
+		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1)))
+			die(_("Server does not allow request for unadvertised object %s"), ref->name);
+
+		ref->matched = 1;
+		*newtail = copy_ref(ref);
+		newtail = &(*newtail)->next;
 	}
 	*refs = newlist;
 }
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 0fc5a7c..177897e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1098,7 +1098,8 @@ test_expect_success 'fetch exact SHA1' '
 		test_must_fail git cat-file -t $the_commit &&
 
 		# fetching the hidden object should fail by default
-		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy &&
+		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
+		test_i18ngrep "Server does not allow request for unadvertised object" err &&
 		test_must_fail git rev-parse --verify refs/heads/copy &&
 
 		# the server side can allow it to succeed
-- 
2.9.3


