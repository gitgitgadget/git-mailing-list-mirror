Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8AEF1F461
	for <e@80x24.org>; Mon, 13 May 2019 08:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfEMIFT (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 04:05:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60735 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMIFS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 04:05:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0E4614F7B1;
        Mon, 13 May 2019 04:05:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YiExBS3rm4ewI/V888eA+HL7BAw=; b=g4MEc8
        wQhBCon1lPUXMDJYaxnFx9XbwgRB9gAFwIPXJowtjksL0m8zPEIIUfHcIh2fxDao
        rhaoAn6uBt/WEiJcFPQh3z8UpRTAKr3UBR9F+DFBry6Ujxubg8dmhn8lVly+XysH
        ayde0Osg+mlEU/62pf/ED6lOox2r4snoOMq+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yt79A8OrY+jVYXSf2Hl5MZCoh/2zdwt9
        LFVQDd+ELlV+vKYQ2GrUbiX7k+HhQjwqsJ8OEcLNtIoQAsjG74Xozp+MyUrJJbEV
        eIZV57egujvtZozKF8EPykHk2GxOiJz+7J+wCXKY1LcVtZ/RtFB/iwaTvOHpFfK0
        MKixWa1bUYs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9751814F7B0;
        Mon, 13 May 2019 04:05:16 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F33BC14F7AF;
        Mon, 13 May 2019 04:05:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: explain why file: URLs and bundles don't mix
References: <20190513002355.25031-1-hi@alyssa.is>
Date:   Mon, 13 May 2019 17:05:14 +0900
In-Reply-To: <20190513002355.25031-1-hi@alyssa.is> (Alyssa Ross's message of
        "Mon, 13 May 2019 00:23:55 +0000")
Message-ID: <xmqqv9yebwzp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7875A72-7555-11E9-90F9-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alyssa Ross <hi@alyssa.is> writes:

> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  Documentation/urls.txt | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index b05da95788..c83d9f859e 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -43,14 +43,24 @@ syntaxes may be used:
>  - \file:///path/to/repo.git/
>  
>  ifndef::git-clone[]
> -These two syntaxes are mostly equivalent, except when cloning, when
> -the former implies --local option. See linkgit:git-clone[1] for
> -details.
> +These two syntaxes are mostly equivalent, with some exceptions:
> +
> +- When cloning, the former implies --local option. See
> +  linkgit:git-clone[1] for details.
> +
> +- The latter is implemented using linkgit:git-upload-pack[1], which
> +  expects its repository to be a directory, and therefore does not
> +  work for bundles (see linkgit:git-bundle[1]).

Hmm, I do not think this is quite true.  

If "git clone /path/to/repo.bndl" implied --local, we would end up
trying to hardlink into /path/to/repo.bndl/objects and would fail.

I think what is closer to the reaility is that we check if the
source is a bundle when the local filesystem path is used and try to
clone from the bundle, before using the local filesystem path as a
directory we can "clone --local" from.  On the other hand, when the
<scheme>://<path> syntax is used, we do not even bother seeing if
the named resource is a bundle, or if --local optimization is
possible (because we do not bother seeing if the named resource is a
local filesystem entity, either).

A possibly interesting tangent to think about is what would happen
if we slightly tweak the above design.  What it would require for
the code to take "git clone https://site/repo.bndl", realize that
the named resource is a bundle file, curl/wget it and clone from
that downloaded bundle?  And if it is feasible to implement, would
it even be a good idea to begin with?  I do not have a ready answer
to either of these questions myself.
