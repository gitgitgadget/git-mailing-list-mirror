From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/6] path.c: allocate enough memory for string
Date: Tue, 29 Mar 2016 20:57:14 -0400
Message-ID: <CAPig+cSqC1muy+vcmpkp9uM9T3CC4pa5jWGUot_FtrVshEAUEw@mail.gmail.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
	<1459298333-21899-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 02:57:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4Rk-00022B-EM
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 02:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbcC3A5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 20:57:16 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33706 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbcC3A5P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 20:57:15 -0400
Received: by mail-vk0-f65.google.com with SMTP id a62so4595054vkh.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 17:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=2UhHJefM0Ec7Bnd5/YdlIfUINLoYj1oyviOS3lr2xLo=;
        b=YwcmuQ1sLIAz8dtCdMm54tweLXyEKKv2NooC2QoMgdAs4MyFzQNtdzxq56T29MOD6V
         0ljZpZjHq13Z+/1FHIVm5QX0uUH/U0YwMp9gS1SNbsor11pmGNXaZzRbHpix0ReVLuq8
         pvR4ysO9G9RZJk5kaenKuCBZTtIKOH26DyoKrnLcyJHtEj52tLHACbrd5XYOhIDO/hYP
         1mIKdxOzgYGeIprPEE58mEZI54iBhmMnunoObhVXpyuQVLuLR6ui+Vi00wlkuMd4x9HY
         QSfu54FCccCRLs0tjtnl6UiSLOcGo68V74ZAGOHJGnKtb/L0isgQZBmSSzujyYyRDVS5
         zdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2UhHJefM0Ec7Bnd5/YdlIfUINLoYj1oyviOS3lr2xLo=;
        b=XVJdNsBcL9jWu1MT1CtQAPwPeBytfDYiojnUIuyMZ67dsEpJ3om7mDaNL1f/B/PoQB
         h53DRLdZqX6pqUwmyY2UJ6zWI6jdhj5TAIPlacYhrQcQIeYpS3aAdvEI0s6hmDds5P4s
         95OiHOFlw0jAdRjUAkTfwqHM0p3RewJF83yIvU+BCKlWuqurGS7wTr5ai92WiTHQ+W+s
         2/gbv/ggeQQXJEqP9G5P/pxP5KpWEoVVcCCuEPMweiQ086MZ0ABmiGpSbZJgRROM5pTC
         lEcxnFlAF8KgJEN/P2eXK0b4agvel0sbmxdzIWczgJH+ZpKzX3CeQbhq9WKKV5x9pnhc
         1/bA==
X-Gm-Message-State: AD7BkJJgOpIjVxZoXiDNhvxtNqm293PtVz3vhRX3wF1zd5vlx/zVtD8jVQ7OVraLzmLjZ3/+is9aYQhnXgyFLw==
X-Received: by 10.176.0.75 with SMTP id 69mr3453689uai.113.1459299434330; Tue,
 29 Mar 2016 17:57:14 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 17:57:14 -0700 (PDT)
In-Reply-To: <1459298333-21899-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: gtDnKYW-7gvXHIBJawIlwx0iiNk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290241>

On Tue, Mar 29, 2016 at 8:38 PM, Stefan Beller <sbeller@google.com> wrote:
> `strlen` returns the length of a string without the terminating null byte.
> To make sure enough memory is allocated we need to pass `strlen(..) + 1`
> to the allocation function.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/path.c b/path.c
> @@ -155,7 +155,7 @@ static struct trie *make_trie_node(const char *key, void *value)
>         struct trie *new_node = xcalloc(1, sizeof(*new_node));
>         new_node->len = strlen(key);
>         if (new_node->len) {
> -               new_node->contents = xmalloc(new_node->len);
> +               new_node->contents = xmalloc(new_node->len + 1);
>                 memcpy(new_node->contents, key, new_node->len);

Huh? This is a trie. It never accesses 'contents' as a NUL-terminated
string. Plus, no NUL is ever even copied, thus this is just
overallocating. How is this an improvement?

>         }
>         new_node->value = value;
> --
