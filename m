From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/15] ref-filter: use parsing functions
Date: Thu, 07 Jan 2016 13:28:35 -0800
Message-ID: <xmqqd1td3wqk.fsf@gitster.mtv.corp.google.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRjXHmBnnmHbbibeV-gcvwMFQc7-5ce4s2OHu+wQwMy4Q@mail.gmail.com>
	<CAOLa=ZSi0c61G8oXsCC0UfprDhf3hESaqKw8eGNRZJ7MTvNY4g@mail.gmail.com>
	<xmqqvb7544de.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZSzPeqsObgno8q0hpbAGUgZgFJ5x8Oj7YtA7_uPLvG0Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 22:28:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHI6s-00016i-Ez
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 22:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbcAGV2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 16:28:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752040AbcAGV2h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 16:28:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF6F23ADAA;
	Thu,  7 Jan 2016 16:28:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J3Y/eIYvpxgQCtnlBkzWMGgTb8o=; b=vUF7x5
	1Osz+HiTk+M5kiTUFAdnlq9yXz9GMfkpFHtleUr7u553CHYpSKXntvYToVpT0i/N
	RkZxNnXR1E4+Q+MZrz/ogcQ9bkiX6AKnp3/A4Trqoo0P4gqFgr7WaBo9RxFXntBa
	ND9IPDjluTZB0euy8nnPz5tq89Bro/+v/bTiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CQ5hUAzkCy658Nak0nNPcmZpdZZ7wIQl
	+JbC+R0YAzLZpjtzayai+e1WKdLEXHn7q5BqYNaCi1ZyRdC4Zb9TDf/zk950AddX
	gxDBXuGyXrPqfPlxqddWhHfPvwcBtXv2L3uwXA5YUJNVzJMtBKt6Q+yITQZ4tqsf
	MlIV5EgcK6c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D72BA3ADA8;
	Thu,  7 Jan 2016 16:28:36 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 577933ADA4;
	Thu,  7 Jan 2016 16:28:36 -0500 (EST)
In-Reply-To: <CAOLa=ZSzPeqsObgno8q0hpbAGUgZgFJ5x8Oj7YtA7_uPLvG0Pw@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 8 Jan 2016 02:14:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9C63BB04-B585-11E5-A70C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283508>

Karthik Nayak <karthik.188@gmail.com> writes:

> So we something like this for the parsing function:
>
>  int parse_ref_filter_atom(const char *atom, const char *ep)
>  {
>         const char *sp;
> +       char *arg;

I think this and the new parameter to .parser() function should be
"const char *".

> @@ -141,6 +143,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>                 const char *formatp = strchr(sp, ':');
>                 if (!formatp || ep < formatp)
>                         formatp = ep;
> +               arg = (char *)formatp;
>                 if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
>                         break;

And this part can just use arg without formatp.  The original is a
bit sloppy and will keep looking for a colon past ep, but we already
know between sp and ep there is no NUL, so we could do this:

		arg = memchr(sp, ':', ep - sp);
		if ((!arg || len == arg - sp) &&
		    !memcmp(valid_atom[i].name, sp, len))
			break;

> @@ -154,6 +157,13 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>         REALLOC_ARRAY(used_atom, used_atom_cnt);
>         used_atom[at].name = xmemdupz(atom, ep - atom);
>         used_atom[at].type = valid_atom[i].cmp_type;
> +       if (arg != ep)
> +               arg = xstrndup(arg + 1, ep - arg - 1);
> +       else
> +               arg = NULL;

Why even copy?  The original that used match_atom_name() borrowed
part of existing string via (const char **val), so you know whatever
used that &buf you grabbed out of match_atom_name() should only be
reading the values not writing into the memory, no?

That is why I think arg should be "const char *".

As the above memchr() alrady took care of "we didn't find a colon"
case, we only need to do this here, I think:

	if (arg)
        	arg = used_atom[at].name + (arg - atom);

and without later free().

Alternatively, we could add an int field to elements of used_atom[]
array that says what byte-offset in the used_atom[].name the atom
arguments start (if any).  Then .parser() does not have to take the
parameter separately [*1*].

> +       if (valid_atom[i].parser)
> +               valid_atom[i].parser(&used_atom[at], arg);
> +       free(arg);
>         if (*atom == '*')
>                 need_tagged = 1;
>         if (!strcmp(used_atom[at].name, "symref"))



[Footnote]

*1* Thinking about it more, perhaps used_atom[].type should be
removed and instead used_atom[].atom should be a pointer into the
valid_atom[] array.  Then any reference to used_atom[].type will
become used_atom[].atom->cmp_type, which is much nicer for two
reasons: (1) one less useless copy (2) one less field that has a
name "type" that is overly generic.

That does not remove the need for recording where the atom argument
is, though, in used_atom[].  We could add a bit "has_deref" to
used_atom[] and then do something like this:

    arg = used_atom[i].name + used_atom[i].atom->namelen +
          used_atom[i].has_deref;

but I do not think we want to go there.  It would hardcode the
knowledge that used_atom[i].name is either used_atom[i].atom->name
or one asterisk prefixed to it, making future extension of the
syntax even harder.
