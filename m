Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1961B1F461
	for <e@80x24.org>; Tue, 14 May 2019 12:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfENMEd (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:04:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:56816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726075AbfENMEd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:04:33 -0400
Received: (qmail 4202 invoked by uid 109); 14 May 2019 12:04:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 12:04:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12251 invoked by uid 111); 14 May 2019 12:05:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 08:05:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 08:04:31 -0400
Date:   Tue, 14 May 2019 08:04:31 -0400
From:   Jeff King <peff@peff.net>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/2] help_unknown_ref(): duplicate collected refnames
Message-ID: <20190514120430.GA27229@sigill.intra.peff.net>
References: <20190514120220.GA7714@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514120220.GA7714@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "git merge" sees an unknown refname, we iterate through the refs to
try to suggest some possible alternates. We do so with for_each_ref(),
and in the callback we add some of the refnames we get to a
string_list that is declared with NODUP, directly adding a pointer into
the refname string our callback received.

But the for_each_ref() machinery does not promise that the refname
string will remain valid, and as a result we may print garbage memory.

The code in question dates back to its inception in e56181060e (help:
add help_unknown_ref(), 2013-05-04). But back then, the refname strings
generally did remain stable, at least immediately after the
for_each_ref() call. Later, in d1cf15516f (packed_ref_iterator_begin():
iterate using `mmapped_ref_iterator`, 2017-09-25), we started
consistently re-using a separate buffer for packed refs.

The fix is simple: duplicate the strings we intend to collect. We
already call string_list_clear(), so the memory is correctly freed.

Signed-off-by: Jeff King <peff@peff.net>
---
 help.c           |  2 +-
 t/t7600-merge.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/help.c b/help.c
index a9e451f2ee..d3b3f64e3c 100644
--- a/help.c
+++ b/help.c
@@ -766,7 +766,7 @@ static int append_similar_ref(const char *refname, const struct object_id *oid,
 static struct string_list guess_refs(const char *ref)
 {
 	struct similar_ref_cb ref_cb;
-	struct string_list similar_refs = STRING_LIST_INIT_NODUP;
+	struct string_list similar_refs = STRING_LIST_INIT_DUP;
 
 	ref_cb.base_ref = ref;
 	ref_cb.similar_refs = &similar_refs;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 7f9c68cbe7..7551ae3488 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -867,4 +867,18 @@ test_expect_success EXECKEEPSPID 'killed merge can be completed with --continue'
 	verify_parents $c0 $c1
 '
 
+test_expect_success 'merge suggests matching remote refname' '
+	git commit --allow-empty -m not-local &&
+	git update-ref refs/remotes/origin/not-local HEAD &&
+	git reset --hard HEAD^ &&
+
+	# This is white-box testing hackery; we happen to know
+	# that reading packed refs is more picky about the memory
+	# ownership of strings we pass to for_each_ref() callbacks.
+	git pack-refs --all --prune &&
+
+	test_must_fail git merge not-local 2>stderr &&
+	grep origin/not-local stderr
+'
+
 test_done
-- 
2.21.0.1388.g2b1efd806f

