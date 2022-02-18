Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF20C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 18:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbiBRSsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:48:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbiBRSsg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 13:48:36 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A8512AC3
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:48:19 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 112601183B9;
        Fri, 18 Feb 2022 13:48:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mVQukM8qhUoWnrrEq5oWx7oSE74XUFjouZR5RV
        Q1Vac=; b=B6Wq+9bLzpy4ivRaoYbIb1e65jiY0k1WkN17d1GFr2tvPehAIbPQAW
        cOrijhuvnF+EmrR7+Z9VNVP8kJ2S9I62i+qnK59kaInGFYoib+11/YtjUZZx/LGD
        V6KlMrrgwn40Y1lvrgsqQ5j6v6R7Fb9Kodc61vH6qH5dnrUAjaDJI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07CF51183B8;
        Fri, 18 Feb 2022 13:48:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6963A1183B7;
        Fri, 18 Feb 2022 13:48:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     COGONI Guillaume <cogoni.guillaume@gmail.com>
Cc:     avarab@gmail.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, guillaume.cogoni@gmail.com,
        matthieu.moy@univ-lyon1.fr
Subject: Re: [PATCH v2 2/2] Add new tests functions like test_path_is_*
References: <220215.86a6erwzee.gmgdl@evledraar.gmail.com>
        <20220218171224.262698-1-cogoni.guillaume@gmail.com>
        <20220218171224.262698-3-cogoni.guillaume@gmail.com>
Date:   Fri, 18 Feb 2022 10:48:15 -0800
In-Reply-To: <20220218171224.262698-3-cogoni.guillaume@gmail.com> (COGONI
        Guillaume's message of "Fri, 18 Feb 2022 18:12:24 +0100")
Message-ID: <xmqqbkz4105s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 554D0AA2-90EB-11EC-A3F5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

COGONI Guillaume <cogoni.guillaume@gmail.com> writes:

> Subject: Re: [PATCH v2 2/2] Add new tests functions like test_path_is_*

I'd retitle the commit to "tests: allow testing if a path is truly
a file or a directory", to follow the convention to highlight that
this change is about the tests.

> Add test_path_is_file_not_symlink(), test_path_is_dir_not_symlink()
> and test_path_is_symlink(). Case of use for the first one
> in test t/t3903-stash.sh to replace "test -f" because that function
> explicitly want the file not to be a symlink by parsing the output
> of "ls -l". Make the code more readable and give more friendly error
> message.

Interesting.  I'll mention why I think you want to rewrite that "by
parsing the output of 'ls -l'" later.

I initially didn't like the "is file and not symlink" suggestion I
made, simply because it looked like it is asking for combinatorial
explosion, but because the only types of filesystem entities that
are not symlink that we care about are files and directories, so we
only need two new variants that say "_not_symlink" in the name,
it is probably not too bad.

> @@ -390,10 +390,9 @@ test_expect_success SYMLINKS 'stash file to symlink' '
>  	rm file &&
>  	ln -s file2 file &&
>  	git stash save "file to symlink" &&
> -	test -f file &&
> +	test_path_is_file_not_symlink file &&

And this is exactly the new helper is meant to be used.  It was
originally a regular file, the test tentatively made it into a
symbolic link, but that tentative change is supposed to be reverted
by the "stash save", so we do want it to be a true regular file.

>  	test bar = "$(cat file)" &&
> -	git stash apply &&
> -	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
> +	git stash apply

However, the removal of the "make sure file is a symbolic link and
it points at file2" is not justifiable with the proposed commit
message.  If the original code were like this ...

	test bar = "$(cat file)" &&
	case "$(ls -l file)" in *" file -> file2") false;; esac &&
	git stash apply &&
	case "$(ls -l file)" in *" file -> file2") :;; *) false ;;esac


... the test _before_ "stash apply" is checking if "file" is a
regular file, the "ls -l" output is used to make sure file is not a
symbolic link that points at file2.  But that is not the original
code did, which invalidates the part of the proposed commit log
message.

The "ls -l" parsing the original does is to check how "stash apply"
recovers the stashed state, where "file" wants to be a symbolic link
and it wants to be pointing at "file2".

It seems we have test_readlink() available these days, so with a
separate clean-up patch, you may want to make the final version
to read something like this, perhaps?

	test_path_is_file_not_symlink file &&
        test bar ="$(cat file") &&
	git stash apply &&
	test "$(test_readlink file)" = file2

I am not sure what test_readlink which is a one-liner Perl script
does when it is fed a non symbolic link, so I do not know if the
"path is truly a file and not a symlink" can be done as

	test -f file &&	! test_readlink file &&

I think the other two hunks to this file have identical issues.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 85385d2ede..61fc5f37e3 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -856,6 +856,16 @@ test_path_is_file () {
>  	fi
>  }
>  
> +test_path_is_file_not_symlink () {
> +	test "$#" -ne 1 && BUG "1 param"
> +	test_path_is_file "$1" &&
> +	if ! test ! -h "$1"

Why not

	if test -h "$1"

instead???  I think "is truly a dir not a symlink" has the same
"Huh?" puzzle.

Thanks.


