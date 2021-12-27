Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445D0C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 18:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhL0SvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 13:51:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56955 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhL0SvD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 13:51:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7657F6E9C;
        Mon, 27 Dec 2021 13:51:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=G/wMiS9NJnqZTCom7N+ry21ymAJiZHKw/KdPPaD8EaI=; b=aNJN
        RTAVatvBPWVZ6OLLlUu8bGsiLv8hmMEH69wy9ZhEF9+Peeu6uwOCOomH7PIV8W4+
        QZhYbiY+veDj8vcIoj7prPxeVkLEEZey0tSDK3cLRsqW3KZ8gfBuSJ1TH2uaHjAC
        U6cmm2rgxtafPRMT16zpl6gZMoY+d9TvHXL2t64=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDEAAF6E9B;
        Mon, 27 Dec 2021 13:51:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D8C3F6E99;
        Mon, 27 Dec 2021 13:51:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v6 7/7] grep: simplify config parsing and option parsing
References: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
        <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
        <patch-v6-7.7-88dfd40bf9e-20211226T223035Z-avarab@gmail.com>
        <xmqqpmpid1jc.fsf@gitster.g>
Date:   Mon, 27 Dec 2021 10:51:00 -0800
Message-ID: <xmqq4k6tyj8r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0356462-6745-11EC-9386-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The above does not look correct at all.
>
> What happens when the configuration parser sees these configuration
> variables in this sequence:
>
>  - grep.patternType set to say "pcre" (or anything not "default").
>  - grep.extendedRegexp set to "true".
>  - grep.patternType set to "default".
>
> After these three variable definitions with the usual "last one
> wins" (for each variable independently), the last value for the
> grep.patternType variable is "default", and the last value for
> the grep.extendedRegexp variable is "true".  The user wants to use
> the ERE patterns.

By the way, the example I gave you for the previous round, and
similarly the one in the message I am responding to were all written
to help you realize that it is simply a broken approach if we do not
keep "default" as default and instead resolve it to either "basic"
or "extended" too early.  The goal of these examples was *NOT* to
tell you "this single thing is broken with the code in this round so
let's fix it".

It seems I am not succeeding in conveying that point, and specially
I smell that in the change between v5 and v6.

So let me try to be a bit more explicit.  Let's not do another round
of "I think this is a moral equivalent of what you want, even though
it is not done the way you suggested." I think we wasted a reroll or
three with that attitude in changes leading to v6 already, after I
gave my review to v5, and I think the v5 review essentially was a
repeat of my review for v3's 3/7, so if I conveyed the point clearly
enough back then, perhaps we didn't have to waste your time on v4
and v5, either.  Sorry about that.

So, here is what this step of the series SHOULD do:

 * Use two members to keep track of the final configuration value we
   saw for grep.patternTYpe and grep.extendedRegexp independently.
   The existing .fixed and .pcre2 fields are superfluous.  But no
   more "ah, we see patternType so let's ignore extendedRegexp"
   games.

 * When parsing the command line options -G, -E, etc., update the
   .patternType member with the value found.  We do not want to and
   need to touch .extendedRegexp member, whose SOLE purpose should
   be to keep track of "what the last value we saw for
   grep.extendedRegexp configuration variable".

 * Do ALL THE ABOVE while keeping "default" in the .patternType
   member as "default" as-is given by the user; do not turn it into
   "basic" or "extended" in config callback at all.

 * At some point of your choice between the time we finished parsing
   both configuration variables and command line options and the
   time we compile the pattern string to regexp objects of various
   types, look at the .patternType member and resolve it into
   basic/extended IFF it is set to default, using .extendedRegexp
   member (for this to work correctly, it is important not to let
   -E/-G command like options to touch .extendedRegexp member---it
   should be used ONLY to keep track of "what the last value we saw
   for grep.extendedRegexp configuration variable").

 * After the above step is done, .extendedRegexp member is no longer
   needed and we can compile the pattern using only the value in
   .patternType member.

The penultimate bullet point gives us a wiggle room to lose the
"commit" thing and delay it until the very last moment, the function
that decides to call which regexp engine's regcomp.  The important
thing is that we cannot lose the value "default" from .patternType
field or lose the last value given to .extendedRegexp field too
early, namely, before we have read all the configurtion streams and
know the last value for these two variables.

Thanks.  Hopefully I was clear enough this time.

----- >8 ---- ----- >8 ---- ----- >8 ---- ----- >8 ---- ----- >8 -----
Subject: [PATCH] fixup! grep tests: add missing "grep.patternType" config tests

---
 t/t7810-grep.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 664f884e12..2e2829ee55 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -471,6 +471,16 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently" '
+		echo "${HC}ab:abc" >expected &&
+		git \
+			-c grep.patternType=fixed \
+			-c grep.extendedRegexp=true \
+			-c grep.patternType=default \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep $L with grep.patternType=extended and grep.patternType=default" '
 		echo "${HC}ab:a+bc" >expected &&
 		git \
-- 
2.34.1-568-g69e9fd72b5

