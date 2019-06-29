Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0FCC1F4B6
	for <e@80x24.org>; Sat, 29 Jun 2019 19:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfF2TOB (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 15:14:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34106 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfF2TOA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 15:14:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EA36A1F461;
        Sat, 29 Jun 2019 19:13:59 +0000 (UTC)
Date:   Sat, 29 Jun 2019 19:13:59 +0000
From:   Eric Wong <e@80x24.org>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Janos Farkas <chexum@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2] repack: disable bitmaps-by-default if .keep files exist
Message-ID: <20190629191359.x2bzcg6ksb2i4xtm@dcvr>
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
 <875zow8i85.fsf@evledraar.gmail.com>
 <20190623180226.GA1100@sigill.intra.peff.net>
 <20190623180825.3ospajjgat3clwiu@dcvr>
 <20190623224244.GB1100@sigill.intra.peff.net>
 <20190628070211.hfweqcons6c6gy52@dcvr>
 <20190629080302.GD21574@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190629080302.GD21574@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Fri, Jun 28, 2019 at 07:02:11AM +0000, Eric Wong wrote:
> > diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> > index 86d05160a3..0acde3b1f8 100755
> > --- a/t/t7700-repack.sh
> > +++ b/t/t7700-repack.sh
> > @@ -239,4 +239,14 @@ test_expect_success 'bitmaps can be disabled on bare repos' '
> >  	test -z "$bitmap"
> >  '
> >  
> > +test_expect_success 'no bitmaps created if .keep files present' '
> > +	pack=$(ls bare.git/objects/pack/*.pack) &&
> > +	test_path_is_file "$pack" &&
> > +	keep=${pack%.pack}.keep &&
> > +	>"$keep" &&
> > +	git -C bare.git repack -ad &&
> > +	bitmap=$(ls bare.git/objects/pack/*.bitmap 2>/dev/null || :) &&
> > +	test -z "$bitmap"
> 
> This test fails when run with 'GIT_TEST_MULTI_PACK_INDEX=1':
> 
>   + ls bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.pack
>   + pack=bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.pack
>   + test_path_is_file bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.pack
>   + test -f bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.pack
>   + keep=bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.keep
>   +
>   + git -C bare.git repack -ad
>   + ls bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.bitmap
>   + bitmap=bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.bitmap
>   + test -z bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.bitmap
>   error: last command exited with $?=1
>   not ok 15 - no bitmaps created if .keep files present
> 
> When the new has_pack_keep_file() helper function calls
> get_packed_git(the_repository) in the loop it returns with NULL
> already on the first iteration, so the keep file goes unnoticed.

Oops, s/get_packed_git/get_all_packs/ seems to fix it.

The following also improves readability as suggested by Ævar
by avoiding a subshell.
-------8<---------
Subject: [PATCH] repack: disable bitmaps-by-default if .keep files exist

Bitmaps aren't useful with multiple packs, and users with
.keep files ended up with redundant packs when bitmaps
got enabled by default in bare repos.

So detect when .keep files exist and stop enabling bitmaps
by default in that case.

Wasteful (but otherwise harmless) race conditions with .keep files
documented by Jeff King still apply and there's a chance we'd
still end up with redundant data on the FS:

  https://public-inbox.org/git/20190623224244.GB1100@sigill.intra.peff.net/

v2: avoid subshell in test case, be multi-index aware

Fixes: 36eba0323d3288a8 ("repack: enable bitmaps by default on bare repos")
Signed-off-by: Eric Wong <e@80x24.org>
Helped-by: Jeff King <peff@peff.net>
Reported-by: Janos Farkas <chexum@gmail.com>
---
Interdiff:
  diff --git a/builtin/repack.c b/builtin/repack.c
  index a9529d1afc..73250b2431 100644
  --- a/builtin/repack.c
  +++ b/builtin/repack.c
  @@ -93,7 +93,7 @@ static int has_pack_keep_file(void)
   {
   	struct packed_git *p;
   
  -	for (p = get_packed_git(the_repository); p; p = p->next) {
  +	for (p = get_all_packs(the_repository); p; p = p->next) {
   		if (p->pack_keep)
   			return 1;
   	}
  diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
  index 0acde3b1f8..0e9af832c9 100755
  --- a/t/t7700-repack.sh
  +++ b/t/t7700-repack.sh
  @@ -245,8 +245,8 @@ test_expect_success 'no bitmaps created if .keep files present' '
   	keep=${pack%.pack}.keep &&
   	>"$keep" &&
   	git -C bare.git repack -ad &&
  -	bitmap=$(ls bare.git/objects/pack/*.bitmap 2>/dev/null || :) &&
  -	test -z "$bitmap"
  +	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
  +	test_must_be_empty actual
   '
   
   test_done

 builtin/repack.c  | 18 ++++++++++++++++--
 t/t7700-repack.sh | 10 ++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index caca113927..73250b2431 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -89,6 +89,17 @@ static void remove_pack_on_signal(int signo)
 	raise(signo);
 }
 
+static int has_pack_keep_file(void)
+{
+	struct packed_git *p;
+
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		if (p->pack_keep)
+			return 1;
+	}
+	return 0;
+}
+
 /*
  * Adds all packs hex strings to the fname list, which do not
  * have a corresponding .keep file. These packs are not to
@@ -343,9 +354,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
 		die(_("--keep-unreachable and -A are incompatible"));
 
-	if (write_bitmaps < 0)
+	if (write_bitmaps < 0) {
 		write_bitmaps = (pack_everything & ALL_INTO_ONE) &&
-				 is_bare_repository();
+				 is_bare_repository() &&
+				 keep_pack_list.nr == 0 &&
+				 !has_pack_keep_file();
+	}
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps;
 
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 86d05160a3..0e9af832c9 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -239,4 +239,14 @@ test_expect_success 'bitmaps can be disabled on bare repos' '
 	test -z "$bitmap"
 '
 
+test_expect_success 'no bitmaps created if .keep files present' '
+	pack=$(ls bare.git/objects/pack/*.pack) &&
+	test_path_is_file "$pack" &&
+	keep=${pack%.pack}.keep &&
+	>"$keep" &&
+	git -C bare.git repack -ad &&
+	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
EW
