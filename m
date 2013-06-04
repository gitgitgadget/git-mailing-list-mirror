From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/15] for-each-ref: don't print out elements directly
Date: Tue, 04 Jun 2013 16:13:09 -0700
Message-ID: <7vsj0x4ghm.fsf@alter.siamese.dyndns.org>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
	<1370349337-20938-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
	<pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 01:13:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk0Pp-0001ah-AU
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 01:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035Ab3FDXNO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 19:13:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62194 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885Ab3FDXNM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jun 2013 19:13:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3929E25659;
	Tue,  4 Jun 2013 23:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GLXVCLnsr36F
	Jr+UlnvbcxaUQtM=; b=AXLEFQtqoAjUMSnR9G/HojGJFZCPn5Fdll7nDKmzZWUL
	ldBoyvlzMGzIbQ9cAD8/DMCAyeZAT6yZO3bi+WjWbDcLk3awbrgtYZ1fUHo52ZIr
	Veln56IqKztGGzOoKOxFCkxBRazyfE4GiiLnxo6WtN5QJuNDJ4KU3g8q6aOfmzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vKAzPX
	/B++BTaS2Dk9OOHq8TKHc6VNwc8dppdfvrdv6/vgrAPVr+v8EGKwCl5ZGdWNGWiL
	EsP4zQWONEhyqKcBXHcG51J1tskrG4MirLzi7Doc4zsAY6wSc8rE1vHnVBFHZ1Ai
	+Ju0w6loA+sbj0XxDh4ZIdCRk6HBBG5OUDtxY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 305BA25658;
	Tue,  4 Jun 2013 23:13:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74E9A25657;
	Tue,  4 Jun 2013 23:13:10 +0000 (UTC)
In-Reply-To: <1370349337-20938-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 4 Jun 2013 18:05:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52DC68F4-CD6C-11E2-A4D8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226422>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> Currently, the entire callchain starting from show_ref() parses and
> prints immediately.  This inflexibility limits our ability to extend =
the
> parser.  So, convert the entire callchain to accept a strbuf argument=
 to
> write to.  Also introduce a show_refs() helper that calls show_ref() =
in
> a loop to avoid cluttering up cmd_for_each_ref() with the task of
> initializing/freeing the strbuf.
>
> [rr: commit message]
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  builtin/for-each-ref.c | 55 ++++++++++++++++++++++++++++++++--------=
----------
>  1 file changed, 35 insertions(+), 20 deletions(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 1d4083c..e2d6c5a 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -864,31 +864,31 @@ static void sort_refs(struct ref_sort *sort, st=
ruct refinfo **refs, int num_refs
>  	qsort(refs, num_refs, sizeof(struct refinfo *), compare_refs);
>  }
> =20
> -static void print_value(struct refinfo *ref, int atom, int quote_sty=
le)
> +static void print_value(struct strbuf *sb, struct refinfo *ref,
> +			int atom, int quote_style)
>  {
>  	struct atom_value *v;
> -	struct strbuf sb =3D STRBUF_INIT;
>  	get_value(ref, atom, &v);
>  	switch (quote_style) {
>  	case QUOTE_NONE:
> -		fputs(v->s, stdout);
> +		strbuf_addstr(sb, v->s);
>  		break;
>  	case QUOTE_SHELL:
> -		sq_quote_buf(&sb, v->s);
> +		sq_quote_buf(sb, v->s);
>  		break;
>  	case QUOTE_PERL:
> -		perl_quote_buf(&sb, v->s);
> +		perl_quote_buf(sb, v->s);
>  		break;
>  	case QUOTE_PYTHON:
> -		python_quote_buf(&sb, v->s);
> +		python_quote_buf(sb, v->s);
>  		break;
>  	case QUOTE_TCL:
> -		tcl_quote_buf(&sb, v->s);
> +		tcl_quote_buf(sb, v->s);
>  		break;
>  	}
>  	if (quote_style !=3D QUOTE_NONE) {
> -		fputs(sb.buf, stdout);
> -		strbuf_release(&sb);
> +		fputs(sb->buf, stdout);
> +		strbuf_release(sb);
>  	}
>  }

The change in the first step made some sense; if asked not to quote,
it just emits the atom with fputs() in the switch (quote_style), so
there is nothing more to do after the switch.

But this change cannot be correct.  It prints literally to sb, and
leaves the function without emitting anything nor freeing the
resource in sb.
