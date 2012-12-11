From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] pretty: Use mailmap to display username and email
Date: Tue, 11 Dec 2012 14:46:38 -0800
Message-ID: <7vehiw6wc1.fsf@alter.siamese.dyndns.org>
References: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
 <1355264493-8298-5-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Rich Midwinter <rich.midwinter@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 23:46:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiYbK-0004zh-H4
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 23:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212Ab2LKWqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 17:46:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab2LKWql (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 17:46:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 213A2A7B1;
	Tue, 11 Dec 2012 17:46:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=arlGdCVknjr7GeQK5KvEop/CYfQ=; b=a+WFZC
	4ypadrKOqG/yA0xoVxcsc8Sv4cTenZQr6FCprMRwSlY9HVEzGaOYR2TqYixHN/U9
	qmj0yRldbY89nWR8ktaY2xvDZEMyulC/MQAVCeNwD6jFq3RRDJU1/1DLCIcdmP5L
	y0jnoAqGYJc/zgojnG9/KXWWClbvOzrDWVWn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WXy66JO5SXbSm8QDq9noJn4PUbI8ccOM
	iA6ekVX2j8crhndNFpMeAayOVC4J0Tsff2iohLrTTN9s6fzLBwXqe5NWHPb5sr1m
	0SX6IEfEtGI+pSc+FeWIv7RyKqzdbwFhf6nFlJUY9sAUBir5vRu8yTXGVg3PWa7I
	nCwH3x/QbMc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DED2A7B0;
	Tue, 11 Dec 2012 17:46:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C6CEA7AF; Tue, 11 Dec 2012
 17:46:40 -0500 (EST)
In-Reply-To: <1355264493-8298-5-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Tue, 11 Dec 2012 23:21:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0C216B6-43E4-11E2-B15B-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211313>

Antoine Pelisse <apelisse@gmail.com> writes:

> Use the mailmap information to display the correct
> username and email address in all log commands.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
>  pretty.c | 46 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index 6730add..e232aaa 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -387,6 +387,8 @@ void pp_user_info(const struct pretty_print_context *pp,
>  		  const char *what, struct strbuf *sb,
>  		  const char *line, const char *encoding)
>  {
> +	char person_name[1024];
> +	char person_mail[1024];
>  	struct ident_split ident;
>  	int linelen, namelen;
>  	char *line_end, *date;
> @@ -405,41 +407,55 @@ void pp_user_info(const struct pretty_print_context *pp,
>  	if (split_ident_line(&ident, line, linelen))
>  		return;
>  
> -	namelen = ident.mail_end - ident.name_begin + 1;
> +	memcpy(person_mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
> +	person_mail[ident.mail_end - ident.mail_begin] = 0;
> +
> +	memcpy(person_name, ident.name_begin, ident.name_end - ident.name_begin);
> +	person_name[ident.name_end - ident.name_begin] = 0;
> +
> +	if (pp->mailmap)
> +		map_user(pp->mailmap, person_mail, sizeof(person_mail),
> +			 person_name, sizeof(person_name));

This is why I said that we may want to rethink the API signature of
the map_user() function.  Now this caller has the hardcoded limit
for name and mail parts, and it needs to make copies of strings into
two arrays only because map_user() expects to get two fixed-size
buffers that are to be rewritten in-place.  If we changed map_user()
to take two strbufs (one for name, the other for mail) to be updated
in place, we would still need to make copies, but later code in this
function may be able to lose a few strlen() calls.

Or it might be better to make those two strbufs output-only
parameter, e.g.

	map_user(struct string_list *mailmap,
        	const char *name, size_t namelen,
                const char *mail, size_t maillen,
                struct strbuf *name_out, struct strbuf *mail_out);

then after split_ident_line(), this caller could feed two pointers
into the original "line" as name and mail parameter, without making
any copies (the callee has to make a copy but it has to be done
anyway when the name/mail is mapped).  I suspect it would make this
caller simpler, but I do not know how invasive such changes are for
other callers of map_user().

Such an update can be left outside of this series, of course.

> +		strbuf_addch(sb, ' ');
> +		strbuf_addch(sb, '<');
> +		strbuf_add(sb, person_mail, strlen(person_mail));
> +		strbuf_addch(sb, '>');
>  		strbuf_addch(sb, '\n');

Is that strbuf_addf(sb, " <%s>\n", person_mail)?
