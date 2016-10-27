Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493D420193
	for <e@80x24.org>; Thu, 27 Oct 2016 18:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942450AbcJ0S3P (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 14:29:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51088 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S942386AbcJ0S3O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 14:29:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E942948307;
        Thu, 27 Oct 2016 14:29:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s5MUUiIC+IZH4cLQ/r030+n7cDI=; b=gea+QT
        eZvdLyX4KgB+sUudtjZuoXgxyUNfUO5U3CB3Ai564varM8jXkxOL95ibspyr1Vo7
        6l4YwQEr0RCdgRO8mh5/f2onEAy/krwKIBY8+DCGOkV+egRhTOuT8Qe8OjRsDdMA
        U6nRFnZzHV5j3DskIqWgqg43BhhUTp2qa3XAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F+M1TsclV1Bxrvg2zyDr+z4JCTSUFMiG
        pwP2RJ8pEhFtFzb/FkNkLCZHCHCDT61nypeXqv+GaXH6wpA9Af9BsCr34031yilM
        VZFvw15SMr0ep2WoIzuD1vIJE0HX8tm47ZJn2eScrEHj8DXssph8mRXvY7aFwlRD
        GIKsvM70hTU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DADDC48306;
        Thu, 27 Oct 2016 14:29:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55FC048305;
        Thu, 27 Oct 2016 14:29:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com
Subject: Re: [PATCH 32/36] pathspec: allow querying for attributes
References: <20161022233225.8883-1-sbeller@google.com>
        <20161022233225.8883-33-sbeller@google.com>
Date:   Thu, 27 Oct 2016 11:29:10 -0700
In-Reply-To: <20161022233225.8883-33-sbeller@google.com> (Stefan Beller's
        message of "Sat, 22 Oct 2016 16:32:21 -0700")
Message-ID: <xmqqzilp63yh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41FDD5B6-9C73-11E6-BF13-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The pathspec mechanism is extended via the new
> ":(attr:eol=input)pattern/to/match" syntax to filter paths so that it
> requires paths to not just match the given pattern but also have the
> specified attrs attached for them to be chosen.

I was looking at preload-index.c and its history again, because I
wanted to ensure that Lars's process filter stuff introduces no
unexpected interactions with getting multi-threaded, similar to the
problem we had in the earlier incarnations of this step, which we
worked around with <xmqqshwvvaxq.fsf@gitster.mtv.corp.google.com>
"pathspec: disable preload-index when attribute pathspec magic is in
use".

I think that Lars's series is safe, because the only thing among
what preload-index.c::preload_thread() does that can go outside the
simple stat data and pattern matching with the pathname is the
racy-git check in ie_match_stat(), and the object store access in
that call was explicitly disabled by 7c4ea599b0 ("Fix index
preloading for racy dirty case", 2008-11-17) long time ago.

By passing CE_MATCH_RACY_IS_DIRTY option to the call, this caller
effectively says "A cache entry whose stat data matches may be
actually dirty when the timestamp is racy, in which case we usually
compare data to determine if it really is clean, but it is OK to err
on the safe and lazy side by declaring it dirty and not marking it
up-to-date while we are preloading.  Do not bother to go to the
object store".

The reason why I am bringing this up in this discussion thread on
this patch is because I wonder if we would benefit by a similar
"let's not do too involved things and be cheap by erring on the safe
and lazy side" strategy in the call to ce_path_match() call made in
this function to avoid making calls to the attr subsystem.

In other words, would it help the system by either simplifying the
processing done or reducing the cycle spent in preload_thread() if
we could tell ce_path_match() "A pathspec we are checking may
require not just the pattern to match but also attributes given to
the path to satisfy the criteria, but for the purpose of preloading,
pretend that the attribute satisfies the match criteria" (or
"pretend that it does not match"), thereby not having to make any
call into the attribute subsystem at all from this codepath?

The strategy this round takes to make it unnecessary to punt
preloading (i.e. dropping "pathspec: disable preload-index when
attribute pathspec magic is in use" patch the old series had) is to
make the attribute subsystem thread-safe.  But that thread-safety in
the initial round is based on a single Big Attribute Lock, so it may
turn out that the end result performs better for this codepath if we
did not to make any call into the attribute subsystem.

I am probably being two step ahead of ourselves by saying the above,
which is just something to keep in mind as a possible solution if
performance in this preload codepath becomes an issue when the
pathspec has attributes match specified.
