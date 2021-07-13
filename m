Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259C9C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 20:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064FD61152
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 20:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhGMVBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 17:01:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:48232 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234765AbhGMVBT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 17:01:19 -0400
Received: (qmail 11793 invoked by uid 109); 13 Jul 2021 20:58:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 20:58:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13976 invoked by uid 111); 13 Jul 2021 20:58:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jul 2021 16:58:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Jul 2021 16:58:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] tests: replace remaining packetize() with
 "test-tool pkt-line"
Message-ID: <YO3+dBHL5ZBe/NbU@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
 <patch-4.5-a44e1790f2a-20210712T164208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-4.5-a44e1790f2a-20210712T164208Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 06:44:19PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Move the only remaining users of "packetize()" over to "test-tool
> pkt-line", for this we need a new "pack-raw-stdin" subcommand in the
> test-tool. The "pack" command takes input on stdin, but splits it by
> "\n", furthermore we'll format the output using C-strings, so the
> embedded "\0" being tested for here would cause the string to be
> truncated.
> 
> So we need another mode that just calls packet_write() on the raw
> input we got on stdin.

Makes sense. Lacking this "raw" version was the sticking point in the
past for using the helper in more places.

> +static void pack_raw_stdin(void)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	strbuf_read(&sb, 0, 0);
> +	if (strbuf_read(&sb, 0, 0) < 0)
> +		die_errno("failed to read from stdin");

What's up with the two reads here?

It looks like just a duplication. And it happens to work because each
one tries to read to eof, making the second one generally a noop.

> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> index 2dde0348816..b52afb0cdea 100755
> --- a/t/t5570-git-daemon.sh
> +++ b/t/t5570-git-daemon.sh
> @@ -193,10 +193,12 @@ test_expect_success 'hostname cannot break out of directory' '
>  '
>  
>  test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
> -	{
> -		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize
> -		printf "0000"
> -	} >input &&
> +	printf "git-upload-pack /interp.git\n\0host=localhost" >has-null &&
> +	test-tool pkt-line pack-raw-stdin >input <has-null &&
> +	test-tool pkt-line pack >>input <<-\EOF &&
> +	0000
> +	EOF

This is a minor style nit, but I really prefer redirecting output from
a block (as in the original) rather than iterative appending (in the
result). IMHO it makes it more obvious what is going into the file and
what is not.

I.e.:

  {
          printf "git-upload-pack /interp.git\n\0host=localhost" |
	  test-tool pkt-line pack-raw-stdin &&
	  printf "0000" | test-tool pkt-line pack
  } >input

(again here the packing of "0000" is pointless, but I'm OK with it for
consistency).

-Peff
