Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AC821F462
	for <e@80x24.org>; Thu, 23 May 2019 06:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfEWGLY (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 02:11:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:36710 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726070AbfEWGLY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 02:11:24 -0400
Received: (qmail 7649 invoked by uid 109); 23 May 2019 06:11:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 May 2019 06:11:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27860 invoked by uid 111); 23 May 2019 06:12:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 23 May 2019 02:12:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 May 2019 02:11:21 -0400
Date:   Thu, 23 May 2019 02:11:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: [PATCH v2] upload-pack: strip namespace from symref data
Message-ID: <20190523061121.GB20871@sigill.intra.peff.net>
References: <CAGyf7-Ew8rS8n67Few9+dT6VXy9rQbaYLswuZkQ3-4j_T_d=qg@mail.gmail.com>
 <20190521214630.GD14807@sigill.intra.peff.net>
 <20190522043146.GA2563@sigill.intra.peff.net>
 <875zq2vkvf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875zq2vkvf.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 22, 2019 at 12:33:56PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Likely nobody noticed because bug (1) means that from the client's
> > perspective, we did not report on HEAD at all. And thus it uses the
> > pre-7171d8c15f fallback code to guess the correct HEAD, which is usually
> > right. It only falls down in ambiguous cases (like the one laid out in
> > the included test).
> 
> ...because here you're talking about "the client's perspective" and "it
> uses the pre-7171d8c15f [...] code", but this should say "the
> pre-a45b5f0552 code", i.e. mention the commit that changed the *client*
> logic.

Heh. I actually found this split, too, while digging in the history, but
thought it might be adding distracting details to the commit message.
But hey, if you're gonna read them _carefully_, I guess I can be more
precise. ;)

The fallback code isn't even from a45b5f0552; it's much older than that.
We started looking at ref annotations at all in fbb074c253 (remote: make
guess_remote_head() use exact HEAD lookup if it is available,
2009-02-27). The guessing code that falls back to comes from 8434c2f1af
(Build in clone, 2008-04-27).  I didn't bother finding the true origin
in the shell script. ;)

So instead of mentioning it at the top (because the bug really is just
on the server side), I re-wrote the paragraph about the client a little
more clearly and precisely:

    Likely nobody noticed because we tend to do the right thing anyway. Bug
    (1) means that we said nothing about HEAD (just refs/namespace/foo/HEAD).
    And so the client half of the code, from a45b5f0552 (connect: annotate
    refs with their symref information in get_remote_head(), 2013-09-17),
    does not annotate HEAD, and we use the fallback in guess_remote_head(),
    matching refs by object id. Which is usually right. It only falls down
    in ambiguous cases, like the one laid out in the included test.

Revised patch below.

-- >8 --
Subject: [PATCH] upload-pack: strip namespace from symref data

Since 7171d8c15f (upload-pack: send symbolic ref information as
capability, 2013-09-17), we've sent cloning and fetching clients special
information about which branch HEAD is pointing to, so that they don't
have to guess based on matching up commit ids.

However, this feature has never worked properly with the GIT_NAMESPACE
feature.  Because upload-pack uses head_ref_namespaced(find_symref), we
do find and report on refs/namespaces/foo/HEAD instead of the actual
HEAD of the repo. This makes sense, since the branch pointed to by the
top-level HEAD may not be advertised at all. But we do two things wrong:

  1. We report the full name refs/namespaces/foo/HEAD, instead of just
     HEAD. Meaning no client is going to bother doing anything with that
     symref, since we're not otherwise advertising it.

  2. We report the symref destination using its full name (e.g.,
     refs/namespaces/foo/refs/heads/master). That's similarly useless to
     the client, who only saw "refs/heads/master" in the advertisement.

We should be stripping the namespace prefix off of both places (which
this patch fixes).

Likely nobody noticed because we tend to do the right thing anyway. Bug
(1) means that we said nothing about HEAD (just refs/namespace/foo/HEAD).
And so the client half of the code, from a45b5f0552 (connect: annotate
refs with their symref information in get_remote_head(), 2013-09-17),
does not annotate HEAD, and we use the fallback in guess_remote_head(),
matching refs by object id. Which is usually right. It only falls down
in ambiguous cases, like the one laid out in the included test.

This also means that we don't have to worry about breaking anybody who
was putting pre-stripped names into their namespace symrefs when we fix
bug (2). Because of bug (1), nobody would have been using the symref we
advertised in the first place (not to mention that those symrefs would
have appeared broken for any non-namespaced access).

Note that we have separate fixes here for the v0 and v2 protocols. The
symref advertisement moved in v2 to be a part of the ls-refs command.
This actually gets part (1) right, since the symref annotation
piggy-backs on the existing ref advertisement, which is properly
stripped. But it still needs a fix for part (2). The included tests
cover both protocols.

Reported-by: Bryan Turner <bturner@atlassian.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 ls-refs.c                        |  3 ++-
 t/t5509-fetch-push-namespaces.sh | 28 ++++++++++++++++++++++++++++
 upload-pack.c                    |  4 ++--
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index 0a7dbc6442..818aef70a0 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -57,7 +57,8 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		if (!symref_target)
 			die("'%s' is a symref but it is not?", refname);
 
-		strbuf_addf(&refline, " symref-target:%s", symref_target);
+		strbuf_addf(&refline, " symref-target:%s",
+			    strip_namespace(symref_target));
 	}
 
 	if (data->peel) {
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index c88df78c0b..75cbfcc392 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -124,4 +124,32 @@ test_expect_success 'try to update a hidden full ref' '
 	test_must_fail git -C original push pushee-namespaced master
 '
 
+test_expect_success 'set up ambiguous HEAD' '
+	git init ambiguous &&
+	(
+		cd ambiguous &&
+		git commit --allow-empty -m foo &&
+		git update-ref refs/namespaces/ns/refs/heads/one HEAD &&
+		git update-ref refs/namespaces/ns/refs/heads/two HEAD &&
+		git symbolic-ref refs/namespaces/ns/HEAD \
+			refs/namespaces/ns/refs/heads/two
+	)
+'
+
+test_expect_success 'clone chooses correct HEAD (v0)' '
+	GIT_NAMESPACE=ns git -c protocol.version=0 \
+		clone ambiguous ambiguous-v0 &&
+	echo refs/heads/two >expect &&
+	git -C ambiguous-v0 symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone chooses correct HEAD (v2)' '
+	GIT_NAMESPACE=ns git -c protocol.version=2 \
+		clone ambiguous ambiguous-v2 &&
+	echo refs/heads/two >expect &&
+	git -C ambiguous-v2 symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index 24298913c0..4d2129e7fc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1037,8 +1037,8 @@ static int find_symref(const char *refname, const struct object_id *oid,
 	symref_target = resolve_ref_unsafe(refname, 0, NULL, &flag);
 	if (!symref_target || (flag & REF_ISSYMREF) == 0)
 		die("'%s' is a symref but it is not?", refname);
-	item = string_list_append(cb_data, refname);
-	item->util = xstrdup(symref_target);
+	item = string_list_append(cb_data, strip_namespace(refname));
+	item->util = xstrdup(strip_namespace(symref_target));
 	return 0;
 }
 
-- 
2.22.0.rc1.549.gadb183c4cb

