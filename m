Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0625A1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 05:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753901AbeFKFx7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 01:53:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:41004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753866AbeFKFx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 01:53:59 -0400
Received: (qmail 5265 invoked by uid 109); 11 Jun 2018 05:53:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 05:53:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13505 invoked by uid 111); 11 Jun 2018 05:54:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 01:54:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 01:53:57 -0400
Date:   Mon, 11 Jun 2018 01:53:57 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Kirill Smelkov <kirr@nexedi.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git List <git@vger.kernel.org>
Subject: [PATCH v2] fetch-pack: don't try to fetch peel values with --all
Message-ID: <20180611055357.GA16430@sigill.intra.peff.net>
References: <20180610143231.7131-1-kirr@nexedi.com>
 <20180611042016.GA31642@sigill.intra.peff.net>
 <20180611044710.GB31642@sigill.intra.peff.net>
 <CAPig+cT73d0rYoSbt7oHVG4MYHVvjKidP0ogRwV+9F73jcjZEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cT73d0rYoSbt7oHVG4MYHVvjKidP0ogRwV+9F73jcjZEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 01:28:23AM -0400, Eric Sunshine wrote:

> On Mon, Jun 11, 2018 at 12:47 AM, Jeff King <peff@peff.net> wrote:
> > Subject: fetch-pack: don't try to fetch peeled values with --all
> > [...]
> > Original report and test from Kirill Smelkov.
> >
> > Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> > @@ -506,30 +506,45 @@ test_expect_success 'test missing ref before existing' '
> > +test_expect_success 'test --all wrt tag to non-commits' '
> > +       blob_sha1=$(echo "hello blob" | git hash-object -t blob -w --stdin) &&
> > +       git tag -a -m "tag -> blob" tag-to-blob $blob_sha1 &&
> > +       tree_sha1=$(printf "100644 blob $blob_sha1\tfile\n" | git mktree) &&
> 
> Perhaps modernize these names to 'blob_oid' and 'tree_oid', or even
> simpler, just 'blob' and 'tree'.

Looking deeper, we do not need these trees and blobs at all. The problem
is really just a tag that peels to an object that is not otherwise a ref
tip, regardless of its type.

So below is a patch that simplifies the test even further (the actual
code change is the same).

> > +       git tag -a -m "tag -> tree" tag-to-tree $tree_sha1 &&
> > +       mkdir fetchall &&
> > +       (
> > +               cd fetchall &&
> > +               git init &&
> > +               git fetch-pack --all .. &&
> 
> Simpler:
> 
>     git init fetchall &&
>     (
>         cd fetchall &&
>         git fetch-pack --all .. &&
> 
> Although, I see that this script already has a mix of the two styles
> (simpler and not-so-simple), so...

The nearby tests actually reuse the "client" directory. We can do that,
too, if we simply create new objects for our test, to make sure they
still need fetching. See below (we could also use "git -C" there, but
the subshell matches the other tests).

-- >8 --
Subject: fetch-pack: don't try to fetch peel values with --all

When "fetch-pack --all" sees a tag-to-blob on the remote, it
tries to fetch both the tag itself ("refs/tags/foo") and the
peeled value that the remote advertises ("refs/tags/foo^{}").
Asking for the object pointed to by the latter can cause
upload-pack to complain with "not our ref", since it does
not mark the peeled objects with the OUR_REF (unless they
were at the tip of some other ref).

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

Reported-by: Kirill Smelkov <kirr@nexedi.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c          |  8 ++++----
 t/t5500-fetch-pack.sh | 10 ++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a320ce9872..cc7a42fee9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -657,11 +657,11 @@ static void filter_refs(struct fetch_pack_args *args,
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
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d4f435155f..5726f83ea3 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -518,6 +518,16 @@ test_expect_success 'test --all, --depth, and explicit tag' '
 	) >out-adt 2>error-adt
 '
 
+test_expect_success 'test --all with tag to non-tip' '
+	git commit --allow-empty -m non-tip &&
+	git commit --allow-empty -m tip &&
+	git tag -m "annotated" non-tip HEAD^ &&
+	(
+		cd client &&
+		git fetch-pack --all ..
+	)
+'
+
 test_expect_success 'shallow fetch with tags does not break the repository' '
 	mkdir repo1 &&
 	(
-- 
2.18.0.rc1.446.g4486251e51

