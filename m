From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/15] ref-filter: introduce color_atom_parser()
Date: Tue, 05 Jan 2016 12:49:13 -0800
Message-ID: <xmqqwprniwfq.fsf@gitster.mtv.corp.google.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-9-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 21:50:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGYYK-0004ky-FU
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 21:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbcAEUtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 15:49:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754011AbcAEUtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 15:49:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 149B637DC7;
	Tue,  5 Jan 2016 15:49:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5qDGnaSwLyxmrjE51sJ7mMMZm9o=; b=eSbus/
	onZlmADImqBTn8aGSv5SxJRwTysMCP3550GWuJZ7ryO4LycsJ8Le0Yji8UVVkMWT
	Z2It0m/liiUSiz8fbIKLQDRD2Zx2g8KAWXhRAC94WY3N0K7genXtyFiuI4SQAhsE
	L5Mpo0xtFFvcJmvNt4c0wEJvlLvPIkgrG1EeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WF61MXd0Gt9GWW/dGvJ068qSLoHFIf/y
	tcE2rHkiJ/VXmIt2L2oZgaxekB9pXTCG5O3c0W2O0KMzzEASI28xAeZjZ20f6Jst
	pIUL1R6ZKjW59FHTYB7HFNJA+Pa3xhyrtDIQgiMQwKTwv6+/V9webBc2kUhUbk5N
	B9/HvjLhQI0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A32537DC6;
	Tue,  5 Jan 2016 15:49:15 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6D8D437DC5;
	Tue,  5 Jan 2016 15:49:14 -0500 (EST)
In-Reply-To: <1451980994-26865-9-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 5 Jan 2016 13:33:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C7C68A36-B3ED-11E5-845A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283399>

Karthik Nayak <karthik.188@gmail.com> writes:

> Introduce color_atom_parser() which will parse a "color" atom and
> store its color in the "used_atom" structure for further usage in
> populate_value().
>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  ref-filter.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index b54c872..9708d67 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -29,6 +29,9 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>  static struct used_atom {
>  	const char *name;
>  	cmp_type type;
> +	union {
> +		char *color;
> +	} u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
>  static int need_color_reset_at_eol;
> @@ -53,6 +56,18 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
>  	return 1;
>  }
>  
> +static void color_atom_parser(struct used_atom *atom)
> +{
> +	if (!match_atom_name(atom->name, "color", (const char **)&atom->u.color))
> +		die("BUG: parsing non-'color'");
> +	if (!atom->u.color)
> +		die(_("expected format: %%(color:<color>)"));
> +	/* atom->u.color points to part of atom->name */
> +	atom->u.color = xstrdup(atom->u.color);
> +	if (color_parse(atom->u.color, atom->u.color) < 0)
> +		die(_("invalid color value: %s"), atom->u.color);

Is this calling color_parse() from color.c?

The function wants the destination to be at least COLOR_MAXLEN, but
I do not see where the piece memory pointed by atom->u.color is
guaranteed to be that long in the new code.  Looking at the code
removed by this patch, it used to correctly use a buffer that is
COLOR_MAXLEN bytes long.  So...

	const char *color_value;

	if (!match_atom_name(atom->name, "color", color_value))
		die("BUG: parsing non-'color'");
	if (!color_value)
		die(_("expected format: %%(color:<color>)"));
	atom->u.color = xmalloc(COLOR_MAXLEN);
        if (color_parse(color_value, atom->u.color) < 0)
		die(_("invalid color value: %s"), color_value);

or even define it in the union, i.e.

	union {
        	char color[COLOR_MAXLEN];
	} u;

and then use atom->u.color[] in-place?
