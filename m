Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3471FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 21:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933848AbcKVVTi (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 16:19:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:46319 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752126AbcKVVTX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 16:19:23 -0500
Received: (qmail 19228 invoked by uid 109); 22 Nov 2016 21:19:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 21:19:23 +0000
Received: (qmail 32223 invoked by uid 111); 22 Nov 2016 21:19:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 16:19:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Nov 2016 16:19:21 -0500
Date:   Tue, 22 Nov 2016 16:19:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 2/3] stripspace: respect repository config
Message-ID: <20161122211920.3qdohxdktykqhyga@sigill.intra.peff.net>
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
 <5567548295222401fab10d3f2901c1787afbfd07.1479737858.git.johannes.schindelin@gmx.de>
 <CACsJy8D5oBR+vo2B+Ro2Q4SX0CG3jME4Gfs1_6AohccmpNvD0A@mail.gmail.com>
 <alpine.DEB.2.20.1611221712480.3746@virtualbox>
 <xmqqshqjqw3z.fsf@gitster.mtv.corp.google.com>
 <xmqqzikrpbz2.fsf@gitster.mtv.corp.google.com>
 <20161122195015.rztaixpz7zvdxb4u@sigill.intra.peff.net>
 <xmqqoa17p8k0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa17p8k0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2016 at 12:24:15PM -0800, Junio C Hamano wrote:

> > Do you want to do another round of -rc3? Ship with the
> > minor regressions and fix them up in v2.11.1?
> 
> I am leaning towards the former (though we may also end up doing the
> latter).

I think I'd lead towards -rc3, as well. Our schedule is somewhat
arbitrary anyway, and one week is less important than somebody picking
up the new release and trying to puzzle out a regression that we already
have a fix for.

> Here is an initial attempt.  It turns out that write_archive() must
> be callable outside a repository to respond to "git archive --list",
> which happens in parse_archive_args(), and the "have-repository?"
> check cannot be moved before that to the caller.

Right, that makes sense. t5000 already tests git-archive outside of a
repo, although it does it in a funny way (it sets GIT_DIR rather than
relying on GIT_CEILING_DIRECTORIES). We should cover that and make sure
that --remote works outside of a repo. Those work now, but we want to
make sure we don't regress them.

And then we want to test that --remote can read a configured remote
name.

And then post-v2.11, we'd want to check that --remote=foo outside of a
repo produces a sane error instead of looking for a bogus
$GIT_DIR/remotes/foo.

Something like this, which does all but the last (and that should
probably happen separately post-release).

---
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 80b238734..09df7f045 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -94,6 +94,20 @@ check_tar() {
 	'
 }
 
+# run "$@" inside a non-git directory
+nongit () {
+	test -d non-repo ||
+	mkdir non-repo ||
+	return 1
+
+	(
+		GIT_CEILING_DIRECTORIES=$(pwd) &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non-repo &&
+		"$@"
+	)
+}
+
 test_expect_success \
     'populate workdir' \
     'mkdir a &&
@@ -179,6 +193,12 @@ test_expect_success 'git archive --remote' \
     'git archive --remote=. HEAD >b5.tar &&
     test_cmp_bin b.tar b5.tar'
 
+test_expect_success 'git archive --remote with configured remote' '
+	git config remote.foo.url . &&
+	git archive --remote=foo HEAD >b5-nick.tar &&
+	test_cmp_bin b.tar b5-nick.tar
+'
+
 test_expect_success \
     'validate file modification time' \
     'mkdir extract &&
@@ -197,9 +217,15 @@ test_expect_success 'git archive with --output, override inferred format' '
 	test_cmp_bin b.tar d4.zip
 '
 
-test_expect_success \
-    'git archive --list outside of a git repo' \
-    'GIT_DIR=some/non-existing/directory git archive --list'
+test_expect_success 'git archive --list outside of a git repo' '
+	nongit git archive --list
+'
+
+test_expect_success 'git archive --remote outside of a git repo' '
+	git archive HEAD >expect.tar &&
+	nongit git archive --remote="$PWD" HEAD >actual.tar &&
+	test_cmp_bin expect.tar actual.tar
+'
 
 test_expect_success 'clients cannot access unreachable commits' '
 	test_commit unreachable &&
