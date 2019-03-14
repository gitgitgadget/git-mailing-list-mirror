Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026F720305
	for <e@80x24.org>; Thu, 14 Mar 2019 09:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfCNJMz (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 05:12:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34136 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfCNJMz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 05:12:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7A96A202BB;
        Thu, 14 Mar 2019 09:12:54 +0000 (UTC)
Date:   Thu, 14 Mar 2019 09:12:54 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190314091254.nescpfp3n6mbjpmh@dcvr>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <20190309024944.zcbwgvn52jsw2a2e@dcvr>
 <20190310233956.GB3059@sigill.intra.peff.net>
 <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
 <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190313145417.GA24101@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Wed, Mar 13, 2019 at 01:51:33AM +0000, Eric Wong wrote:
> 
> > But I did find Ævar's forgotten gitperformance doc and thread
> > where the topic was brought up:
> > 
> >   https://public-inbox.org/git/20170403211644.26814-1-avarab@gmail.com/
> 
> One thing that thread reminded me of: we probably also want to default
> pack.writebitmaphashcache on. Otherwise the time saved during the object
> enumeration can backfire when we spend much more time trying delta
> compression (because we don't know the pathnames of any objects).

Interesting...  I found a big improvement with public-inbox
just using bitmaps; but have never tried the hash cache.

> The reason it defaults to off is for on-disk compatibility with JGit.

Right.  Our documentation seems to indicate JGit just warns (but
doesn't fall over), so maybe that can be considered separately.

I've never used JGit myself; and was satisfied enough with
bitmaps alone that I never tried the hash-cache.

> But I have very little experience running without the hash-cache on. We
> added it very early on because we found performance was not great
> without it (I don't know if people running JGit have run into the same
> problem and if not, why not).

As far as serving clones and fetches, public-inbox-init has
always created bare repos with bitmaps enabled, but without
the hash-cache for compatibility concerns.

That's a lot of fetches and clones over the years.

> > +test_expect_success 'incremental repack does not complain' '
> > +	git -C bare.git repack -q 2>repack.err &&
> > +	! test -s repack.err
> > +'
> 
> This last line could use "test_must_be_empty".

Thanks for the review!

---------8<-----------
Subject: [PATCH] repack: enable bitmaps by default on bare repos

A typical use case for bare repos is for serving clones and
fetches to clients.  Enable bitmaps by default on bare repos to
make it easier for admins to host git repos in a performant way.

Signed-off-by: Eric Wong <e@80x24.org>
Helped-by: Jeff King <peff@peff.net>
---
 Documentation/config/repack.txt |  2 +-
 builtin/repack.c                |  5 ++++-
 t/t7700-repack.sh               | 19 ++++++++++++++++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/repack.txt b/Documentation/config/repack.txt
index a5c37813fd..9c413e177e 100644
--- a/Documentation/config/repack.txt
+++ b/Documentation/config/repack.txt
@@ -24,4 +24,4 @@ repack.writeBitmaps::
 	packs created for clones and fetches, at the cost of some disk
 	space and extra time spent on the initial repack.  This has
 	no effect if multiple packfiles are created.
-	Defaults to false.
+	Defaults to true on bare repos, false otherwise.
diff --git a/builtin/repack.c b/builtin/repack.c
index 67f8978043..caca113927 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -14,7 +14,7 @@
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
-static int write_bitmaps;
+static int write_bitmaps = -1;
 static int use_delta_islands;
 static char *packdir, *packtmp;
 
@@ -343,6 +343,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
 		die(_("--keep-unreachable and -A are incompatible"));
 
+	if (write_bitmaps < 0)
+		write_bitmaps = (pack_everything & ALL_INTO_ONE) &&
+				 is_bare_repository();
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps;
 
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 6162e2a8e6..86d05160a3 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -221,5 +221,22 @@ test_expect_success 'repack --keep-pack' '
 	)
 '
 
-test_done
+test_expect_success 'bitmaps are created by default in bare repos' '
+	git clone --bare .git bare.git &&
+	git -C bare.git repack -ad &&
+	bitmap=$(ls bare.git/objects/pack/*.bitmap) &&
+	test_path_is_file "$bitmap"
+'
+
+test_expect_success 'incremental repack does not complain' '
+	git -C bare.git repack -q 2>repack.err &&
+	test_must_be_empty repack.err
+'
 
+test_expect_success 'bitmaps can be disabled on bare repos' '
+	git -c repack.writeBitmaps=false -C bare.git repack -ad &&
+	bitmap=$(ls bare.git/objects/pack/*.bitmap 2>/dev/null || :) &&
+	test -z "$bitmap"
+'
+
+test_done
-- 
EW
