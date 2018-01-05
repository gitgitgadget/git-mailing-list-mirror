Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4CE31F428
	for <e@80x24.org>; Fri,  5 Jan 2018 19:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbeAETTW (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 14:19:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65129 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeAETTV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 14:19:21 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAA86CC4E3;
        Fri,  5 Jan 2018 14:19:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VRj23rIDe2oD3aB+qXykMle7j7Y=; b=ml6XFd
        wVncKSvnaACcLBFDE6wjRCxv7IXWz2WA24V2MY7rJd3Pt4FGXdoJyYpSrMATsnlO
        XA37tIR4LC6NoZFOdiFZK3ZNQxYXFeACh8R8b531Xv3fQGtUhOFuZVpPexibSPmG
        88IYDOm7f70D8PbO4dkRrpH6evfE6jWrLltB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nG0yzyN7HifHN9Qg/fya+d0wi+3zdcbP
        qGfdqtTkAsaqzUm7zgdBPptFh130iM/Rnp4Q8lXS89LzASgc8MwOadVXuf0vnqKU
        t5viqyvYywwwGcnzjhYR7az5Honp+H2+tmqa4JXmo4O8PWzMr82jFlGtAXrtJGeh
        T8HtWnWPrcI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2BDCCC4E2;
        Fri,  5 Jan 2018 14:19:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DCC9CC4E1;
        Fri,  5 Jan 2018 14:19:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Stephan Janssen <sjanssen@you-get.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] clone: factor out dir_exists() helper
References: <20180102210753.GA10430@sigill.intra.peff.net>
        <20180102211014.GC22556@sigill.intra.peff.net>
        <xmqqbmi9dw55.fsf@gitster.mtv.corp.google.com>
        <20180104235412.GA3474@sigill.intra.peff.net>
        <20180105002206.GB3474@sigill.intra.peff.net>
Date:   Fri, 05 Jan 2018 11:19:19 -0800
In-Reply-To: <20180105002206.GB3474@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 4 Jan 2018 19:22:06 -0500")
Message-ID: <xmqqo9m8cdvs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 547D9268-F24D-11E7-B22F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jan 04, 2018 at 06:54:12PM -0500, Jeff King wrote:
>
>> > If we really want to be anal, perhaps a new helper path_exists()
>> > that cares only about existence of paths (i.e. the implementation of
>> > these two helpers they currently have), together with update to
>> > check the st.st_mode for file_exists() and dir_exists(), may help
>> > making the API set more rational, but I do not think it is worth it.
>> 
>> Yep, I also considered that file_exists() probably wants to be
>> path_exists() with its current implementation. We'd probably want to
>> review all of the callers.
>> 
>> Anyway, I tried to do the minimal refactoring here, with no change in
>> behavior. I'm not opposed to calling this dir_exists() as path_exists()
>> and making it globally available (as you note, I don't think we'd want
>> to use a true dir_exists() here).
>
> So I actually started down this road just now, but I'm not sure if it's
> worth it.

Yeah, although I said it already without starting down this road,
you actually thought about it more and your insight is more valuable
;-)

> If we were to transition to an endgame with path_exists(),
> dir_exists(), and file_exists(), we'd probably want to do something
> like:
>
>   1. introduce path_exists(), but leave existing file_exists() callers
>      in place
>
>   2. introduce file_exists_as_file(), which checks S_IFREG
>
>   3. audit each file_exists() call to see if it ought to be
>      path_exists() or file_exists_as_file() and convert as needed
>
>   4. When there are no more file_exists() calls left, all
>      file_exists_as_file() instances can be renamed to file_exists().
>
> But as with any "audit each..." plan, that leaves topics in flight out
> of luck. If we want to be kind to those, we'd have to wait a long while
> to shake out any file_exists() callers.
>
> At which point is there much value in having path_exists() as a wrapper?
> It's a better name, perhaps, but I think my future-proofing against
> "file_exists() may become file-specific" was probably overly paranoid. I
> don't think we could sanely do that conversion without risking breakage.

If we want to, the endgame can be to have a single path_exists_as()
helper that could be used like so:

	#define PATH_TYPE_IFREG	(1<<0)
	#define PATH_TYPE_IFLNK (1<<1)
	#define PATH_TYPE_IFDIR (1<<2)
	#define PATY_TYPE_IFANY ((1<<3)-1)

	#define path_exists(path) path_exists_as(path, PATH_TYPE_ANY)
	#define path_exists_as_file(path) path_exists_as(path, PATH_TYPE_IFREG)

	/* backward compatibility */
	#define file_exists(path) path_exists_as(path, PATH_TYPE_ANY)

We can avoid "file-exists used to mean this thing but in a distant
future it means completely different thing" that way.

> Maybe we should just document its behavior and use it here, rather than
> introducing this new dir_exists().

Sounds good enough to me ;-)
