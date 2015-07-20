From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
Date: Mon, 20 Jul 2015 10:29:52 -0700
Message-ID: <xmqqsi8iybxr.fsf@gitster.dls.corp.google.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437246749-14423-2-git-send-email-Karthik.188@gmail.com>
	<xmqq1tg2zsxr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:30:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHEt5-0000u5-Kw
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 19:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411AbbGTR3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 13:29:55 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35546 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754701AbbGTR3z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 13:29:55 -0400
Received: by pabkd10 with SMTP id kd10so32345131pab.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=FypawjooJNbdob4QDepbwno+YQzNcyiK4S8DsEe9ceM=;
        b=TgTMIfTIgpsZUfhMhbIi9GP2gb5BgBlXcgskNxAba1wI3KSFiQrne/c5W5nzSewOfd
         tjr/1utPjbtByB0alrO/T5+5LHaHb8fDwY8+ZriW1cIbKd+KCTds7Pbds30mQoUFXrZv
         ZK6+/wRNcMxbwe2nz+Z4d3dXVX+M6Gd9dJtvBOsHA/38ej4Tu7bwRN14mbkoUn0BGuTg
         WEP9qo9nYWCy1nuZ3ZcPdj25F882fvkWZwZMeOlJcIyISJRwr4WjHYimiGuRBfYmQW/d
         p1fqEku+j2YGej/2FzQ8Y2KV1M57xs/HkVG7JzBK3QvUnvxnI7XKIbj4Hd+u99QVC91Z
         zw9A==
X-Received: by 10.66.163.201 with SMTP id yk9mr61657893pab.63.1437413394447;
        Mon, 20 Jul 2015 10:29:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4dc:19bb:f338:713b])
        by smtp.gmail.com with ESMTPSA id k5sm22927170pdn.10.2015.07.20.10.29.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 Jul 2015 10:29:53 -0700 (PDT)
In-Reply-To: <xmqq1tg2zsxr.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 20 Jul 2015 09:37:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274333>

Junio C Hamano <gitster@pobox.com> writes:

> Your caller is iterating over the elements in a format string,
> e.g. 'A %(align:20)%(foo) B %(bar) C', and its caller is iterating
> over a list of refs, e.g. 'maint', 'master' branches.  With that
> format string, as long as %(foo) does not expand to something that
> exceeds 20 display places or so, I'd expect literal 'B' for all refs
> to align, but I do not think this code gives me that; what happens
> if '%(foo)' happens to be an empty string for 'maint' but is a
> string, say 'x', for 'master'?

Having looked at the caller once again, I have to say that the
interface to this function is poorly designed.  'info' might have
been a convenient place to keep the "formatting state" during this
loop (e.g. "was the previous atom tell us to format this atom in a
special way and if so how?"), but that state does not belong to the
'info' thing we are getting from our caller.  It is something we'd
want to clear before we come into the for() loop, and mutate and
utilize while in the loop.  For example, if the caller ever wants
to show the same ref twice by calling this function with the same
ref twice, and if the format string ended with %(align:N), you do
not want that leftover state to right-pad the first atom in the
second invocation.

Imagine that in the future you might want to affect how things are
formatted based on how much we have already output for the ref so
far (e.g. limiting the total line length).  Where would you implement
such a feature and hook it in this loop?

I'd imagine that a sensible way to organize and structure the
codeflow to support this "align" and related enhancement we may want
to have in the future cleanly would be to teach "print_value" about
the "formatting state" and share it with this loop.  Roughly...

>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>  {
>  	const char *cp, *sp, *ep;
>  

Insert something like this here:

	struct ref_formatting_state state;

	memset(&state, 0, sizeof(state));
        state.quote_style = quote_style;

>  	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>  		struct atom_value *atomv;
> +		int parsed_atom;
>  
>  		ep = strchr(sp, ')');
>  		if (cp < sp)
>  			emit(cp, sp);
> -		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
> +		parsed_atom = parse_ref_filter_atom(sp + 2, ep);
> +		get_ref_atom_value(info, parsed_atom, &atomv);
> +		assign_formating(info, parsed_atom, atomv);
>  		print_value(atomv, quote_style);

and replace all of the above with something like this (a separate
variable parsed_atom may not be necessary):

		get_ref_atom_value(&state, info,
				parse_ref_filter_atom(sp + 2, ep), &atomv);
		print_value(&state, atomv);

Things like %(align:20) are not really atoms in the sense that they
are not used as placeholders for attributes that refs being printed
have, but they are there solely in order to affect the "formating
state".  Introduce a new field "struct atom_value.pseudo_atom" to
tell print_value() that fact from get_ref_atom_value(), e.g.

	static void print_value(struct ref_formatting_state *state,
        			struct atom_value *v)
	{
		struct strbuf value = STRBUF_INIT;
		struct strbuf formatted = STRBUF_INIT;

        	if (v->pseudo_atom)
                	return;
		if (state->pad_to_right) {
                	strbuf_addf(&value, "%.*s", state->pad_to_right, v->s);
			state->pad_to_right = 0;
		}
		switch (state->quote_style) {                
		case QUOTE_SHELL:
                	sq_quote_buf(&formatted, value.buf);
                        break;
                        ...
		}
                fputs(formatted.buf, stdout);
                strbuf_release(&value);
                strbuf_release(&formatted);
	}

or something like that.  As this print_value() knows everything that
happens to a single output line during that loop and is allowed to
keep track of what it sees in 'state', this would give a natural and
codeflow to add 'limit the total line length' and things like that
if desired.

We may want to further clean up to update %(color) thing to clarify
that it is a pseudo atom.  I suspect %(align:20)%(color:blue) would
do a wrong thing with the current code, and it would be a reasonable
thing to allow both of these interchangeably:

  %(align:20)%(color:blue)%(refname:short)%(color:reset)
  %(color:blue)%(align:20)%(refname:short)%(color:reset)

and implementation of that would become more obvious once you have a
more explicit "formatting state" that is known to and shared among
get_value(), the for() loop that walks the format string, and
print_value().
