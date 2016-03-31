From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv3 1/4] notes: don't leak memory in git_config_get_notes_strategy
Date: Thu, 31 Mar 2016 17:08:30 -0400
Message-ID: <CAPig+cRPNt1aNdsONXgX0SkgNiYtTS8vCGQzE2u4+vpd-N-Vew@mail.gmail.com>
References: <1459447446-32260-1-git-send-email-sbeller@google.com>
	<1459447446-32260-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 23:08:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aljpe-0001qZ-HU
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 23:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933120AbcCaVIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 17:08:35 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34768 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbcCaVIc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 17:08:32 -0400
Received: by mail-vk0-f54.google.com with SMTP id e185so119220015vkb.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=roe3qrI1cXlEFphPg1LJIxaq2SAzlcn9jovrcMhT+jw=;
        b=nG/Erc6vafuvYWdKwJcLfG8t+UyjF1+uxy5qA0IeNIkyuh4kshjEkgqC9fjTkdOudA
         ZE5bMqvvnk80hQuaMsXkUrbfdt4CTfhGLlb/6BhQ0PUfaWZNL8bEuyZjyeeC94+si5pP
         FZkEbXGvxIi1xoK78sjtlVHpVsbXgiOHj0BI9+JsPRG0St8IPGsZ6zqaqBTnq2uv2gTl
         WTehiEUxFOJV9KOaCuwb4WPek7HBvxu90tvCsZKhJzrlnby6qYDnxOIY4R1pj3Nc29Er
         CBdPH/YZMFDudw6BZpY7kweLKMuhNdLQ2+J8iCkzvZYd/7NyGwIgu/Zx5A+tCXBatKSR
         0yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=roe3qrI1cXlEFphPg1LJIxaq2SAzlcn9jovrcMhT+jw=;
        b=F8EwHoPteFvBAgy4dZeolT8DmWXlbH0QNum+mkei1OsuiNusTu+pwfmBcAEzzOK4tm
         WKLnD752SkwPslwR5HKolUZzuuZ4g6HHTqKjDYewItVhbLYsCIWXIp6/9jgJOyy0yQDa
         vai35xH1piF8Xp55Xxm6doINB+jXcRfBNutfQsXgFHi0SdfU/3X01CPwrQo++F0LBO+H
         wzXjGaRcBjH2LOa0UlttCfsYxeVoY5qUlcKS421+nj+7YZtHuP9fkCtu7xS8Xpsj4UyB
         JVIBDMjdcB5/RgLgs5ZQIW7NiigzqIFgaMGZ7S6dPem86C/FEG2PzRSkw+xUamXs8UXa
         2pUg==
X-Gm-Message-State: AD7BkJLme9QUjjXD9k+KxEqziNHBujF0TRI5jW1crU7UJTWQe3iOJ1jCOTbOf7Z0sDr9QieeQyUV7YIV4ZNFEQ==
X-Received: by 10.159.38.49 with SMTP id 46mr2921468uag.139.1459458510647;
 Thu, 31 Mar 2016 14:08:30 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 31 Mar 2016 14:08:30 -0700 (PDT)
In-Reply-To: <1459447446-32260-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: ZMn5Zi3AxISdIC0otlJLSsEgt7k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290473>

On Thu, Mar 31, 2016 at 2:04 PM, Stefan Beller <sbeller@google.com> wrote:
> `value` is just a temporary scratchpad, so we need to make sure it doesn't
> leak. It is xstrdup'd in `git_config_get_string_const` and
> `parse_notes_merge_strategy` just compares the string against predefined
> values, so no need to keep it around longer. Instead of using
> `git_config_get_string_const`, use `git_config_get_value`, which doesn't
> return a copy.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/notes.c b/builtin/notes.c
> @@ -746,7 +746,7 @@ static int git_config_get_notes_strategy(const char *key,
>  {
>         const char *value;
>
> -       if (git_config_get_string_const(key, &value))
> +       if (git_config_get_value(key, &value))

Hmm, doesn't this introduce a rather severe regression? Unless I'm
misreading the code (possible), with the original, if 'key' was
boolean (lacked a value in the config file), then it would complain:

    Missing value for 'floop.blork'

but, with this change, it will dereference NULL and crash.

(My understanding was that Peff's suggestion to use
git_config_get_value() implied a bit of work beyond the simple textual
substitution of 'git_config_get_value' for
'git_config_get_string_const'.)

>                 return 1;
>         if (parse_notes_merge_strategy(value, strategy))
>                 git_die_config(key, "unknown notes merge strategy %s", value);
