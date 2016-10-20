Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44ADA1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbcJTViG (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:38:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:60266 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752385AbcJTViG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:38:06 -0400
Received: (qmail 4126 invoked by uid 109); 20 Oct 2016 21:38:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 21:38:05 +0000
Received: (qmail 30194 invoked by uid 111); 20 Oct 2016 21:38:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 17:38:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 17:38:03 -0400
Date:   Thu, 20 Oct 2016 17:38:03 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Drastic jump in the time required for the test suite
Message-ID: <20161020213803.7d7bymby7pouzij3@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
 <20161019205638.m3ytxozzmeh47ml2@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610201218060.3264@virtualbox>
 <CAGZ79kZpj5xXHmnA+JfLKdGmgzp7Mut1OsKMOeowpw8m1+aKGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZpj5xXHmnA+JfLKdGmgzp7Mut1OsKMOeowpw8m1+aKGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 12:54:32PM -0700, Stefan Beller wrote:

> Maybe we should stop introducing un-optimized tests.
> [...]
> * heavy use of the "git -C <dir>" pattern. When applying that
>   thouroughly we'd save spanning the subshells.

Yeah, I imagine with some style changes we could drop quite a few
subshells. The problem is that the conversion work is manual and
tedious. I'd look first for spots where we can eliminate thousands of
calls with a single change.

> That said I really like the idea of having a helper that would eliminate the cat
> for you, e.g. :
> 
> git_test_helper_equal_stdin_or_diff_and_die -C super_repo status
> --porcelain=v2 --branch --untracked-files=all <<-EOF
> 1 A. N... 000000 100644 100644 $_z40 $HMOD .gitmodules
> 1 AM S.M. 000000 160000 160000 $_z40 $HSUP sub1
> EOF

I think that helper still ends up using "cat" and "diff" under the hood,
unless you write those bits in pure shell. But at that point, I suspect
we could "cat" and "test_cmp" in pure shell, something like:

	cat () {
		# optimize common here-doc usage
		if test $# -eq 0
		then
			while read -r line
			do
				printf '%s' "$line"
			done
		fi
		command cat "$@"
	}

	test_cmp () {
		# optimize for common "they are the same" case
		# without any subshells or subprograms
		while true; do
			if ! read -r line1 <&3
			then
				if ! read -r line2 <&4
					# EOF on both; good
					return 0
				else
					# EOF only on file1; fail
					break
				fi
			fi
			if ! read -r line2 <&4
			then
				# EOF only on file2; fail
				break
			fi
			test "$line1" = "$line2" || break
		done 3<"$1" 4<"$2"

		# if we get here, the optimized version found some
		# difference. We can just "return 1", but let's run
		# the real $GIT_TEST_CMP to provide pretty output.
		# This should generally only happen on test failures,
		# so performance isn't a big deal.
		"$GIT_TEST_CMP" "$@"
	}

Those are both completely untested. But maybe they are worth playing
around with for somebody on Windows to see if they make a dent in the
test runtime.

-Peff
