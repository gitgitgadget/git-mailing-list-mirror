Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE70C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 07:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiGSHNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 03:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiGSHNd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 03:13:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE432DB5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 00:13:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5478A1B77E4;
        Tue, 19 Jul 2022 03:13:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T468bMdzvMhoEPDjH6RKluVQ3emgAesSx5KDFr
        KYE54=; b=k+PVsrJzEo4iDeLBTMAK3zy1Ee0pv50i7lU0FrVoeRoNDlScj6Y2df
        c7K47CWPhQ5uLNGJq+MZy3hrMP1ZVCreOZotmLawZwViJUOP9DUyVEwMNx9DDG+j
        liaj4VygYCCOfXnFXShEWiCgn0CATYVFmbRTDq2r0YN6P+itoMQ90=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C9E21B77E3;
        Tue, 19 Jul 2022 03:13:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B3B461B77E2;
        Tue, 19 Jul 2022 03:13:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        levraiphilippeblain@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5] submodule merge: update conflict error message
References: <20220712231935.2979727-1-calvinwan@google.com>
        <20220718214349.3379328-1-calvinwan@google.com>
Date:   Tue, 19 Jul 2022 00:13:27 -0700
In-Reply-To: <20220718214349.3379328-1-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 18 Jul 2022 21:43:49 +0000")
Message-ID: <xmqqsfmxd17s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49DFC4B2-0732-11ED-9A2D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> @@ -1835,6 +1853,7 @@ static int merge_submodule(struct merge_options *opt,
>  			   "resolution exists: %s"),
>  			 path, sb.buf);
>  		strbuf_release(&sb);
> +		resolution_exists = 1;
>  		break;
>  	default:
>  		for (i = 0; i < merges.nr; i++)
> @@ -1845,10 +1864,22 @@ static int merge_submodule(struct merge_options *opt,
>  			 _("Failed to merge submodule %s, but multiple "
>  			   "possible merges exist:\n%s"), path, sb.buf);
>  		strbuf_release(&sb);
> +		resolution_exists = 1;
>  	}

These work on the result of calling find_first_merges(), but is it
possible that we are asked to call this function more than once
because we see conflicted submodule updates at two or more paths?

I may be misreading the code, but find_first_merges(), either the
version we see in this file, or the one in merge-recursive.c, or its
original introduced in 68d03e4a (Implement automatic fast-forward
merge for submodules, 2010-07-07), look safe to be called twice.  It
runs the get_revision() machinery, smudging the object flags while
walking the history, but I do not see any code that cleans up these
flags for the second traversal.

Also, this is not a new problem, but I am afraid that the logic to
find existing merges in find_first_merges() might be overly loose.
It tries to find existing merges that can reach the two commits, and
then finds, among these merges, the one that is not descendant of
any other such merges.  Don't we end up finding a merge M

    A---o---M
           /
          B

when a superproject merge needs a merge of A and B in the submodule?
That is certainly a merge that contains both A and B and it may be
closer to A and B than any other existing merges, but it still may
not be a merge between A and B (in the depicted case, an extra
commit 'o' nobody ordered is included for free in the result).  I am
not seeing how existing code tries to avoid such a situation.

Thanks.
