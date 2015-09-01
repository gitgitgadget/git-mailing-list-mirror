From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Tue, 01 Sep 2015 14:19:06 -0700
Message-ID: <xmqqegihrg6t.fsf@gitster.mtv.corp.google.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 23:19:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWsxW-0006Tz-Bj
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 23:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbbIAVTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 17:19:10 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32780 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbbIAVTI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 17:19:08 -0400
Received: by paap5 with SMTP id p5so253124paa.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cWvOnApYZBbo1yXgIv5Ui3PzgHelTLlIEond+Jk9YDU=;
        b=joCxRJ4OMLN0JH8oG5Ax9QBtmNy9YieWbNBNVQa3cOFBo+Scws8E9+yyra9Nxanp6j
         DAleXnFsq4Go/bzFEysWlWNwEkCwdIpdJC3qwDBD0XtDKJHJCPQRcLhK5NPvEGj7s50u
         +6INsnmQ6aRn3IIt62Yt1FLe/fJVn5CvdN811mZephRhoeYeOa4MQQya0TvMimp3oxuf
         NR2AAxVYtxwit40CwLzrkXHNb9cqXYCiNZ22a8m98MCjmYmLkGA52ZOyLBPJt1V4AJcJ
         jZcT/LfzDCdZvF4/cvMKI43+k8zIJXGNrpAcoiuFMMVY9wyqLynuxzxMYZYaMc9dhlMH
         /QvQ==
X-Received: by 10.66.141.231 with SMTP id rr7mr50993722pab.11.1441142348289;
        Tue, 01 Sep 2015 14:19:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id qn6sm19189250pbc.22.2015.09.01.14.19.06
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 01 Sep 2015 14:19:07 -0700 (PDT)
In-Reply-To: <1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 1 Sep 2015 23:56:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277041>

Karthik Nayak <karthik.188@gmail.com> writes:

> We have an `at_end` function for each element of the stack which is to
> be called when the `end` atom is encountered. Using this we implement
> the aling_handler() for the `align` atom, this aligns the final strbuf

align_handler().

>  struct ref_formatting_stack {
>  	struct ref_formatting_stack *prev;
>  	struct strbuf output;
> +	void (*at_end)(struct ref_formatting_stack *stack);
> +	void *cb_data;
>  };

s/cb_data/at_end_data/ or something, as this is not really about a
function callback.  Imagine a fictional future where you add a new
functions at_middle---the readers cannot tell what cb_data is about
at that point.

> +static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
> +{
> +	struct ref_formatting_stack *current = state->stack;
> +	struct strbuf s = STRBUF_INIT;
> +
> +	if (!current->at_end)
> +		die(_("format: `end` atom used without a supporting atom"));

Not a show-stopper, but we may need some wordsmithing for "a
supporting atom" here; an end-user would not know what it is.

> +	current->at_end(current);
> +
> +	/*
> +	 * Perform quote formatting when the stack element is that of
> +	 * a modifier atom and right above the first stack element.
> +	 */
> +	if (!state->stack->prev->prev) {
> +		quote_formatting(&s, current->output.buf, state->quote_style);
> +		strbuf_swap(&current->output, &s);
> +	}
> +	strbuf_release(&s);
> +	pop_stack_element(&state->stack);
> +}

Nice.

> @@ -687,6 +748,7 @@ static void populate_value(struct ref_array_item *ref)
>  		int deref = 0;
>  		const char *refname;
>  		const char *formatp;
> +		const char *valp;
>  		struct branch *branch = NULL;
>  
>  		v->handler = append_atom;
> @@ -754,6 +816,42 @@ static void populate_value(struct ref_array_item *ref)
>  			else
>  				v->s = " ";
>  			continue;
> +		} else if (skip_prefix(name, "align", &valp)) {

This looked as if you are willing to take %(align) in addition to
%(align:...), but...

> +			struct align *align = &v->align;
> +			struct strbuf **s;
> +
> +			if (valp[0] != ':')
> +				die(_("format: usage %%(align:<width>,<position>)"));

... apparently that is not what is happening.  Why not skip "align:"
with colon as the prefix, then?

> +			else
> +				valp++;
> +			s = strbuf_split_str(valp, ',', 0);
> +
> +			/* If the position is given trim the ',' from the first strbuf */
> +			if (s[1])
> +				strbuf_setlen(s[0], s[0]->len - 1);
> +
> +			if (strtoul_ui(s[0]->buf, 10, &align->width))
> +				die(_("positive width expected align:%s"), s[0]->buf);
> +
> +			if (!s[1])
> +				align->position = ALIGN_LEFT;
> +			else if (!strcmp(s[1]->buf, "left"))
> +				align->position = ALIGN_LEFT;
> +			else if (!strcmp(s[1]->buf, "right"))
> +				align->position = ALIGN_RIGHT;
> +			else if (!strcmp(s[1]->buf, "middle"))
> +				align->position = ALIGN_MIDDLE;
> +			else
> +				die(_("improper format entered align:%s"), s[1]->buf);

This does not reject %(align:40,left,junk), no?  Before "s[1] does
not exist so default to left align", you would want

	if (s[2])
		die("align:width,position followed by garbage: ,%s", s[2]->buf);

I have a few observations; these are not necessarily we would want
to change in the scope of this series, though.

 - The design of strbuf_split_buf API feels screwy.  A variant of
   this function that strips the terminator at the end would be what
   most callers would want.  Granted, leaving the terminator in the
   resulting buffer does let the caller tell if the input ended with
   an incomplete line that lacked the final terminator, but for all
   s[i] for 0 <= i < N-1 where s[N] is the first element that is
   NULL, they must end with the terminator---otherwise the elements
   would not have split into the array in the first place.  "By
   keeping the terminator, you can tell which one of the possible
   terminators was used" could be a valid rationale for the API if
   the function allowed more than one terminators, but that does not
   apply here, either.

 - I would have expected the above code to look more like this:

	width = -1; position = ALIGN_LEFT;
	s = strbuf_split_str(valp, ',', 0);
	while (*s) {
		if (s[1])
                	strbuf_setlen(*s, *s->len - 1);
		if (!strtoul_ui(*s->buf, 10, &width))
                	; /* parsed width successfully */
                else if (!strcmp(*s->buf, "left"))
                	position = ALIGN_LEFT;
		else if ...
		else
                	die("unknown parameter: %s", *s->buf);
		s++;			
	}
	if (width < 0)
		... perhaps set to the default width, or
                ... call die() complaining that you did not see
                ... an explicit width specified

   Doing the code that way, it would be more obvious that a way to
   extend the parser to accept forms like

	%(align:width=40,position=left)

   is by adding "keyword=value" parser before the fallbacks for
   short-hand, i.e. "if looks like number" and everything else.
        
