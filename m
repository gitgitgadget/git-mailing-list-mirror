From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv3 09/13] submodule config: keep update strategy around
Date: Mon, 21 Sep 2015 20:56:49 -0400
Message-ID: <CAPig+cRGBSYbt6FsRwNR2TYz7vD650f3=KH_c87h27SaVCUTcQ@mail.gmail.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-10-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 02:57:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeBtC-00029z-QA
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 02:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757530AbbIVA4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 20:56:51 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36313 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757390AbbIVA4u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 20:56:50 -0400
Received: by vkfp126 with SMTP id p126so76373214vkf.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 17:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DlDplKoFCaM1enUMK3W1hKX6gLKJP9Z3oxB5H0wDDlQ=;
        b=NcbEC4vWr/y5+2mloDaxEKC5rCl+6BsPbFBQS3TJ+ZdgtrQ4KYxix3zBzmyL1dXv44
         1MUUTwrrpr31Fvz7GFjaZZsWCJVAHutEfCvBY875N3Zw22cWLFkUGgXdsYVBOLynXyv6
         SLee/PEOfZjZhV2zDkgq1gWq/rrHIOB9BkiSRsYL+b2vSDZsURGzme3OGNFIlfL522xG
         R2hwYZ9moFFc1yfJpJhp9p0rEIGQIx1kVZ9l9RCSt/OHyIktSion26BR/PwNCFg9Ur/z
         0bXZJvHt0MQyTAhAbc8UOyo/L22CLzaepTX30flrPvu2017hSaqxh+LwFofwfUPosaQP
         5qSQ==
X-Received: by 10.31.151.84 with SMTP id z81mr14869506vkd.14.1442883410044;
 Mon, 21 Sep 2015 17:56:50 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Mon, 21 Sep 2015 17:56:49 -0700 (PDT)
In-Reply-To: <1442875159-13027-10-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: _yp-ymmOB1ZQPaPB46FGtTd024s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278369>

On Mon, Sep 21, 2015 at 6:39 PM, Stefan Beller <sbeller@google.com> wrote:
> We need the submodule update strategies in a later patch.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/submodule-config.c b/submodule-config.c
> @@ -326,6 +327,21 @@ static int parse_config(const char *var, const char *value, void *data)
>                 free((void *) submodule->url);
>                 strbuf_addstr(&url, value);
>                 submodule->url = strbuf_detach(&url, NULL);
> +       } else if (!strcmp(item.buf, "update")) {
> +               struct strbuf update = STRBUF_INIT;
> +               if (!value) {
> +                       ret = config_error_nonbool(var);
> +                       goto release_return;
> +               }
> +               if (!me->overwrite && submodule->update != NULL) {
> +                       warn_multiple_config(me->commit_sha1, submodule->name,
> +                                       "update");
> +                       goto release_return;
> +               }
> +
> +               free((void *) submodule->update);
> +               strbuf_addstr(&update, value);
> +               submodule->update = strbuf_detach(&update, NULL);
>         }
>
>  release_return:

Why the complicated logic flow? Also, why is strbuf 'update' needed?

I'd have expected to see something simpler, such as:

    } else if (!strcmp(item.buf, "update")) {
        if (!value)
            ret = config_error_nonbool(var);
        else if (!me->overwrite && ...)
            warn_multiple_config(...);
        else {
            free((void *)submodule->update);
            submodule->update = xstrdup(value);
        }
    }
