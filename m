From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 10/16] fast-import: use skip_prefix for parsing input
Date: Thu, 19 Jun 2014 23:19:09 -0400
Message-ID: <CAPig+cTgz1s_68MVT5XgTsM9j=NZnCt3tNX3wBGddEq3nWZgyw@mail.gmail.com>
References: <20140618194117.GA22269@sigill.intra.peff.net>
	<20140618194912.GJ22622@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 05:19:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxpMH-0005oK-0d
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 05:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933565AbaFTDTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 23:19:13 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:37070 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbaFTDTK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 23:19:10 -0400
Received: by mail-yh0-f47.google.com with SMTP id v1so2410280yhn.6
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 20:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=N3xQROxcKx5P1NU6XaFHIsFONXY10gr7+/mujYv+UgM=;
        b=pYFvYTuxJE1adrxDwKSo2iBNDKuaQAl8u+kglfew3sVSQdXCN4V3F0mjObJW4YMXh+
         OdADNsdEw027H0dKHBScaenzeYP/P6RBFXpdgPv/gQq2YMQdADv710BHZzZvmL4ZrNXc
         ElBBL8Y3aAkZ011C0cdxXBPjsLjd+pDmw2JSeyHW1LBvM1vlqVln564NW4kV/l2tnqp/
         zQumsJOarcMdTfXBQhsWdAzY1tkJNRUmM5Le8QPtPXhF27zPPJhwQRNDFVu0/VGU5XmG
         zecE06N/0ZdIS6MOSD304/zz0w+E4r/2pt+wp8EeaPu/dr+RE2io/V0loVPf1XhNwrjv
         Rv+w==
X-Received: by 10.236.66.139 with SMTP id h11mr1001395yhd.30.1403234349997;
 Thu, 19 Jun 2014 20:19:09 -0700 (PDT)
Received: by 10.170.36.80 with HTTP; Thu, 19 Jun 2014 20:19:09 -0700 (PDT)
In-Reply-To: <20140618194912.GJ22622@sigill.intra.peff.net>
X-Google-Sender-Auth: mZAA9p0NRdV8LTDEAsNDF0YCjyE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252212>

On Wed, Jun 18, 2014 at 3:49 PM, Jeff King <peff@peff.net> wrote:
> Fast-import does a lot of parsing of commands and
> dispatching to sub-functions. For example, given "option
> foo", we might recognize "option " using starts_with, and
> then hand it off to parse_option() to do the rest.
>
> However, we do not let parse_option know that we have parsed
> the first part already. It gets the full buffer, and has to
> skip past the uninteresting bits. Some functions simply add
> a magic constant:
>
>   char *option = command_buf.buf + 7;
>
> Others use strlen:
>
>   char *option = command_buf.buf + strlen("option ");
>
> And others use strchr:
>
>   char *option = strchr(command_buf.buf, ' ') + 1;
>
> All of these are brittle and easy to get wrong (especially
> given that the starts_with call and the code that assumes
> the presence of the prefix are far apart). Instead, we can
> use skip_prefix, and just pass each handler a pointer to its
> arguments.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/fast-import.c b/fast-import.c
> index a3ffe30..5f17adb 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2713,20 +2706,22 @@ static void parse_new_commit(void)
>
>         /* file_change* */
>         while (command_buf.len > 0) {
> -               if (starts_with(command_buf.buf, "M "))
> -                       file_change_m(b);
> -               else if (starts_with(command_buf.buf, "D "))
> -                       file_change_d(b);
> -               else if (starts_with(command_buf.buf, "R "))
> -                       file_change_cr(b, 1);
> -               else if (starts_with(command_buf.buf, "C "))
> -                       file_change_cr(b, 0);
> -               else if (starts_with(command_buf.buf, "N "))
> -                       note_change_n(b, &prev_fanout);
> +               const char *v;

This declaration of 'v' shadows the 'v' added by patch 8/16 earlier in
the function.

> +               if (skip_prefix(command_buf.buf, "M ", &v))
> +                       file_change_m(v, b);
> +               else if (skip_prefix(command_buf.buf, "D ", &v))
> +                       file_change_d(v, b);
> +               else if (skip_prefix(command_buf.buf, "R ", &v))
> +                       file_change_cr(v, b, 1);
> +               else if (skip_prefix(command_buf.buf, "C ", &v))
> +                       file_change_cr(v, b, 0);
> +               else if (skip_prefix(command_buf.buf, "N ", &v))
> +                       note_change_n(v, b, &prev_fanout);
>                 else if (!strcmp("deleteall", command_buf.buf))
>                         file_change_deleteall(b);
> -               else if (starts_with(command_buf.buf, "ls "))
> -                       parse_ls(b);
> +               else if (skip_prefix(command_buf.buf, "ls ", &v))
> +                       parse_ls(v, b);
>                 else {
>                         unread_command_buf = 1;
>                         break;
