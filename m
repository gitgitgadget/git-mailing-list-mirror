Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF09C433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 22:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiDWXCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 19:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiDWXCk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 19:02:40 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F340F47AC6
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 15:59:41 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 514AE114A63;
        Sat, 23 Apr 2022 18:59:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qehm92YXDjZi
        Y5K4qeKHfGWUi0LBhuACf4OZKwNxalE=; b=XhO2grg7xPSXVZ4gtOptAS0H65Pw
        h2uPmL2jTNk/HLto7fly4+Mnb3D21ovDfbV6hkXL58qHkXzEYV9qsDBsiGFaUHII
        pX3PLKo18qyt2XAVQ+Wy08OOlY5VRIz+e1+pQ83TxMB5y0dvmAHb7YNWrc5SODfC
        TfHWvwZYvRZkdEk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47944114A62;
        Sat, 23 Apr 2022 18:59:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6BA81149D9;
        Sat, 23 Apr 2022 18:51:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] fixup! CI: move p4 and git-lfs variables to
 ci/install-dependencies.sh
References: <patch-v5-10.29-07e36035a1e-20220421T181526Z-avarab@gmail.com>
        <20220423201129.34133-1-carenas@gmail.com>
Date:   Sat, 23 Apr 2022 15:51:22 -0700
In-Reply-To: <20220423201129.34133-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sat, 23 Apr 2022 13:11:29 -0700")
Message-ID: <xmqqo80r1kid.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E7176C86-C357-11EC-8844-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Once the code was moved into an ubuntu specific branch, it doesn't make
> sense anymore to refer to logic that only applies to a different branch
>
> Cleanup the comment to allow for the implementation to change without
> making it stale, and while at it rename the variable used to track the
> P4 version to something slightly less confusing.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  ci/install-dependencies.sh | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

OK.  The place we run wget from is

    $P4WHENCE/bin.linux26x86_64/{p4,p4d}

for Linux.  And P4WHENCE is defined to be

    http://{filehost,cdist2}.perforce.com/perforce/r$LINUX_P4_VERSION

Unfortunately, what we grab are not these two files for macOS.

https://cdist2.perforce.com/perforce/r21.2/bin.macosx1015x86_64/helix-cor=
e-server.tgz

If p4 and p4d were the only files that we grabbed for macOS, then
what I wanted to suggest in the previous message would have worked,
i.e.=20

We define, per $runs_on_pool, two variables:

     P4VERSION (e.g. "r16.2", "r21.2")
     P4ARCH (e.g. "bin.macosx1015x86_64", "bin.linux26x86_64")

Then a single definition, after the "case $runs_on_pool ... esac",
of a leading URL, i.e.

     P4DIST=3Dhttps://cdist2.perforce.com/perforce/$P4VERSION/$P4ARCH/

can be used to help two wget commands, i.e.

     wget --quiet "$P4DIST/p4"
     wget --quiet "$P4DIST/p4d"

in install-dependencies.sh for both Linux-x86_64 and macOS.

But if we cannot unify the way the installation is done for macOS
and Linux that way, I do not think renaming $LINUX_P4_VERSION to
another name is worth doing (notice that the point of the above
exercise was to abstract these into just two variables, VERSION and
ARCH).

By the way, I spelunked https://filehost.perforce.com/perforce/ from
a browser to see how the files are layed out over there, not cdist2.
I am guessing that "filehost" is the name they want end-users like us
to use when downloading what they distribute?

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 098baeef3fb..7bea45fd339 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -23,11 +23,9 @@ esac
>  case "$runs_on_pool" in
>  ubuntu-latest)
>  	# The Linux build installs the defined dependency versions below.
> -	# The OS X build installs much more recent versions, whichever
> -	# were recorded in the Homebrew database upon creating the OS X
> -	# image.
> +	# The OS X build installs much more recent versions
>  	# Keep that in mind when you encounter a broken OS X build!
> -	LINUX_P4_VERSION=3D"16.2"
> +	P4_AT_LINUX_VERSION=3D"16.2"
>  	LINUX_GIT_LFS_VERSION=3D"1.5.2"
> =20
>  	P4_PATH=3D"$HOME/custom/p4"
> @@ -39,7 +37,7 @@ ubuntu-latest)
>  		echo "$PATH" >>"$GITHUB_PATH"
>  	fi
> =20
> -	P4WHENCE=3Dhttp://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
> +	P4WHENCE=3Dhttp://filehost.perforce.com/perforce/r$P4_AT_LINUX_VERSIO=
N
>  	LFSWHENCE=3Dhttps://github.com/github/git-lfs/releases/download/v$LIN=
UX_GIT_LFS_VERSION
> =20
>  	sudo apt-get -q update
