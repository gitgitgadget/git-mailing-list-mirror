Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99AFE1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 22:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeFDWZc (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 18:25:32 -0400
Received: from p3plsmtpa11-06.prod.phx3.secureserver.net ([68.178.252.107]:41625
        "EHLO p3plsmtpa11-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751482AbeFDWZa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 18:25:30 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jun 2018 18:25:30 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id PxnjfgSarjn1aPxnlfUQOd; Mon, 04 Jun 2018 15:18:11 -0700
Date:   Tue, 5 Jun 2018 01:18:08 +0300
From:   Max Kirillov <max@max630.net>
To:     Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] http-backend: respect CONTENT_LENGTH for
 receive-pack
Message-ID: <20180604221807.GC27650@jessie.local>
References: <20180602212749.21324-1-max@max630.net>
 <20180602212749.21324-3-max@max630.net>
 <20180604044408.GD14451@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604044408.GD14451@sigill.intra.peff.net>
From2:  "Maksim Kirillov" <max630@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfB6k+IYshaY8ch59nK7NAqVvb/yZPT0C8Se6liXdUmInkFkDNDpKtJuSHX029r+1NxN/gW1QwIcschUQOg//a1tLVydbl+vL3gf25MF8zgQ9pVJQCUQS
 2VmXSUYWEBhQLvxO3kw28iJTxpqHPmeO6Qi7tdzJTpalFA5bNnOlrIWUc+HiJQvSKqEg/ff3G9sVJGPoHPFMc5aVv66LIcQjaY2Dzw9CJsYs+Nf3vGDHP309
 nkfcOhgeudMk7JV0UJTAPE2Iz/hfXZRi2GidIhMB+nzD29ax/AW+2o05WBlqMHCbPF11t8mjjZcidLfZ01/+mS+s3Nvx0ZBdKWKoMcuKbbwssKL1vuQM724N
 OzWF56cICkegkfuseOh+MQfeYxy4LhH7xJoh8jPiO0TK0EUKCPc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 12:44:09AM -0400, Jeff King wrote:

Thanks for the comments, I will do the things you proposed,
or try to and get back later if there are any issues. Some
notes below.

> On Sun, Jun 03, 2018 at 12:27:49AM +0300, Max Kirillov wrote:
> Since this is slightly less efficient, and because it only matters if
> the web server does not already close the pipe, should this have a
> run-time configuration knob, even if it defaults to
> safe-but-slightly-slower?

Personally, I of course don't want this. Also, I don't think
the difference is much noticeable. But you can never be sure
without trying. I'll try to measure some numbers.

>> +		if (write_in_full(out, buf, n) < 0)
>> +			die_errno("%s aborted reading request", prog_name);
> 
> We don't necessarily know why the write failed. If it's EPIPE, then yes,
> the program probably did abort. But all we know is that write() failed.
> We should probably say something more generic like:
> 
>   die_errno("unable to write to '%s'");
> 
> or similar.

Actually, it is already 3rd same error in this file. Maybe
deserve some refactoring. I will change the message also.

>> +test_expect_success 'setup repository' '
>> +	test_commit c0 &&
>> +	test_commit c1
>> +'
>> +
>> +hash_head=$(git rev-parse HEAD)
>> +hash_prev=$(git rev-parse HEAD~1)
> 
> We generally prefer to have all commands, even ones we don't expect to
> fail, inside test_expect blocks (e.g., with a "setup" description).

Will the defined variables get to the next test? I'll try to
do as you describe.

>> +cat >fetch_body <<EOF
>> +0032want $hash_head
>> +00000032have $hash_prev
>> +0009done
>> +EOF
> 
> This depends on the size of the hash. That's always 40 for now, but is
> something that may change soon.
> 
> We already have a packetize() helper; could we use it here?

Could you point me to it? I cannot find it.

My understanfing is that the current protocol assumes
40 symbols hash, so another hash length would be another
protocol, and since it's manually forged here it would
anyway has to be changeda.

>> +test_expect_success 'fetch plain truncated' '
>> +	test_http_env upload \
>> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body.trunc git http-backend >act.out 2>act.err &&
>> +	test_must_fail verify_http_result "200 OK"
>> +'
> 
> Usually test_must_fail on a checking function like this is a sign that
> the check is not as robust as we'd like. If the function checks two
> things "A && B", then checking test_must_fail will only let us know
> "!A || !B", but you probably want to check both.

Well here I just want to know that the request has failed,
and we already know that it can fail in different ways,
but the test is not going to differentiate those ways.

> (We'd also generally not use test_must_fail with a non-git command, and
> just use a simple "! verify_http_result"; that would apply equally if
> gets split into two commands).

Will use ! there.

>> +sleep 1; # is interrupted by SIGCHLD
>> +if (!$exited) {
>> +        close($out);
>> +        die "Command did not exit after reading whole body";
>> +}

...

> Also, do we need to protect ourselves against other signals being
> delivered? E.g., if I resize my xterm and this process gets SIGWINCH, is
> it going to erroneously end the sleep and say "nope, no exited signal"?

I'll check, but what could I do? Should I add blocking other
signals there?
