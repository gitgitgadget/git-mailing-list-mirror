Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9000E2089D
	for <e@80x24.org>; Thu, 27 Jul 2017 17:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbdG0RT5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 13:19:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57219 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750981AbdG0RT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 13:19:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97695A2209;
        Thu, 27 Jul 2017 13:19:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zMO8IjA4G2aN3rCf+gPExiRzCbU=; b=qcIgSn
        r+Er+qryCB4286/nbCWFIM9G26FmhvNoXfM0Ha1MaeAlXyc4vEmsrbEyrgjAYI6C
        YCIYZ5T6a9YUDURWAx7aJ/ld3EdrGpxRLOIays2X9WY1aPHDPuyidqAzmpbLw8m2
        xsOVEXO3ZcOkVpgzLzrm4KUhc4/omwK2OkUTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LGfozLYxFDPqGSe2TjoMm1NZ2z5AtQe/
        E60+92R17hKguOXww/emNJk/Rrt3cdT9ZX0g7q1Jd836SjgkoF8zFEV0O81bMTkb
        AM3T+0gn+fS8wtEQfdS6WZCl5fFjNkg4k4ybPnTztyYr90b9lBmqwSynRVZUr1KW
        bYkgc4agPCw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EA32A2208;
        Thu, 27 Jul 2017 13:19:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6B43A2206;
        Thu, 27 Jul 2017 13:19:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a symlink
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
        <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
Date:   Thu, 27 Jul 2017 10:19:48 -0700
In-Reply-To: <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Wed, 26 Jul 2017 16:39:42 -0700")
Message-ID: <xmqq8tj9okzv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBC69104-72EF-11E7-B0A8-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Change `commit_packed_refs()` to use `get_locked_file_path()` to find
> the path of the file that it should overwrite. Since that path was
> properly resolved when the lockfile was created, this restores the
> pre-42dfa7ecef behavior.

Because when we take a lock hold_lock_file() eventually calls into
lock_file() which by default takes the lock on the target of the
symbolic link (which is the sensible default, which is triggered in
this codepath), so this change to use the name of that file is all
that is needed.

Makes sense.  Makes me wonder why we need a separate .new file
(instead of writing into the .lock instead), but that is a different
issue.

Thanks.  I'll do the SYMLINKS thing while queuing.

> diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
> index 2bb4b25ed9..0d8a03e2a9 100755
> --- a/t/t3210-pack-refs.sh
> +++ b/t/t3210-pack-refs.sh
> @@ -238,4 +238,19 @@ test_expect_success 'retry acquiring packed-refs.lock' '
>  	git -c core.packedrefstimeout=3000 pack-refs --all --prune
>  '
>  
> +test_expect_success 'pack symlinked packed-refs' '
> +	# First make sure that symlinking works when reading:
> +	git update-ref refs/heads/loosy refs/heads/master &&
> +	git for-each-ref >all-refs-before &&
> +	mv .git/packed-refs .git/my-deviant-packed-refs &&
> +	ln -s my-deviant-packed-refs .git/packed-refs &&
> +	git for-each-ref >all-refs-linked &&
> +	test_cmp all-refs-before all-refs-linked &&
> +	git pack-refs --all --prune &&
> +	git for-each-ref >all-refs-packed &&
> +	test_cmp all-refs-before all-refs-packed &&
> +	test -h .git/packed-refs &&
> +	test "$(readlink .git/packed-refs)" = "my-deviant-packed-refs"
> +'
> +
>  test_done
