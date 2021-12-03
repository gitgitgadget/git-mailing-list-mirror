Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598B1C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 00:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377900AbhLCAwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 19:52:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63351 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377798AbhLCAwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 19:52:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5122EC58B;
        Thu,  2 Dec 2021 19:48:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sU+DV18GP5M8
        jN51yowLtCwrMxFr+L0JKDtFf4HcrhE=; b=UqFP+sphIfnBGt2ORKgpE5IdUBiM
        /IO2X5o8vJsaFfkwAgO+vQajMMDKjHtHGw2T6C6ArNoSDcH+Tr5f4aF9L8b8axhZ
        1jMW986PL95piuh+1u5GCWOeVjXMbgthIAsdesSTFYBZ8y7U3D6fLWuqF0gz8l9C
        Nbubz1zaqeywicI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBBFEEC58A;
        Thu,  2 Dec 2021 19:48:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41E59EC589;
        Thu,  2 Dec 2021 19:48:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 3/7] grep tests: add missing "grep.patternType"
 config test
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
        <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
        <patch-v3-3.7-fcad1b1664b-20211129T143956Z-avarab@gmail.com>
        <xmqqbl22634q.fsf@gitster.g>
Date:   Thu, 02 Dec 2021 16:48:49 -0800
In-Reply-To: <xmqqbl22634q.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        29 Nov 2021 13:52:37 -0800")
Message-ID: <xmqqk0gmtswe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C8732F58-53D2-11EC-8116-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Extend the grep tests to assert that setting
>> "grep.patternType=3Dextended" followed by "grep.patternType=3Ddefault"
>> will behave as if "--extended-regexp" was provided, and not as
>> "--basic-regexp".
>
> grep.patternType is the usual "last-one wins".  If the last value
> set to patternType is the default, the setting to grep.extendedRegexp
> should take effect (so if it is set to true, we'd see ERE behavour).
>
> Back in the days when the "return to the default matching behavior"
> part was written in 84befcd0 (grep: add a grep.patternType
> configuration setting, 2012-08-03), grep.extendedRegexp was the only
> way to configure the behaviour since b22520a3 (grep: allow -E and -n
> to be turned on by default via configuration, 2011-03-30).  It was
> understandable that we referred to the behaviour that honors the
> older configuration variable as "the default matching" behaviour.
> It is fairly clear in its log message:
>
>     When grep.patternType is set to a value other than "default", the
>     grep.extendedRegexp setting is ignored. The value of "default" rest=
ores
>     the current default behavior, including the grep.extendedRegexp
>     behavior.
>
> So, unless your description is a typo, I am somewhat surprised by
> your findings that =3Ddefault that comes later does not defeat an
> earlier =3Dextended.
>
> It should just clear that earlier extended set by grep.patternType
> and only pay attention to grep.extendedRegexp variable.  Doing
> anything else is a bug, I think.

So, let's see how=20

  $ git -c grep.patternType=3Dextended \
	-c grep.patternType=3Ddefault \
	grep foo

works today.

We start from builtin/grep.c::cmd_grep(), which calls
git_config(grep_cmd_config).  grep_cmd_config() farms out most of
the work to grep.c::grep_config(), which populates the grep_defaults
structure. grep_defaults.pattern_type_option first becomes
GREP_PATTERN_TYPE_ERE and then it gets overwritten to
GREP_PATTERN_TYPE_UNSPECIFIED.

Then grep.c::grep_init() copies that grep_defaults to the
per-invocation "struct grep_opt opt" that is on-stack in
builtin/grep.c::cmd_grep(). =20

opt.patternType becomes GREP_PATTERN_TYPE_UNSPECIFIED;
opt.extendedRegexp in the same structure is 0, because nobody has
touched the corresponding member in grep_defaults in
grep_cmd_config().

Then parse_options() gets its turn to futz with members in "opt".
-E/-G/-F/-P would be parsed into a separate variable "pattern_type";
in this case, there is no command line option, so the pattern_type
variable has GREP_PATTERN_TYPE_UNSPECIFIED.

And finally grep.c::grep_commit_pattern_type() is called to combine
what is in "pattern_type" and "opt".

It calls grep_set_pattern_type_option() to futz with members in opt
that is what determines the final choice.

 - If pattern_type is not UNSPECIFIED, use that;

 - Otherwise, if opt->pattern_type_option is not UNSPECIFIED, use that;

 - Otherwise, i.e. if pattern_type from the command line and
   opt->pattern_type_option from the configuration are both
   UNSPECIFIED, then check if opt->extended_regexp_option (which is
   set from the config via grep.extendedRegexp) is set.  If so, call
   grep_set_pattern_type_option() to use ERE.

Now, what does grep_set_pattern_type_option() do?

The first thing it does is when pattern_type given is not ERE, drop
the opt->extended_regexp_option bit (which may have been set by
having grep.extendedRegexp configuration set to true).  This is
because, just like 'fixed' and 'pcre2', the runtime after the opt
structure is set up, the code does not look at a single "type"
member that enumerates BRE, ERE, FIXED, PCRE to determine the type
of the pattern, and the 'extended_regexp_option' member, after
grep_commit_pattern_type() finishes its processing, is used to
signal that ERE is in effect.  But as we've seen in the design goal
of the earlier change 84befcd0 (grep: add a grep.patternType
configuration setting, 2012-08-03), the bit obtained from the
grep.extendedRegexp configuration variable is only valid when
grep.patternType is set to UNSPECIFIED (aka default), so there needs
some dropping of this bit happen.

But with two grep.patternType configuration, I do not think the bug
will trigger.  As we traced above, we just get UNSPECIFIED in
grep_defaults.pattern_type_option, that is copied to cmd_grep()::opt,
and it gets combined with UNSPECIFIED in cmd_grep()::pattern_type in
grep_commit_pattern_type().  But the three-step logic in the "commit"
will not do anything in this case.  So, I do not see any code that
makes this behave as if "git grep -E foo" was given.

I suspect that if you do

  $ git -c grep.extendedRegexp=3Dtrue \
	-c grep.patternType=3Ddefault \
	grep foo

it should set the .extended_regexp_option member to true and the
.pattern_type_option member to UNSPECIFIED in grep_defaults, copy it
to cmd_grep()::opt, and grep_commit_pattern_type() will try to
combine that "opt" with pattern_type=3D=3DUNSPECIFIED.  The third "both
pattern_type and opt.pattern_type_option are UNSPECIFIED" case
triggers, and grep_set_pattern_type_option() would be called, with
its pattern_type parameter explicitly set to ERE.

The logic to combine these two are convoluted and I sense that it
could be simplified without breaking the established semantics, but
so far I am not seeing how the code can break in such a way that

>> Extend the grep tests to assert that setting
>> "grep.patternType=3Dextended" followed by "grep.patternType=3Ddefault"
>> will behave as if "--extended-regexp" was provided, and not as
>> "--basic-regexp".

this claim holds.

So,... after spending too much time following the code, I went back
to the actual test added by the code and see this:

+	test_expect_success "grep $L with grep.patternType=3Dextended and grep.=
patternType=3Ddefault" '
+		echo "${HC}ab:a+bc" >expected &&
+		git \
+			-c grep.patternType=3Dextended \
+			-c grep.patternType=3Ddefault \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'

Here, file "ac" has three lines

        a+b*c
        a+bc
        abc

and "a+b*c" pattern is designed to hit the first line with -F, the
second one with -G (because + is literal in BRE so it must exist
literally in the haystack, b* matches single b but not literal b* in
the haystack), the last one with -E (because neither + or * is
literal, so the first two lines do not match, but the last one
matches).  The expectation in the code, unlike what is in the log
message, is that this should match as if -G was given.

So, I guess there is no bug (other than the alarming false report in
the log message).



