From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 01/11] ref-filter: print output to strbuf for formatting
Date: Mon, 03 Aug 2015 13:36:33 -0700
Message-ID: <xmqq4mkg85ym.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
	<1438620861-25219-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 22:36:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMMTR-0001et-GY
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 22:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbbHCUgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 16:36:37 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:32996 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402AbbHCUgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 16:36:35 -0400
Received: by pdbnt7 with SMTP id nt7so78052191pdb.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 13:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=SusxublecZrPAhr1wnENtMAFAKhCn8gCl3DXq/Kaypc=;
        b=qhRCLwfUW2alwsz9WAPNfCw7NKYpoD0JIa4tkADxwukM9MrxqJkVJMOxf7UFzmWYMs
         8dP+WUrTmrP3WwLaKlo34vnEOwhp/a4xVvzqXWwL67y4YfmYoA8pbRbsqu+p+ZIyeeml
         ulRycVBW5T2mOr7hKklBaN2lHNUIfNybbMns1dXNjn+jHlz0W+gLuJl9ncc21M2kWi3B
         l17ZtEGO+8E3wIereGdrXTa69aBq8xZ2v0i5QzcLcwjOxfyDL9YOQdKvD681v/ir4yjM
         nzm5IPAVBWS4CMVyNDKShnrLGMCSX+rHGhollfTiC1K3D4PgcW/NmtfyWPFKPctBItQ3
         4s+g==
X-Received: by 10.70.89.135 with SMTP id bo7mr39834934pdb.65.1438634194868;
        Mon, 03 Aug 2015 13:36:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id xp10sm18544869pac.34.2015.08.03.13.36.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 13:36:34 -0700 (PDT)
In-Reply-To: <1438620861-25219-1-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Mon, 3 Aug 2015 22:24:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275195>

Karthik Nayak <karthik.188@gmail.com> writes:

> Introduce a strbuf `output` which will act as a substitute rather than
> printing directly to stdout. This will be used for formatting
> eventually.
> ---

Missing sign-off; the patch looks like a good first step in a nice
direction.

>  ref-filter.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 7561727..febdc45 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1190,30 +1190,25 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>  	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
>  }
>  
> -static void print_value(struct atom_value *v, int quote_style)
> +static void print_value(struct atom_value *v, int quote_style, struct strbuf *output)
>  {
> -	struct strbuf sb = STRBUF_INIT;
>  	switch (quote_style) {
>  	case QUOTE_NONE:
> -		fputs(v->s, stdout);
> +		strbuf_addstr(output, v->s);
>  		break;
>  	case QUOTE_SHELL:
> -		sq_quote_buf(&sb, v->s);
> +		sq_quote_buf(output, v->s);
>  		break;
>  	case QUOTE_PERL:
> -		perl_quote_buf(&sb, v->s);
> +		perl_quote_buf(output, v->s);
>  		break;
>  	case QUOTE_PYTHON:
> -		python_quote_buf(&sb, v->s);
> +		python_quote_buf(output, v->s);
>  		break;
>  	case QUOTE_TCL:
> -		tcl_quote_buf(&sb, v->s);
> +		tcl_quote_buf(output, v->s);
>  		break;
>  	}
> -	if (quote_style != QUOTE_NONE) {
> -		fputs(sb.buf, stdout);
> -		strbuf_release(&sb);
> -	}
>  }
>  
>  static int hex1(char ch)
> @@ -1234,7 +1229,7 @@ static int hex2(const char *cp)
>  		return -1;
>  }
>  
> -static void emit(const char *cp, const char *ep)
> +static void emit(const char *cp, const char *ep, struct strbuf *output)
>  {
>  	while (*cp && (!ep || cp < ep)) {
>  		if (*cp == '%') {
> @@ -1243,13 +1238,13 @@ static void emit(const char *cp, const char *ep)
>  			else {
>  				int ch = hex2(cp + 1);
>  				if (0 <= ch) {
> -					putchar(ch);
> +					strbuf_addch(output, ch);
>  					cp += 3;
>  					continue;
>  				}
>  			}
>  		}
> -		putchar(*cp);
> +		strbuf_addch(output, *cp);
>  		cp++;
>  	}
>  }
> @@ -1257,19 +1252,21 @@ static void emit(const char *cp, const char *ep)
>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>  {
>  	const char *cp, *sp, *ep;
> +	struct strbuf output = STRBUF_INIT;
> +	int i;
>  
>  	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>  		struct atom_value *atomv;
>  
>  		ep = strchr(sp, ')');
>  		if (cp < sp)
> -			emit(cp, sp);
> +			emit(cp, sp, &output);
>  		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
> -		print_value(atomv, quote_style);
> +		print_value(atomv, quote_style, &output);
>  	}
>  	if (*cp) {
>  		sp = cp + strlen(cp);
> -		emit(cp, sp);
> +		emit(cp, sp, &output);
>  	}
>  	if (need_color_reset_at_eol) {
>  		struct atom_value resetv;
> @@ -1278,9 +1275,12 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>  		if (color_parse("reset", color) < 0)
>  			die("BUG: couldn't parse 'reset' as a color");
>  		resetv.s = color;
> -		print_value(&resetv, quote_style);
> +		print_value(&resetv, quote_style, &output);
>  	}
> +	for (i = 0; i < output.len; i++)
> +		printf("%c", output.buf[i]);
>  	putchar('\n');
> +	strbuf_release(&output);
>  }
>  
>  /*  If no sorting option is given, use refname to sort as default */
