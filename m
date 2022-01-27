Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26514C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 21:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344381AbiA0VfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:35:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57336 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344375AbiA0VfM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 16:35:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B1FD10CF1F;
        Thu, 27 Jan 2022 16:35:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yLYQkW/BbQQ0zMMaV5+bagEtqDEaAMxfr/AmaU
        I41f0=; b=I61FSf4QMndNHtqwznpR4Wu7NL6wBXAk9mzKTaFWu0yko+PPOjSMSa
        4RegOoqEwx+HxkF3hLFGNWDTGO/WCnbfiuO27eTRAbjL4Cf3/zgIJB8YFVUL49Fy
        NNQKHgTQ/MvLCIjpoOu+dZuyFoJNumnT96I4jFOBKlqOC5phsg1qM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 937E210CF1C;
        Thu, 27 Jan 2022 16:35:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB30910CF1B;
        Thu, 27 Jan 2022 16:35:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v9 9/9] grep: simplify config parsing and option parsing
References: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
        <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
        <patch-v9-9.9-445467e87f7-20220127T115058Z-avarab@gmail.com>
        <xmqq35l82a7i.fsf@gitster.g>
Date:   Thu, 27 Jan 2022 13:35:09 -0800
In-Reply-To: <xmqq35l82a7i.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        27 Jan 2022 12:30:09 -0800")
Message-ID: <xmqqpmoczwtu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0157A49A-7FB9-11EC-87E7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Would this also work?
>
> 	-c grep.extendedRegexp=false \
> 	-c grep.patternType=default \
> 	-c grep.extendedRegexp=true
>
> We do keep extendedRegexp, but as soon as we read .patternType that
> is default, adjust_pattern_type() overwrites the pattern_type_option
> member with BRE, and the fact that .patternType was specified as "do
> whatever the .extendedRegexp says" is lost when we read the third
> one.
>
> So, no, I am not sure this is correct.
> ...
> But as I said, "committing" ERE vs BRE in this manner is probably
> way too early and produce an incorrect result.  Instead ...
>
>> @@ -490,9 +446,9 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
>
> ... this is the right place to do the "see if pattern_type_option is
> 'default' and if so use 'extended_regexp_option' to commit to either
> BRE or ERE".
>
> I guess that is what I have been repeating during the review of the
> past few rounds.  Am I overlooking some other cases where that
> simpler-to-explain approach does not work?
> ...
>>  	.max_depth = -1, \
>> +	.extended_regexp_option = -1, \
>
> I do not think you meant this.  Uninitialized grep.extendedRegexp
> defaults to 0 (BRE), I think.

Taking all together, here is a squashable fix with an additional
test.

In addition to squashing the following in, we must update the
proposed log message.  Given that, even after taking _this long_ (I
think I have been saying this since the review of v5 iteration),
this series is still making the same mistake again, the fact that
the code needs to read all the configuration variables before it can
correctly decide what type the user really means deserves to be
stressed in the log message.

Despite what the proposed log message for this round (and many other
previous iterations) claimed, it fundamentally cannot be done inside
the callback, simply because the callback will not know how many
more times it will be called with what value for grep.patternType
and grep.extendedRegexp.  It can be done anywhere after the option
parser has finished reading all the options and knows there will not
be any more grep.patternType and grep.extendedRegexp that would
affect the computation.  One of the most natural such place is at
the beginning of compile_regexp(), I would think.

Other than that, all the previous steps looked good, so did the
parts of this commit that the attached fix-up does not touch.  It is
great that we do not have to carry "fixed", "pcre", etc. around as
separate members.

Thanks.

 grep.c          | 17 +++++------------
 grep.h          |  2 +-
 t/t7810-grep.sh | 10 ++++++++++
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git c/grep.c w/grep.c
index f07a21ff1a..a8f503f55c 100644
--- c/grep.c
+++ w/grep.c
@@ -48,12 +48,6 @@ static int parse_pattern_type_arg(const char *opt, const char *arg)
 
 define_list_config_array_extra(color_grep_slots, {"match"});
 
-static void adjust_pattern_type(enum grep_pattern_type *pto, const int ero)
-{
-	if (*pto == GREP_PATTERN_TYPE_UNSPECIFIED)
-		*pto = ero ? GREP_PATTERN_TYPE_ERE : GREP_PATTERN_TYPE_BRE;
-}
-
 /*
  * Read the configuration file once and store it in
  * the grep_defaults template.
@@ -68,17 +62,11 @@ int grep_config(const char *var, const char *value, void *cb)
 
 	if (!strcmp(var, "grep.extendedregexp")) {
 		opt->extended_regexp_option = git_config_bool(var, value);
-		adjust_pattern_type(&opt->pattern_type_option,
-				    opt->extended_regexp_option);
 		return 0;
 	}
 
 	if (!strcmp(var, "grep.patterntype")) {
 		opt->pattern_type_option = parse_pattern_type_arg(var, value);
-		if (opt->extended_regexp_option == -1)
-			return 0;
-		adjust_pattern_type(&opt->pattern_type_option,
-				    opt->extended_regexp_option);
 		return 0;
 	}
 
@@ -444,6 +432,11 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	int err;
 	int regflags = REG_NEWLINE;
 
+	if (opt->pattern_type_option == GREP_PATTERN_TYPE_UNSPECIFIED)
+		opt->pattern_type_option = (opt->extended_regexp_option
+					    ? GREP_PATTERN_TYPE_ERE
+					    : GREP_PATTERN_TYPE_BRE);
+
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
 	p->fixed = opt->pattern_type_option == GREP_PATTERN_TYPE_FIXED;
diff --git c/grep.h w/grep.h
index f89324e9aa..bdc6765482 100644
--- c/grep.h
+++ w/grep.h
@@ -181,7 +181,7 @@ struct grep_opt {
 	.relative = 1, \
 	.pathname = 1, \
 	.max_depth = -1, \
-	.extended_regexp_option = -1, \
+	.extended_regexp_option = 0, \
 	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
 	.colors = { \
 		[GREP_COLOR_CONTEXT] = "", \
diff --git c/t/t7810-grep.sh w/t/t7810-grep.sh
index 34d8f69c1d..b818e656ad 100755
--- c/t/t7810-grep.sh
+++ w/t/t7810-grep.sh
@@ -491,6 +491,16 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (ERE)" '
+		echo "${HC}ab:abc" >expected &&
+		git \
+			-c grep.extendedRegexp=false \
+			-c grep.patternType=default \
+			-c grep.extendedRegexp=true \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep $L with grep.patternType=extended and grep.patternType=default" '
 		echo "${HC}ab:a+bc" >expected &&
 		git \
