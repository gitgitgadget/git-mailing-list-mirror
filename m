From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 02/10] ref-filter: make the 'color' use ref_formatting_state
Date: Fri, 24 Jul 2015 14:46:35 -0700
Message-ID: <xmqq1tfxkz44.fsf@gitster.dls.corp.google.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
	<1437764685-8633-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 23:46:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIkni-0003kS-R9
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 23:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbbGXVqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 17:46:38 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33181 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbbGXVqi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 17:46:38 -0400
Received: by pdbnt7 with SMTP id nt7so19178102pdb.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=p7yH6v0lXLmC8YPJfJBpcsv2G25R9UlpF7eRdG0ZGpM=;
        b=trxAFq2WB5us/MS8yJhIqOAhlrmsD+mZjMa4E7s/6+0Zj3j0RUEZs0l7Omo5IsWeeL
         ebvEb08N/FAGIumKLCkL6oAdkNyUnu/ZrImgKRljlpvoHImnaIIArL4S4XvQu3LdiL8a
         bN3vM6jBK41QFiy/6TbBzxLwd7yx/nHCRVyYHovRSItbComytZ9WGr2G+8K/5jM1CJmd
         O6nnbEwx0/F2Wel6vyI/ycTRCzgU3nzJWDppkTWsrHzxzaocElRvecSRaFcLaoJR/XTz
         P2GEQ5ZuXO6nA4crKg2i0wDzoX3Kr8gtsAB5tzRmsNN+SIgYC3l7bTNzVabTQvUtiW6S
         1FhQ==
X-Received: by 10.70.88.80 with SMTP id be16mr34790443pdb.37.1437774397576;
        Fri, 24 Jul 2015 14:46:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id ti10sm16377243pab.20.2015.07.24.14.46.36
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 14:46:36 -0700 (PDT)
In-Reply-To: <1437764685-8633-3-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sat, 25 Jul 2015 00:34:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274604>

Karthik Nayak <karthik.188@gmail.com> writes:

> Make color which was considered as an atom, to use
> ref_formatting_state and act as a pseudo atom. This allows
> interchangeability between 'align' and 'color'.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---

I think 1/10 and 2/10 are the other way around.  Preferably, these
would be three patches, in this order:

 (1) prepare the "formatting state" and pass it around; no other
     code change.

 (2) have "color" use that facility.

 (3) add a new feature using that facility.

The first two may want to be combined into a single patch, if it
does not make the patch too noisy.

>  ref-filter.c | 16 ++++++++++++----
>  ref-filter.h |  1 +
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 3c90ffc..fd13a23 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -663,7 +663,8 @@ static void populate_value(struct ref_formatting_state *state,
>  
>  			if (color_parse(name + 6, color) < 0)
>  				die(_("unable to parse format"));
> -			v->s = xstrdup(color);
> +			state->color = xstrdup(color);
> +			v->pseudo_atom = 1;
>  			continue;
>  		} else if (!strcmp(name, "flag")) {
>  			char buf[256], *cp = buf;
> @@ -1217,6 +1218,11 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>  static void ref_formatting(struct ref_formatting_state *state, struct atom_value *v,
>  			   struct strbuf *value)
>  {
> +	if (state->color) {
> +		strbuf_addstr(value, state->color);
> +		free((void *)state->color);
> +		state->color = NULL;
> +	}
>  	if (state->pad_to_right) {
>  		if (!is_utf8(v->s))
>  			strbuf_addf(value, "%-*s", state->pad_to_right, v->s);
> @@ -1224,8 +1230,9 @@ static void ref_formatting(struct ref_formatting_state *state, struct atom_value
>  			int len = strlen(v->s) - utf8_strwidth(v->s);
>  			strbuf_addf(value, "%-*s", state->pad_to_right + len, v->s);
>  		}
> -	} else
> -		strbuf_addf(value, "%s", v->s);
> +		return;
> +	}
> +	strbuf_addf(value, "%s", v->s);
>  }
>  
>  static void print_value(struct ref_formatting_state *state, struct atom_value *v)
> @@ -1326,7 +1333,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>  
>  		if (color_parse("reset", color) < 0)
>  			die("BUG: couldn't parse 'reset' as a color");
> -		resetv.s = color;
> +		resetv.s = "";
> +		state.color = xstrdup(color);
>  		print_value(&state, &resetv);
>  	}
>  	putchar('\n');
> diff --git a/ref-filter.h b/ref-filter.h
> index ea2d0e6..bacbb23 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -31,6 +31,7 @@ struct ref_sorting {
>  struct ref_formatting_state {
>  	unsigned int pad_to_right; /*pad atoms to the right*/
>  	int quote_style;
> +	const char *color;
>  };
>  
>  struct ref_array_item {
