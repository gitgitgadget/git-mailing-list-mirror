Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48ADC433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 21:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiFTVYO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 20 Jun 2022 17:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiFTVYN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 17:24:13 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B291EC50
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 14:24:11 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 25KLO7l6067865
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Jun 2022 17:24:07 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     "'Derrick Stolee'" <derrickstolee@github.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <00a401d884d0$32885890$979909b0$@nexbridge.com> <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com> <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com> <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com> <220620.861qvjvzue.gmgdl@evledraar.gmail.com> <CAPc5daV29NuOkL1rZvzaqhe5fSrY2os42zsQRhtP6p6AJTp2NA@mail.gmail.com>
In-Reply-To: <CAPc5daV29NuOkL1rZvzaqhe5fSrY2os42zsQRhtP6p6AJTp2NA@mail.gmail.com>
Subject: RE: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1
Date:   Mon, 20 Jun 2022 17:24:02 -0400
Organization: Nexbridge Inc.
Message-ID: <00c101d884ec$133b6ec0$39b24c40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGbty4YZi8TaCT7HXBORJwwZ7F75wEiX5VOAgU1x3MCW0ymCQGaN5tmAV2iTgOtjpOUAA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 20, 2022 4:43 PM, Junio C Hamano wrote:
>I was expecting you to use \Q...\E (and passing $remote_url as an argument to
>perl script) actually.  If you let $remote_url interpolated by shell into a script of the
>host language, whether perl or sed, you'd be responsible for quoting it
>appropriately for the host language yourself, and use of single-quote pair would
>not necessarily be sufficient, no?

That would make it easier to debug. In the mean time, I am trying to get the environment to test with the problematic path and am having issues after renaming the directory.

>
>On Mon, Jun 20, 2022 at 1:34 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>wrote:
>>
>>
>> On Mon, Jun 20 2022, Derrick Stolee wrote:
>>
>> > On 6/20/22 2:59 PM, rsbecker@nexbridge.com wrote:
>> >> On June 20, 2022 2:46 PM, Derrick Stolee wrote:
>> >
>> >>> The issue is this line (some tabs removed):
>> >>>
>> >>>  new_cmdline=$(printf "%s" "$cmdline" | perl -pe
>> >>> 's[origin(?!/)]["'"$remote_url"'"]g')
>> >>>
>> >>> At this point, $remote_url contains the file path including the @
>> >>> symbol. However, this perl invocation is dropping everything starting at the
>@ to the next slash.
>> >>>
>> >>> I'm not sure of a better way to accomplish what is trying to be
>> >>> done here (replace 'origin' with that specific url) without maybe causing
>other issues.
>> >>>
>> >>> This line was introduced by e1790f9245f (fetch tests: fetch <url>
>> >>> <spec> as well as fetch [<remote>], 2018-02-09).
>> >>
>> >> How about using sed instead of perl for this?
>> >
>> > I wasn't sure if using sed would create a different kind of
>> > replacement problem, but using single-quotes seems to get around that kind
>of issue.
>> >
>> > Please see the patch below. I'm currently running CI in a GGG PR [1]
>> >
>> > [1] https://github.com/gitgitgadget/git/pull/1267
>> >
>> > Thanks,
>> > -Stolee
>> >
>> >
>> > --- >8 ---
>> >
>> > From 1df4fc66d4a62adc7087d7d22c8d78842b4e9b4d Mon Sep 17 00:00:00
>> > 2001
>> > From: Derrick Stolee <derrickstolee@github.com>
>> > Date: Mon, 20 Jun 2022 15:52:09 -0400
>> > Subject: [PATCH] t5510: replace 'origin' with URL more carefully
>> >
>> > The many test_configured_prune tests in t5510-fetch.sh test many
>> > combinations of --prune, --prune-tags, and using 'origin' or an
>> > explicit URL. Some machinery was introduced in e1790f9245f (fetch
>> > tests: fetch <url> <spec> as well as fetch [<remote>], 2018-02-09)
>> > to replace 'origin' with this explicit URL. This URL is a "file:///"
>> > URL for the root of the $TRASH_DIRECTORY.
>> >
>> > However, if the current build tree has an '@' symbol, the
>> > replacement using perl fails. It drops the '@' as well as anything
>> > else in that directory name.
>> >
>> > You can verify this locally by cloning git.git into a "victim@03"
>> > directory and running the test script.
>> >
>> > To resolve this issue, replace the perl invocation with two sed
>> > commands. These two are used to ensure that we match exactly on the
>> > whole word 'origin'. We can guarantee that the word boundaries are
>> > spaces in our tests. The reason to use exact words is that sometimes
>> > a refspec is supplied, such as "+refs/heads/*:refs/remotes/origin/*"
>> > which would cause an incorrect replacement. The two commands are
>> > used because there is not a clear POSIX way to match on word
>> > boundaries without getting extremely pedantic about what possible
>> > characters we could have at the boundaries.
>> >
>> > Reported-by: Randall Becker <rsbecker@nexbridge.com>
>> > Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>> > ---
>> >  t/t5510-fetch.sh | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh index
>> > 4620f0ca7fa..8ca3aa5e931 100755
>> > --- a/t/t5510-fetch.sh
>> > +++ b/t/t5510-fetch.sh
>> > @@ -853,7 +853,9 @@ test_configured_prune_type () {
>> >               then
>> >                       new_cmdline=$cmdline_setup
>> >               else
>> > -                     new_cmdline=$(printf "%s" "$cmdline" | perl -pe
>'s[origin(?!/)]["'"$remote_url"'"]g')
>> > +                     new_cmdline=$(printf "%s" "$cmdline" | \
>> > +                                     sed "s~origin ~'$remote_url' ~g" | \
>> > +                                     sed "s~ origin~
>> > + '$remote_url'~g")
>> >               fi
>> >
>> >               if test "$fetch_prune_tags" = 'true' ||
>>
>> Thanks for looking at this. Checking this out again this whole quoting
>> mess is a bit of a ... mess, I wonder if there's some better way to
>> avoid this. Anyway:
>>
>> So, is this functionally the same as:
>>
>>         diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>>         index 4620f0ca7fa..9cd8b36f835 100755
>>         --- a/t/t5510-fetch.sh
>>         +++ b/t/t5510-fetch.sh
>>         @@ -853,7 +853,9 @@ test_configured_prune_type () {
>>                         then
>>                                 new_cmdline=$cmdline_setup
>>                         else
>>         -                       new_cmdline=$(printf "%s" "$cmdline" | perl -pe
>'s[origin(?!/)]["'"$remote_url"'"]g')
>>         +                       new_cmdline=$(printf "%s" "$cmdline" |
>>         +                                     perl -pe 's[origin ]["'"$remote_url"'" ]g' |
>>         +                                     perl -pe 's[ origin][ "'"$remote_url"'"]g')
>>                         fi
>>
>>                         if test "$fetch_prune_tags" = 'true' ||
>>
>> ?
>>
>> I don't mind the migration to "sed", but doing so to fix a bug makes
>> this especially hard to analyze. I.e. you've gotten rid of the (?!/),
>> I haven't re-looked at this enough to see if/how that's important.
>>
>> I just came up with the above as a quick hack, but for any proper
>> migration to sed can't we do this in one command?
>>
>> In any case you never need "| \" in your scripts, just end the line
>> with "|".

