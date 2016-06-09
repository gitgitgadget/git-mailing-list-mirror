From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/5] attr.c: always pass check[] to collect_some_attrs()
Date: Wed, 8 Jun 2016 17:25:39 -0700
Message-ID: <CAGZ79kbWygHWVhcn9du8P15i2okvFgvt2VPdamHCf2Bvm-n0fg@mail.gmail.com>
References: <20160608225818.726-1-gitster@pobox.com> <20160608225818.726-6-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 02:25:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAnnB-0007yF-Ox
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 02:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776AbcFIAZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 20:25:41 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35618 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932317AbcFIAZk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 20:25:40 -0400
Received: by mail-qk0-f174.google.com with SMTP id p22so13161016qka.2
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 17:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mQSON8MqC4pV1zvI3qZ73wjHAWgAg5eUdlS5QE9Zefo=;
        b=HlnE2uAipdp6xpozfZMM4ok+2VD52UQ844qL2h7MEE/UhwACvkHuSEbzs3VEu4Ff6M
         cyQFWtvbBj4K+dgrIKRwNFz0grYhxTYsTfV3X4bbdLzA4UKNJc9VoBZHhj548VytrwSN
         h5712i6mmRvxQbv3fe1k9PF9wPMc0LZF37DBQPyxGNBbc3KY6O21tRrv6rbkdKmKSa/m
         /nSyCy/AmqpAHAjMWyuJ9w6408+E0C8l6vRCTaym4UIHOGB1nHa5LIGHP+JdJLPXeDHr
         dBlc8uzhc6/YGfCMwy7bICGZtOaeQEwTayDG7F3DV4uWrpggbZlALlhOM4NRl0W0eMC5
         L7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mQSON8MqC4pV1zvI3qZ73wjHAWgAg5eUdlS5QE9Zefo=;
        b=ANjm5/1BEiQ2h0So4el0IAzrY9oo0TSzIarT81pVlRc9qLat5scQjNIOzOE6RmDGD5
         NHNnO1EJOmBOFXBAAM6dXGtkDRVQw3EOjxSoCG8Jo3hzXKWjjiMGasvFS9+VRg+Rhob4
         MoWUJmW90ZVESpuTbpfXn6dN9/daMOaSme5DuEEuGDZC4mZ2+q/kpe31MoIVlxyaf/u6
         NJZK6ZUm8HVsCy6BHpZrXLH1lOCcTA2T0KZLQETkF7JHo0OOsC4s6qR30XmLBewyaPao
         a+vkuhYdRQvnCpRdLQS/xeMFY0+DGOIcupk1MHDRJJzhzeGF6gUnlhZslvfUSmWYCVIb
         BuqA==
X-Gm-Message-State: ALyK8tKlrKVyYr7vzA8D7Ayj2WDYhSOlHveuZI/5HShWL/JfeKMr6rMAwC4cXbTU8Guey0qjFaVLHyeY0i83hI5V
X-Received: by 10.55.10.147 with SMTP id 141mr6128477qkk.91.1465431939477;
 Wed, 08 Jun 2016 17:25:39 -0700 (PDT)
Received: by 10.237.42.226 with HTTP; Wed, 8 Jun 2016 17:25:39 -0700 (PDT)
In-Reply-To: <20160608225818.726-6-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296867>

On Wed, Jun 8, 2016 at 3:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> This function used to be called with check=NULL to signal it to
> collect all attributes in the global check_all_attr[] array.
>
> Because the longer term plan is to allocate check_all_attr[] and
> attr_stack data structures per git_attr_check instance (i.e. "check"
> here) to make the attr subsystem thread-safe, it is unacceptable.
>
> Pass "Are we grabbing all attributes defined in the system?" bit as
> a separate argument and pass it from the callers.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  attr.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index cdf064e..95d2f77 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -743,11 +743,12 @@ static int macroexpand_one(int nr, int rem)
>
>  /*
>   * Collect attributes for path into the array pointed to by
> - * check_all_attr.  If check is not NULL, only attributes in
> - * check[] are collected. Otherwise all attributes are collected.
> + * check_all_attr.  If collect_all is zero, only attributes in
> + * check[] are collected.  Otherwise, check[] is cleared and
> + * any and all attributes that are visible are collected in it.
>   */
>  static void collect_some_attrs(const char *path, int pathlen,
> -                              struct git_attr_check *check)
> +                              struct git_attr_check *check, int collect_all)

I think it may be better to have a collect_all_attrs instead of a flag here,
as more than half the executed code differs (the parts conditioned on
collect_all are rather large in the function)

>
>  {
>         struct attr_stack *stk;
> @@ -768,10 +769,11 @@ static void collect_some_attrs(const char *path, int pathlen,
>         }
>
>         prepare_attr_stack(path, dirlen);
> +

stray empty line?
