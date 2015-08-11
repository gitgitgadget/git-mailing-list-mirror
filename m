From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 05/13] ref-filter: implement an `align` atom
Date: Tue, 11 Aug 2015 11:52:29 -0700
Message-ID: <xmqqy4hhr72q.fsf@gitster.dls.corp.google.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
	<1439129506-9989-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 20:52:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPEf8-00072Y-HR
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 20:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbbHKSwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 14:52:33 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35290 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbbHKSwc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 14:52:32 -0400
Received: by pacgr6 with SMTP id gr6so56457918pac.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 11:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GFmhDDv23gf0SjsfV2cyr5aR0oz3jRyu+xg4nk4yay8=;
        b=PD7BfuXuPehc0ki63lru/VYAqEWYb5xtMAHox1hij5Uex9W1UlClKlaX/uzE3klXrs
         jczHZsseMKGGnN7Kr9U9W8iG7ngAErpXLUFxrTSKyNyLfXl9XLZN1VLoA+C6z5WxnwUY
         CvN7i5vKe1OyDnjzLWC0DKyfm7PLR+G9NVtij9vl/qqYeDxw8sXCEahGdesbFxUE+/f6
         xFYFsNqJfob5v6i1hLoOa+C4VJh9C43AU5wNWm8zc4bHBxN28OGTEcImFSZzqUowckfG
         sUcZZYVCRXe9YffGe1mLGEhe4jk47Uw57EeQFWXMkMAzkcEgqmM2DfSHTOxkjHUca23F
         144g==
X-Received: by 10.66.237.165 with SMTP id vd5mr4922115pac.45.1439319151557;
        Tue, 11 Aug 2015 11:52:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id nm8sm3558928pbc.20.2015.08.11.11.52.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 11:52:30 -0700 (PDT)
In-Reply-To: <1439129506-9989-6-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 9 Aug 2015 19:41:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275710>

Karthik Nayak <karthik.188@gmail.com> writes:

>  struct atom_value{

Obviously not a problem with this step, but you need a SP before the
open brace.

> @@ -692,6 +704,26 @@ static void populate_value(struct ref_array_item *ref)
>  			else
>  				v->s = " ";
>  			continue;
> +		} else if (skip_prefix(name, "align:", &valp)) {
> +			struct align *align = xmalloc(sizeof(struct align));
> +
> +			if (skip_prefix(valp, "left,", &valp))
> +				align->position = ALIGN_LEFT;
> +			else if (skip_prefix(valp, "right,", &valp))
> +				align->position = ALIGN_RIGHT;
> +			else if (skip_prefix(valp, "middle,", &valp))
> +				align->position = ALIGN_MIDDLE;
> +			else
> +				die(_("improper format entered align:%s"), valp);
> +			if (strtoul_ui(valp, 10, &align->width))
> +				die(_("positive width expected align:%s"), valp);

Minor nits on the design.  %(align:<width>[,<position>]) would let
us write %(align:16)...%(end) and use the "default position", which
may be beneficial if one kind of alignment is prevalent (I guess all
the internal users left-align?)  %(align:<position>,<width>) forces
users to spell both out all the time.

> @@ -1198,7 +1230,9 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>  
>  struct ref_formatting_state {
>  	struct strbuf output;
> +	struct align *align;
>  	int quote_style;
> +	unsigned int end : 1;
>  };

Mental note: it is not clear why you need 'end' field in the state.
Perhaps it is an indication that the division of labor is poorly
designed between the helper that updates the formatting state and
the other helper that reflects the formatting state to the final
string.

> @@ -1262,12 +1296,31 @@ static void append_non_atom(const char *cp, const char *ep, struct ref_formattin
>  
>  static void set_formatting_state(struct atom_value *atomv, struct ref_formatting_state *state)
>  {
> -	/* Based on the atomv values, the formatting state is set */
> +	if (atomv->align) {
> +		state->align = atomv->align;
> +		atomv->align = NULL;
> +	}
> +	if (atomv->end)
> +		state->end = 1;
> +}
> +
> +static int align_ref_strbuf(struct ref_formatting_state *state, struct strbuf *final)
> +{
> +	if (state->align && state->end) {

... and I think that is what I see.  If this function knows that we
are processing %(end), i.e. perform-state-formatting is called for
each atom and receives atomv, there wouldn't have to be a code like
this.

> +		struct align *align = state->align;
> +		strbuf_utf8_align(final, align->position, align->width, state->output.buf);
> +		strbuf_reset(&state->output);
> +		state->align = NULL;
> +		return 1;
> +	} else if (state->align)
> +		return 1;
> +	return 0;
>  }
>  
>  static void perform_state_formatting(struct ref_formatting_state *state, struct strbuf *final)
>  {
> -	/* More formatting options to be eventually added */
> +	if (align_ref_strbuf(state, final))
> +		return;

At the design level, I have a strong suspicion that it is a wrong
way to go.  It piles more "if (this state bit was left by the
previous atom) then do this" on this function and will make an
unmanageable mess.

You have a dictionary of all possible atoms somewhere.  Why not hook
a pointer to the "handler" function (or two) to each element in it,
instead of duplicating "this one is special" information down to
individual atom instantiations (i.e. atomv) as atomv.modifier_atom
bit, an dstructure the caller more like this?

	get_ref_atom_value(info, parse_ref_filter_atom, &atomv);
        if (atomv->pre_handler)
        	atomv->pre_handler(atomv, &state);
	format_quote_value(atomv, &state);
        if (atomv->post_handler)
        	atomv->post_handler(atomv, &state);

Actually, each atom could just have a single handler; an atom like
%(refname:short) whose sole effect is to append atomv->s to the
state buffer can point a function to do so in its handler.

On the other hand, align atom's handler would push a new state on
the stack, marking that it is the one to handle diverted output.

	align_atom_handler(atomv, state)
        {
        	struct format_state *new = push_new_state(state);
		strbuf_init(&new->output);
                new->atend = align_handler;
                new->return_to = atomv; /* or whatever that holds width,pos */
	}

Then end atom's handler would pop the state from the stack, and the
processing to be done

	end_atom_handler(atomv, state)
	{
                state->atend(state);
                pop_state(state);
	}                

and the called align_handler would be something like:

	align_handler(state)
	{
                struct strbuf aligned = STRBUF_INIT;
		struct format_state *return_to = state->prev;
                struct atom_value *atomv = state->return_to;

                strbuf_utf8_align(&aligned,
                        atomv->align.pos, atomv->align.width,
                        state->output.buf);
		strbuf_addbuf(&return_to->output, &aligned);
                strbuf_release(&aligned);
	}

With an arrangement like that, the body of the loop in
show_ref_array_item() could be as simple and regular as:

	get_ref_atom_value(info, parse_ref_filter_atom, &atomv);
       	atomv->handler(atomv, &state);

without any new "ah, this %(end) is special so we need a new
mechanism to pass information between set_formatting_state and
perform_formatting" logic introduced every time you add new things.
