Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE90620756
	for <e@80x24.org>; Tue, 10 Jan 2017 19:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941626AbdAJTZ6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 14:25:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65298 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932326AbdAJTZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 14:25:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EB8E5D8BC;
        Tue, 10 Jan 2017 14:25:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rdirXbNzCZP6QBWitTH8T8SPliU=; b=J/8xlc
        sEfr3h1AgaTfJp2l0KvDxJwu4PZIODC647VZpjPhof6Oz2ppJDIPqhMMBPyQhEE3
        lGyqe47UYPrw0FG4kFDRxF2xe7U/lU8jmODuZ9FFX21bpyAZOX10tW/r4PtAoQZX
        ihc8tQNibS3grqbiuQcGN9wRbR+ZO8mlfhi68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DMIu0DKjA23EsLPOnJQeKjyGVDlzCtmQ
        bk3lkizkICvFsceZS2jEWVJmh1L42KNvE8qW4BdG11j9QJWmZ6EmZ0/LXuze7Yet
        PFbVYRAn74S3eWVco7ioPWQPpSqWeBhFoxDjAFa+bm/hb7caZddasXFl4lAojm5R
        c14XL06CvJI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 557935D8B0;
        Tue, 10 Jan 2017 14:25:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD9C15D8AE;
        Tue, 10 Jan 2017 14:25:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Richard Hansen <hansenr@google.com>, git@vger.kernel.org,
        davvid@gmail.com, sbeller@google.com, simon@ruderich.org
Subject: Re: [PATCH v4 14/14] mergetool: fix running in subdir when rerere enabled
References: <20170109054238.42599-1-hansenr@google.com>
        <20170109232941.43637-1-hansenr@google.com>
        <20170109232941.43637-15-hansenr@google.com>
        <3a09e318-f14b-5f14-a992-3bd045f0a4c6@kdbg.org>
Date:   Tue, 10 Jan 2017 11:25:52 -0800
In-Reply-To: <3a09e318-f14b-5f14-a992-3bd045f0a4c6@kdbg.org> (Johannes Sixt's
        message of "Tue, 10 Jan 2017 07:17:51 +0100")
Message-ID: <xmqqmveyson3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A60AABC-D76A-11E6-91C6-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> +	prefix=$(git rev-parse --show-prefix) || exit 1
>> +	cd_to_toplevel
>> +
>> +	if test -n "$orderfile"
>> +	then
>> +		orderfile=$(git rev-parse --prefix "$prefix" -- "$orderfile") || exit 1
>> +		orderfile=$(printf %s\\n "$orderfile" | sed -e 1d)
>
> Is the purpose of this complication only to detect errors of the git
> invocation? IMHO, we could dispense with that, but others might
> disagree. I am arguing because this adds yet another process; but it
> is only paid when -O is used, so...

I do not terribly mind an added process, but this change makes it
harder to read and also forces the readers to wonder if the quoting
around printf is correct.

>> @@ -461,14 +470,17 @@ main () {
>>  		then
>>  			print_noop_and_exit
>>  		fi
>> +	elif test $# -ge 0
>> +	then
>> +		files_quoted=$(git rev-parse --sq --prefix "$prefix" -- "$@") || exit 1
>> +		eval "set -- $files_quoted"
>
> BTW, the --sq and eval business is not required here. At this point,
> $IFS = $'\n', so
>
> 		set -- $(git rev-parse --sq --prefix "$prefix" -- "$@")
>
> will do. (Except that it would not detect errors.)

I thought you are suggesting not to use --sq but it is still there.
I think the original is written in such a way that any letter in
each of "$@" is preserved, even an LF in the filename.

Such a pathname probably won't correctly be given from the "rerere
remaining" side (i.e. when you are lazy and run mergetool without
pathname), so it may appear not to matter, but being able to give an
explicit pathname from the command line is a workaround for that, so
in that sense, it has value to prepare this side of the codepath to
be able to cope with such a pathname.

Unrelated, but I notice that in this:

    eval "set -- $(git rev-parse --sq --prefix "$prefix" -- "$@")"
    shift

"set" will get one "--" from its direct command line argument,
followed by "--" that comes out of rev-parse, and then the first
pathname (i.e. "$prefix/$1", if "$1" is relative).  Then the first
"--" is discarded and the second "--" that came out of rev-parse
becomes "$1", and the first pathname becomes "$2", etc.  We use
"shift" to get rid of "--" and move everything down by one.

It is my fault but it is a roundabout way to say:

    eval "set $(git rev-parse --sq --prefix "$prefix" -- "$@")"

I would think, and we should probably want to write this like so.
[PATCH v4 02/14] would probably want to be updated as well.

I can locally update them if everybody agrees it is a good idea.
