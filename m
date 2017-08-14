Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D9420899
	for <e@80x24.org>; Mon, 14 Aug 2017 20:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbdHNUhQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 16:37:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54473 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752124AbdHNUhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 16:37:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71E18961C7;
        Mon, 14 Aug 2017 16:37:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7ZnzS4GAb4azk7xf/GiLIapM2Ik=; b=hQm5G5
        yAfSiWcUdU4sYoqVhAHSpV0QC9uiwmZUkIqAgIDgyPmYTjkP5csOrH0t2dxBQUMf
        vYAYw14RguJVjvGI2dgGN0DpOwImFW6ZiN13WCRusJPxbsOO0Ng6FwsJ6Ko4qS9D
        HUI1xCuVDChct3loBT5UJCqWS8pMY9Qdr+/UM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=enJlWAc1zoHXu78Li3alipLmGaeoK64c
        Y4mvbtX+DqdLOgK7y+Cz/DlPbNcqo5NkuQ1YrBQX8VGuXfdlK1O0t+oVyH4YYWXW
        2Cztx0KMUR2j/QcPL3PowM0bMGvxr60w5vJrgiPGsgVHNkbg4XRRBZcul/NqeZPL
        QsE4nffshQk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AC92961C4;
        Mon, 14 Aug 2017 16:37:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C91559615D;
        Mon, 14 Aug 2017 16:37:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] stash: prevent warning about null bytes in input
References: <20170814050801.7158-1-me@ikke.info>
        <xmqq7ey6udvl.fsf@gitster.mtv.corp.google.com>
        <20170814203246.GA3839@alpha.vpn.ikke.info>
Date:   Mon, 14 Aug 2017 13:37:06 -0700
In-Reply-To: <20170814203246.GA3839@alpha.vpn.ikke.info> (Kevin Daudt's
        message of "Mon, 14 Aug 2017 22:32:46 +0200")
Message-ID: <xmqqpobxubrh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5722B41E-8130-11E7-AFD0-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> On Mon, Aug 14, 2017 at 12:51:26PM -0700, Junio C Hamano wrote:
>> Kevin Daudt <me@ikke.info> writes:
>> 
>> > The no_changes function calls the untracked_files function through
>> > command substitution. untracked_files will return null bytes because it
>> > runs ls-files with the '-z' option.
>> >
>> > Bash since version 4.4 warns about these null bytes. As they are not
>> > required for the test that is being done, remove null bytes from the
>> > input.
>> 
>> That's an interesting one ;-)
>> 
>> I wonder if you considered giving an option to untracked_files
>> helper function, though.  After all, it has only two callers,
>> and it feels a bit suboptimal to ask the command to do a special
>> thing (i.e. "-z") only to clean it up with a pipe.
>
> As a matter of fact, I did not consider that option. I do agree that's a
> much better approach.
>
>> 
>> IOW, something along the lines of (totally untested)...
>> 
>
> How should I proceed with this? Resubmit it after testing with the
> appropriate attribution?

Sure.  

An appropriate attribution would be a "Helped-by: me" at most, but I
do not think for something this small it may not even bee needed.

>
>>  git-stash.sh | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/git-stash.sh b/git-stash.sh
>> index 9b6c2da7b4..5f09a47f0a 100755
>> --- a/git-stash.sh
>> +++ b/git-stash.sh
>> @@ -43,9 +43,16 @@ no_changes () {
>>  }
>>  
>>  untracked_files () {
>> +	if test "$1" = "-z"
>> +	then
>> +		shift
>> +		z=-z
>> +	else
>> +		z=
>> +	fi
>>  	excl_opt=--exclude-standard
>>  	test "$untracked" = "all" && excl_opt=
>> -	git ls-files -o -z $excl_opt -- "$@"
>> +	git ls-files -o $z $excl_opt -- "$@"
>>  }
>>  
>>  clear_stash () {
>> @@ -114,7 +121,7 @@ create_stash () {
>>  		# Untracked files are stored by themselves in a parentless commit, for
>>  		# ease of unpacking later.
>>  		u_commit=$(
>> -			untracked_files "$@" | (
>> +			untracked_files -z "$@" | (
>>  				GIT_INDEX_FILE="$TMPindex" &&
>>  				export GIT_INDEX_FILE &&
>>  				rm -f "$TMPindex" &&
>> 
>> 
