Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316941F404
	for <e@80x24.org>; Tue, 16 Jan 2018 19:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeAPTGs (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 14:06:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56525 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbeAPTGr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 14:06:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7306FD61A2;
        Tue, 16 Jan 2018 14:06:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=R4knFSipHEAc
        B5vi9ejlaeg5GT0=; b=OafzqriC48UYffzYNU1EGwRs9/szCclI1MIXyqE/j9Ue
        fOIyNyzzfNQKacrURbrFtFEhxr6i9mlXItBV9vO9FqTiw8F6Jr/zpVP4KZ7Ok9OB
        PhkjFP+8w7/HYuI7qeCotY9YehrmNlMXnHew1EElqVr9fMT1mVlwTCI/M7VVVzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aSz+UD
        5SYqCivRCMmZkXYvGLD+o8QICn1v12hSyzrV3V+8FF+sWH7+WK7ZhKK5vv3eVato
        FdFXi6o0eMA6RKYEIPbctLLN50t7L2SkeFfQxk4m9voEcl/UyW9a+1fOmGtyIC5Y
        c1jJ4URpGeaHGzQwaea/ejEKHwXdHEzg+hnFk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68B26D61A1;
        Tue, 16 Jan 2018 14:06:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6EF8D61A0;
        Tue, 16 Jan 2018 14:06:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff.c: flush stdout before printing rename warnings
References: <20180116092349.11330-1-pclouds@gmail.com>
Date:   Tue, 16 Jan 2018 11:06:44 -0800
In-Reply-To: <20180116092349.11330-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 16 Jan 2018 16:23:49 +0700")
Message-ID: <xmqqd129vd17.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6564DA22-FAF0-11E7-A160-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The diff output is buffered in a FILE object and could still be
> partially buffered when we print these warnings (directly to fd 2).
> The output is messed up like this
>
>  worktree.c                                   |   138 +-
>  worktree.h        warning: inexact rename detection was skipped due to=
 too many files.
>                            |    12 +-
>  wrapper.c                                    |    83 +-
>
> It gets worse if the warning is printed after color codes for the graph
> part are already printed. You'll get a warning in green or red.
>
> Flush stdout first, so we can get something like this instead:
>
>  xdiff/xutils.c                               |    42 +-
>  xdiff/xutils.h                               |     4 +-
>  1033 files changed, 150824 insertions(+), 69395 deletions(-)
> warning: inexact rename detection was skipped due to too many files.

The patch sort-of makes sense, and I am not sure if any of the
issues that show rooms for potential improvements I'll mention are
worth doing.

 - This matters only when the standard output and the starndard error
   are going to the same place.  It also would be conceptually nicer to
   flush stderr as well even though it is by default not fully
   buffered.

 - Also this function can take two bools and gives a warning that
   potentially cause the issue three out of four combinations, so one
   out of four cases we would be unnecessarily flushing.



> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  diff.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/diff.c b/diff.c
> index fb22b19f09..5545c25640 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5454,6 +5454,7 @@ N_("you may want to set your %s variable to at le=
ast "
> =20
>  void diff_warn_rename_limit(const char *varname, int needed, int degra=
ded_cc)
>  {
> +	fflush(stdout);
>  	if (degraded_cc)
>  		warning(_(degrade_cc_to_c_warning));
>  	else if (needed)
