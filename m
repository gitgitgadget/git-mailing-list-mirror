Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE4CC433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 18:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352466AbiBKSCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 13:02:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbiBKSCT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 13:02:19 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82741CF5
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 10:02:18 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 33060186F60;
        Fri, 11 Feb 2022 13:02:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7+i/nTHHdui6rkMCNY6fSx7LZabeuHQrh7GFom
        cRz/g=; b=V85LcMGTKjSNRjJL4pSxW4j7/ORRAS2CzJCxkwtrIDE9a5rgLd4c8M
        lhtGfY9audbri00BV/QjKjpW2aBBLk7+OYMhFspNhRXxKC4MEC8pJeVXOwFTFRr1
        JO1Xm0//me9gOYjwbvp+pKJCmUa9NKrB9n5ivkas7TOg0RQCGILxI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C1CE186F5F;
        Fri, 11 Feb 2022 13:02:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 83E85186F5E;
        Fri, 11 Feb 2022 13:02:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     COGONI Guillaume <cogoni.guillaume@gmail.com>
Cc:     git@vger.kernel.org, git.jonathan.bressat@gmail.com,
        guillaume.cogoni@gmail.com, matthieu.moy@univ-lyon1.fr
Subject: Re: [PATCH] t/t3903-stash.sh: replace test [-d|-f] with test_path_is_*
References: <20220211134655.1149320-1-cogoni.guillaume@gmail.com>
Date:   Fri, 11 Feb 2022 10:02:14 -0800
In-Reply-To: <20220211134655.1149320-1-cogoni.guillaume@gmail.com> (COGONI
        Guillaume's message of "Fri, 11 Feb 2022 14:46:55 +0100")
Message-ID: <xmqq5yplcme1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BECA8DB0-8B64-11EC-A384-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

COGONI Guillaume <cogoni.guillaume@gmail.com> writes:

> @@ -390,7 +390,7 @@ test_expect_success SYMLINKS 'stash file to symlink' '
>  	rm file &&
>  	ln -s file2 file &&
>  	git stash save "file to symlink" &&
> -	test -f file &&
> +	test_path_is_file file &&

This is not wrong per-se, and I know I shouldn't demand too much
from a practice patch like this, but for a real patch, I hope
contributors carefully check if the original is doing the right
thing.

What does the code want to do?

 - The starting state, HEAD, has a 'file' that is a regular file.

 - We remove and replace 'file' with a symbolic link.

 - We stash.

So the expectation here is at this point, 'file' is a regular file
and not a symbolic link.  Some anticipated errors are that "stash
save" fails to turn 'file' back to a regular file include leaving it
as a symbolic link and successfully remove the symblic link version
but somehow failing to recreate a regular file.

Is "test -f file", which was used by the original, the right way to
detect these possible errors?

Whey file2 is a regular file that exists and file is a symbolic link
points at it, i.e. if "stash save" fails to operate, "test -f file" would
still say "Yes, it is a file".

    $ >regular-file
    $ rm -f missing-file
    $ ln -s regular-file link-to-file
    $ ln -s missing-file link-to-missing
    $ test -f regular-file; echo $?
    0
    $ test -f link-to-file; echo $?
    0
    $ test -f link-to-missing; echo $?
    1
    $ test ! -h regular-file && test -f regular-file; echo $?
    0
    $ test ! -h link-to-file && test -f link-to-file; echo $?
    1


As "test_path_is_file" is merely a wrapper around "test -f", this
patch may not make it any worse, but I am skeptical if this is a
good idea, given that possible follow-on project may be one or more
of these:

 * verify that all existing users of test_path_is_file want to
   reject a symlink to file, and add 'test ! -h "$1" &&' to the
   implementation of the test helper in t/test-lib-functions.sh
   (we may want to do the same for test_path_is_dir).

 * introduce test_path_is_symlink and use it appropriately.  This
   will be a more verbose version of "test -h".

 * introduce test_path_is_file_not_symlink and use it here.

If the proposed log message leaves a note on the issue, e.g.

    There are dubious uses of "test -f" in the original that should
    be differentiating a regular file and a symbolic link to an
    existing regular file, but this mechanical conversion patch does
    not fix them.

it would be nicer.

Thanks.
