Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7EAC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 20:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D33961369
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 20:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhGMUxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 16:53:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:48214 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhGMUxV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 16:53:21 -0400
Received: (qmail 11673 invoked by uid 109); 13 Jul 2021 20:50:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 20:50:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13876 invoked by uid 111); 13 Jul 2021 20:50:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jul 2021 16:50:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Jul 2021 16:50:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] tests: replace [de]packetize() shell+perl
 test-tool pkt-line
Message-ID: <YO38ladlVVGAmQnl@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
 <patch-3.5-c33f344ab20-20210712T164208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.5-c33f344ab20-20210712T164208Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 06:44:18PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The shell+perl "[de]packetize()" helper functions were added in
> 4414a150025 (t/lib-git-daemon: add network-protocol helpers,
> 2018-01-24), and around the same time we added the "pkt-line" helper
> in 74e70029615 (test-pkt-line: introduce a packet-line test helper,
> 2018-03-14).
> 
> For some reason it seems we've mostly used the shell+perl version
> instead of the helper since then. There were discussions around
> 88124ab2636 (test-lib-functions: make packetize() more efficient,
> 2020-03-27) and cacae4329fa (test-lib-functions: simplify packetize()
> stdin code, 2020-03-29) to improve them and make them more efficient.

This seems like a good goal, and the conversions look mostly faithful
(with one exception below). Having the helper tool recognize "0000" as a
flush makes some of the scripts much nicer to read (even if it is
technically ambiguous in the input).

I did seem like there were some other stylistic things happening, too,
though. For instance:

> -extract_haves () {
> -	depacketize | perl -lne '/^(\S+) \.have/ and print $1'
> -}
> -
>  test_expect_success 'with core.alternateRefsCommand' '
>  	write_script fork/alternate-refs <<-\EOF &&
>  		git --git-dir="$1" for-each-ref \
> @@ -27,18 +23,40 @@ test_expect_success 'with core.alternateRefsCommand' '
>  			refs/heads/public/
>  	EOF
>  	test_config -C fork core.alternateRefsCommand ./alternate-refs &&
> -	git rev-parse public/branch >expect &&
> -	printf "0000" | git receive-pack fork >actual &&
> -	extract_haves <actual >actual.haves &&
> -	test_cmp expect actual.haves
> +
> +	test-tool pkt-line pack >in <<-\EOF &&
> +	0000
> +	EOF
> +
> +	cat >expect <<-EOF &&
> +	$(git rev-parse main) refs/heads/main
> +	$(git rev-parse base) refs/tags/base
> +	$(git rev-parse public) .have
> +	0000
> +	EOF

This is testing the whole output, rather than just the "have" lines (as
the original did). It was intentionally written the other way for two
reasons:

  - it keeps the focus on what we are actually testing: the .have
    behavior

  - it makes the test less brittle to other changes in the script

I can buy the argument that sometimes testing the whole output, even if
it is more brittle, helps us find other unexpected outcomes (e.g., the
stderr test_cmp vs grep thing earlier in the series). But here it just
seems strictly worse to me.

It would be easy to just replace depacketize with "pktline unpack", but
keep the perl one-liner. I don't think it's a _huge_ deal in this case
either way, but I'm not enthused about the trend.

> +	test-tool pkt-line pack >in <<-\EOF &&
> +	0000
> +	EOF

This used to just be "printf 0000". The new version is longer and less
efficient, but I'm OK with it on the grounds of consistency (all inputs
flow through "pkt-line pack", and all outputs through "pkt-line unpack").

> diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-report-status-v1.sh
> index 1233a46eac5..cf33d993192 100644
> --- a/t/t5411/once-0010-report-status-v1.sh
> +++ b/t/t5411/once-0010-report-status-v1.sh
> @@ -34,13 +34,13 @@ test_expect_success "proc-receive: report status v1" '
>  				$A $B | packetize
>  		fi &&
>  		printf "%s %s refs/for/main/topic1\n" \
> -			$ZERO_OID $A | packetize &&
> +			$ZERO_OID $A | test-tool pkt-line pack &&
>  		printf "%s %s refs/heads/foo\n" \
> -			$ZERO_OID $A | packetize &&
> +			$ZERO_OID $A | test-tool pkt-line pack &&
>  		printf "%s %s refs/for/next/topic\n" \
> -			$ZERO_OID $A | packetize &&
> +			$ZERO_OID $A | test-tool pkt-line pack &&
>  		printf "%s %s refs/for/main/topic2\n" \
> -			$ZERO_OID $A | packetize &&
> +			$ZERO_OID $A | test-tool pkt-line pack &&

Now that you're using the multi-line-capable helper, these could all be
a single (and much more readable):

  test-tool pkt-line pack <<-EOF
  $ZERO_OID $A refs/for/main/topic1
  $ZERO_OID $A refs/heads/foo
  $ZERO_OID $A refs/for/next/topic
  $ZERO_OID $A refs/for/main/topic2
  EOF

couldn't they?

> -	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
> -	0012command=fetch
> -	$(echo "object-format=$(test_oid algo)" | packetize)
> -	00010013deepen-since 1
> -	$(echo "want $(git rev-parse other)" | packetize)
> -	$(echo "have $(git rev-parse main)" | packetize)
> +	test-tool pkt-line pack >in <<-EOF &&
> +	command=fetch
> +	object-format=$(test_oid algo)
> +	0001
> +	deepen-since 1
> +	want $(git rev-parse other)
> +	have $(git rev-parse main)
>  	0000
>  	EOF

This is much more readable. Nice.

> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
> index e5d3d15ba8d..e6c8338b648 100755
> --- a/t/t5562-http-backend-content-length.sh
> +++ b/t/t5562-http-backend-content-length.sh
> @@ -53,12 +53,13 @@ test_expect_success 'setup' '
>  	test_commit c1 &&
>  	hash_head=$(git rev-parse HEAD) &&
>  	hash_prev=$(git rev-parse HEAD~1) &&
> -	{
> -		packetize "want $hash_head" &&
> -		printf 0000 &&
> -		packetize "have $hash_prev" &&
> -		packetize "done"
> -	} >fetch_body &&
> +	test-tool pkt-line pack >fetch_body <<-EOF &&
> +	want $hash_head
> +	0000
> +	have $hash_prev
> +	done
> +	0000
> +	EOF

There's a flush packet at the end of your input in the post-image that
doesn't seem to be in the original.

> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> index 82c31ab6cd8..2dde0348816 100755
> --- a/t/t5570-git-daemon.sh
> +++ b/t/t5570-git-daemon.sh
> @@ -198,12 +198,14 @@ test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
>  		printf "0000"
>  	} >input &&

This one doesn't use "pkt-line pack". Which is good, because we care
about being exact about things like newlines here.

>  	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
> -	depacketize <output >output.raw &&
> +	test-tool pkt-line unpack <output >actual &&
> +
> +	cat >expect <<-EOF &&
> +	$(git rev-parse HEAD) HEAD
> +	$(git rev-parse refs/heads/main) refs/heads/main
> +	0000
> +	EOF
>  
> -	# just pick out the value of main, which avoids any protocol
> -	# particulars
> -	perl -lne "print \$1 if m{^(\\S+) refs/heads/main}" <output.raw >actual &&
> -	git -C "$repo" rev-parse main >expect &&
>  	test_cmp expect actual
>  '

This is another case where you're checking the output for more than the
original did, ignoring the comment. :) When using depacketize, the bits
after the "\0" were encoded and kept, so it was necessary. The pkt-line
helper just throws those bits away, so it's OK (I'm a little surprised
that discarding those bits wasn't a roadblock for converting some tests,
but I guess we didn't have any low-level protocol tests that cared).

-Peff
