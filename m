Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF651F45F
	for <e@80x24.org>; Tue,  7 May 2019 07:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfEGHGZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 03:06:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:49822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726546AbfEGHGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 03:06:25 -0400
Received: (qmail 17587 invoked by uid 109); 7 May 2019 07:06:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 May 2019 07:06:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8772 invoked by uid 111); 7 May 2019 07:07:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 07 May 2019 03:07:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2019 03:06:23 -0400
Date:   Tue, 7 May 2019 03:06:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 0/2] perf-lib.sh: fix 0baf78e7bc regression, refactor
 & fix bugs
Message-ID: <20190507070622.GA28060@sigill.intra.peff.net>
References: <20190506202451.GA19850@sigill.intra.peff.net>
 <20190506232309.28538-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506232309.28538-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 07, 2019 at 01:23:07AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > What if instead we:
> >
> >   - taught test-lib.sh to make GIT_TEST_INSTALLED absolute (since after
> >     all it is the one who is planning to chdir and wreck the relative
> >     path)
> >
> >   - let callers pass in $GIT_PERF_RESULTS_PREFIX instead of guessing at
> >     it ourselves from the path name. Then the "run" script could quite
> >     reasonably just pass in the tree oid it already has instead of us
> >     trying to decode it. And nobody would care about whether
> >     $GIT_TEST_INSTALLED has been mangled.
> >
> > I thought about going this route for my original patch, but I wanted to
> > fix the regression (which I agree is quite serious and embarrassing) as
> > quickly and simply as possible.
> 
> It seems simplest after the changes I've made here to just make a
> relative GIT_TEST_INSTALLED be an error in test-lib.sh, why bend over
> backwards to support it?

I'm OK with that, though _somebody_ has to generate the full path. My
thinking was that it would be a little nicer if we did at the lowest
level, but it's pretty easy to do it directly in the "run" script.

> Re GIT_PERF_RESULTS_PREFIX: Depending on what you mean we now have
> that in 2/2 as PERF_RESULTS_PREFIX.
> 
> But if you mean the user can pass it in that doesn't make sense, since
> we need to pick a different prefix revision we test, so it's a
> many-to-many relationship.

I couldn't quite parse this. What I meant was that any caller of the
perf scripts would pass in two pieces of data: the path to the git we
want to test (GIT_TEST_INSTALLED) and the unique name under which it
should be saved (GIT_PERF_PREFIX, which would generally be either empty
or the tree oid).

I see that perf-lib.sh also has support for running git out of some
arbitrary installed directory. I'm not sure if anybody actually uses
that, but it's not too hard to support either (the run script just
generates the prefix).

Something like (just for illustration on top of master; this doesn't
have the actual bugfix):

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 169f92eae3..e2b342f216 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -29,10 +29,7 @@ TEST_NO_MALLOC_CHECK=t
 
 . ../test-lib.sh
 
-if test -z "$GIT_TEST_INSTALLED"; then
-	perf_results_prefix=
-else
-	perf_results_prefix=$(printf "%s" "${GIT_TEST_INSTALLED%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
+if test -n "$GIT_TEST_INSTALLED"; then
 	GIT_TEST_INSTALLED=$ABSOLUTE_GIT_TEST_INSTALLED
 fi
 
@@ -179,7 +176,8 @@ test_wrapper_ () {
 		base=$(basename "$0" .sh)
 		echo "$test_count" >>"$perf_results_dir"/$base.subtests
 		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
-		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
+		prefix=$PERF_RESULTS_PREFIX${PERF_RESULTS_PREFIX:+.}
+		base="$perf_results_dir"/"$prefix$(basename "$0" .sh)"."$test_count"
 		"$test_wrapper_func_" "$@"
 	fi
 
diff --git a/t/perf/run b/t/perf/run
index 9aaa733c77..e5695ec8de 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -87,15 +87,20 @@ run_dirs_helper () {
 		fi
 		build_git_rev $rev "$mydir"
 		mydir=build/$rev
+		PERF_RESULTS_PREFIX=$rev
+	else
+		PERF_RESULTS_PREFIX=$(echo mydir | tr -c "[a-zA-Z0-9]" "[_*]")"."
 	fi
 	if test "$mydir" = .; then
 		unset GIT_TEST_INSTALLED
+		unset PERF_RESULTS_PREFIX
 	else
 		GIT_TEST_INSTALLED="$mydir/bin-wrappers"
 		# Older versions of git lacked bin-wrappers; fallback to the
 		# files in the root.
 		test -d "$GIT_TEST_INSTALLED" || GIT_TEST_INSTALLED=$mydir
 		export GIT_TEST_INSTALLED
+		export PERF_RESULTS_PREFIX
 	fi
 	run_one_dir "$@"
 }

It does mean that anybody calling "GIT_TEST_INSTALLED=whatever
./p1234-foo.sh" has to pass in PERF_RESULTS_PREFIX, but I think that's
OK (they should be using the "run" script anyway).

> As seen in 2/2 modifying some of the shell & associated Perl code it's
> a bit nasty that we need to duplicate the logic for picking these
> PERF_RESULTS_PREFIXes in the shell code and Perl code. Ideally the
> shell code would pick it, and pass the mapping to the Perl code
> somehow. But that's another "has sucked since forever, future TODO"
> item.

Yeah, I didn't realize that aggregate.perl has the duplicate logic.
Gross. But I agree that's not a topic for now. It would continue to
compute the same PERF_RESULTS_PREFIX that "run" does, except it doesn't
need to bother to pass it to anybody else.

(Note that in my patch above, I dropped the pointless "build_" from the
rev-based names, so aggregate.perl would need to do the same).

-Peff
