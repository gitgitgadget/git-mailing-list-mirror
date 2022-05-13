Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EDBC433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 20:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352837AbiEMU0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 16:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbiEMU0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 16:26:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D57F47
        for <git@vger.kernel.org>; Fri, 13 May 2022 13:26:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A90B1A736F;
        Fri, 13 May 2022 16:26:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RYIdVkH0uhk61nIJvNxRkQaOJF7Z77hj1qb2UE
        DcLsQ=; b=tUR1to+rJGV4Wn0GXEkmmwfFqabl6oa60IMRZ09No2U4xYpw8IkGbq
        7X33TYLl22VCeUNBD7cI7g5w81kr/tVzm98q2jKkombxN12yyBheNERmc05piTgW
        MhVN5JovrualYzoebekacrNOrivISBeiHbpohKYCIoXPtzz415fa4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43A7D1A736E;
        Fri, 13 May 2022 16:26:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DF79C1A736D;
        Fri, 13 May 2022 16:26:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon.Richter@hogyros.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] Add config option/env var to limit HTTP auth methods
References: <20220513070416.37235-1-Simon.Richter@hogyros.de>
        <20220513070416.37235-3-Simon.Richter@hogyros.de>
Date:   Fri, 13 May 2022 13:26:09 -0700
In-Reply-To: <20220513070416.37235-3-Simon.Richter@hogyros.de> (Simon
        Richter's message of "Fri, 13 May 2022 09:04:15 +0200")
Message-ID: <xmqqzgjl89i6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED770886-D2FA-11EC-93D2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon.Richter@hogyros.de writes:

> +http.authMethod::
> +	Set the method with which to authenticate to the HTTP server, if
> +	required. This can be overridden on a per-remote basis; see
> +	`remote.<name>.authMethod`. Both can be overridden by the
> +	`GIT_HTTP_AUTHMETHOD` environment variable.  Possible values are:
> ++
> +--
> +* `anyauth` - Automatically pick a suitable authentication method. It is
> +  assumed that the server answers an unauthenticated request with a 401
> +  status code and one or more WWW-Authenticate headers with supported
> +  authentication methods. This is the default.
> +* `basic` - HTTP Basic authentication
> +* `digest` - HTTP Digest authentication; this prevents the password from being
> +  transmitted to the server in clear text
> +* `negotiate` - GSS-Negotiate authentication (compare the --negotiate option
> +  of `curl(1)`)
> +* `ntlm` - NTLM authentication (compare the --ntlm option of `curl(1)`)
> +--

The above makes sense.

Configuring this variable per URL, just like all other variables in
"http.*" namespace, we should be able to use the "http.<url>.*"
mechanism that the users are already familiar with.

> diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
> index 0678b4bcfe..0f87234427 100644
> --- a/Documentation/config/remote.txt
> +++ b/Documentation/config/remote.txt
> @@ -10,6 +10,10 @@ remote.<name>.url::
>  remote.<name>.pushurl::
>  	The push URL of a remote repository.  See linkgit:git-push[1].
>  
> +remote.<name>.authMethod::
> +	For http and https remotes, the method to use for
> +	authenticating against the server. See `http.authMethod`.

IOW, this looks out of place.
