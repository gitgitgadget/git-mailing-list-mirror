From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCHv2 2/8] submodule config: keep update strategy around
Date: Thu, 29 Oct 2015 21:14:22 -0400
Message-ID: <CAPig+cRTa35B5aHcopaWOtCLxN6BhGJKTcVeDUf0hrZE_nfCKQ@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<1446074504-6014-3-git-send-email-sbeller@google.com>
Reply-To: Eric Sunshine <sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 02:14:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZryGx-0005xk-JJ
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 02:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbbJ3BOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 21:14:23 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:32888 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbbJ3BOX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 21:14:23 -0400
Received: by vkgy127 with SMTP id y127so38776769vkg.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 18:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=rJbNP63m32bolnvXBeWOwEo/Jr+D85Sim42hGYfV8UU=;
        b=aX/ZPtMbzmWhawYhDbuyE1F5Xc3G7BWfd308e9Ybf1bmuBQ47btwdX1W1D1TWMw0t2
         iLYXDXSdIeRFN+4J++GI9NW50XstMu34GYOBGxeluOjjYeI7F5YZyYfPy/GYRq2dWMdZ
         kjaVsLnWwSq7DBOgrvuaZGxJ2qSgF7LUGQmqrrIDku7us5jk4afclOuESKhj5ZM34Jjs
         oiYvZC0IrQsUyGXgIifPtivlW4YSCojiUsqKkoOcGW+0URzfjlQ3JsIJMaNj1MQvO0QA
         59+jLQSO5U29R5u5kLmrKAXbmP5DqtWW8gDNIdJOqmbrKcKR7TI44Nbl6sK/K5xo1Xh5
         oDJQ==
X-Received: by 10.31.153.210 with SMTP id b201mr3543942vke.117.1446167662301;
 Thu, 29 Oct 2015 18:14:22 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Thu, 29 Oct 2015 18:14:22 -0700 (PDT)
In-Reply-To: <1446074504-6014-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280469>

On Wed, Oct 28, 2015 at 7:21 PM, Stefan Beller <sbeller@google.com> wrote:
> We need the submodule update strategies in a later patch.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/submodule-config.c b/submodule-config.c
> index afe0ea8..8b8c7d1 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -311,6 +312,16 @@ static int parse_config(const char *var, const char *value, void *data)
>                         free((void *) submodule->url);
>                         submodule->url = xstrdup(value);
>                 }
> +       } else if (!strcmp(item.buf, "update")) {
> +               if (!value)
> +                       ret = config_error_nonbool(var);
> +               else if (!me->overwrite && submodule->update != NULL)

Although "foo != NULL" is unusual in this code-base, it is used
elsewhere in this file, including just outside the context seen above.
Okay.

> +                       warn_multiple_config(me->commit_sha1, submodule->name,
> +                                            "update");
> +               else {
> +                       free((void *)submodule->update);

Minor: Every other 'free((void *) foo)' in this file has a space after
"(void *)", one of which can be seen in the context just above.

> +                       submodule->update = xstrdup(value);
> +               }
>         }
>
>         strbuf_release(&name);
