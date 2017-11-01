Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E5820450
	for <e@80x24.org>; Wed,  1 Nov 2017 01:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbdKABoZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 21:44:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59895 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753486AbdKABoY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 21:44:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1617FBBB3D;
        Tue, 31 Oct 2017 21:44:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MRMx4UQhzUkah+PeDpqNLX4t39E=; b=DlDY+b
        us+KuovxeQSNtYJYdPQJlZPIEAjz/XXfikpYOMdNbf7j7baVfQ5UtFO6eQ7w+BVc
        MRlE11BdWDYF5dk8I39x4n6BEFDI3l821mnyi1kM5wi/WKHRz9iMaZZ0Jj+Ia71x
        PKbSttrBJNAa85LjJ8fC58KnfO5CB7CtuBBcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nSs4twdZPXNG/R4cUVLboM112oJDGSTF
        Wg9vFfo82vpZ0kcrv0id7LNF1yrjdo31Nk6xc10H8+NhJaUTqeLU6DeBY3G9GLnQ
        g75xrzdkmmel1n0LbHYl+G3Qb/JKvzh5DSWbtWeuWz9O3G3mKiY81Ktv1zE2gP0f
        q9vp1pBoIcM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D09ABBB3C;
        Tue, 31 Oct 2017 21:44:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 871D0BBB3B;
        Tue, 31 Oct 2017 21:44:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t5580: add Cygwin support
References: <20171031131903.10496-1-adam@dinwoodie.org>
Date:   Wed, 01 Nov 2017 10:44:22 +0900
In-Reply-To: <20171031131903.10496-1-adam@dinwoodie.org> (Adam Dinwoodie's
        message of "Tue, 31 Oct 2017 13:19:03 +0000")
Message-ID: <xmqq1sliydqh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FE8A86E-BEA6-11E7-A1EB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> t5580 tests that specifying Windows UNC paths works with Git.  Cygwin
> supports UNC paths, albeit only using forward slashes, not backslashes,
> so run the compatible tests on Cygwin as well as MinGW.
>
> The only complication is Cygwin's `pwd`, which returns a *nix-style
> path, and that's not suitable for calculating the UNC path to the
> current directory.  Instead use Cygwin's `cygpath` utility to get the
> Windows-style path.
>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>  t/t5580-clone-push-unc.sh | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
> index b322c2f72..47a9a7cda 100755
> --- a/t/t5580-clone-push-unc.sh
> +++ b/t/t5580-clone-push-unc.sh
> @@ -3,12 +3,16 @@
>  test_description='various Windows-only path tests'
>  . ./test-lib.sh
>  
> -if ! test_have_prereq MINGW; then
> +if test_have_prereq CYGWIN; then
> +	alias winpwd='cygpath -aw .'
> +elif test_have_prereq MINGW; then
> +	alias winpwd=pwd
> +else
>  	skip_all='skipping Windows-only path tests'
>  	test_done
>  fi

The fact that UNCPATH matters only on windows-related platforms
justifies the name used for this alias, I guess ;-)

>  
> -UNCPATH="$(pwd)"
> +UNCPATH="$(winpwd)"
>  case "$UNCPATH" in
>  [A-Z]:*)
>  	# Use administrative share e.g. \\localhost\C$\git-sdk-64\usr\src\git
> @@ -45,8 +49,8 @@ test_expect_success push '
>  	test "$rev" = "$(git rev-parse --verify refs/heads/to-push)"
>  '
>  
> -test_expect_success 'remote nick cannot contain backslashes' '
> -	BACKSLASHED="$(pwd | tr / \\\\)" &&
> +test_expect_success MINGW 'remote nick cannot contain backslashes' '
> +	BACKSLASHED="$(winpwd | tr / \\\\)" &&
>  	git ls-remote "$BACKSLASHED" >out 2>err &&
>  	test_i18ngrep ! "unable to access" err
>  '
