Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3C471F403
	for <e@80x24.org>; Mon, 11 Jun 2018 04:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbeFKErN (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 00:47:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:40968 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753866AbeFKErN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 00:47:13 -0400
Received: (qmail 3012 invoked by uid 109); 11 Jun 2018 04:47:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 04:47:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12955 invoked by uid 111); 11 Jun 2018 04:47:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 00:47:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 00:47:11 -0400
Date:   Mon, 11 Jun 2018 00:47:11 -0400
From:   Jeff King <peff@peff.net>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Subject: [PATCH] fetch-pack: don't try to fetch peeled values with --all
Message-ID: <20180611044710.GB31642@sigill.intra.peff.net>
References: <20180610143231.7131-1-kirr@nexedi.com>
 <20180611042016.GA31642@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180611042016.GA31642@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 12:20:16AM -0400, Jeff King wrote:

> Doubly interesting, it looks like this case _used_ to work, but was
> broken by 5f0fc64513 (fetch-pack: eliminate spurious error messages,
> 2012-09-09). Which only changed the fetch-pack side. It moved the
> handling of --all so that it was no longer in the "else" for
> check_refname_format(). I guess the original code was rejecting those
> peeled bits as "not a ref" (which makes sense).
> 
> So that seems like a bug in fetch-pack. But I'm still not convinced that
> upload-pack doesn't also have a bug.

Here's a patch which fixes fetch-pack. I just rolled the test into the
same commit; I hope that's OK.

I'm somewhat on the fence regarding the upload-pack behavior. It would
probably be pretty easy to fix, but since this is how it has always
worked, I'm not sure if it's worth changing (and I think it is
consistent in a sense -- it just means that the peeled tips we advertise
are meant only as information, and not to be explicitly requested).

One other funny thing I noticed about this code. For ill-formed refs, it
checks that they begin with "refs/" and that they fail
check_refname_format(). But I think that means I could advertise
"foobar^{}" and fetch-pack would consider it a possible ref to fetch.
That seems odd. I guess that's perhaps how it handles HEAD, though. I
didn't dig in further.

-- >8 --
Subject: fetch-pack: don't try to fetch peeled values with --all

When "fetch-pack --all" sees a tag-to-blob on the remote, it
tries to fetch both the tag itself ("refs/tags/foo") and the
peeled value that the remote advertises ("refs/tags/foo^{}").
Asking for the object pointed to by the latter can cause
upload-pack to complain with "not our ref", since it does
not mark the peeled objects with the OUR_REF.

Arguably upload-pack _should_ be marking those peeled
objects. But it never has in the past, since clients would
generally just ask for the tag and expect to get the peeled
value along with it. And that's how "git fetch" works, as
well as older versions of "fetch-pack --all".

The problem was introduced by 5f0fc64513 (fetch-pack:
eliminate spurious error messages, 2012-09-09). Before then,
the matching logic was something like:

  if (refname is ill-formed)
     do nothing
  else if (doing --all)
     always consider it matched
  else
     look through list of sought refs for a match

That commit wanted to flip the order of the second two arms
of that conditional. But we ended up with:

  if (refname is ill-formed)
    do nothing
  else
    look through list of sought refs for a match

  if (--all and no match so far)
    always consider it matched

That means tha an ill-formed ref will trigger the --all
conditional block, even though we should just be ignoring
it. We can fix that by having a single "else" with all of
the well-formed logic, that checks the sought refs and
"--all" in the correct order.

Original report and test from Kirill Smelkov.

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I just stuck with your same test, but thinking about it, I guess this
would be a problem even for a tag-to-commit.

Diff is -U15 to better show the context (in case you are wondering why
it is so big ;) ).

 fetch-pack.c          |  8 ++++----
 t/t5500-fetch-pack.sh | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a320ce9872..cc7a42fee9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -645,35 +645,35 @@ static void filter_refs(struct fetch_pack_args *args,
 
 		if (starts_with(ref->name, "refs/") &&
 		    check_refname_format(ref->name, 0))
 			; /* trash */
 		else {
 			while (i < nr_sought) {
 				int cmp = strcmp(ref->name, sought[i]->name);
 				if (cmp < 0)
 					break; /* definitely do not have it */
 				else if (cmp == 0) {
 					keep = 1; /* definitely have it */
 					sought[i]->match_status = REF_MATCHED;
 				}
 				i++;
 			}
-		}
 
-		if (!keep && args->fetch_all &&
-		    (!args->deepen || !starts_with(ref->name, "refs/tags/")))
-			keep = 1;
+			if (!keep && args->fetch_all &&
+			    (!args->deepen || !starts_with(ref->name, "refs/tags/")))
+				keep = 1;
+		}
 
 		if (keep) {
 			*newtail = ref;
 			ref->next = NULL;
 			newtail = &ref->next;
 		} else {
 			ref->next = unmatched;
 			unmatched = ref;
 		}
 	}
 
 	/* Append unmatched requests to the list */
 	for (i = 0; i < nr_sought; i++) {
 		struct object_id oid;
 		const char *p;
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d4f435155f..74641e8870 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -506,30 +506,45 @@ test_expect_success 'test missing ref before existing' '
 test_expect_success 'test --all, --depth, and explicit head' '
 	(
 		cd client &&
 		git fetch-pack --no-progress --all --depth=1 .. refs/heads/A
 	) >out-adh 2>error-adh
 '
 
 test_expect_success 'test --all, --depth, and explicit tag' '
 	git tag OLDTAG refs/heads/B~5 &&
 	(
 		cd client &&
 		git fetch-pack --no-progress --all --depth=1 .. refs/tags/OLDTAG
 	) >out-adt 2>error-adt
 '
 
+test_expect_success 'test --all wrt tag to non-commits' '
+	blob_sha1=$(echo "hello blob" | git hash-object -t blob -w --stdin) &&
+	git tag -a -m "tag -> blob" tag-to-blob $blob_sha1 &&
+	tree_sha1=$(printf "100644 blob $blob_sha1\tfile\n" | git mktree) &&
+	git tag -a -m "tag -> tree" tag-to-tree $tree_sha1 &&
+	mkdir fetchall &&
+	(
+		cd fetchall &&
+		git init &&
+		git fetch-pack --all .. &&
+		git cat-file blob $blob_sha1 >/dev/null &&
+		git cat-file tree $tree_sha1 >/dev/null
+	)
+'
+
 test_expect_success 'shallow fetch with tags does not break the repository' '
 	mkdir repo1 &&
 	(
 		cd repo1 &&
 		git init &&
 		test_commit 1 &&
 		test_commit 2 &&
 		test_commit 3 &&
 		mkdir repo2 &&
 		cd repo2 &&
 		git init &&
 		git fetch --depth=2 ../.git master:branch &&
 		git fsck
 	)
 '
-- 
2.18.0.rc1.446.g4486251e51

