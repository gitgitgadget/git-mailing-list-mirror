From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] mailmap: simplify map_user() interface
Date: Sun, 06 Jan 2013 14:56:28 -0800
Message-ID: <7vehhxnco3.fsf@alter.siamese.dyndns.org>
References: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
 <1357421206-5014-5-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 23:56:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trz99-0007dE-3C
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 23:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268Ab3AFW4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 17:56:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36739 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255Ab3AFW4b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 17:56:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C76AA25F;
	Sun,  6 Jan 2013 17:56:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ryne+nOuSA5Y1jpOTdgaqpE8Mwo=; b=FVEiOu
	PTABOITvRkXw5AaroOf9XhC9L/ntANYUVvOKyE+kzpK+tZW5opUHqX4zr91oMo1m
	uCH8JfeA70K1hluaopngZUb+iAXX6t3IqrHWgmtvOVrWqHxSpIWAOjOg2ktnfXh+
	HnSMn4J7/1MCTQ3C0xeiHtr3Vj7pmNL0YV9O8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NZ1u051SLEaZCrQeDQbujAHMkWoWPea+
	xLRZfcfqjSsEfdeHxi64nHkEEdqyLBs1l3v1GIOWTROKot7lEqdDT95rXzwGjehb
	N2sv38YFOtz6aoUIqpHKR+x+RM4ZEiDR1oMw9fm7U46QWAJrt6XE5KPCtjC3Gmfe
	YQwibj5W9QI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48E69A25E;
	Sun,  6 Jan 2013 17:56:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCE9CA25C; Sun,  6 Jan 2013
 17:56:29 -0500 (EST)
In-Reply-To: <1357421206-5014-5-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Sat, 5 Jan 2013 22:26:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4EE20070-5854-11E2-A4F3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212853>

Antoine Pelisse <apelisse@gmail.com> writes:

> diff --git a/builtin/blame.c b/builtin/blame.c
> index dd4aff9..86450e3 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> ...
> @@ -1356,51 +1356,61 @@ static void get_ac_line(const char *inbuf, const char *what,
>  		len = strlen(tmp);
>  	else
>  		len = endp - tmp;
>  
>  	if (split_ident_line(&ident, tmp, len)) {
>  	error_out:
>  		/* Ugh */
> +		tmp = "(unknown)";
> +		strbuf_addstr(name, tmp);
> +		strbuf_addstr(mail, tmp);
> +		strbuf_addstr(tz, tmp);
>  		*time = 0;
>  		return;
>  	}
>  
>  	namelen = ident.name_end - ident.name_begin;
> +	tmpname = ident.name_begin;
>  
> +	maillen = ident.mail_end - ident.mail_begin;
> +	tmpmail = ident.mail_begin;
>  
>  	*time = strtoul(ident.date_begin, NULL, 10);
>  
> +	len = ident.tz_end - ident.tz_begin;
> +	strbuf_add(tz, ident.tz_begin, len);
>  
>  	/*
>  	 * Now, convert both name and e-mail using mailmap
>  	 */
> +	map_user(&mailmap, &tmpmail, &maillen,
> +		 &tmpname, &namelen);

I like the general simplification this change gives us, but do we
still want to name these variables "tmp"-something?  At least to me,
it makes it look like the variable holds a pointer to a piece of
memory that was temporarily allocated.  Calling it "mail_begin" or
something might be less confusing.

The changes to pretty.c (pp_user_info) and shortlog.c
(insert_one_record) calls these variables mailbuf and namebuf,
so perhaps these are better names?
