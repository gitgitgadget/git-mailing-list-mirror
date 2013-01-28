From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v3 05/11] sequencer.c: recognize "(cherry picked from ..."
 as part of s-o-b footer
Date: Sun, 27 Jan 2013 21:38:51 -0800
Message-ID: <CA+sFfMfm3k8T-TrXxZPD6pe4hN3LoCH98Txeam4HCmw1scHswA@mail.gmail.com>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
	<1359335515-13818-6-git-send-email-drafnel@gmail.com>
	<20130128022148.GG8206@elie.Belkin>
	<20130128025140.GI8206@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 06:39:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzhR5-0003bM-Ep
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 06:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241Ab3A1Fiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 00:38:54 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41603 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab3A1Fix (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 00:38:53 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so854720wgb.35
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 21:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=KW6ZJ8PoVPWorLF8fo6zJiJRpOqEleLqrrG4plsm7gY=;
        b=w0gqwtCglcEu9win6uDItKOrwEHbs8TZVo3O+AkYhGdah2ReVQ/br8U07jufdTqIKK
         /CEa8LvPaNEq9nA/ALhQu9gTnUF/82kHde831lcjPSU6d/bpYhg5sJKauo4jWiH0UKlN
         0lcQ/XNwBXn2UL47JMp6KZBq9TcsBJOGf5l1PiKB88qX/x36uYzrum6SIG9j/eLeneb2
         /PLKAEJ+7b6FYHcz7Dox/LltWHEHECs9qeYhFqyFhvcLI99uNnS4+5CKbtlCts0qsJy6
         Kwmt1cqFePiDeTpwclZPx1m+nYcGGL9pEjuPHKdiwyOnvx3aBmOMp38e6RmQPjHDwaAU
         9sng==
X-Received: by 10.180.107.97 with SMTP id hb1mr7564413wib.4.1359351531870;
 Sun, 27 Jan 2013 21:38:51 -0800 (PST)
Received: by 10.194.143.18 with HTTP; Sun, 27 Jan 2013 21:38:51 -0800 (PST)
In-Reply-To: <20130128025140.GI8206@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214803>

On Sun, Jan 27, 2013 at 6:51 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jonathan Nieder wrote:
>
>> Here's the tweak I suggested last time.  I think its behavior is
>> slightly better in the "ends with incomplete line" case because it
>> limits the characters examined by is_rfc2822_line() and
>> is_cherry_picked_from_line() not to include buf[len] (which would
>> presumably sometimes be '\0').
>
> Whoops, that revealed a subtlety --- the '\n' or '\0' is what prevents
> exiting the loop in is_rfc2822_line when the line does not contain a
> colon.  Here's a corrected version of the tweak, that should actually
> work. :)
>
> diff --git i/sequencer.c w/sequencer.c
> index 0b5cd18c..108ea27b 100644
> --- i/sequencer.c
> +++ w/sequencer.c
> @@ -1029,13 +1029,11 @@ static int is_rfc2822_line(const char *buf, int len)
>         for (i = 0; i < len; i++) {
>                 int ch = buf[i];
>                 if (ch == ':')
> +                       return 1;
> +               if (!isalnum(ch) && ch != '-')
>                         break;
> -               if (isalnum(ch) || (ch == '-'))
> -                       continue;
> -               return 0;
>         }
> -
> -       return 1;
> +       return 0;
>  }
>
>  static int is_cherry_picked_from_line(const char *buf, int len)
> @@ -1043,9 +1041,7 @@ static int is_cherry_picked_from_line(const char *buf, int len)
>         /*
>          * We only care that it looks roughly like (cherry picked from ...)
>          */
> -       return !prefixcmp(buf, cherry_picked_prefix) &&
> -               (buf[len - 1] == ')' ||
> -                (buf[len - 1] == '\n' && buf[len - 2] == ')'));
> +       return !prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
>  }
>
>  static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
> @@ -1072,8 +1068,8 @@ static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
>                         ; /* do nothing */
>                 k++;
>
> -               if (!(is_rfc2822_line(buf + i, k - i) ||
> -                       is_cherry_picked_from_line(buf + i, k - i)))
> +               if (!is_rfc2822_line(buf + i, k - i - 1) &&
> +                   !is_cherry_picked_from_line(buf + i, k - i - 1))
>                         return 0;
>         }
>         return 1;

Looks good to me.

-Brandon
