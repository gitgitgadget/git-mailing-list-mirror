Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4475D1FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 07:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932377AbdC3HUq (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 03:20:46 -0400
Received: from mx1.riseup.net ([198.252.153.129]:47081 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752733AbdC3HUp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 03:20:45 -0400
Received: from piha.riseup.net (unknown [10.0.1.163])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id EF9D61A232D;
        Thu, 30 Mar 2017 07:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1490858444; bh=ymYxK/xEWWAea4H6bZryJC/W7UEwI8W1kSnvio9dWWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7wfLtl/9KBMezOAbh8hIFltdEfuw9ZzHjB6rN+MsS9BDqC3+gxshNv3dgvdsGKfj
         WsfkELLWojo9W/ObMlEmWpV2RYFDTfbOQI2U/z82GhQW03SBFSGXGMBhH6VEhQa9Vc
         bGanWyVQ6ePkMAPWiVI/wst+WlvLdrKOdAgFa704=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: pickfire)
        with ESMTPSA id AA3C91C0534
Date:   Thu, 30 Mar 2017 15:20:38 +0800
From:   Ivan Tham <pickfire@riseup.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add build-in pattern for shell
Message-ID: <20170330072038.GA17735@riseup.net>
References: <20170329165331.17742-1-pickfire@riseup.net>
 <xmqqzig49e4j.fsf@gitster.mtv.corp.google.com>
 <20170330022822.YGyP5YgSE%pickfire@riseup.net>
 <xmqqefxf7038.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqefxf7038.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 11:25:15PM -0700, Junio C Hamano wrote:
>Pickfire <pickfire@riseup.net> writes:
>
>>> > +- `sh` suitable for source code in POSIX-compatible shells.
>>>
>>> The new test you added seems to show that this is not limited to
>>> POSIX shells but also understands bashisms like ${x//x/x}.  Perhaps
>>> drop "POSIX-compatible" from here
>>
>> Those shells are still POSIX-compatible so I think it is true to put
>> that or otherwise, something like fish shell will break since it is
>> as well a shell but the syntax is totally different.

Okay, I will change it from POSIX-compatible to POSIX-like.

>Scripts with bash-isms are not necessarily usable by POSIX compatible
>shells (think "dash") and this highlighter recognises bash specific
>enhancements (which by the way is a plus), so if you absolutely want to
>say "POSIX something" in order to clarify that csh and friends do not
>apply, say "POSIX-like".
>
>>> 	...[ \t]*\\(\\)[\t]*....
>>
>> Ah, I think I forgot to escape the quoting of ( and ). I will send in
>> another patch for that.
>
>OK.  Note that we usually avoid applying a patch whose brokenness was
>noticed while review (which then necessitates a follow up patch "oops,
>the previous was botched; here is a fix-up").  The "another patch"
>needs to be a v2, i.e. pretending as if the version of the patch we are
>discussing never happened, not an incremental on top of the patch we
>are discussing..

Yes, I will put in a V2 which comes with "[PATCH v2]" in reply to this
thread.

>>> > +	 /* -- */ +
>>> > "(\\$|--?)?([a-zA-Z_][a-zA-Z0-9._]*|[0-9]+|#)|--" /* command/param
>>> > */
>>>
>>> TBH, I have no idea what this line-noise is doing.
>>
>> That breaks word into "a", "$a" and "-a" as well as "$1" and "$#". I
>> tried supporting $? by adding +|#|\\?)--" but it doesn't seemed like
>> it is working.
>
>This ...

???

>>> $foobar, $4, --foobar, foobar, 123 and -- can be seen easily out of
>>> these patterns.  I am not sure what --# would be (perhaps you meant
>>> to only catch $# and --# is included by accident, in which case it
>>> is understandable).  It feels a bit strange to see that $# is
>>> supported but not $?; --foo but not --foo=bar; foobar but not "foo
>>> bar" inside a dq-pair.
>>
>> Yes, getting --# will be very rare in shell. I think it is better to
>> seperate the --foo=bar into --foo and bar. I don't get what you man
>> by the dq-pair.
>
>These design decisions (e.g. what you decided are the tokens to be
>taken as a word---taking "--foo" and "bar" as separate things when
>given "--foo=bar" is a good example but with this regexp you are making
>many other design decisions) need to be explained in the log message.
>A string inside a double-quote pair is taken as a single parameter to
>the shell, e.g.
>
>    cmd "arg that is quoted inside double-quote pair" $#
>
>It is unclear what your regexp is doing to such an argument.

Okay, I will put that into the log. I still don't quite know what you
want to achieve with:

    cmd "arg that is quoted inside double-quote pair" $#

If I am correct, you are probably talking about:

    "cmd "arg that is quoted inside double-quote pair" $#"

That will be handled with other words together.

>>> > +	 "|\\$[({]|[)}]|[-+*/=!]=?|[\\]&%#/|]{1,2}|[<>]{1,3}|[ \t]#.*"),
>>>
>>> And this one is even more dense.
>
>FYI, this is also pointing out the need to explain what kind of things
>you wanted to recognise as words; explaining in a reply message is a
>good first step, as the questioner may find the explanation in your
>response still inadequate, in which case you have a chance to refine
>it, but the ultimate goal is to put the polished explanation that would
>help people who later want to understand what you added to the codebase
>by describing what you wanted to do with the change in either in-code
>comment or commit log message when you send an updated patch.

Ah, I can point it out here:

\\$[({]           start of $( or ${
[)}]              ends ^
[-+*/=!]=?        operators
[\\]&%#/|]{1,2}   pipes and stuff like ${a##a} or &&
[<>]{1,3}         io redirections
[ \t]#.*          comments

I hope that makes it clear and concise.

-- 
Do what you like, like what you do.  -- Pickfire
