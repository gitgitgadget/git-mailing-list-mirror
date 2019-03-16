Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC39420248
	for <e@80x24.org>; Sat, 16 Mar 2019 15:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfCPPkS (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 11:40:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57639 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfCPPkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 11:40:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83B1A460DC;
        Sat, 16 Mar 2019 11:40:14 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=bSqrhKP5G9Ad32luBI89W98ivPI=; b=YfnFpM
        ZfYXm+2klFB9ud9x0o8G6MFvDIVroL50bYVkCsQPNJmTcYrTD5sD3wdNiiSCK1+V
        /vFONN5atepIYohYlHYJVEXjswvvcIKHpplkFsfJNZDHGpRutkIXG5MyfsLbTwHU
        QhQEvU7iMgn8LcPLNMbwxGI++FlU0Tg7p6f9Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D750460DA;
        Sat, 16 Mar 2019 11:40:14 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=T85YV029zOo9sPyhEPqF4TuuILD+c4rO2BFTC8nC66U=; b=TuYoxG8pgbBr17dauHT0sncDPrRy7JCPV0Rs/9sxpuwgc2BeTMfMruvCl0o0fatvDD5Ts0w0H5DFLwoap+643OI8nt7DeL7Wpgn2yCfea9Q6Z3MZVey3SI9wmR42RyjuVRQ6czAydUlnjXCqE8HtMJiyiUl0V92zvNRiqDQUu60=
Received: from localhost (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BDD40460D9;
        Sat, 16 Mar 2019 11:40:10 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     debian@onerussian.com
Subject: Re: [PATCH 1/4] submodule: refuse to add repository with no commits
In-Reply-To: <20190314150219.2040-2-kyle@kyleam.com>
References: <20190314150219.2040-1-kyle@kyleam.com> <20190314150219.2040-2-kyle@kyleam.com>
Date:   Sat, 16 Mar 2019 11:40:09 -0400
Message-ID: <87lg1eq146.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C885E1AA-4801-11E9-B4F3-D01F9763A999-24757444!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

[...]

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 514ede2596..6c74656027 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -234,10 +234,18 @@ cmd_add()
>  	if test -z "$force" &&
>  		! git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path" > /dev/null 2>&1
>  	then
> -		eval_gettextln "The following path is ignored by one of your .gitignore files:
> +		if test -d "$sm_path" &&
> +			test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null) &&
> +			! git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null
> +		then
> +			die "$(eval_gettext "'\$sm_path' does not have any commits")"
> +		else
> +			eval_gettextln "\
> +The following path is ignored by one of your .gitignore files:
>  \$sm_path
>  Use -f if you really want to add it." >&2
> -		exit 1
> +			exit 1
> +		fi

I didn't think through this check, which would have been obvious had I
ran the added test without the rest of the patches in this series.  It
assumes that the 'git add --dry-run' call fails, but that failure
depends on the last patch of this series.  So I'd need to move this
patch to the end or find a new place for this "no commits" check.
