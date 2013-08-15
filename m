From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] create_delta_index: simplify condition always evaluating
 to true
Date: Thu, 15 Aug 2013 17:46:54 -0400
Message-ID: <CAPig+cQ5Y9irLk=9Bhz09c=5yzZEcyMKn2kbhcrO_zDpgmkhGw@mail.gmail.com>
References: <CAPig+cQmdPo4mo69DsDmUURcw+HbxkAoNEqY08qiuJs8S+=bvQ@mail.gmail.com>
	<1376602462-32339-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 23:46:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA5Nj-00086K-D4
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 23:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab3HOVqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 17:46:55 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:50972 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab3HOVqz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 17:46:55 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so1520491oah.34
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1v0o/SkTHk3Z0wFEKQwrCXjYWwhXdm9hAtiReW070dQ=;
        b=IdsCI/TEEHP7Z9dT6Lxyx2ui78k+DHLh2pfxVOR6J1WPhvRrlKj/MpSvOi21FXk1rK
         yYOR+axt6spaEp4/4FLI+HiiN1aZ2JTFzvf9qbdysG22P24uUZSG6mx1oXepiuAhcUaI
         7+TFmmTbBF3YkzyqODNojZm0Il0S5ia1qlIwPmgjXvPaFEzALLd90KydvuMj5oyh+ABm
         DGQxSF2y6IklS5Qk3oaWjn1u61/eqezJKuffohdTBFfbZZNnDIDFnezSJYEzq9+TvGt+
         TZCILp5NSKZMo+qhQPjm6rx1MTCFo8og7nATgTIKQ/wJgBFSOHRP90ZKKRA4gdjSuzCK
         e1NA==
X-Received: by 10.60.132.40 with SMTP id or8mr2016278oeb.65.1376603214487;
 Thu, 15 Aug 2013 14:46:54 -0700 (PDT)
Received: by 10.182.131.234 with HTTP; Thu, 15 Aug 2013 14:46:54 -0700 (PDT)
In-Reply-To: <1376602462-32339-1-git-send-email-stefanbeller@googlemail.com>
X-Google-Sender-Auth: r86HhlWGCq4ZwoAv7t034ZKg-Dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232376>

On Thu, Aug 15, 2013 at 5:34 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> When checking the previous lines in that function, we can deduce that
> hsize must always be smaller than (1u<<31), since 506049c7df2c6
> (fix >4GiB source delta assertion failure), because entries is
> capped at an upper bound of 0xfffffffeU, so hsize contains a maximum
> value of 0x3fffffff, which is smaller than (1u<<31), so the value of
> 'i' will never be larger than 31.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>
> Eric, thanks for reviewing my patch.
>
> I applied the first 2 proposals (deduce, entries), but I disagree on
> the third, so I reformulated the sentence, as I really meant the variable
> i and not it as a pronoun.

Thanks. Adding the quotes around 'i' makes your meaning clear. Without
the quotes, apparently it was ambiguous, and my brain read it as a
misspelling of 'it'.

> Do I understand right, you're suggesting to remove the
> source code comment? I did this now, but I have a bad feeling with it.
>
> The change of this patch surely removes dead code as of now and makes it
> more readable. But also it could become alive again, once somebody
> changes things nearby and forgets about the assumption, hsize not
> exceeding a certain size. That's why I put a comment in there, so
> the future changes nearby may be more careful.

Indeed, I feel uncomfortable with the patch in general for the very
reason that you state: it might become live again. Without the patch,
the code remains safe without any extra effort. With this patch, even
with the in-code comment, someone making changes needs to take special
care. Sometimes it makes sense to leave safeties in place, even if
they can't be triggered _today_; and safeties (such as i < 31) also
serve as documentation.

>
> Thanks,
> Stefan
>
>
>  diff-delta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff-delta.c b/diff-delta.c
> index 93385e1..3797ce6 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -155,7 +155,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
>                 entries = 0xfffffffeU / RABIN_WINDOW;
>         }
>         hsize = entries / 4;
> -       for (i = 4; (1u << i) < hsize && i < 31; i++);
> +       for (i = 4; (1u << i) < hsize; i++);
>         hsize = 1 << i;
>         hmask = hsize - 1;
>
> --
> 1.8.4.rc3.1.gc1ebd90
>
