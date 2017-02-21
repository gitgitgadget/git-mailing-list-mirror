Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94A792021B
	for <e@80x24.org>; Tue, 21 Feb 2017 07:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbdBUHiS (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 02:38:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:59136 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbdBUHiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 02:38:16 -0500
Received: (qmail 14481 invoked by uid 109); 21 Feb 2017 07:38:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 07:38:15 +0000
Received: (qmail 32624 invoked by uid 111); 21 Feb 2017 07:38:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 02:38:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Feb 2017 02:38:13 -0500
Date:   Tue, 21 Feb 2017 02:38:13 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH] config: preserve <subsection> case for one-shot config
 on the command line
Message-ID: <20170221073813.w4zrkky2d4drnwbs@sigill.intra.peff.net>
References: <20170215111704.78320-1-larsxschneider@gmail.com>
 <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
 <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
 <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
 <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
 <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
 <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
 <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
 <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
 <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2017 at 01:58:07AM -0800, Junio C Hamano wrote:

> Since nothing seems to have happened in the meantime, here is what
> I'll queue so that we won't forget for now.  Lars's tests based on
> how the scripted "git submodule" uses "git config" may still be
> valid, but it is somewhat a roundabout way to demonstrate the
> breakage and not very effective way to protect the fix, so I added a
> new test that directly tests "git -c <var>=<val> <command>".

Yeah, I agree that is the best way to cover this code.

> I am not sure if this updated one is worth doing, or the previous
> "strchr and strrchr" I originally wrote was easier to understand.

I think either is OK. I would actually have written it halfway in
between, like:

  static void canonicalize_config_variable_name(char *varname)
  {
          const char *p;

          /* downcase the first segment */
          for (p = varname; *p; p++) {
	          if (*p == '.')
		          break;
                  *p = tolower(*p);
	  }

          /* locate end of middle segment, if there is one */
          p = strrchr(p, '.');
          if (!p)
                  return; /* invalid single-level var, but let it pass */
          for (; *p; p++)
                  *p = tolower(*p);
  }

You can toss that on the bikeshed heap. :)

The other change from yours is that it flips the order of the strrchr
and return. Yours is more efficient in the sense that we know there is
no dot, so we do not have to keep searching at all (though of course
this case is invalid and we would not expect to see it in practice).

But it did take me a minute in yours to figure out why last_dot was
always set to a dot (the answer is that it starts at "cp", which must
itself be a dot, because we would already have returned otherwise).

> One thing I noticed is that "git config --get X" will correctly
> diagnose that a dot-less X is not a valid variable name, but we do
> not seem to diagnose "git -c X=V <cmd>" as invalid.

I don't think that was intentional. We just never caught the case. It
might be reasonable to do so (and it's easy to catch here while
canonicalizing). I think there are probably some other cases we _could_
catch, too (e.g., invalid characters for keynames). But I'm not excited
about duplicating the logic from the file-parser.

> Perhaps we should, but it is not the focus of this topic.

Definitely.

> diff --git a/t/t1351-config-cmdline.sh b/t/t1351-config-cmdline.sh
> new file mode 100755
> index 0000000000..acb8dc3b15
> --- /dev/null
> +++ b/t/t1351-config-cmdline.sh
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +
> +test_description='git -c var=val'
> +
> +. ./test-lib.sh

There are a bunch of other "git -c" tests inside t1300. I don't know if
it would be better to put them all together.

Arguably, those other ones should get pulled out here to the new script.
More scripts means that the tests have fewer hidden dependencies, and we
can parallelize the run more. I admit I've shied away from new scripts
in the past because the number allocation is such a pain.

> +test_expect_success 'last one wins: two level vars' '
> +	echo VAL >expect &&
> +
> +	# sec.var and sec.VAR are the same variable, as the first
> +	# and the last level of a configuration variable name is
> +	# case insensitive.  Test both setting and querying.

I assume by "setting and querying" here you mean "setting via -c,
querying via git-config".

> +	git -c sec.var=val -c sec.VAR=VAL config --get sec.var >actual &&
> +	test_cmp expect actual &&
> +	git -c SEC.var=val -c sec.var=VAL config --get sec.var >actual &&
> +	test_cmp expect actual &&
> +
> +	git -c sec.var=val -c sec.VAR=VAL config --get SEC.var >actual &&
> +	test_cmp expect actual &&
> +	git -c SEC.var=val -c sec.var=VAL config --get sec.VAR >actual &&
> +	test_cmp expect actual

Looks good.

> +test_expect_success 'last one wins: three level vars' '
> +	echo val >expect &&
> +
> +	# v.a.r and v.A.r are not the same variable, as the middle
> +	# level of a three-level configuration variable name is
> +	# case sensitive.  Test both setting and querying.
> +
> +	git -c v.a.r=val -c v.A.r=VAL config --get v.a.r >actual &&
> +	test_cmp expect actual &&
> +	git -c v.a.r=val -c v.A.r=VAL config --get V.a.R >actual &&
> +	test_cmp expect actual &&
> +
> +	echo VAL >expect &&
> +	git -c v.a.r=val -c v.a.R=VAL config --get v.a.r >actual &&
> +	test_cmp expect actual &&
> +	git -c v.a.r=val -c V.a.r=VAL config --get v.a.r >actual &&
> +	test_cmp expect actual &&
> +	git -c v.a.r=val -c v.a.R=VAL config --get V.a.R >actual &&
> +	test_cmp expect actual &&
> +	git -c v.a.r=val -c V.a.r=VAL config --get V.a.R >actual &&
> +	test_cmp expect actual
> +'

There are two blocks of tests, each with their own "expect" value.
Should the top "expect" here be moved down with its block to make that
more clear?

Other than that nit, the tests look good to me.

-Peff
