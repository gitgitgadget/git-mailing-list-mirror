Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F891F461
	for <e@80x24.org>; Tue,  9 Jul 2019 04:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfGIEzJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 00:55:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64522 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGIEzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 00:55:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21DF5150169;
        Tue,  9 Jul 2019 00:55:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SiZbm2gfEyYYzyOv3la48twvovg=; b=ImMU9b
        u5GgLZJQ12cmTMwRrEWZvmO06rPjpWY6i7Ez5oxHHBbOKllJB3q59UWE1KzPCNEA
        nPGfyNcuzMOAbxLXcSuFSE/KQ9PCrbsPu93boJT7baOERVmowtSrx9Y4DijXLLrG
        kNvMCo7IrDFM5GhuJ3SkjDtcoJBclE4GdCsn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lkTKLBp97MmgEcw6BuaululXDm0aGZIQ
        HuASO1s36twCCWg5zfoIVXkPvLgVxlaaHxaCV9Nq7zZQ/iGAzEb2ymqw7My4pUNU
        fi2BEoBvhVKD54fUUqap+gfCgwaXu86JKLAUzhCjKba+2EHcT2KiDyB2HISmTNMU
        xyslQe3e4Hw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18B25150168;
        Tue,  9 Jul 2019 00:55:04 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABA0D150163;
        Tue,  9 Jul 2019 00:55:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     paulus@samba.org, max@max630.net, git@vger.kernel.org
Subject: Re: [PATCH] gitk: fix --all behavior combined with --not
References: <20190704080907.GA45656@book.hvoigt.net>
        <xmqq4l3wz6y8.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 08 Jul 2019 21:55:00 -0700
In-Reply-To: <xmqq4l3wz6y8.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 08 Jul 2019 12:01:35 -0700")
Message-ID: <xmqqr26zx0wr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B647E868-A205-11E9-9E7F-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Heiko Voigt <hvoigt@hvoigt.net> writes:
>
>> In commit 4d5e1b1319 ("gitk: Show detached HEAD if --all is specified",
>> 2014-09-09) the intention was to have detached HEAD shown when the --all
>> argument is given.
>
> The "do we have --all?" test added by that old commit is not quite
> satisfying in the first place.  E.g. we do not check if there is a
> double-dash before it.  This change also relies on an ancient design
> mistake of allowing non-dashed options before a dashed one, adding
> more to dissatisfaction by making a future change to correct the
> design mistake harder.

Actually, I do not think this patch is a good idea.

This command

   $ git rev-list $commit --not --all

is a good way to ask "See if $commit is anchored to the repository
with any of refs or HEAD".  It does so by marking the tips of all
refs and HEAD as negative (i.e. stop the travesal) endpoints and
mark given $commit as a positive endpoint.

The commits listed by feeding the output of the above to the
rev-list command would be the ones that are only reachable by
$commit and not any of the refs.

The "--all" in rev-list family (including "git log") unconditionally
include HEAD.  The glitch here is that "--all" in rev-parse does
not.  And 4d5e1b1319 was an attempt to "fix" that, i.e. make "--all"
imply "HEAD".  That is, the original code we can see in your patch
appends "HEAD" to the list of args, so

   $ gitk $commit --not --all

ends up in running

   $ git rev-parse $commit --not --all HEAD

and the result are used as the traversal endpoints (aka "arguments
to rev-list command").  And that is exactly what the user wants to
see happen.

But you do not want to *prepend* HEAD to make the command line look
this way:

   $ git rev-parse HEAD $commit --not --all

which I think is what your patch does.  It asks a completely
different question: what are the commits reachable from either HEAD
or $commit that are not reachable from any of our refs?

What you want to do is to make sure your additional "HEAD" always
goes together with the existing "--all" the user gave you.

As the code is _already_ finding the _exact_ location on the command
line where "--all" appears, I think you can go one step further and
make sure you insert the "HEAD" immediately after "--all", as that
exactly matches what you (and the ancient 4d5e1b1319) are trying to
achieve: pretend as if "--all" always include "HEAD", even when it
is detached.

This is orthogonal to the question I posed in my earlier reply
(i.e. "we found --all; is it really a 'give me all refs' request
given by the user, or something else (is it an argument to another
option, like "--grep '--all'", or is it pathspec after '--'), but
assuming that we have reliably found the "--all" on the command line
the user meant as "give me all refs", I think inserting HEAD
immediately after that location would be the right solution.  It is
incorrect to unconditionally append as your original example shows,
but it is equally incorrect to unconditionally prepend.
