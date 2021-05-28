Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFBCC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 04:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F69611BD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 04:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhE1FB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 01:01:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64779 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbhE1FB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 01:01:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDB7C143B7D;
        Fri, 28 May 2021 00:59:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m1/JTIiv8kYECEbXteTHOUNKUO77acKIBhKxYs
        hdtS4=; b=XVzsHGTo81nW/SUfSPRIJh8mWwIlIhj4u45LZfQ93elaZcAbL7KDVE
        Fxh4or9y9Uz/6Py9ldeiKmOkyaGLDVbD7EaQwHVk2JAzwFjQHc1pNXso73DTDQdQ
        ri45KTDuSI/uuCRruXoTJGvuuAUudpI2e2R4L8zcpMPbz5pUG1/Rw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5EFA143B79;
        Fri, 28 May 2021 00:59:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27017143B77;
        Fri, 28 May 2021 00:59:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dietrich Epp <depp@moria.us>
Cc:     git@vger.kernel.org
Subject: Re: git rm --pathspec-from-file does not work in subdirectories
References: <CAKGua8U25GF=mC+vRARRY99ZgaHoUOA7vppmOUdWoeB=bf3NAA@mail.gmail.com>
Date:   Fri, 28 May 2021 13:59:48 +0900
In-Reply-To: <CAKGua8U25GF=mC+vRARRY99ZgaHoUOA7vppmOUdWoeB=bf3NAA@mail.gmail.com>
        (Dietrich Epp's message of "Fri, 28 May 2021 00:20:47 -0400")
Message-ID: <xmqqlf7z78sb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 882C1644-BF71-11EB-999B-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dietrich Epp <depp@moria.us> writes:

> How to reproduce: cd into a subdirectory and use git rm
> --pathspec-from-file. For example, in Git's repo, at the top level:
>
> $ git rm --pathspec-from-file=/dev/null
> fatal: No pathspec was given. Which files should I remove?
> $ cd compat
> $ git rm --pathspec-from-file=/dev/null
> fatal: --pathspec-from-file is incompatible with pathspec arguments

Thanks for a report.

I think this reveals issues with not just the --pathspec-from-file
which has been added relatively recently, but potentially a larger
issue "git rm" from subdirectory has.

When run from a subdirectory, "git rm" without pathspec behaves
as if a single "." (i.e. everything underneath the current
directory) is given as the pathspec.  Of course, this is incompatible
with reading of the pathspec elements from a file and unfortunately
it cannot be disabled, so there currently is no way to use the option
if you are in a subdirectory.

But a potentially larger problem is that "git rm -r" will remove
everything under the current directory unless you are at the top
level of the working tree, even when the user does not give "." to
explicitly say "I want everything under the current directory gone".

I wonder if the attached patch would make both issues better.

