Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC011F406
	for <e@80x24.org>; Thu, 11 Jan 2018 09:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932924AbeAKJiX (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 04:38:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:40970 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754319AbeAKJiW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 04:38:22 -0500
Received: (qmail 25660 invoked by uid 109); 11 Jan 2018 09:38:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Jan 2018 09:38:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21734 invoked by uid 111); 11 Jan 2018 09:38:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Jan 2018 04:38:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jan 2018 04:38:20 -0500
Date:   Thu, 11 Jan 2018 04:38:20 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t3900: add some more quotes
Message-ID: <20180111093819.GB9190@sigill.intra.peff.net>
References: <20180110095832.22077-1-dev+git@drbeat.li>
 <6b32292b-0f71-7cf8-2069-41766d440b58@kdbg.org>
 <20180110195323.GA26186@sigill.intra.peff.net>
 <xmqqy3l5z9hx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3l5z9hx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 01:31:22PM -0800, Junio C Hamano wrote:

> > +# Read from stdin into the variable given in $1.
> > +test_read_to_eof () {
> > +	# Bash's "read" is sufficiently flexible that we can skip the extra
> > +	# process.
> > +	if test -n "$BASH_VERSION"
> > +	then
> > +		# 64k should be enough for anyone...
> > +		read -N 65536 -r "$1"
> > +	else
> > +		# command substitution eats trailing whitespace, so we add
> > +		# and then remove a non-whitespace character.
> > +		eval "$1=\$(cat; printf x)"
> > +		eval "$1=\${$1%x}"
> > +	fi
> > +}
> 
> Yuck.  Hacky but nice.
> 
> I think this will make it easier to read but I suspect here text
> would use temporary files and may slow things down a bit?  I do not
> know if it is even measurable, though.

Yeah, since I was able to contain the horrible-ness in this function, I
think the overall readability/portability is probably OK. My main
concern was that it would be slower (hence the bash hackery). I applied
the patch below on top to see what kind of impact we could measure
across the whole suite:

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index be8a47d304..6f2e6e7560 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -441,6 +441,15 @@ test_expect_success () {
 	then
 		test_read_to_eof test_block
 		set -- "$1" "$test_block"
+	else
+		# this is obviously a dumb thing to do, but it's just
+		# a performance-testing hack.
+		test_read_to_eof test_block <<EOF
+$2
+EOF
+		# our here-doc hackery added an extra newline
+		set -- "$1" "${test_block%
+}"
 	fi
 	test_verify_prereq
 	export test_prereq

After doing five trial timings each of "make test" on:

  - stock git with dash
  - this patch with dash (so using "cat" to read the here-doc)
  - stock git with bash
  - this patch with bash (so using an internal "read")

I couldn't come up with any definitive slowdown.

In the first two, there's a fair bit of run-to-run noise (easily 10%),
and my best run was actually _with_ the patch (by only 3%, but still the
opposite of what you'd expect).

Running the (stock) suite with bash is definitively slower than with
dash (by about 20%). Adding in this patch didn't seem to make it any
slower.

So I dunno. Maybe it's not so crazy an idea.

-Peff
