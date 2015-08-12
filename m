From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] cleanup submodule_config a bit.
Date: Wed, 12 Aug 2015 17:13:01 -0400
Message-ID: <CAPig+cTcWME_U+nYATK7kK0vOSSCjJmGgXmUVmSawBiV5M+02g@mail.gmail.com>
References: <1439406838-6290-1-git-send-email-sbeller@google.com>
	<1439406838-6290-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Karsten Blees <karsten.blees@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 23:13:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPdKe-0001DF-T7
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 23:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbbHLVNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 17:13:04 -0400
Received: from mail-yk0-f195.google.com ([209.85.160.195]:36130 "EHLO
	mail-yk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbHLVNC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 17:13:02 -0400
Received: by ykay144 with SMTP id y144so1985584yka.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0xSquDzEch0ueDIQxX55ALW9E17b/ZGXqj0zdDPSF2U=;
        b=nGR60CFVKIAunDmO0DcsvSgoPYAZlUidkH28mUalf048zCoc0fKcLDFIctdLj2pmSP
         9cEFKvJ8o+5f2XDmX5n1/eZmiR6sgDmOgKDCuRbT1NCytzrxtVB2pje9UBfK4INYmutF
         gycmo9kahksE2PJgV8Wng2D+l+ZQzozCVAdSSXVoFjmcgcpuA0EuUDuaer4Vgcq3dG49
         DYx+dtvQHjFKRBMcUHxj6HLXfVdIOlGMKJZtoZTaDqifOb5XFOoUk/ajgL41ZJ9gfgol
         +cmgdX9WEtZ6k/oZq3S+DtskPOLcdnX3HAkhfmP97bmSxbGUucYn9dxbOq5xb+rX439n
         e3ig==
X-Received: by 10.13.220.132 with SMTP id f126mr36261586ywe.39.1439413981530;
 Wed, 12 Aug 2015 14:13:01 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Wed, 12 Aug 2015 14:13:01 -0700 (PDT)
In-Reply-To: <1439406838-6290-3-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: AJZrVPuRqpMSvs25viddQkhIFCg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275810>

On Wed, Aug 12, 2015 at 3:13 PM, Stefan Beller <sbeller@google.com> wrote:
> In the first hunk, `submodule` is NULL all the time, so we can make it clearer
> by directly returning NULL.
>
> In the second hunk, we can directly return the lookup values as it also makes
> the coder clearer.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule-config.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 199692b..08e93cc 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -387,7 +387,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>         }
>
>         if (!gitmodule_sha1_from_commit(commit_sha1, sha1))
> -               return submodule;
> +               return NULL;

There are a couple other places which return 'submodule' when it is
known to be NULL. One could rightly expect that they deserve the same
treatment, otherwise, the code becomes more confusing since it's not
obvious why 'return NULL' is used some places but not others.

>         switch (lookup_type) {
>         case lookup_name:
> @@ -420,14 +420,12 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>
>         switch (lookup_type) {
>         case lookup_name:
> -               submodule = cache_lookup_name(cache, sha1, key);
> -               break;
> +               return cache_lookup_name(cache, sha1, key);
>         case lookup_path:
> -               submodule = cache_lookup_path(cache, sha1, key);
> -               break;
> +               return cache_lookup_path(cache, sha1, key);
> +       default:
> +               return NULL;
>         }
> -
> -       return submodule;

Earlier in the function, there's effectively a clone of this logic to
which you could apply the same transformation. Changing it here, while
ignoring the clone, makes the code more confusing (or at least
inconsistent) rather than less.

>  }
>
>  static const struct submodule *config_from_path(struct submodule_cache *cache,
> --
> 2.5.0.234.gefc8a62
