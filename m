Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BD5C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 13:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC1E615E3
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 13:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbhKPNi6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 16 Nov 2021 08:38:58 -0500
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:33441 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232201AbhKPNi5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 16 Nov 2021 08:38:57 -0500
Received: from MTA-12-3.privateemail.com (mta-12-1.privateemail.com [198.54.122.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 3148380B3E
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 08:36:00 -0500 (EST)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
        by mta-12.privateemail.com (Postfix) with ESMTP id 1698A18000B5;
        Tue, 16 Nov 2021 08:35:59 -0500 (EST)
Received: from [192.168.0.46] (unknown [10.20.151.240])
        by mta-12.privateemail.com (Postfix) with ESMTPA id 0FD9218000A5;
        Tue, 16 Nov 2021 08:35:57 -0500 (EST)
Date:   Tue, 16 Nov 2021 08:35:51 -0500
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH] grep: avoid setting UTF mode when not needed
To:     =?iso-8859-1?b?xnZhciBBcm5mavZy8A==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Marcelo Arenas =?iso-8859-1?b?QmVs824=?= 
        <carenas@gmail.com>, git@vger.kernel.org, gitster@pobox.com,
        Andreas Schwab <schwab@linux-m68k.org>
Message-Id: <R33O2R.WYXS4AQP7W05@effective-light.com>
In-Reply-To: <211116.86tugcp8mg.gmgdl@evledraar.gmail.com>
References: <87bl2kv309.fsf@igel.home>
        <20211116110035.22140-1-carenas@gmail.com>
        <211116.86tugcp8mg.gmgdl@evledraar.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Does anyone know if René's patch causes older PCRE versions to break? 
If it doesn't I think René's patch plus Ævar's fix is the way to go.

On Tue, Nov 16 2021 at 01:32:17 PM +0100, Ævar Arnfjörð Bjarmason 
<avarab@gmail.com> wrote:
> 
> On Tue, Nov 16 2021, Carlo Marcelo Arenas Belón wrote:
> 
>>  Since ae39ba431a (grep/pcre2: fix an edge case concerning ascii 
>> patterns
>>  and UTF-8 data, 2021-10-15), PCRE_UTF mode is enabled in cases 
>> where it
>>  will fail because of UTF-8 validation, which is needed for versions 
>> of
>>  PCRE2 older than 10.34.
>> 
>>  Revert the change on logic to avoid failures that were reported 
>> from the
>>  test cases, but that should also reflect in normal use when JIT is 
>> enabled
>>  and could result in crashes (or worse), as UTF-8 validation is 
>> skipped.
>> 
>>  Keeping the tests, as they pass even without the fix as replicated 
>> locally
>>  in Debian 10 and the CI.
>> 
>>  Reported-by: Andreas Schwab <schwab@linux-m68k.org>
>>  Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>>  ---
>>   grep.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>> 
>>  diff --git a/grep.c b/grep.c
>>  index f6e113e9f0..fe847a0111 100644
>>  --- a/grep.c
>>  +++ b/grep.c
>>  @@ -382,10 +382,8 @@ static void compile_pcre2_pattern(struct 
>> grep_pat *p, const struct grep_opt *opt
>>   		}
>>   		options |= PCRE2_CASELESS;
>>   	}
>>  -	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
>>  -	    (!opt->ignore_locale && is_utf8_locale() &&
>>  -	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
>>  -					    (p->fixed || p->is_fixed))))
>>  +	if (!opt->ignore_locale && is_utf8_locale() && 
>> has_non_ascii(p->pattern) &&
>>  +	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>>   		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>> 
>>   #ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER
> 
> Hrm.
> 
> A few things:
> 
> First, if we've got a post-PCREv2 version whatever fix let's guard 
> that
> with an ifdef, see thep GIT_PCRE2_VERSION_*_HIGHER at the top of 
> grep.h.
> 
> It really helps to have those, both to know to test on those older
> versions, and also so that we can at some point in the future bump the
> required version and drop these workarounds entirely (as we do with
> git-curl-compat.h).
> 
> Secondly, whatever do here let's first fix the test added in 
> ae39ba431a,
> so we're not groping around in the dark even more.
> 
> I didn't spot this at the time but the test that Hamza added in that
> based on my initial report[1] is broken & doesn't test anything
> meaningful. It needs to have this applied:
> 
> 	diff --git a/t/t7812-grep-icase-non-ascii.sh 
> b/t/t7812-grep-icase-non-ascii.sh
> 	index 22487d90fdc..1da6b07a579 100755
> 	--- a/t/t7812-grep-icase-non-ascii.sh
> 	+++ b/t/t7812-grep-icase-non-ascii.sh
> 	@@ -60,7 +60,7 @@ test_expect_success GETTEXT_LOCALE,PCRE 'log 
> --author with an ascii pattern on U
> 	        test_write_lines "forth" >file4 &&
> 	        git add file4 &&
> 	        git commit --author="À Ú Thor <author@example.com>" -m 
> sécond &&
> 	-       git log -1 --color=always --perl-regexp --author=".*Thor" 
> >log &&
> 	+       git log -1 --color=always --perl-regexp --author=". . Thor" 
> >log &&
> 	        grep Author log >actual.raw &&
> 	        test_decode_color <actual.raw >actual &&
> 	        test_cmp expected actual
> 
> I.e. the whole point of using the color output to test this is to
> discover where PCRE2 is going to consider a character boundary to be,
> using .* means that it won't be tested at add, since .* will happily 
> eat
> up whatever arbitrary data it finds with or without UTF-8 mode.
> 
> Other tests added in that & adjacent (if any?) commits may have the 
> same
> issue, I haven't dug into it.
> 
> If we lead with that patch we'll get the test passing on master as
> before, but with your patch above it'll break. I.e. the "when not
> needed' in the $subject isn't true, it's just that the test is
> completely broken.
> 
> In the context of this being a pretty urgent post-release fix (but I
> don't know if Junio would consider a point-release, so perhaphs it's
> not) I'd be OK with either of:
> 
>  A. Let's back out this new log grep color thing entirely while we
>     reconsider this. The gitster/hm/paint-hits-in-log-grep topic
>     currently reverts cleanly.
> 
>  B. Don't break the new log grep color thing, and also fix the 
> 'grepping
>     binary' regression (which is much more important than having A)
> 
> But let's not go for some in-between where we break the new feature to
> the point of it being worse than the state of not having it at all in
> v2.33.0.
> 
> I.e. without the that log grep color feature we wouldn't screw up the
> display of non-ASCII characters in log output (yay), in v2.34.0 we
> don't, but also color the match (yay), but we broke grepping binary
> *files* (boo!).
> 
> I think the approach I suggested in [2] is a much more viable way
> forward, i.e. let's stop fiddling with this giant nested if statement
> that's mainly meant for the grep-a-file-case, revert to the
> pre-log-grep-color state, and have the log-grep-color mode pass in a
> "yes, I'd like the UTF-8 mode, please".
> 
> Having said that that's probably also broken, just in ways we're less
> likely to spot (or maybe some of the log encoding settings/reencoding
> saves us there?), we may need to have that ifdef'd to 10.34 and 
> higher,
> or have some opt-in setting for this.
> 
> 1. https://lore.kernel.org/git/87v92bju64.fsf@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/87v92bju64.fsf@evledraar.gmail.com/


