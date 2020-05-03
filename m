Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D46DC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8EA20787
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgECJNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 05:13:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:35012 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727116AbgECJNL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 05:13:11 -0400
Received: (qmail 21759 invoked by uid 109); 3 May 2020 09:13:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 May 2020 09:13:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4815 invoked by uid 111); 3 May 2020 09:13:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 03 May 2020 05:13:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 3 May 2020 05:13:09 -0400
From:   Jeff King <peff@peff.net>
To:     clime <clime7@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: [PATCH 2/2] ref-filter: apply fallback refname sort only after all
 user sorts
Message-ID: <20200503091309.GB170902@coredump.intra.peff.net>
References: <20200503090952.GA170768@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200503090952.GA170768@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 9e468334b4 (ref-filter: fallback on alphabetical comparison,
2015-10-30) taught ref-filter's sort to fallback to comparing refnames.
But it did it at the wrong level, overriding the comparison result for a
single "--sort" key from the user, rather than after all sort keys have
been exhausted.

This worked correctly for a single "--sort" option, but not for multiple
ones. We'd break any ties in the first key with the refname and never
evaluate the second key at all.

To make matters even more interesting, we only applied this fallback
sometimes! For a field like "taggeremail" which requires a string
comparison, we'd truly return the result of strcmp(), even if it was 0.
But for numerical "value" fields like "taggerdate", we did apply the
fallback. And that's why our multiple-sort test missed this: it uses
taggeremail as the main comparison.

So let's start by adding a much more rigorous test. We'll have a set of
commits expressing every combination of two tagger emails, dates, and
refnames. Then we can confirm that our sort is applied with the correct
precedence, and we'll be hitting both the string and value comparators.

That does show the bug, and the fix is simple: moving the fallback to
the outer compare_refs() function, after all ref_sorting keys have been
exhausted.

Note that in the outer function we don't have an "ignore_case" flag, as
it's part of each individual ref_sorting element. It's debatable what
such a fallback should do, since we didn't use the user's keys to match.
But until now we have been trying to respect that flag, so the
least-invasive thing is to try to continue to do so. Since all callers
in the current code either set the flag for all keys or for none, we can
just pull the flag from the first key. In a hypothetical world where the
user really can flip the case-insensitivity of keys separately, we may
want to extend the code to distinguish that case from a blanket
"--ignore-case".

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c            |  7 ++++--
 t/t6300-for-each-ref.sh | 54 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index bdb3535ce5..bf7b70299b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2295,7 +2295,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 		if (va->value < vb->value)
 			cmp = -1;
 		else if (va->value == vb->value)
-			cmp = cmp_fn(a->refname, b->refname);
+			cmp = 0;
 		else
 			cmp = 1;
 	}
@@ -2314,7 +2314,10 @@ static int compare_refs(const void *a_, const void *b_, void *ref_sorting)
 		if (cmp)
 			return cmp;
 	}
-	return 0;
+	s = ref_sorting;
+	return s && s->ignore_case ?
+		strcasecmp(a->refname, b->refname) :
+		strcmp(a->refname, b->refname);
 }
 
 void ref_sorting_icase_all(struct ref_sorting *sorting, int flag)
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index c9caf26327..da59fadc5d 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -650,17 +650,59 @@ test_atom refs/tags/signed-long contents "subject line
 body contents
 $sig"
 
-sort >expected <<EOF
-$(git rev-parse refs/tags/bogo) <committer@example.com> refs/tags/bogo
-$(git rev-parse refs/tags/master) <committer@example.com> refs/tags/master
-EOF
+test_expect_success 'set up multiple-sort tags' '
+	for when in 100000 200000
+	do
+		for email in user1 user2
+		do
+			for ref in ref1 ref2
+			do
+				GIT_COMMITTER_DATE="@$when +0000" \
+				GIT_COMMITTER_EMAIL="$email@example.com" \
+				git tag -m "tag $ref-$when-$email" \
+				multi-$ref-$when-$email || return 1
+			done
+		done
+	done
+'
 
 test_expect_success 'Verify sort with multiple keys' '
-	git for-each-ref --format="%(objectname) %(taggeremail) %(refname)" --sort=objectname --sort=taggeremail \
-		refs/tags/bogo refs/tags/master > actual &&
+	cat >expected <<-\EOF &&
+	100000 <user1@example.com> refs/tags/multi-ref2-100000-user1
+	100000 <user1@example.com> refs/tags/multi-ref1-100000-user1
+	100000 <user2@example.com> refs/tags/multi-ref2-100000-user2
+	100000 <user2@example.com> refs/tags/multi-ref1-100000-user2
+	200000 <user1@example.com> refs/tags/multi-ref2-200000-user1
+	200000 <user1@example.com> refs/tags/multi-ref1-200000-user1
+	200000 <user2@example.com> refs/tags/multi-ref2-200000-user2
+	200000 <user2@example.com> refs/tags/multi-ref1-200000-user2
+	EOF
+	git for-each-ref \
+		--format="%(taggerdate:unix) %(taggeremail) %(refname)" \
+		--sort=-refname \
+		--sort=taggeremail \
+		--sort=taggerdate \
+		"refs/tags/multi-*" >actual &&
 	test_cmp expected actual
 '
 
+test_expect_success 'equivalent sorts fall back on refname' '
+	cat >expected <<-\EOF &&
+	100000 <user1@example.com> refs/tags/multi-ref1-100000-user1
+	100000 <user2@example.com> refs/tags/multi-ref1-100000-user2
+	100000 <user1@example.com> refs/tags/multi-ref2-100000-user1
+	100000 <user2@example.com> refs/tags/multi-ref2-100000-user2
+	200000 <user1@example.com> refs/tags/multi-ref1-200000-user1
+	200000 <user2@example.com> refs/tags/multi-ref1-200000-user2
+	200000 <user1@example.com> refs/tags/multi-ref2-200000-user1
+	200000 <user2@example.com> refs/tags/multi-ref2-200000-user2
+	EOF
+	git for-each-ref \
+		--format="%(taggerdate:unix) %(taggeremail) %(refname)" \
+		--sort=taggerdate \
+		"refs/tags/multi-*" >actual &&
+	test_cmp expected actual
+'
 
 test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 	test_when_finished "git checkout master" &&
-- 
2.26.2.957.g6dc93e954a
