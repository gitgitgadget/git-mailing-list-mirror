From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 02/11] ref-filter: make `color` use `ref_formatting_state`
Date: Mon, 27 Jul 2015 15:06:14 +0200
Message-ID: <vpqlhe192d5.fsf@anie.imag.fr>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
	<1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
	<1437982035-6658-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 15:06:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJi71-0004UE-BT
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 15:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbbG0NG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 09:06:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52906 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823AbbG0NGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 09:06:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6RD6Djg011120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Jul 2015 15:06:13 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6RD6Ev2012067;
	Mon, 27 Jul 2015 15:06:14 +0200
In-Reply-To: <1437982035-6658-2-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Mon, 27 Jul 2015 12:57:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 27 Jul 2015 15:06:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6RD6Djg011120
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438607174.53326@dcb9041vSn8x+0DUA8bTfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274678>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1195,6 +1197,11 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>  static void ref_formatting(struct ref_formatting_state *state,
>  			   struct atom_value *v, struct strbuf *value)
>  {
> +	if (state->color) {
> +		strbuf_addstr(value, state->color);
> +		free(state->color);
> +		state->color = NULL;
> +	}
>  	strbuf_addf(value, "%s", v->s);
>  }
>  
> @@ -1266,6 +1273,13 @@ static void emit(const char *cp, const char *ep)
>  	}
>  }
>  
> +static void apply_pseudo_state(struct ref_formatting_state *state,
> +			       struct atom_value *v)
> +{
> +	if (v->color)
> +		state->color = (char *)v->s;
> +}
> +
>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>  {
>  	const char *cp, *sp, *ep;

It's not clear enough in the code and history that these these two
functions are symmetrical.

You can find better names. 'apply_pseudo_state' seems wrong it two ways:
it does not _apply_ the state, but it stores it. And it's a "pseudo-atom
related state", but not a "pseudo-state".

How about

ref_formatting -> apply_formatting_state
apply_pseudo_state -> store_formatting_state

?

Actually, I would even call these functions right from
show_ref_array_item, so that the result look like this:

		if (atomv->pseudo_atom)
			store_formatting_state(&state, atomv);
		else {
			apply_formatting_state(&state, atomv);
			reset_formatting_state(&state);
			print_value(&state, atomv);
		}

In the history, if you are to introduce a dumb version of ref_formatting
in PATCH 1, I think you should also introduce a dumb (actually, totally
empty) version of apply_pseudo_state. Then, further patches would just
add a few lines in each function, and ...

> @@ -1281,7 +1295,10 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>  		if (cp < sp)
>  			emit(cp, sp);
>  		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
> -		print_value(&state, atomv);
> +		if (atomv->pseudo_atom)
> +			apply_pseudo_state(&state, atomv);
> +		else
> +			print_value(&state, atomv);
>  	}

... this hunk would belong to PATCH 1.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
