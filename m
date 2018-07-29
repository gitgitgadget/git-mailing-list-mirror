Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9313D208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 19:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeG2U7k (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 16:59:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39400 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbeG2U7k (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Jul 2018 16:59:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e88b:d3b1:c008:ba22])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BB8186073B;
        Sun, 29 Jul 2018 19:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532892489;
        bh=CBC8tLlKJU7GQDkfx9VRrSsf90WBucD4JZgoDtwypfE=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bxLz3TfjBIS993YHkfuUzB+7+QtdIhilFMEyTBKVbkaqrRqKUTSi9HyfsMp9m/j9y
         riSbh7GHW9rkd6GUETSCfd2jBdSvAVk009s4gqe1hNR1plcu5JonPgEh7r9oHeyHBS
         IBMrj9F8vBBC81a7WZ1R7MqJdkeiDGYT/RWmp55js14jRKhhfbRBJD+csJ8FJxLck2
         U65n8CMZbyRThEuWxt+F0ECYbb/6wdNOeLjse6utT3a+utsE2QMQsogKg5RBdxUSee
         sPRbZ7px4/dqNqtmtmak3/WmGIeFUqpsD65avm2p08KsS/IKdxrfuDzrA2BTdoSYCR
         sgvrcYVJjDB6xw5ySEB6yvr+zq7pi32AdkUXZHsM29Do8G/FIiq0AcIedRvdnhMLmB
         ZCNWH/5zxUqyBFIUovjVycdw56VgJAHicNiVBLnvRFv0sj9/c+xSPDNiJVxl8FhbMy
         7BXS8Hkj5kAWXztv50Ofrc9d9tGKzF9Bo9WggJnRF6Id6EV9ntq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>
Subject: [PATCH] refspec: allow @ on the left-hand side of refspecs
Date:   Sun, 29 Jul 2018 19:28:03 +0000
Message-Id: <20180729192803.1047050-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The object ID parsing machinery is aware of "@" as a synonym for "HEAD"
and this is documented accordingly in gitrevisions(7).  The push
documentation describes the source portion of a refspec as "any
arbitrary 'SHA-1 expression'"; however, "@" is not allowed on the
left-hand side of a refspec, since we attempt to check for it being a
valid ref name and fail (since it is not).

Teach the refspec machinery about this alias and silently substitute
"HEAD" when we see "@".  This handles the fact that HEAD is a symref and
preserves its special behavior.  We need not handle other arbitrary
object ID expressions (such as "@^") when pushing because the revision
machinery already handles that for us.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I probably type "git push upstream HEAD" from five to thirty times a
day, many of those where I typo "HEAD", so I decided to implement the
shorter form.  This design handles @ as HEAD in both fetch and push,
whereas alternate solutions would not.

check_refname_format explicitly rejects "@"; I tried at first to simply
ignore that with a flag, but we end up calling that from several other
places in the codebase and rejecting it and all of those places would
have needed updating.

I thought about putting the if/else logic in a function, but since it's
just four lines, I decided not to.  However, if people think it would be
tidier, I can do so.

Note that the test portion of the patch is best read with git diff -w;
the current version is very noisy.

 refspec.c             |   6 ++-
 t/t5516-fetch-push.sh | 104 +++++++++++++++++++++---------------------
 2 files changed, 58 insertions(+), 52 deletions(-)

diff --git a/refspec.c b/refspec.c
index e8010dce0c..57c2f65104 100644
--- a/refspec.c
+++ b/refspec.c
@@ -62,8 +62,12 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		return 0;
 	}
 
+	if (llen == 1 && lhs[0] == '@')
+		item->src = xstrdup("HEAD");
+	else
+		item->src = xstrndup(lhs, llen);
+
 	item->pattern = is_glob;
-	item->src = xstrndup(lhs, llen);
 	flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
 
 	if (fetch) {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index a5077d8b7c..cbccbd2f8d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -436,70 +436,72 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
 
 '
 
-test_expect_success 'push with HEAD' '
+for ref in HEAD @
+do
+	test_expect_success "push with $ref" '
 
-	mk_test testrepo heads/master &&
-	git checkout master &&
-	git push testrepo HEAD &&
-	check_push_result testrepo $the_commit heads/master
+		mk_test testrepo heads/master &&
+		git checkout master &&
+		git push testrepo $ref &&
+		check_push_result testrepo $the_commit heads/master
 
-'
+	'
 
-test_expect_success 'push with HEAD nonexisting at remote' '
+	test_expect_success "push with $ref nonexisting at remote" '
 
-	mk_test testrepo heads/master &&
-	git checkout -b local master &&
-	git push testrepo HEAD &&
-	check_push_result testrepo $the_commit heads/local
-'
+		mk_test testrepo heads/master &&
+		git checkout -B local master &&
+		git push testrepo $ref &&
+		check_push_result testrepo $the_commit heads/local
+	'
 
-test_expect_success 'push with +HEAD' '
+	test_expect_success "push with +$ref" '
 
-	mk_test testrepo heads/master &&
-	git checkout master &&
-	git branch -D local &&
-	git checkout -b local &&
-	git push testrepo master local &&
-	check_push_result testrepo $the_commit heads/master &&
-	check_push_result testrepo $the_commit heads/local &&
+		mk_test testrepo heads/master &&
+		git checkout master &&
+		git branch -D local &&
+		git checkout -b local &&
+		git push testrepo master local &&
+		check_push_result testrepo $the_commit heads/master &&
+		check_push_result testrepo $the_commit heads/local &&
 
-	# Without force rewinding should fail
-	git reset --hard HEAD^ &&
-	test_must_fail git push testrepo HEAD &&
-	check_push_result testrepo $the_commit heads/local &&
+		# Without force rewinding should fail
+		git reset --hard HEAD^ &&
+		test_must_fail git push testrepo $ref &&
+		check_push_result testrepo $the_commit heads/local &&
 
-	# With force rewinding should succeed
-	git push testrepo +HEAD &&
-	check_push_result testrepo $the_first_commit heads/local
+		# With force rewinding should succeed
+		git push testrepo +$ref &&
+		check_push_result testrepo $the_first_commit heads/local
 
-'
+	'
 
-test_expect_success 'push HEAD with non-existent, incomplete dest' '
+	test_expect_success "push $ref with non-existent, incomplete dest" '
 
-	mk_test testrepo &&
-	git checkout master &&
-	git push testrepo HEAD:branch &&
-	check_push_result testrepo $the_commit heads/branch
+		mk_test testrepo &&
+		git checkout master &&
+		git push testrepo $ref:branch &&
+		check_push_result testrepo $the_commit heads/branch
 
-'
+	'
 
-test_expect_success 'push with config remote.*.push = HEAD' '
-
-	mk_test testrepo heads/local &&
-	git checkout master &&
-	git branch -f local $the_commit &&
-	(
-		cd testrepo &&
-		git checkout local &&
-		git reset --hard $the_first_commit
-	) &&
-	test_config remote.there.url testrepo &&
-	test_config remote.there.push HEAD &&
-	test_config branch.master.remote there &&
-	git push &&
-	check_push_result testrepo $the_commit heads/master &&
-	check_push_result testrepo $the_first_commit heads/local
-'
+	test_expect_success "push with config remote.*.push = $ref" '
+		mk_test testrepo heads/local &&
+		git checkout master &&
+		git branch -f local $the_commit &&
+		(
+			cd testrepo &&
+			git checkout local &&
+			git reset --hard $the_first_commit
+		) &&
+		test_config remote.there.url testrepo &&
+		test_config remote.there.push $ref &&
+		test_config branch.master.remote there &&
+		git push &&
+		check_push_result testrepo $the_commit heads/master &&
+		check_push_result testrepo $the_first_commit heads/local
+	'
+done
 
 test_expect_success 'push with remote.pushdefault' '
 	mk_test up_repo heads/master &&
