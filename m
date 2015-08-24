From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 04/12] ref-filter: implement an `align` atom
Date: Mon, 24 Aug 2015 15:13:25 -0700
Message-ID: <xmqqmvxg2v3u.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<1440214788-1309-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 00:13:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTzzi-00076R-97
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 00:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbbHXWN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 18:13:29 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33972 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbbHXWN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 18:13:27 -0400
Received: by pabzx8 with SMTP id zx8so15832108pab.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 15:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DXx/+W1AdVIJYz6psEKNRTJN9cJukAofA86WudzxLl0=;
        b=ymWPU+lNOCTnJDvF0rNq6bV1d0mvec2v9u1tULrPV1JKItcve/yXK6ingCPNWNBzjF
         a7GaHWUAeP86+LToHIB8faYUKJvSYPzwa3clg9/USokYvp0esr8Qxcp3IU8Oy5uPF6Ks
         v/PEMVM29VSM4HyNav6yy4mro2x87nJf0KdaZdlA6YwDTCncYluFeVk8HufPr9YvTQee
         AWi5Nzbr8RklvRPauOaLCRbmAKDB7ZcWDs95xAz9wKYOx92obtpGuxO8FTZmjiqgwI0W
         pJnmxjwDz5T1AjcVxFrO6apZVsbOIWifLcY8UPfvK5YYtVnqZjrAVM+rH4Qa/KRhA77O
         Fc8A==
X-Received: by 10.68.218.104 with SMTP id pf8mr49820839pbc.31.1440454407256;
        Mon, 24 Aug 2015 15:13:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id j4sm6646044pdk.9.2015.08.24.15.13.26
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 15:13:26 -0700 (PDT)
In-Reply-To: <1440214788-1309-5-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sat, 22 Aug 2015 09:09:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276491>

Karthik Nayak <karthik.188@gmail.com> writes:

> +static void perform_quote_formatting(struct strbuf *s, const char *str, int quote_style);
> +
> +static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
> +{
> +	struct ref_formatting_stack *current = state->stack;
> +	struct strbuf s = STRBUF_INIT;
> +
> +	if (!current->at_end)
> +		die(_("format: `end` atom used without a supporting atom"));
> +	current->at_end(current);
> +	/*
> +	 * Whenever we have more than one stack element that means we
> +	 * are using a certain modifier atom. In that case we need to
> +	 * perform quote formatting.
> +	 */
> +	if (!state->stack->prev->prev) {

The comment and the condition seem to be saying opposite things.
The code says "If the stack only has one prev that is the very
initial one, then we do the quoting, i.e. the result of expanding
the enclosed string in %(start-something)...%(end) is quoted only
when that appears at the top level", which feels more correct than
the comment that says "if we are about to pop after seeing the
first %(end) in %(start)...%(another)...%(end)...%(end) sequence,
we quote what is between %(another)...%(end)".

> +		perform_quote_formatting(&s, current->output.buf, state->quote_style);
> +		strbuf_reset(&current->output);
> +		strbuf_addbuf(&current->output, &s);
> +	}
> +	strbuf_release(&s);
> +	pop_stack_element(&state->stack);
> +}
> +

> @@ -1228,29 +1315,33 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>  	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
>  }
>  
> -static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
> +static void perform_quote_formatting(struct strbuf *s, const char *str, int quote_style)
>  {
> -	struct strbuf *s = &state->stack->output;
> -
> -	switch (state->quote_style) {
> +	switch (quote_style) {
>  	case QUOTE_NONE:
> -		strbuf_addstr(s, v->s);
> +		strbuf_addstr(s, str);
>  		break;
>  	case QUOTE_SHELL:
> -		sq_quote_buf(s, v->s);
> +		sq_quote_buf(s, str);
>  		break;
>  	case QUOTE_PERL:
> -		perl_quote_buf(s, v->s);
> +		perl_quote_buf(s, str);
>  		break;
>  	case QUOTE_PYTHON:
> -		python_quote_buf(s, v->s);
> +		python_quote_buf(s, str);
>  		break;
>  	case QUOTE_TCL:
> -		tcl_quote_buf(s, v->s);
> +		tcl_quote_buf(s, str);
>  		break;
>  	}
>  }
>  
> +static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
> +{
> +	struct strbuf *s = &state->stack->output;
> +	perform_quote_formatting(s, v->s, state->quote_style);

Hmmm, do we want to unconditionally do the quote here, or only when
we are not being captured by upcoming %(end) to be consistent with
the behaviour of end_atom_handler() above?

> @@ -1307,7 +1398,18 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>  		if (cp < sp)
>  			append_literal(cp, sp, &state);
>  		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
> -		append_atom(atomv, &state);
> +		/*
> +		 * If the atom is a modifier atom, then call the handler function.
> +		 * Else, if this is the first element on the stack, then we need to
> +		 * format the atom as per the given quote. Else we just add the atom value
> +		 * to the current stack element and handle quote formatting at the end.
> +		 */
> +		if (atomv->handler)
> +			atomv->handler(atomv, &state);
> +		else if (!state.stack->prev)
> +			append_atom(atomv, &state);
> +		else
> +			strbuf_addstr(&state.stack->output, atomv->s);

Ahh, this explains why you are not doing it above, but I do not
think if this is a good division of labor.

You can see that I expected that "if !state.stack->prev" check to be
inside append_atom(), and I would imagine future readers would have
the same expectation when reading this code.  I.e.

	append_atom(struct atom_value *v, struct ref_f_s *state)
        {
		if (state->stack->prev)
			strbuf_addstr(&state->stack->output, v->s);
		else
                	quote_format(&state->stack->output, v->s, state->quote_style);
	}

The end result may be the same, but I do think "append_atom is to
always quote, so we do an unquoted appending by hand" is a bad way
to do this.

Moreover, notice that the function signature of append_atom() is
exactly the same as atomv->handler's.  I wonder if it would be
easier to understand if you made append_atom() the handler for a
non-magic atoms, which would let you do the above without any if/else
and just a single unconditional

	atomv->handler(atomv, &state);
