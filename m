Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D546C1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 14:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeGYQDI (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 12:03:08 -0400
Received: from p3plsmtpa12-10.prod.phx3.secureserver.net ([68.178.252.239]:49663
        "EHLO p3plsmtpa12-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728581AbeGYQDI (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Jul 2018 12:03:08 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id iL7zfHOF9BaBOiL84fyBbB; Wed, 25 Jul 2018 07:51:06 -0700
Date:   Wed, 25 Jul 2018 17:51:00 +0300
From:   Max Kirillov <max@max630.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v8 3/3] http-backend: respect CONTENT_LENGTH for
 receive-pack
Message-ID: <20180725145100.GA1959@jessie.local>
References: <20180610150521.9714-1-max@max630.net>
 <20180610150521.9714-4-max@max630.net>
 <20180725121435.20519-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180725121435.20519-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfFab3RDYL0wrgkTtYOGoznedZwZ/NxRNSXUs+575BiJTS+lU0V9lsaOoH9IHLt+vNHHvhYVUDIQq24kZCqGfVxWrKdNFY/HJnc7HCIVeDUdG0acXPwdR
 FKuCvbJWz5EBsaIIxHYIhjZjLrF5n1fly5IXpL/LcRRNe6u4VcwR1CI1HgOfEj6NpGWQsbFvZIWksaJ5nHWwJImedwUv0KAcvPqoYYdR9bBKlw9bjR+e+4GE
 ICfTvYBkfiDryxRUgHYdniFRmMqP6XVJ9z/mKme6ATNPmoq37mzMn0cjQckzJ3B5gYsSYacaAygsqpSY/l09bmW08nX6g/DY42+qs7t4sALVu87DDP80VnEh
 mwy6yweP4TwNkbiHeAkyi/i6BX3pQ4AivPMj2G/oxeO3f/zdqPRWTcmpsY3IjQ/NGaegyQwT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 02:14:35PM +0200, SZEDER Gábor wrote:
>> +	# sometimes there is fatal error buit the result is still 200
> 
> s/buit/but/

Thanks, will fix

>> +	if grep 'fatal:' act.err
>> +	then
>> +		return 1
>> +	fi
> 
> I just happened to stumble upon a failure because of 'fatal: the
> remote end hung up unexpectedly' in the test 'push plain'.

Did it happen once or repeated? It is rather strange, that
one shoud not fail. Which OS it was?

There have been doubds that a random incoming signal can
trigger such a failure.

> What does that "sometimes" in the above comment mean, and how often
> does such a failure happen?  I see these patches are in 'pu' for over
> a month now, so based on the number of reflog entries since then it
> happened once from about 30-35 builds on Travis CI so far.

"sometimes" here means "for some kinds of fatal error
failure", there is nothing random in it.

> > +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body git http-backend >act.out 2>act.err &&
> 
> Don't save the standard error of the whole shell function.
> When running the test with /bin/sh and '-x' tracing, then the trace of
> commands executed in the function will be included in the standard
> error as well, which may interfere with later verification (though in
> this case it doesn't seem like it would cause any issues).
> 
> Please limit the redirections to the relevant command's output.  AFAICT
> all invocations of 'test_http_env' in these tests have their stdout and
> stderr redirected to the same pair of files, so perhaps you could
> simply move all these redirections inside the function.

Thanks, I'll try to fix it 

>> +	! verify_http_result "200 OK"
> 
> ... this function would return error (because of that 'if grep fatal:
> ...' statement) without even looking at the status, but the test would
> still succeed.  Is that really the desired behavior here?

Yes, it is a desired behavior. A failure is expected here,
and the failure does not show up as non-200 status, as
described above.
