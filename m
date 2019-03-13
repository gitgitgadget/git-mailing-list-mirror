Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45FF720305
	for <e@80x24.org>; Wed, 13 Mar 2019 01:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfCMBvf (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 21:51:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60952 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfCMBvf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 21:51:35 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1DA36202BB;
        Wed, 13 Mar 2019 01:51:34 +0000 (UTC)
Date:   Wed, 13 Mar 2019 01:51:33 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] repack: enable bitmaps by default on bare repos
Message-ID: <20190313015133.n7f7lyujnlwfytre@dcvr>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <20190309024944.zcbwgvn52jsw2a2e@dcvr>
 <20190310233956.GB3059@sigill.intra.peff.net>
 <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190312104954.GA2023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> OK. I still think of bitmaps as something that might need manual care
> and feeding, but I think that may be leftover superstition. I can't
> offhand think of any real downsides to this.

It's a _relatively_ new feature to long-time users like us, so
maybe the "new == immature" mindset sets in[*].  I skimmed some
mail archives but couldn't find any reason not to...

But I did find Ævar's forgotten gitperformance doc and thread
where the topic was brought up:

  https://public-inbox.org/git/20170403211644.26814-1-avarab@gmail.com/

> On Tue, Mar 12, 2019 at 03:13:03AM +0000, Eric Wong wrote:
> > @@ -343,11 +343,15 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> >  	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
> >  		die(_("--keep-unreachable and -A are incompatible"));
> >  
> > +	if (!(pack_everything & ALL_INTO_ONE)) {
> > +		if (write_bitmaps > 0)
> > +			die(_(incremental_bitmap_conflict_error));
> > +	} else if (write_bitmaps < 0) {
> > +		write_bitmaps = is_bare_repository();
> > +	}
> 
> Might it be easier here to always resolve "-1" into a 0/1? I.e., like:
> 
>   if (write_bitmaps < 0)
> 	write_bitmaps = (pack_everything & ALL_INTO_ONE) && is_bare_repository();
> 
> and then the rest of the logic can stay the same, and does not need to
> be modified to handle "write_bitmaps < 0"?

Good point, changed in v2.

> > +test_expect_success 'bitmaps are created by default in bare repos' '
> > +	git clone --bare .git bare.git &&
> > +	cd bare.git &&
> 
> Please don't "cd" outside of a subshell, since it impacts further tests
> that are added.

Oops, I got it into my head that each test was already run in a
separate subshell :x  Fixed.

> > +	mkdir old &&
> > +	mv objects/pack/* old &&
> > +	pack=$(ls old/*.pack) &&
> 
> Are we sure we have just done $pack here? Our repo came from a
> local-disk clone, which would have just hard-linked whatever was in the
> source repo. So we're subtly relying on the state that other tests have
> left.
> 
> I'm not sure what we're trying to accomplish with this unpacking,
> though. Running "git repack -ad" should generate bitmaps whether the
> objects were already in a single pack or not. So I think this test can
> just be:

Right, I forgot "repack -a" didn't need loose objects to operate :x

> I do agree with Ævar it might also be worth testing that disabling
> bitmaps explicitly still works. And also that repacking _without_ "-a"
> (i.e., an incremental) does not complain about being unable to generate
> bitmaps.

Yup, now with additional tests for repack.writeBitmaps=false,
repack (w/o "-a") and a config/repack.txt update

------------8<---------
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
index 6162e2a8e6..6458286dcf 100755
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
+	! test -s repack.err
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
