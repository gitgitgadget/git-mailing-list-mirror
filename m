Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F31C433E2
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 18:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673DA2158C
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 18:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CX3i0tmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgILSUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 14:20:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58380 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgILSUO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 14:20:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F37AFF2856;
        Sat, 12 Sep 2020 14:20:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=obl8/TmyJPlNn/K+fKc622CU58Y=; b=CX3i0t
        moToPGzsLuUMCzy/hhBMB4ed57DAznexVFIJp7sqilZ/uKtcRCP6BV7mG5Ekx0/W
        s6VHlKTb5YkmkJNJQGmXCiFJ1FNHE4rr0aMsjOJpZZdtHiHS+cJpuWFT3JQSdu7t
        J5qgt80BUIM5cVn1XkRM8pHgqRNFLgtp7ubew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PpVGCeapaBlD1K8s4TACd5GK5Xs0didU
        FRG704/WLnCRnXQH0JdBQLd+lYWG5YL+leDXYw8izoIcKCiTc141WtP1w4zJL8p9
        2ueg+y9kCx8H5UeNAPPnQbGHjnoTZq6tGs281v7OoIBcMvzkEwom/urkzxRRamCz
        AtV+Yve4rXI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED9C2F2855;
        Sat, 12 Sep 2020 14:20:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 44B6EF284F;
        Sat, 12 Sep 2020 14:20:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] push: add "--[no-]force-if-includes"
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
        <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
        <20200912150459.8282-2-shrinidhi.kaushik@gmail.com>
Date:   Sat, 12 Sep 2020 11:20:06 -0700
In-Reply-To: <20200912150459.8282-2-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Sat, 12 Sep 2020 20:34:58 +0530")
Message-ID: <xmqq5z8ioo15.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96A091FE-F524-11EA-A69B-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> Add a new option: `--force-if-includes` to `git-push` where forced
> updates are allowed only if the tip of the remote-tracking ref has
> been integrated locally, by verifying if the tip of the remote-tracking
> ref on which a local branch has based on (for a rewrite), is reachable
> from at least one of the `reflog` entries of the local branch about
> to be updated by force on the remote.
>
> This option can also be used with `--force-with-lease` in setups
> where the remote-tracking refs of the repository are implicitly
> updated in the background.
>
> If a local branch is based on a remote ref for a rewrite, and if that
> remote-tracking ref is updated by a push from another repository after
> it has been checked out locally, force updating that branch to remote
> with `--force-with-lease[=<refname>[:expect]]` without specifying the
> "<refname>" or "<expect>" values, can cause the update that happened
> in-between the checkout and forced push to be lost.
>
> Specifying `--force-with-includes` with `--force-with-lease` as an
> ancillary argument at the time of push, ensures that any new updates
> to the remote-tracking refs are integrated locally before allowing a
> forced update. This behavior can enabled by default if the configuration
> option `push.forceIfIncludesWithLease` is set to `true`.

This step seems to do too many things at once.  Split into logical
progression of improvements, or nobody can sensibly review it, I am
afraid.

> diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> index f5e5b38c68..1b4948faa0 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -114,3 +114,11 @@ push.recurseSubmodules::
>  	specifying '--recurse-submodules=check|on-demand|no'.
>  	If not set, 'no' is used by default, unless 'submodule.recurse' is
>  	set (in which case a 'true' value means 'on-demand').
> +
> +push.forceIfIncludesWithLease::
> +	If set to `true`, adds `--force-if-includes` as an ancillary argument
> +	to `--force-with-lease[=<refname>[:<expect>]]`, when "<refname>" or
> +	"<expect>" values are unspecified at the time of push.
> ++
> +Note: Specifying `--no-force-if-includes` to linkgit:git-push[1] as an
> +argument during the time of push does _not_ override this configuration.

I do not see why you still want to link these two unrelated
features.  I may want to do forced push with lease when I know I am
rewinding, and I may want to do a if-included force when needed, but
I do not see why I want to ask the former and implicitly see it also
trigger the latter.

I haven't seen the details, but if we severe the (unnecessary?)
entanglement of these two features, perhaps this patch will become a
lot smaller and more focused?  I dunno.
