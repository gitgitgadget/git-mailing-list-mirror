Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB01C433E3
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 19:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1D12076D
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 19:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TbVM/sii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgGQTxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:53:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51253 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgGQTxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 15:53:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94E7F6B614;
        Fri, 17 Jul 2020 15:53:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ejcOjepUr651foEOpecGKNEl5Wc=; b=TbVM/s
        iiDTd5YO3edDDGRVpciksc1OBiyZmPBGFpfM72ZuVKCMLuCDtS4gDwaSr1Jo6OlW
        e9bsRzfWvOWwp6n7PKTfZI6ftzIXFGA6JttMhItB9rXehvrB5hkTCejwMUxX7u6i
        8lYRYjUdIpDzUd5I8hgqg8656vYORCc9Rc2u4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JKjhqzJHTtOwpKFqAtx7Csz1t3nu8GPs
        8UogiKZR/XBmaRgUG3jzjggxF0XvcZKG5exgz5k11kiVRKQ8esEcYE5502AgBAO1
        cYoSTqC9mbWfWDLxq2kBbpvzeCEgFoZBYY9eIQfjqgD0llFriP9MLlld9ON11zVG
        lARRSyHrFMA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C0096B613;
        Fri, 17 Jul 2020 15:53:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FC586B612;
        Fri, 17 Jul 2020 15:53:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     "LTPCGO | George" <george@ltpcgo.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Issue with insufficient permission for adding an object to repository database .git/objects
References: <d6bbe71e47dcfd7ef31213537eeb3f05@ltpcgo.com>
        <CAPx1GvfKxu8gwbp0Gn2dBf9th874skKjD-echeAFr7_77o8FYw@mail.gmail.com>
Date:   Fri, 17 Jul 2020 12:53:20 -0700
In-Reply-To: <CAPx1GvfKxu8gwbp0Gn2dBf9th874skKjD-echeAFr7_77o8FYw@mail.gmail.com>
        (Chris Torek's message of "Thu, 16 Jul 2020 08:41:40 -0700")
Message-ID: <xmqq365pex5b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AA49FA2-C867-11EA-8AF1-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> What Git does is this:
>
>  * form the name of a file that we expect not to exist
>  * use an open() system call in this way:
>
>      fd = open(path, O_CREAT | O_EXCL | O_RDWR, 0444)
>
> Note that this is a single, atomic system call that asks
> the OS to:
>
>  1. make sure the path does not exist currently -- if it
>     does, return an error;
>  2. create that path and open the resulting file for
>     reading and writing, but make sure that no one else
>     may write to that path.
>
> On a local file system, this really is a single atomic
> operation: either the path does not exist *and* you are
> allowed to create it *and* the creation succeeds *and*
> you now have a writable file-handle for a read-only file;
> or, any one of the "and"s above has failed (file already
> existed, you aren't allowed to create here, etc).

That's a very nice and clealy written analysis.  What you outlined
above is exactly why we use these flags and create the file
read-only from the get go.

Having said that, most of these "create atomically" that are coming
via the tempfile API could use a looser 0644, as the primary reason
why we are careful is not to protect against bad actors but to
protect against ourselves (another process or another thread) racing
to create the same object---in other words, we are happy as long as
O_CREAT|O_EXCL is honored, and "link into the final place and then
unlink the tempfile" or "rename into the final place" patterns that
are used to conclude the temporary file obtained via the tempfile
API are reliable on the target filesystem.

The resulting file being read-only with 0444 (limited further by
umask) is not all that important.  It is certainly possible to
destroy an owner-writable file by redirecting into it, and making
the files read-only may prevent such an accident from happening, but
immediate parent directories of these files have to be at least
owner-writable, so it is just as easy to destroy such a read-only
file by unlinking it from its parent directory.

I may be forgetting important reasons why we insist read-only files
in $GIT_DIR for objects, packs and commit-graph files (there may be
others), but otherwise I do not have a strong objection to a patch
with a well written log message that loosens these 0444 modes that
are (eventually) given to git_mkstemp_mode() to 0644.

Thanks.
