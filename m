From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/6] notes: don't leak memory in git_config_get_notes_strategy
Date: Tue, 29 Mar 2016 21:11:30 -0400
Message-ID: <CAPig+cQxtFDY8kAx-UD_dYatTJJnx260CaY5Ke3yDOS666YEtA@mail.gmail.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
	<1459298333-21899-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 03:11:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4fY-0007Zv-1S
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbcC3BLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:11:31 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34229 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbcC3BLb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:11:31 -0400
Received: by mail-vk0-f67.google.com with SMTP id e6so4569920vkh.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 18:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=iPU/rSrM9aXNEur5T/ooKMMtEZQ1DCMtEzSxFV005ZU=;
        b=U9cF8pjMUxe3J7ix0976zdPrvLmsS/qUbQXrLhJMYlgrCG/aZEbYpenGJ1Njr5gC84
         ZdkU57HasvRrOKfjAhk6XDt9wemOOn2QpQjLkejHH9vNpuUet7waunBMapfHZXKoc9S4
         WD+hwSK3yEhQTUo5EacRRINNls1eiyCY2ccLviUK3Qv7bocekcTmHFV81MX5PDlCy2cW
         Lj3JRcdGOq49Uzaq1yBm7jPfEU+KvfMFnB9q1gbwV/51Y1Aiy1tucKcQhOSWy8M7F6/s
         P/eBZUQwRZ2v+8AZZaWlARCdogB62ugQssvIBzQr1NDfVXagDutHa7e7+8vXHwXOAj5t
         G2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=iPU/rSrM9aXNEur5T/ooKMMtEZQ1DCMtEzSxFV005ZU=;
        b=ko0XzK17MqKjj9O42kPTyjECOJWSHPbwp1DE2Bk6SSXIhUbiAvDwTUl2w4gOyqDdiq
         ZgnqkHU13Vgp1o80DxK5m+BXic+9CzHMEZLsMD7w4h7/Uc66yOJ4HseP7WNgvv1SHciz
         1PtBOV6QHYS8WgUby/dKBSxGAKQlYMFzMO/T4A3TPIewmi7GUDbWohTJBYgy57Q1w9df
         jMhMDsKS1J+Cq8KzdKNIEAr8V1rbHCwislIvaF1U7gRrsGKl5sqczIA8lurOZCeg2uA7
         tyotV7izMh2jwbyyAXBn0ZvAjlWqP8Feulj+FUNJuXDmRWcW6EFcdpJvTWOoO1kHRLXu
         lMdg==
X-Gm-Message-State: AD7BkJIcY3SyXaGz7C8JMTWYldi/qJoJ74aUmXEcjvU8hEdgnupMpJDkPLg8mQ4eBX2u0y0rfBKBnHI9X2G/VA==
X-Received: by 10.31.47.135 with SMTP id v129mr3499337vkv.115.1459300290169;
 Tue, 29 Mar 2016 18:11:30 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 18:11:30 -0700 (PDT)
In-Reply-To: <1459298333-21899-4-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: zu5Im1yS4RqwUcaFmb9qqday67E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290247>

On Tue, Mar 29, 2016 at 8:38 PM, Stefan Beller <sbeller@google.com> wrote:
> `value` is just a temporary scratchpad, so we need to make sure it doesn't
> leak. It is xstrdup'd in `git_config_get_string_const` and
> `parse_notes_merge_strategy` just compares the string against predefined
> values, so no need to keep it around longer.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/notes.c b/builtin/notes.c
> @@ -751,6 +751,7 @@ static int git_config_get_notes_strategy(const char *key,
>         if (parse_notes_merge_strategy(value, strategy))
>                 git_die_config(key, "unknown notes merge strategy %s", value);
>
> +       free((void*)value);

I wonder if the intent would be clearer if you gave 'value' type 'char
*' rather than 'const char *', and called git_config_get_string()
rather than git_config_get_string_const().

>         return 0;
>  }
