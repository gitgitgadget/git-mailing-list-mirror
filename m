Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2EFC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 05:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4039E61151
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 05:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhJ2FUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 01:20:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52600 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhJ2FUy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 01:20:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0D6FF739B;
        Fri, 29 Oct 2021 01:18:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N1W5wsw1D6Ud/5IrqjzWWjGX/C9kZ2IZ0CtYI+
        IstuA=; b=DBbjfEXNlMAJJ2UWt/Geyt9Im7lLG8cCp6CaUR4s6Oc9nihrIwUoWZ
        O+YVYIReKJKR3hdLXtwLPmAOlo58Y96pDBFqX47lVfwuDpKpzOp8IO/MlBPpC0gB
        0Gb2cPfBVrLVP37mlVDmaYOwB55bkKOHtxX9S90APBikKgmJkgtTQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8A30F739A;
        Fri, 29 Oct 2021 01:18:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F23DF7399;
        Fri, 29 Oct 2021 01:18:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] tests: disable fsync everywhere
References: <20211028002102.19384-1-e@80x24.org>
        <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
        <20211028182824.GA1307@dcvr> <xmqqilxhq774.fsf@gitster.g>
        <20211029001552.GA29647@dcvr>
Date:   Thu, 28 Oct 2021 22:18:24 -0700
In-Reply-To: <20211029001552.GA29647@dcvr> (Eric Wong's message of "Fri, 29
        Oct 2021 00:15:52 +0000")
Message-ID: <xmqqr1c4mmsf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A470A4EE-3877-11EC-88F8-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> @@ -42,6 +42,7 @@ const char *git_hooks_path;
>  int zlib_compression_level = Z_BEST_SPEED;
>  int pack_compression_level = Z_DEFAULT_COMPRESSION;
>  int fsync_object_files;
> +int use_fsync = -1;

OK, (-1) is "undetermined yet", as usual.

> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 64319bed43..4c8118010a 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -3607,6 +3607,22 @@ package GITCVS::updater;
>  use strict;
>  use warnings;
>  use DBI;
> +our $_use_fsync;
> +
> +# n.b. consider using Git.pm
> +sub use_fsync {
> +    if (!defined($_use_fsync)) {
> +        my $x = $ENV{GIT_TEST_FSYNC};
> +        if (defined $x) {

I would have expected to see "exists $ENV{GIT_TEST_FSYNC}", but I
guess there is no way to place in %ENV anyway, so it would be OK.

> +            local $ENV{GIT_CONFIG};
> +            delete $ENV{GIT_CONFIG};

OK, "git -c test.fsync=no cvsserver" would added something to
GIT_CONFIG that would affect test.fsync, but wouldn't the usual
last-one-wins rule be sufficient to check the value of $x using the
next construction, no matter what is in GIT_CONFIG?  I do not think
it would hurt to delete $ENV{GIT_CONFIG}, but I am not sure how it
is necessary.

> +            my $v = ::safe_pipe_capture('git', '-c', "test.fsync=$x",
> +                                        qw(config --type=bool test.fsync));

THis is an interesting idiom.

> +            $_use_fsync = defined($v) ? ($v eq "true\n") : 1;
> +        }
> +    }
> +    $_use_fsync;
> +}


> +# TODO: move this to Git.pm?
> +sub use_fsync {

Possibly, but in a slightly more general form, taking the name of
the environment variable that holds a boolean value as an argument,
or something?

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a291a5d4a2..21f5fab999 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -489,6 +489,13 @@ then
>  	export GIT_PERL_FATAL_WARNINGS
>  fi
>  
> +case $GIT_TEST_FSYNC in
> +'')
> +	GIT_TEST_FSYNC=0
> +	export GIT_TEST_FSYNC
> +	;;
> +esac

> diff --git a/write-or-die.c b/write-or-die.c
> index 0b1ec8190b..a3d5784cec 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -1,4 +1,5 @@
>  #include "cache.h"
> +#include "config.h"
>  #include "run-command.h"
>  
>  /*
> @@ -57,6 +58,10 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
>  
>  void fsync_or_die(int fd, const char *msg)
>  {
> +	if (use_fsync < 0)
> +		use_fsync = git_env_bool("GIT_TEST_FSYNC", 1);
> +	if (!use_fsync)
> +		return;

OK.  That's quite straight-forward.

>  	while (fsync(fd) < 0) {
>  		if (errno != EINTR)
>  			die_errno("fsync error on '%s'", msg);

Will queue.
