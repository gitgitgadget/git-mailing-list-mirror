From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Close config file handle if the entry to unset is not found
Date: Fri, 14 Aug 2015 15:35:39 -0400
Message-ID: <CAPig+cQMng-bPjO3WLYb1z7aghYhhHqewSr+EGFgV6Gs6_JZRQ@mail.gmail.com>
References: <55CE3F23.7040702@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Fri Aug 14 21:35:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQKlV-000491-Tz
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 21:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbbHNTfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 15:35:41 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35549 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbHNTfk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 15:35:40 -0400
Received: by ykbi184 with SMTP id i184so13425307ykb.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cLwbfWZ7P3D7s+/TIbRBCLa8OnHVLTjmN2H/XU6+87A=;
        b=IG0khQsqtZdEw+R/vj+1fwzyuSwZswshmyq+JuhXgSdtLDoM5Ex3f10QraFDHV1u/d
         OKUvfJYv6sIKPp43SnuSZFwSfhRMWDgou62d2G05MRyggoIvLh1CpeO2hyiBWZlSPZ2D
         g3wWyVMAPVCAOSArgswQl07iGEVnNACnNovISrC9I9Z/qFEntHE6Jhgw1Lh7qeU2tpS8
         DgK/QSqXp/wBjEde2b9Fe14GuMi4kzwTnbE8YbEIIahpx9FNUyp3pbLnJ0n2dqmxzS52
         qOTr8dnThQNys7BDYxPko+yUaUFvdYr30fNVMucfMSM9DiFPms9WCocNYfaMzyHtkjsL
         6fQw==
X-Received: by 10.129.76.151 with SMTP id z145mr33211107ywa.17.1439580939947;
 Fri, 14 Aug 2015 12:35:39 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 14 Aug 2015 12:35:39 -0700 (PDT)
In-Reply-To: <55CE3F23.7040702@cs-ware.de>
X-Google-Sender-Auth: U3ewXX7L4222V3Oucd73MQnNLW0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275925>

On Fri, Aug 14, 2015 at 3:18 PM, Sven Strickroth <sven@cs-ware.de> wrote:
> Without this patch there might be open handle leaks.

Thanks for the patch. A question below...

> Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---
> diff --git a/config.c b/config.c
> index 9fd275f..89b49e3 100644
> --- a/config.c
> +++ b/config.c
> @@ -2048,6 +2048,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
>                 if ((store.seen == 0 && value == NULL) ||
>                                 (store.seen > 1 && multi_replace == 0)) {
>                         ret = CONFIG_NOTHING_SET;
> +                       close(in_fd);
>                         goto out_free;

>From a cursory read of the code, it appears that there are several
other places where the open 'in_fd' gets leaked which would deserve
the same treatment. So, it's not clear why this patch handles only
this one case. Am I missing something?

>                 }
>
> --
