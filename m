Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575D31FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 10:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754777AbeAMKc7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 05:32:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:43046 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754483AbeAMKc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 05:32:58 -0500
Received: (qmail 30171 invoked by uid 109); 13 Jan 2018 10:32:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Jan 2018 10:32:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5812 invoked by uid 111); 13 Jan 2018 10:33:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Jan 2018 05:33:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Jan 2018 05:32:56 -0500
Date:   Sat, 13 Jan 2018 05:32:56 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] travis-ci: build Git during the 'script' phase
Message-ID: <20180113103255.GA31117@sigill.intra.peff.net>
References: <20180108172214.23615-1-szeder.dev@gmail.com>
 <xmqqvagc6m42.fsf@gitster.mtv.corp.google.com>
 <5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com>
 <CAM0VKjnSzoc+E408ifKCg+qPTaGRNL3e3JVdRN573kdcBSzbHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjnSzoc+E408ifKCg+qPTaGRNL3e3JVdRN573kdcBSzbHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 02:32:54PM +0100, SZEDER Gábor wrote:

> That's the just beginning of a looong list of executed test scripts in
> seemingly pseudo-random order.  IMHO that's very rarely the interesting
> part; I, for one, am only interested in that list in exceptional cases,
> e.g. while tweaking the build dependencies or the 'prove --state=...'
> options.

Aren't folds supposed to do this? I.e., record all the output but only
show it to the user if the command exited non-zero.

According to:

  https://blog.travis-ci.com/2013-05-22-improving-build-visibility-log-folds

they auto-fold individual commands _except_ the ones in the script
section. Is there a way to manually mark folds in the output?

Hmph. I could not find an answer from travis, but googling seems to turn
up that something like this would work:

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 07f27c7270..8c830aa3c0 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -77,6 +77,23 @@ check_unignored_build_artifacts ()
 	}
 }
 
+fold () {
+	printf 'travis_fold:start:%s\r' "$1"
+}
+
+unfold () {
+	printf 'travis_fold:end:%s\r' "$1"
+}
+
+fold_cmd () {
+	local name=$1; shift
+	fold "$name"
+	"$@"
+	local ret=$?
+	unfold "$name"
+	return $ret
+}
+
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.
 # Set tracing executed commands, primarily setting environment variables
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index d3a094603f..12b2590230 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -7,8 +7,8 @@
 
 ln -s $HOME/travis-cache/.prove t/.prove
 
-make --jobs=2
-make --quiet test
+fold_cmd compile make --jobs=2
+fold_cmd test make --quiet test
 
 check_unignored_build_artifacts
 

I've queued a CI job to see if this actually works. :)

-Peff
