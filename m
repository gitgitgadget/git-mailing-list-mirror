From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 1/4] notes: don't leak memory in git_config_get_notes_strategy
Date: Wed, 30 Mar 2016 13:32:46 -0400
Message-ID: <CAPig+cTeVgyNHa5uHUMDZ6ifxyjk2wvm=jGd9tP1+BuBKKVR+g@mail.gmail.com>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
	<1459357518-14913-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:32:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJzC-0004GE-3P
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbcC3Rcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:32:48 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33123 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbcC3Rcr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:32:47 -0400
Received: by mail-vk0-f49.google.com with SMTP id k1so70587685vkb.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=2LnwmycJV3IMZdtKMUL80kVsHVpPmBb2RIT/BVg1TqA=;
        b=iwXI6rVxOXgR0UEABIsRmgkj2IXv6oZXZpZqiA0POozFBhjSW/RbSzVXgcPOoraKA6
         QhPKEEbEzlnL/kgnFFcxVp022z2Bv0QVWo2Cq6yipq3h1NJXhOV9MY57T6s21L9L6cny
         UPrmQHzMxePGW8iD4rIaRak04VimEJpReclGdRvuY8BzDxLfsVpI4htXlwoE0Zc0l32N
         OSKq3DxKN3z5x36UapJXMpf2nFO5RFXsZ8L+nORpx5wD8RO80lFRxKwTRo3A68xeZVgV
         BAq2c1GcoUfj7IRwX8E4ZHr5PcfbBHWCmevPRMpR0y2NhTj4GJYveBBz+nGZ+gBELjLR
         9tBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2LnwmycJV3IMZdtKMUL80kVsHVpPmBb2RIT/BVg1TqA=;
        b=WWm74i72ioTEu6kyVGfDQTtzRXhYnaS6sWsE7hKyiAGlWUioxyRekclXTx/Bm/GluM
         moM1N7QoSsjohmePgmaP6D4xqtQBR8AwnpbXkpq3aVwMiaOphJO3wxk9VqCuN+AwcydT
         FeCVjb9qERHqSIsyWs1PwpyUqckQLO4ctNHnKyobLZUinaYGM/DgoV7aSsc7nAFlapkB
         430TAfz3HBC2JndWxXaFLhUMw34J7D38n3uasTmEw/bmPE0EG/HALoTZ3ykh80Z2Ho3+
         Hd/mWyAM0j48WROKuqAhiyBJ2gMjkilNUbpGGZq4KbrYJQCr9qkxLgHLsbnt+RN/lVEN
         bc/Q==
X-Gm-Message-State: AD7BkJIkMyCq5VIHBNW0iZi69Jp7G9IVJneAzHTbVZPFRh6SOU4KRMBlUCwcO6cq23NWlDbz1pUUGrcNaVKUrg==
X-Received: by 10.159.37.234 with SMTP id 97mr5342979uaf.99.1459359166813;
 Wed, 30 Mar 2016 10:32:46 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Wed, 30 Mar 2016 10:32:46 -0700 (PDT)
In-Reply-To: <1459357518-14913-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: tZ-ESt3NTNmGMAI2lGWt_k4B4zI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290328>

On Wed, Mar 30, 2016 at 1:05 PM, Stefan Beller <sbeller@google.com> wrote:
> `value` is just a temporary scratchpad, so we need to make sure it doesn't
> leak. It is xstrdup'd in `git_config_get_string` and
> `parse_notes_merge_strategy` just compares the string against predefined
> values, so no need to keep it around longer. Make `value` non-const to
> avoid the cast in the free.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/notes.c b/builtin/notes.c
> @@ -744,13 +744,14 @@ static int merge_commit(struct notes_merge_options *o)
>  static int git_config_get_notes_strategy(const char *key,
>                                          enum notes_merge_strategy *strategy)
>  {
> -       const char *value;
> +       char *value;
>
> -       if (git_config_get_string_const(key, &value))
> +       if (git_config_get_string(key, &value))
>                 return 1;
>         if (parse_notes_merge_strategy(value, strategy))
>                 git_die_config(key, "unknown notes merge strategy %s", value);
>
> +       free(value);
>         return 0;
>  }

Hmm, I thought Peff's suggestion of using git_config_get_value() was
accepted as superior since it avoids the allocation altogether, thus
no need for free() and no leak.
