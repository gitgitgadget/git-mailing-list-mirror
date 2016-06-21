Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18E91FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 19:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbcFUTSe (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 15:18:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750948AbcFUTSe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 15:18:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BD5526373;
	Tue, 21 Jun 2016 15:18:32 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jG5WkgU9Tyd1hZuTcuWCIhUqhwE=; b=FnhaeM
	oFjkbX4HCTl/dG18R+6RahCNBneEI9FoAhyp0g6KLNabTJWFwx/zXjhms9ahOFEP
	XRC6//pEsdourT7c5NZSRCKNPhnMGOsJgLGveCA7LBEQTi3Atp6zFqaPgseElHIX
	0zSJp6wXE+yxB47vl66NRAXXq85AW1eR6YaNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qu92CEaYBxx5eyrf4xbsYw8ljolC31+J
	fm3Huv5eBETTKeouF0d1OVNXvFLAgMZ3EPtI8qmVaSs4K1kmwkP++GFFVppD5+VV
	IbIXTdK87hTykyN7HxJHc5tAG1FOwjHbOV7TNTtYgzVfn5f8QMWL/gxnG7taEgY7
	rhQ9lLaZ8DE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60F0B26372;
	Tue, 21 Jun 2016 15:18:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB7D52636F;
	Tue, 21 Jun 2016 15:18:31 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH] t5614: don't use subshells
References: <1466443278-21591-1-git-send-email-sbeller@google.com>
Date:	Tue, 21 Jun 2016 12:18:29 -0700
In-Reply-To: <1466443278-21591-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 20 Jun 2016 10:21:18 -0700")
Message-ID: <xmqqh9cmpcze.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F123D142-37E4-11E6-B24A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>  Unlike the prior patch we would not want this patch to fall through
>  to origin/maint fast, but allow cooking?

I do not see anything that makes this treated differently from the
other fix.  The only difference in behaviour is that "lines" file is
now created at the root level of the trash repository's working tree
instead of tested clones', and I do not think any test depends on
the number of untracked paths in the trash working tree or tries to
make sure a file called "lines" is not in there.

> diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
> index a9aaa01..da2a67f 100755
> --- a/t/t5614-clone-submodules.sh
> +++ b/t/t5614-clone-submodules.sh
> @@ -25,76 +25,46 @@ test_expect_success 'setup' '
>  test_expect_success 'nonshallow clone implies nonshallow submodule' '
>  	test_when_finished "rm -rf super_clone" &&
>  	git clone --recurse-submodules "file://$pwd/." super_clone &&
> -	(
> -		cd super_clone &&
> -		git log --oneline >lines &&
> -		test_line_count = 3 lines
> -	) &&
> -	(
> -		cd super_clone/sub &&
> -		git log --oneline >lines &&
> -		test_line_count = 3 lines
> -	)
> +	git -C super_clone log --oneline >lines &&
> +	test_line_count = 3 lines &&
> +	git -C super_clone/sub log --oneline >lines &&
> +	test_line_count = 3 lines
>  '

Having said that, I wonder if we want further reduction of the
repetition.  Each test except "setup" in this script does an
identical thing with very small set of parameters:

    - make sure super_clone will be removed when done.
    - clone file://$pwd/. to super_clone but with different set of options.
    - check the commits in super_clone and super_clone/sub.

So, the above would ideally become something like

do_test 3 3 --recurse-submodules

where the helper would look like

do_test () {
	cnt_super=$1 cnt_sub=$2 &&
        shift 2 &&
        test_when_finished "rm -fr super_clone" &&
        git clone "$@" "file://$pwd/." super_clone &&
        git -C super_clone log --oneline >lines &&
        test_line_count = $cnt_super lines &&
        git -C super_clone/sub log --oneline >lines &&
        test_line_count = $cnt_sub lines
}

Would it rob too much flexibility from future tests to be added to
this script if we did it that way?

