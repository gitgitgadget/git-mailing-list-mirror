From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 3/3] Advices about 'git rm' during conflicts (unmerged
 paths) more relevant
Date: Wed, 30 May 2012 11:44:09 -0700
Message-ID: <7vipfdzeyu.fsf@alter.siamese.dyndns.org>
References: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338384216-18782-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed May 30 20:44:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZnsc-00082v-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 20:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab2E3SoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 14:44:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35547 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754773Ab2E3SoM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 14:44:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF6948200;
	Wed, 30 May 2012 14:44:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5/usfcwIUHr2qFVdQhudUEYjvZg=; b=Eqgwop
	+pUCo6ujUJerONoFXaMni6vp3BNyB4A2JxCNJPGmKv30TwltjvPh2f6+IPbJ2L03
	Ccr5S+N+8qXz2z1lNU1UGPL+wzGSPVSU20i0TI7I/7lifPvGYxTiy3KrOZ6THIGl
	piDEyxrn9hD44ide1YAYUzU24ndAb2IRxWJqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bpaUi6Wpcq735VRyoB1d2iB86d1Oyi0u
	2MM+WXFn/fO33ShDdKXauFKgPpMNQKCygeIugVSL6cHTMqQNTAp3L4MVqX51s5yU
	8/I0cUB+dZNdJnPdltlTmYlQOL7frCn18uFYseSy0V0PCKSoNFlFAhduZwfrLln3
	Coovh6SvXdw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B747181FF;
	Wed, 30 May 2012 14:44:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 194C081FE; Wed, 30 May 2012
 14:44:11 -0400 (EDT)
In-Reply-To: <1338384216-18782-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Kong Lucien's message of "Wed, 30 May 2012 15:23:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7237583E-AA87-11E1-895C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198830>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

>  static void wt_status_print_unmerged_header(struct wt_status *s)
>  {
> +	int i;
> +	int simple_deleted_flag = 0;
> +	int both_deleted_flag = 0;
> +	int not_deleted_flag = 0;
>  	const char *c = color(WT_STATUS_HEADER, s);
>  
>  	status_printf_ln(s, c, _("Unmerged paths:"));
> +
> +	for (i = 0; i < s->change.nr; i++) {
> +		struct string_list_item *it = &(s->change.items[i]);
> +		struct wt_status_change_data *d = it->util;
> +
> +		if (d->stagemask == 1 && !both_deleted_flag)
> +			both_deleted_flag = 1;
> +		else if ((d->stagemask == 3 || d->stagemask == 5) && !simple_deleted_flag)
> +			simple_deleted_flag = 1;
> +		else if ((d->stagemask == 2 || d->stagemask == 4 || d->stagemask == 6 ||
> +				d->stagemask == 7) && !not_deleted_flag)
> +			not_deleted_flag = 1;
> +	}

Yuck.  Do you need to "&& !flag" in any of these?

	switch (d->stagemask) {
        case 1:
        	both_deleted = 1;
                break;
        case 3:
        case 5:
        	simple_deleted = 1;
                break;
        default:
        	not_deleted = 1;
                break;
	}

Also, I think "simple deleted" is grossly misnamed.  It is "one side
deleted, other side possibly modified", isn't it?  Because it is
almost always safe to resolve "both sides deleted" to a deletion,
but "one deleted, the other modified" needs a lot more thought to
resolve correctly, it is a much more complex case.  I'd call it
del_mod_conflict or something if I were writing this code.

In any case, drop "_flag" from the names.  They are annoying and do
not add much value.

>  	if (!advice_status_hints)
>  		return;
>  	if (s->whence != FROM_COMMIT)
> @@ -142,7 +160,16 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
>  		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
>  	else
>  		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
> -	status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
> +
> +	if (!both_deleted_flag)

If you meant the control flow to follow your indentation, I think
you are missing opening "{" at the end of the above line.

> +		if (!simple_deleted_flag)
> +			status_printf_ln(s, c, _("  (use \"git add <file>...\" as appropriate to mark resolution)"));

Nobody deleted, so we do not suggest "rm" as resolution, which makes
sense.

As far as I know, in the current message we say "as appropriate"
because we leave the choice of add/rm to the end user.  Do you still
need "as appropriate" after deciding that "add" is the only choice
for the user?

> +		else
> +			status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));

There is del/mod conflict and nothing else; the user needs to choose
between add/rm.  OK.

> +	else if (!simple_deleted_flag && !not_deleted_flag)
> +		status_printf_ln(s, c, _("  (use \"git rm <file>...\" as appropriate to mark resolution)"));

Assuming that a closing "}" for the "if (!both_deleted)" above is
missing at the beginning of this line, there is no del/mod conflict,
some del/del and no addition, so "rm" is the only choice, which
makes sense.  The same comment on "as appropriate" applies here.

> +	else
> +		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
>  	status_printf_ln(s, c, "");
>  }

I like the way it tries to be helpful, but I doubt this patch would
make much difference in the real life.  As you follow the logic like
I demonstrated above, you show specific help only in a very narrow
case (i.e. there is no possible removal or there are nothing but
"both sides removed").
