Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4131F462
	for <e@80x24.org>; Fri,  7 Jun 2019 14:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfFGOva (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 10:51:30 -0400
Received: from goliath.siemens.de ([192.35.17.28]:46790 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfFGOva (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 10:51:30 -0400
Received: from mail1.siemens.de (mail1.siemens.de [139.23.33.14])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id x57EpK21014130
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jun 2019 16:51:20 +0200
Received: from [147.54.65.49] (MD11GXTC.ad001.siemens.net [147.54.65.49])
        by mail1.siemens.de (8.15.2/8.15.2) with ESMTP id x57EpK06011103;
        Fri, 7 Jun 2019 16:51:20 +0200
Subject: Re: [PATCH] configure: Detect linking style for HP aCC on HP-UX
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <6aabf669-a73f-d23d-8d65-8b96eefbae4b@siemens.com>
 <20190516093412.14795-1-avarab@gmail.com>
From:   "Osipov, Michael" <michael.osipov@siemens.com>
Message-ID: <c12ec5ff-87c9-a6d0-e9f6-6d7e1cf343c5@siemens.com>
Date:   Fri, 7 Jun 2019 16:51:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190516093412.14795-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Am 2019-05-16 um 11:34 schrieb Ævar Arnfjörð Bjarmason:
> From: Michael Osipov <michael.osipov@siemens.com>
> 
> HP aCC does not accept any of the previously tested CC_LD_DYNPATH
> formats, but only its own[1] "-Wl,+b" format. Add it to configure.ac.
> 
> 1. http://nixdoc.net/man-pages/hp-ux/man1/ld_pa.1.html
> 
> Signed-off-by: Michael Osipov <michael.osipov@siemens.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> I took the liberty of slightly amending the commit message.
> 
>   configure.ac | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index be3b55f1cc..a43b476402 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -475,8 +475,18 @@ else
>         if test "$git_cv_ld_rpath" = "yes"; then
>            CC_LD_DYNPATH=-rpath
>         else
> -         CC_LD_DYNPATH=
> -         AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
> +         AC_CACHE_CHECK([if linker supports -Wl,+b,], git_cv_ld_wl_b, [
> +            SAVE_LDFLAGS="${LDFLAGS}"
> +            LDFLAGS="${SAVE_LDFLAGS} -Wl,+b,/"
> +            AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])], [git_cv_ld_wl_b=yes], [git_cv_ld_wl_b=no])
> +            LDFLAGS="${SAVE_LDFLAGS}"
> +         ])
> +         if test "$git_cv_ld_wl_b" = "yes"; then
> +            CC_LD_DYNPATH=-Wl,+b,
> +          else
> +             CC_LD_DYNPATH=
> +             AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
> +          fi
>         fi
>      fi
>   fi
> 

I can see that this one has not yet been committed nor my PR has been 
pulled.

Any chances to get this into master?

Michael
