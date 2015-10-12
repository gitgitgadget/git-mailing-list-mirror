From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fixup: use xstrfmt instead of fixed-size buf + sprintf + xstrdup
Date: Mon, 12 Oct 2015 10:45:34 -0700
Message-ID: <xmqqk2qsm14x.fsf@gitster.mtv.corp.google.com>
References: <vpqa8rp2xku.fsf@grenoble-inp.fr>
	<1444580188-18773-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, karthik.188@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Oct 12 19:45:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlhAM-00048x-4L
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 19:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbbJLRph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 13:45:37 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33471 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbbJLRph (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 13:45:37 -0400
Received: by pabrc13 with SMTP id rc13so24571012pab.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RkUTwqr6DERKBB6d9hdAhWZidlqFdIuW8YQ8NqXk+W4=;
        b=hvC9hZSc+HqMpVVnuIJKgMSlY8SLwiTLXGxcmfFQ6HMLGxAg6/teKA6zg8PQmO1HS0
         4CCRK7e72LJVdwOTinaDA2sV6iiDphCz+jBqr1mfKjukLMks6pUVyMsR10kq4I65qVcl
         WJsLPpyey3LTxwpinLxTCUGuhXzBlacWcwaKnA+Gubwt+IEDLqRxw77r8gUHcjjE1dpg
         mio/pLDaPL7BRfKjdstGHWRdqbyrFC845CWWpKB6+Qpa1810vm61V1nCLsD63C3phxs9
         CRXWWv/fLZTzAT+GtlAgEhpfrxLjIEtiXQbMHM8anX6mwRJJ8Nbvppw+VpCLLvUwLw/b
         A+HQ==
X-Received: by 10.66.253.199 with SMTP id ac7mr35350659pad.56.1444671936652;
        Mon, 12 Oct 2015 10:45:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:448f:3a3:d25a:82f])
        by smtp.gmail.com with ESMTPSA id kw10sm19513932pbc.25.2015.10.12.10.45.35
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 12 Oct 2015 10:45:35 -0700 (PDT)
In-Reply-To: <1444580188-18773-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Sun, 11 Oct 2015 18:16:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279387>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The char buf[40] is safe (at least while the strings are not
> translated), but I'd rather avoid magic numbers like this 40 in the
> code, and use a construct that does not have this size limitation.
> Especially if it makes the code shorter.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

The construct being fixed with this change looks very similar to
Peff's a5e03bf5 (ref-filter: drop sprintf and strcpy calls,
2015-09-24) on jk/war-on-sprintf topic, but the new code since that
commit cleaned up.

I'd expect that this will be rolled into Karthik's series in the
next reroll?  

Looking good.  Thanks.

>  ref-filter.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 6044eb0..7932c21 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1116,7 +1116,6 @@ static void populate_value(struct ref_array_item *ref)
>  				 strcmp(formatp, "trackshort") &&
>  				 (starts_with(name, "upstream") ||
>  				  starts_with(name, "push"))) {
> -				char buf[40];
>  				unsigned int nobracket = 0;
>  
>  				if (!strcmp(valp, ",nobracket"))
> @@ -1135,24 +1134,21 @@ static void populate_value(struct ref_array_item *ref)
>  					v->s = "";
>  				else if (!num_ours) {
>  					if (nobracket)
> -						sprintf(buf, "behind %d", num_theirs);
> +						v->s = xstrfmt("behind %d", num_theirs);
>  					else
> -						sprintf(buf, "[behind %d]", num_theirs);
> -					v->s = xstrdup(buf);
> +						v->s = xstrfmt("[behind %d]", num_theirs);
>  				} else if (!num_theirs) {
>  					if (nobracket)
> -						sprintf(buf, "ahead %d", num_ours);
> +						v->s = xstrfmt("ahead %d", num_ours);
>  					else
> -						sprintf(buf, "[ahead %d]", num_ours);
> -					v->s = xstrdup(buf);
> +						v->s = xstrfmt("[ahead %d]", num_ours);
>  				} else {
>  					if (nobracket)
> -						sprintf(buf, "ahead %d, behind %d",
> -							num_ours, num_theirs);
> +						v->s = xstrfmt("ahead %d, behind %d",
> +							       num_ours, num_theirs);
>  					else
> -						sprintf(buf, "[ahead %d, behind %d]",
> -						num_ours, num_theirs);
> -					v->s = xstrdup(buf);
> +						v->s = xstrfmt("[ahead %d, behind %d]",
> +							       num_ours, num_theirs);
>  				}
>  				continue;
>  			} else if (!strcmp(formatp, "trackshort") &&
