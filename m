From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/15] logmsg_reencode: return const buffer
Date: Mon, 9 Jun 2014 21:36:43 -0400
Message-ID: <CAPig+cQzNnnTST-SVgxRsgLtHFO8NFpnJ=uFzHStgMeJDhgMfQ@mail.gmail.com>
References: <20140609180236.GA24644@sigill.intra.peff.net>
	<20140609181017.GD20315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 03:36:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuAzY-0006Oc-JY
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 03:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933608AbaFJBgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 21:36:44 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:48027 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345AbaFJBgn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 21:36:43 -0400
Received: by mail-yh0-f46.google.com with SMTP id 29so3278047yhl.5
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 18:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2JcU+D/tRJQdkg0UbM5IHGqZuSkDxUEfPsUli0t4aEc=;
        b=O9AdpJe8vb7QScXOUhSNYAJ32IsWYYzhzYUpT3mVczBog/1OUsqiU4ZkuxSbcG8Z1x
         xD6FfxlPF9Ir2NFaeylY+X4DpQpQB6S47D3N94iP90SX4aqknzBGiITngO+OVhW3miJ5
         BoCoF20dlqDg0fSsMheM9i6ZW5sO5CUAi49e4Bv9PceoytE5a6yVyjQ5eUIDopoaHMCI
         VpZhVTlSBx8vZu9SN0o8j0bfQrQlQGcQNhD3RBZ7HGBInLPTiMlIS24dXT0uH47r0DJk
         Y5ApjQCOJ/xo+mTQB7ln6jcqMOseiCyhMgtjL5e+SCUyXqszSgRbf/y9pOu9T6F0lHId
         QPQA==
X-Received: by 10.236.66.139 with SMTP id h11mr18858661yhd.30.1402364203218;
 Mon, 09 Jun 2014 18:36:43 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Mon, 9 Jun 2014 18:36:43 -0700 (PDT)
In-Reply-To: <20140609181017.GD20315@sigill.intra.peff.net>
X-Google-Sender-Auth: qpWz4BVpoCndVMIIuIwpq5z0QeU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251152>

On Mon, Jun 9, 2014 at 2:10 PM, Jeff King <peff@peff.net> wrote:
> The return value from logmsg_reencode may be either a newly
> allocated buffer or a pointer to the existing commit->buffer.
> We would not want the caller to accidentally free() or
> modify the latter, so let's mark it as const.  We can cast
> away the constness in logmsg_free, but only once we have
> determined that it is a free-able buffer.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> index 71e2337..47e5b7a 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2788,7 +2788,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
>  {
>         int retval;
>         const char *encoding;
> -       char *message;
> +       const char *message;
>         struct strbuf buf = STRBUF_INIT;
>
>         if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
> @@ -2830,12 +2830,18 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
>                 format_display_notes(commit->object.sha1, &buf, encoding, 1);
>         }
>
> -       /* Find either in the original commit message, or in the temporary */
> +       /* Find either in the original commit message, or in the temporary.

Style:

    /*
     * Find either...
     */

> +        * Note that we cast away the constness of "message" here. It is
> +        * const because it may come from the cached commit buffer. That's OK,
> +        * because we know that it is modifiable heap memory, and that while
> +        * grep_buffer may modify it for speed, it will restore any
> +        * changes before returning.
> +        */
>         if (buf.len)
>                 retval = grep_buffer(&opt->grep_filter, buf.buf, buf.len);
>         else
>                 retval = grep_buffer(&opt->grep_filter,
> -                                    message, strlen(message));
> +                                    (char *)message, strlen(message));
>         strbuf_release(&buf);
>         logmsg_free(message, commit);
>         return retval;
> --
> 2.0.0.729.g520999f
>
