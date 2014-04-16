From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 1/2] sequencer.c: check for lock failure and bail early in fast_forward_to
Date: Tue, 15 Apr 2014 18:37:29 -0700
Message-ID: <CA+sFfMe1SB_Njpgq5VJQ3B-0Oh5nyJf5uf+WzzT-H6b1Cz-WRg@mail.gmail.com>
References: <1397605608-12128-1-git-send-email-sahlberg@google.com>
	<1397605608-12128-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 03:37:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaEn9-0001nf-6X
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 03:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbaDPBhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 21:37:31 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:65065 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbaDPBha (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 21:37:30 -0400
Received: by mail-qg0-f43.google.com with SMTP id f51so10714884qge.30
        for <git@vger.kernel.org>; Tue, 15 Apr 2014 18:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vd5QK+ispWQR0WucP/UbUNl4TsAI6m9ADBmxmirOt/8=;
        b=GxZxVENrxbHWStDrv0cKgn6MTx72qFeCHP+Ig3jFAE3S3tnNUnWbNUfBgK+VGfgaA6
         ECYHoAjfq0YfBmsv6WDSfC4yTNMmh2jkdU8m/L31JQrO2plHxA/FUrBS4+iV1G3EUpY+
         9z44L6drhqjhrks421O8+OvD3aS8a0SZU5jpVGm/pyxpYDoCPegQznFVo/c03SCSQZ5K
         hckdmMlsAR3i7FX7yBbegc+aMjogIIb3Cdkj2BuMGaK4GI+sWbyqN9o+uKlVHAHKzYAg
         nBirgsQZkgQyExV2wSzHlWcA3j5wQjeGdNRvka5vWw4vCIf8Jshf5btYvD5JP2GZl6o+
         Y44A==
X-Received: by 10.224.30.131 with SMTP id u3mr1603557qac.50.1397612249759;
 Tue, 15 Apr 2014 18:37:29 -0700 (PDT)
Received: by 10.96.113.105 with HTTP; Tue, 15 Apr 2014 18:37:29 -0700 (PDT)
In-Reply-To: <1397605608-12128-2-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246313>

On Tue, Apr 15, 2014 at 4:46 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:

<snip well-worded commit message>

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  sequencer.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index bde5f04..6aa3b50 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -281,8 +281,15 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
>                 exit(1); /* the callee should have complained already */
>         ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
>                                            0, NULL);
> +       if (!ref_lock) {
> +               ret = error(_("Failed to lock HEAD during fast_forward_to"));
> +               goto leave;
> +       }
> +

Or just:

   if (!ref_lock)
       return error(_("Failed to lock HEAD ..."));

We don't need to strbuf_release() since the strbuf has not been
modified at this point.  We've only initialized with a static
initializer.

>         strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
>         ret = write_ref_sha1(ref_lock, to, sb.buf);
> +
> +leave:
>         strbuf_release(&sb);
>         return ret;
>  }
> --

-Brandon
