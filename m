Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250A3C433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 08:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D9164FC8
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 08:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhCJIGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 03:06:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60519 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhCJIGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 03:06:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C38DC11487C;
        Wed, 10 Mar 2021 03:06:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p9xTMy5dgyhRKZm/y5MII5For4U=; b=YN82TM
        kepO9DmiNxcJU7EwG66VXRVORTyK56WWtZ5HGnYxTKyxUVaR69AmqT9iuK9dxHnr
        oNc5xSoAOdmROOCi40D7wKpZjMXEmmOWACL8V+w5hnVHxUu+c8k5h4ql2ahE8XC1
        OqenaUGKgE2PHWEdfthXJb9wanllVBkms2Bt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dDMCS2dY4IHCQ3/0m9B90zx0RlH4AJMF
        oocY8YW32LDRnfkeaNVDPaN0ZkWtJXJS0ttKZ0DGplLaHWOA0lv/m7aYpldABhh0
        7ZLtp4JITb7MdhPmFyst5GNadkriJb3EAXcEQ6vUJuGPhfciJR35U+DQ1BgE6isX
        qwCYud5zShE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBADC11487B;
        Wed, 10 Mar 2021 03:06:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06FCD11487A;
        Wed, 10 Mar 2021 03:06:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>,
        Dana Dahlstrom <dahlstrom@google.com>
Subject: Re: [PATCH] mergetool: do not enable hideResolved by default
References: <20210130054655.48237-1-seth@eseth.com>
        <20210209200712.156540-1-seth@eseth.com>
        <20210209200712.156540-2-seth@eseth.com> <YEbdj27CmjNKSWf4@google.com>
Date:   Wed, 10 Mar 2021 00:06:06 -0800
In-Reply-To: <YEbdj27CmjNKSWf4@google.com> (Jonathan Nieder's message of "Mon,
        8 Mar 2021 18:29:35 -0800")
Message-ID: <xmqqmtvbjuvl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78AA6FBE-8177-11EB-B016-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 911470a5b2..f751d9cfe2 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -358,13 +358,8 @@ merge_file () {
>  		    enabled=false
>  		fi
>  	else
> -		# The user does not have a preference. Ask the tool.
> -		if hide_resolved_enabled
> -		then
> -		    enabled=true
> -		else
> -		    enabled=false
> -		fi
> +		# The user does not have a preference. Default to disabled.
> +		enabled=false

OK.  So the logic used to be

 - If the user has preference for a specific backend, use it;

 - If the user says the feature is unwanted, that is final;

 - If the user says it generally is OK to use the feature, let each
   backend set the preference;

 - If there is no preference, let each backend set the preference.

As we want to disable the feature for any backend when the user does
not explicitly say the feature is wanted (either in general, or for
a specific backend), the change in the above hunk is exactly want we
want to see.

Looking good.  Let's not revert the series and disable by default.

Should I expect an updated log message, though?  What was in the
proposed log message sounded more unsubstantiated complaint than
giving readable reasons why the feature is unwanted, but both the
response by Seth and your response to Seth's response had material
that made it more convincing why we would want to disable this by
default, e.g. "with little to no explanation", "We don't have a way
to communicate to the end-user" (both by Seth), "when ... didn't end
up lining up the files correctly", "no way to visually distinguish"
(yours) are all good ingredients to explain why this feature is
prone to subtly and silently give wrong information to the
end-users.

Thanks.
