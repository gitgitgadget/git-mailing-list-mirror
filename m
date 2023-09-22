Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DF6CD484D
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 17:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjIVRyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 13:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjIVRxi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 13:53:38 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35565212F
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 10:52:18 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1695405135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JQOol8P54SjT1w6kX0tzsjX6JjbbACYb0GpMMf422ns=;
        b=WOzWx78LxAvY65/E1AiOPNYXipmL90b3zsQCDmxesMaR7ES8PaJNBjhmkmw6NJGN9kV0yt
        1hNe4R0KGqn6wH1pcrA8JhnARPSE5cllNuBamSjpq7uUYU3w05I9DpbJXxn6GNTd+/zBXm
        BWGiVUNzDgHgvUjQAgTLaKPQl9BxWFRqozGTrJnQLgrzvMywTs8QRRUPML74tFhEIDyqSX
        mR/0TL2wwpfOXxTpDQQEs/botwyp1kywJqscYBYg+f0cN2WNxB3xozTNKQHJJRbGlaetBE
        P1u9X9lnLTH2iGS1oTRP7AnO7UnJwv4Qat9t4oY2SzffZIB4HbaZvkXJce1Yhg==
Date:   Fri, 22 Sep 2023 19:52:14 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff --stat: set the width defaults in a helper function
In-Reply-To: <xmqqjzsi2l7r.fsf@gitster.g>
References: <166396f0a98e248fc3d1236757632c5d648ddc0b.1695364961.git.dsimic@manjaro.org>
 <xmqqjzsi2l7r.fsf@gitster.g>
Message-ID: <fc9ba2f7a8080f7fd669dd8f718876bc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-09-22 19:04, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Extract the commonly used initialization of the --stat-width=<width>,
>> --stat-name-width=<width> and --stat-graph-with=<width> parameters to 
>> the
>> internal default values into a helper function, to avoid repeating the 
>> same
>> initialization code in a few places.
> 
> Thanks.
> 
> If this is only about settings related to controlling widths of
> various elements on diffstat lines, isn't the "std" in name a bit
> too broad, though?  init_diffstat_widths(&rev.diffopt) or something
> like that might be a better fit.  I dunno if it is a huge deal,
> though.

Makes sense to me, init_diffstat_widths(&rev.diffopt) fits better and 
it's more descriptive.  I'm a big fan of using self-descriptive naming, 
but originally I wanted to follow the already present naming scheme, so 
I'm glad to see that you asked for a more descriptive function name.

>> Add a couple of tests to additionally cover existing configuration 
>> options
>> diff.statNameWidth=<width> and diff.statGraphWidth=<width> when used 
>> by
>> git-merge to generate --stat outputs.  This closes the gap in the 
>> tests that
>> existed previously for the --stat tests, reducing the chances for 
>> having
>> any regressions introduced by this commit.
> 
> Nice.

Thanks.

>> While there, perform a bunch of small wording improvements and some 
>> minor
>> code cleanups in the improved unit test, as spotted, to make it a bit 
>> neater
>> and to improve its test-level consistency.
> 
> Alright.  The last category of changes need somebody else to review
> them in addition to myself, as I expect that it would be somewhat
> subjective and I tend to be change-averse.
> 
> The code changes all looked sensible.
> 
>> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
>> index beb2ec2a55..aa947d93cf 100755
>> --- a/t/t4052-stat-output.sh
>> +++ b/t/t4052-stat-output.sh
>> @@ -12,32 +12,31 @@ TEST_PASSES_SANITIZE_LEAK=true
>>  . ./test-lib.sh
>>  . "$TEST_DIRECTORY"/lib-terminal.sh
>> 
>> -# 120 character name
>> -name=aaaaaaaaaa
>> -name=$name$name$name$name$name$name$name$name$name$name$name$name
>> +# 120-character name
>> +printf -v name 'a%.0s' {1..120}
> 
> This is a totally unnecessary and unacceptable change.  "-v name"
> may be available in the built-in variant found in bash, but you
> would likely find that it is missing from other shells.  {1..120} is
> also a bash-ism.

Makes sense to stick with the simpler variant, which won't cause 
compatibility issues.

> And because we are still calling the result a "name" (not
> "filename") ...
> 
>>  cat >expect72 <<-'EOF'
>>   ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 
>> +
>>  EOF
>> -test_expect_success "format-patch: small change with long name gives 
>> more space to the name" '
>> +test_expect_success "format-patch: small change with long filename 
>> gives more space to the filename" '
> 
> ... I do not see the point of this change (and similar ones in the
> rest of the patch).  Even the configuration is called statNameWidth
> and not statFileNameWidth.  In the context of the tests that check
> "stat-output" (that is in the filename of this script), we should be
> able to use "name" consistently without causing any confusion, as it
> is unlikely to be mistaken with other kinds of "name".

On second thought, I agree that sticking with just "name" is better in 
this test.

>> -test_expect_success "format-patch --cover-letter ignores COLUMNS (big 
>> change)" '
>> +test_expect_success "format-patch --cover-letter ignores COLUMNS 
>> envvar with big change" '
> 
> Not wrong per-se, but I wonder if it is necessary to stress that
> COLUMNS is an environment variable that tells the programs how wide
> a terminal they are showing their output.  A usual shell variable
> would not affect the "git" process it runs, and COLUMNS without any
> dot in it cannot be our configuration variable, so even without deep
> knowledge of tradition, I thought it would be rather obvious.

On second thought, I agree that using just "COLUMN" suffices while also 
being more compact.

> Same comment for "statNameWidth config"; with fewer number of bytes,
> it would be more descriptive to say "diff.statNameWidth".

Oh, nice catch!  Makes sense.

>> -	test_expect_success "$cmd --stat-graph-width with big change" '
>> +	test_expect_success "$cmd --stat-graph-width=width with big change" 
>> '
>>  		git $cmd $args --stat-graph-width=26 >output &&
> 
> This may be a good change, especially if there are tests that feed
> different parameters and if it helps clarifying which variant is
> tested, e.g. "--stat=<width>,<name-width>" vs "--stat=<width>".
> 
> Ah, wait, "--stat-graph-width" always takes a single value, so the
> above justification does not quite apply.  But still, it is not
> making it worse, and because there is another test that is labeled
> with "--stat-width=width", being consistent with it has value.

Yes, I think that the improved consistency outweights the slight 
redundancy.

> OK.
> 
>> -	test_expect_success "$cmd --stat-graph-width --graph with big 
>> change" '
>> +	test_expect_success "$cmd --stat-graph-width=width --graph with big 
>> change" '
> 
> Ditto.
> 
> Thanks.

Thanks, I'll prepare and send v2 of the patch, based on your feedback.
