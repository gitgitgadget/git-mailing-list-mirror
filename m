Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E68F20248
	for <e@80x24.org>; Sat, 13 Apr 2019 05:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfDMF5j (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 01:57:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:57224 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725776AbfDMF5j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 01:57:39 -0400
Received: (qmail 27797 invoked by uid 109); 13 Apr 2019 05:57:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Apr 2019 05:57:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12692 invoked by uid 111); 13 Apr 2019 05:58:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Apr 2019 01:58:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Apr 2019 01:57:37 -0400
Date:   Sat, 13 Apr 2019 01:57:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 7/7] fetch: do not consider peeled tags as advertised tips
Message-ID: <20190413055736.GG19495@sigill.intra.peff.net>
References: <20190413055127.GA32340@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190413055127.GA32340@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our filter_refs() function accidentally considers the target of a peeled
tag to be advertised by the server, even though upload-pack on the
server side does not consider it so. This can result in the client
making a bogus fetch to the server, which will end with the server
complaining "not our ref". Whereas the correct behavior is for the
client to notice that the server will not allow the request and error
out immediately.

So as bugs go, this is not very serious (the outcome is the same either
way -- the fetch fails). But it's worth making the logic here correct
and consistent with other related cases (e.g., fetching an oid that the
server did not mention at all).

The crux of the issue comes from fdb69d33c4 (fetch-pack: always allow
fetching of literal SHA1s, 2017-05-15). After that, the strategy of
filter_refs() is basically:

  - for each advertised ref, try to match it with a "sought" ref
    provided by the user. Skip any malformed refs (which includes
    peeled values like "refs/tags/foo^{}"), and place any unmatched
    items onto the unmatched list.

  - if there are unmatched sought refs, then put all of the advertised
    tips into an oidset, including the unmatched ones.

  - for each sought ref, see if it's in the oidset, in which case it's
    legal for us to ask the server for it

The problem is in the second step. Our list of unmatched refs includes
the peeled refs, even though upload-pack does not allow them to be
directly fetched. So the simplest fix would be to exclude them during
that step.

However, we can observe that the unmatched list isn't used for anything
else, and is freed at the end. We can just free those malformed refs
immediately. That saves us having to check each ref a second time to see
if it's malformed.

Note that this code only kicks in when "strict" is in effect. I.e., if
we are using the v0 protocol and uploadpack.allowReachableSHA1InWant is
not in effect. With v2, all oids are allowed, and we do not bother
creating or consulting the oidset at all. To future-proof our test
against the upcoming GIT_TEST_PROTOCOL_VERSION flag, we'll manually mark
it as a v0-only test.

Signed-off-by: Jeff King <peff@peff.net>
---
We actually discussed this a while ago in:

  https://public-inbox.org/git/20180611044710.GB31642@sigill.intra.peff.net/

and the surrounding thread. I'm not convinced that upload-pack
shouldn't be considering the peeled values as ref tips, but given that
we have never done so, it's probably not worth making that change now.
Clients couldn't rely on it without a capability marker, and all of this
goes away in the v2 protocol anyway.

 fetch-pack.c          | 11 ++++++++---
 t/t5516-fetch-push.sh | 11 +++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a181d3401d..bb8eac8126 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -573,9 +573,14 @@ static void filter_refs(struct fetch_pack_args *args,
 		next = ref->next;
 
 		if (starts_with(ref->name, "refs/") &&
-		    check_refname_format(ref->name, 0))
-			; /* trash */
-		else {
+		    check_refname_format(ref->name, 0)) {
+			/*
+			 * trash or a peeled value; do not even add it to
+			 * unmatched list
+			 */
+			free_one_ref(ref);
+			continue;
+		} else {
 			while (i < nr_sought) {
 				int cmp = strcmp(ref->name, sought[i]->name);
 				if (cmp < 0)
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 98ef71b48c..4f065212b8 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1273,6 +1273,17 @@ test_expect_success 'fetch follows tags by default' '
 	test_cmp expect actual
 '
 
+test_expect_success 'peeled advertisements are not considered ref tips' '
+	mk_empty testrepo &&
+	git -C testrepo commit --allow-empty -m one &&
+	git -C testrepo commit --allow-empty -m two &&
+	git -C testrepo tag -m foo mytag HEAD^ &&
+	oid=$(git -C testrepo rev-parse mytag^{commit}) &&
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+		git fetch testrepo $oid 2>err &&
+	test_i18ngrep "Server does not allow request for unadvertised object" err
+'
+
 test_expect_success 'pushing a specific ref applies remote.$name.push as refmap' '
 	mk_test testrepo heads/master &&
 	rm -fr src dst &&
-- 
2.21.0.931.gd0bc72a411
