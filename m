Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA391F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 02:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfJ1CWv (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 22:22:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59832 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfJ1CWv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 22:22:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A32197164;
        Sun, 27 Oct 2019 22:22:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NTTqNLG00cisRVHf+J7ckncPpbc=; b=jclVUL
        IdVvuBJiFZS/Ha/t+EY8TW/EJgwqfevd96URU7dbk0TQwU4ag3OdMwaqt8+NXya1
        +tPDMb4nSKS1JwMwGPXHiCoVE59zxrJKRGNk2C5UbOOOpZr98cauyrlbHY04tEf9
        p8x1f59bux9tdhLciVXlwtgyfPlNH4rta9ejE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SHpwFMBoY7QCU4IFZyBHGlr7lSLOkPlr
        2nnZc8t8CYOhvStLsD9s8tPSDbjkmhTQdVaZGq4wqhJUJ9yJfiPTX7WE7hddjCbv
        haJFf9TGTCCl1OTdIZrrIem/qTwdQscRbvD3r3qqCSd4xdQ0OK6qRhAZ6dRpPV42
        2s8e1Dw1668=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5239497163;
        Sun, 27 Oct 2019 22:22:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3521F97162;
        Sun, 27 Oct 2019 22:22:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Outreachy] [PATCH] dir: add new function `path_exists()`
References: <20191027163038.47409-1-mirucam@gmail.com>
Date:   Mon, 28 Oct 2019 11:22:40 +0900
In-Reply-To: <20191027163038.47409-1-mirucam@gmail.com> (Miriam Rubio's
        message of "Sun, 27 Oct 2019 17:30:38 +0100")
Message-ID: <xmqqy2x5a9sf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1EAF2A6-F929-11E9-A3AB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> Added a new function path_exists() that works the same as file_exists()
> but with better descriptive name.

"I did this" before justifying why it is a good thing is not a good
description.

	builtin/clone.c has a static funciton dir_exists() that
	checks if a given path exists on the filesystem.  It returns
	true (and it is correct for it to return true) when the
	given path exists as a non-directory (e.g. a regular file).

	This is confusing.  What the caller wants to check, and what
	this function wants to return, is if the path exists, so
	rename it to path_exists().

would make sense (and follows our convention to command the codebase
to "become like so").

> New calls should use path_exists() instead of file_exists().

This is not a good suggestion in general, and I do not want to see
such a statement here or (more importantly) not in the header file.
Calls that want to see if the path exists, regardless of type,
should use path_exists() instead of file_exists().  Other calls that
should be checking if a regular file exists there should continue to
use file_exists().  Once we finished sweeping code, one of two
things could happen:

 (1) there remains no caller to file_exists()---it turns out that
     everybody wanted to check if there is something at the given
     path, no matter what type of filesystem entity it is.  In such
     a case, we can safely remove file_exists().

 (2) there are legitimate callers to file_exists()---these callers
     used "does stat() succeed?" without checking if the filesystem
     entity at the path is indeed a regular file, but that was what
     they wanted to do.  In such a case, we can tighten the check in
     file_exists() to also make sure that we saw a regular file.

If you audited all existing callers of file_exists() as a part of
preparing this topic, and if the result is (1) above, then I think
this single patch as the whole of this topic is OK.  But if so, the
proposed log message should state that fact to justify the above
statement.  Also we may want to remove the implementation of
file_exists() and replace it with

	#define file_exists(path) path_exists(path)

in dir.h if we were to go that route.

I actually suspect that you would rather one to go in the other
direction, i.e. to narrow the scope of this topic and change the
dir_exists() to path_exists() inside builtin/clone.c, leaving the
function file-scope static, and stop there.  Unless/until all the
existing callers of file_exists() have been audited and we know all
of (or at least "most of") them want to ask "does anything exist at
this path?", that would be the more sensible thing to do.

Thanks.
