Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4050C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352072AbiCXQ4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352104AbiCXQzy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:55:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FC6B0D0C
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:52:52 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56E19103266;
        Thu, 24 Mar 2022 12:52:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d+TWaADshG64x9Rfyzf7eJlNXd4q2QwkaiZik5
        /h+v0=; b=fsOo/CYc3lZCZnsPxI0lyS2SlwFJUDz6CIyiLBk/n147G2Hdyze/vZ
        gjFbL6eAUySIXfrlBD5CeG7Li4Jne9kEVnG/ZCkGeMTADNwA/0mAKSjZRdaiowIG
        tFM2svlyuPDsQNdlKLRR1EBEq0hUFk3FnAJwBfwE1bzC3Sw0fUazA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CEF7103264;
        Thu, 24 Mar 2022 12:52:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F255103261;
        Thu, 24 Mar 2022 12:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando <greenfoo@u92.eu>
Cc:     git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [PATCH v5 1/3] vimdiff: new implementation with layout support
References: <20220319091141.4911-1-greenfoo@u92.eu>
        <20220319091141.4911-2-greenfoo@u92.eu> <xmqqsfr8sjpl.fsf@gitster.g>
        <29c787c2-8916-4d04-85c1-a4c0597b9848@www.fastmail.com>
Date:   Thu, 24 Mar 2022 09:52:47 -0700
In-Reply-To: <29c787c2-8916-4d04-85c1-a4c0597b9848@www.fastmail.com>
        (Fernando's message of "Thu, 24 Mar 2022 13:21:05 +0100")
Message-ID: <xmqqee2rl2cg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D611F62C-AB92-11EC-A994-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando <greenfoo@u92.eu> writes:

>> > +debug_print() { 
>> > +	# Send message to stderr if global variable DEBUG is set to "true"
>> > +
>> > +	if test -n "$GIT_MERGETOOL_VIMDIFF_DEBUG"
>> > +	then
>> > +		>&2 echo "$@"
>> > +	fi
>> > +}
>> 
>> Do we want to keep this helper, and many calls to it sprinkled in
>> this file, or are they leftover cruft?
>
> I left it in case we ever need to debug this script in the future. But if you
> think it's not worth it, I can delete it. We have three options:
>
>   A) Leave it
>   B) Completely remove it
>   C) Remove the function and replace the places where it is being called by
>      a commented out "echo" to stderr
>
> Let me know what you prefer.

If you anticipate that you'd need more debugging sessions as time
goes and people want to try to come up with different layouts, (A)
is preferrable, I would think.

>> We should be able to do this no external commands
>> and just two variable substitutions and without relying on
>> bash-isms, but the above should do.
>
> In v1 of this patch series, instead of this function, I was doing this other
> thing:
>
>     X=${Y:a:b}
>
> ...but that is a bash-ism, so I replaced it with what you see above ("echo" +
> "cut")

Yes, I think I was the one who spotted the bash-ism in an earlier
round, if I am not mistaken.

> I was not able to find another way of doing it using just standard POSIX shell
> syntax [1] (notice that "cut" is included in IEEE Std 1003.1 [2] so it shouldn't
> be an issue to rely on it)

Although "echo" is often built-in, "cut" and pipe mean a fork to
create an extra process, which some folks may want less of.

> In any case, if anyone knows how we could achieve the same without using
> external commands, please let me know and I'll change it (in the meantime I'll
> keep searching for alternatives too). If after a reasonable amount of time none
> of us manages to find a solution I suggest to leave it as it is now.

I already said that this is good enough for now, didn't I?  But see
below, and do not use it, it should work but it is uglier than a
simple single liner pipe.

>> I wonder if there were an easy way to "compare" the $FINAL_CMD this
>> new code feeds to $merge_tool_path and what was fed to it by the
>> original code to show that we are not regressing what the end user
>> sees.
>> 
>> The "run_unit_tests()" only compares the cmd generated for each
>> given layout, but the original vimdiff$N didn't express them in
>> terms of $layout this patch introduces, so unfortunately that is not
>> it.
>> 
>> Ideas?
>
> Before this patch series, this is what each variant fed into "$merge_tool_path":
>
>   - vimdiff:
>       -f -d -c '4wincmd w | wincmd J' $LOCAL $BASE $REMOTE $MERGED
>
>   - vimdiff1:
>       -f -d -c 'echon "..."' $LOCAL $REMOTE
>
>   - vimdiff2:
>       -f -d -c 'wincmd l' $LOCAL $MERGED $REMOTE
>
>   - vimdiff3:
>       -f -d -c 'hid | hid | hid' $LOCAL $REMOTE $BASE $MERGED
>
> After this patch series, when one of these predefined variants is selected, a
> fixed layout is chosen and translated into the final string fed into
> "$merge_tool_path":
>
>   - vimdiff --> (LOCAL,BASE,REMOTE)/MERGED
>       -f -c "echo | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis" -c "tabfirst" $LOCAL $BASE $REMOTE $MERGED
>
>   - vimdiff1 --> @LOCAL,REMOTE
>       -f -c "echo | vertical split | 1b | wincmd l | 3b | tabdo windo diffthis" -c "tabfirst" $LOCAL $BASE $REMOTE $MERGED
>  
>   - vimdiff2 --> LOCAL,MERGED,REMOTE
>       -f -c "echo | vertical split | 1b | wincmd l | vertical split | 4b | wincmd l | 3b | tabdo windo diffthis" -c "tabfirst" $LOCAL $BASE $REMOTE $MERGED
>
>   - vimdiff3 --> MERGED
>       -f -c "echo | 4b | bufdo diffthis" -c "tabfirst" $LOCAL $BASE $REMOTE $MERGED
>
> Thus, we need to do two things:
>
>   1. Manually check (one time operation) that the *before* and *after* strings
>      are equivalent (from the point of view of vim).

Yes, and it is a good way to convey that the author did sufficient
due diligence to note in the proposed commit log message (1) these
two sets of actual vim commands, and (2) the fact that the author
made sure these "not literally identical" command line options
produce identical results for these existing modes.

>   2. Add a unit test that verifies that the layout associated to each variant
>      actually produces the string listed above. That way we make sure the
>      functionality does not break in the future.

Have a comment next to each of these four layout tests what variant
from pre-layout era it correspnds to, if you haven't done so.

> Step (1) is what I have already done (but I encourage others to do the same...
> the more eyes the better).
>
> Step (2)... is already done! Notice how, on the "run_unit_tests()" function,
> these layouts correspond to test cases numbers #07, #09, #01 and #10 :)
>
>   NOTE: While re-reviewing this, I noticed the layout definition for "vimdiff1"
>         was set to "@LOCAL,MERGED" instead of "@LOCAL,REMOTE", which is the
>         correct value. I'll fix this in v6.
>
> Should this be considered enough test for backwards compatibility?

Yes, with a bit to extend the proposed log message to help #1, and a
bit of comments next to the test cases to help #2.

Thanks.




#!/bin/sh
substring () {
	STRING=$1 START=$2 LEN=$3

	local strip= 
	while test 0 -lt "$START"
	do
		strip="?$strip"
		START=$(($START - 1))
	done
	if test -n "$strip"
	then
		STRING=${STRING#$strip}
	fi
	strip=
	COUNT=$(( ${#STRING} - $LEN ))
	while test 0 -lt "$COUNT"
	do
		strip="?$strip"
		COUNT=$(($COUNT - 1))
	done
	if test -n "$strip"
	then
		STRING=${STRING%$strip}
	fi
	echo "$STRING"
}

while read string start len
do
	substring $string $start $len
done

