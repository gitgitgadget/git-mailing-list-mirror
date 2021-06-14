Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB41C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 06:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6E6613B8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 06:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhFNGYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 02:24:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56054 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhFNGYd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 02:24:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D4D7BECD7;
        Mon, 14 Jun 2021 02:22:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XmwUx4xKgRsl6F6MkH7oDfUCt02pbA/m/7DbHc
        2XzYw=; b=u3cNoMwoe2vaDtmRpM2lpXYaclfy33MmMjpqoq9HPeVFMp/20UkitC
        dCZy3QJQv6Hz3/fknPiXvOFhCJh+kfhauBlATQrat2Dwwkmr+5eKhc4Sda/IxDto
        VvM0nu9qZdNFsF31rpCLESflxKgqPHttYMH77AUnkQzwYRea4tz3I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 165A3BECD6;
        Mon, 14 Jun 2021 02:22:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B416BECD5;
        Mon, 14 Jun 2021 02:22:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] submodule: cache superproject gitdir during
 'update'
References: <20210611225428.1208973-1-emilyshaffer@google.com>
        <20210611225428.1208973-5-emilyshaffer@google.com>
Date:   Mon, 14 Jun 2021 15:22:29 +0900
In-Reply-To: <20210611225428.1208973-5-emilyshaffer@google.com> (Emily
        Shaffer's message of "Fri, 11 Jun 2021 15:54:28 -0700")
Message-ID: <xmqqeed5x8wq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5D50E62-CCD8-11EB-8B33-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> A cached path to the superproject's gitdir might be added during 'git
> submodule add', but in some cases - like submodules which were created
> before 'git submodule add' learned to cache that info - it might be
> useful to update the cache. Let's do it during 'git submodule update',
> when we already have a handle to the superproject while calling
> operations on the submodules.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  git-submodule.sh            |  9 +++++++++
>  t/t7406-submodule-update.sh | 10 ++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index eb90f18229..ddda751cfa 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -648,6 +648,15 @@ cmd_update()
>  			fi
>  		fi
>  
> +		# Cache a pointer to the superproject's gitdir. This may have
> +		# changed, so rewrite it unconditionally. Writes it to worktree
> +		# if applicable, otherwise to local.
> +
> +		sp_gitdir="$(git rev-parse --absolute-git-dir)"
> +		relative_gitdir="$(realpath --relative-to "$sm_path" "$sp_gitdir")"

realpath may not exist on the target system.  Discussions on the
patch [*1*] may be of interest.

It might be a good idea to push to your github repository to trigger
CI on macOS (I am guessing that you do not test locally on macs from
the two issues we saw in this series).

Thanks.


[Reference]

*1*
https://lore.kernel.org/git/20201206225349.3392790-3-sandals@crustytoothpaste.net/
