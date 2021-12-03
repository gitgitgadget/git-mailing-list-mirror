Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E148FC433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 17:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353409AbhLCRNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 12:13:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56450 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353346AbhLCRNs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 12:13:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25AC4167D11;
        Fri,  3 Dec 2021 12:10:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fLVQIKrRH+jNDCJhS7T55YRV3teeGyTxQ56nyK
        g3bSY=; b=ESDTis/ogzEptGX4DLHtItp4qKWMeYOLWa7am7xYerFFX3BmAqcngv
        wbFSGAA/IKfOxeTwiCRtdM2Voo61KaM1zqdVcjx3p2gekc2fYGw50EzrZ9AM8sL/
        Qx7MJJkWcGyC90i9jfXu/R178SkdricPvZhCAlQiklnGybvi6c2m4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E1C2167D10;
        Fri,  3 Dec 2021 12:10:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 214BC167D0F;
        Fri,  3 Dec 2021 12:10:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: t7900 failures when $HOME is symlinked
References: <4cf14040-c8e1-0f75-0ec4-fd8cf6bed0a5@gmail.com>
Date:   Fri, 03 Dec 2021 09:10:16 -0800
In-Reply-To: <4cf14040-c8e1-0f75-0ec4-fd8cf6bed0a5@gmail.com> (Philippe
        Blain's message of "Fri, 3 Dec 2021 09:56:28 -0500")
Message-ID: <xmqq1r2tty13.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E45A68E2-545B-11EC-932F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Stolee,
>
> I noticed two failures, t7900.32 and t7900.36, on a system where
> $HOME is symlinked, i.e.
>
>     $ cd $HOME && pwd
>     /home/me
>     $ pwd -P
>     /some/other/path/me
>
> These two tests use 'pfx = $(cd $HOME && pwd)', so $pfx is '/home/me',
> but the actual path that gets written by Git is canonicalized, i.e.
> '/some/other/path/me'. I think a simple fix would be to use 'pwd -P'
> instead, which fixes it for me.

Curious.  Your personal HOME shouldn't have much to do with the
tests, but obviously it can indirectly affect the outcome because it
affects where you place your repository.

HOME during tests is set in t/test-lib.sh, based on where
TRASH_DIRECTORY is, and the latter is often derived from
TEST_OUTPUT_DIRECTORY (unless --root is given), which comes from
TEST_DIRECTORY and it is set like so:

    # Test the binaries we have just built.  The tests are kept in
    # t/ subdirectory and are run in 'trash directory' subdirectory.
    if test -z "$TEST_DIRECTORY"
    then
            # We allow tests to override this, in case they want to run tests
            # outside of t/, e.g. for running tests on the test library
            # itself.
            TEST_DIRECTORY=$(pwd)
    else
            # ensure that TEST_DIRECTORY is an absolute path so that it
            # is valid even if the current working directory is changed
            TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
    fi
    if test -z "$TEST_OUTPUT_DIRECTORY"
    then
            # Similarly, override this to store the test-results subdir
            # elsewhere
            TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
    fi
    GIT_BUILD_DIR="$TEST_DIRECTORY"/..

If you want to do $(pwd -P) somewhere, isn't it that one you want to
change to avoid similar problems in any code, including the ones
that are not yet written, that uses $(pwd)?

This is a tangent, but I think I found a small bug while spelunking
for the origin of HOME during tests.

 * We parse out --root=* option like this:

	--root=*)
		root=${opt#--*=} ;;

   Notice that we do not require it to be absolute path.

 * TRASH_DIRECTORY is originally set to "trash directory." with a
   suffix to make it unique across test scripts, but it immediately
   gets turned into an absolute path by doing this:

        test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
        case "$TRASH_DIRECTORY" in
        /*) ;; # absolute path is good
         *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
        esac

   I notice that a root that is not absolute is silently lost during
   this process.

   TEST_OUTPUT_DIRECTORY is set to TEST_DIRECTORY that comes from
   $(pwd) we saw earlier, or TEST_OUTPUT_DIRECTORY_OVERRIDE, which
   is also set to $(pwd) elsewhere, so the case statement does make
   it absolute in the end.  It just loses --root=* without complaint
   which is what I found iffy.

