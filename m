From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty-print: de-tabify indented logs to make things line up properly
Date: Wed, 16 Mar 2016 11:01:39 -0700
Message-ID: <xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 19:01:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agFlU-0002Xf-Nu
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 19:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934604AbcCPSBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2016 14:01:45 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934328AbcCPSBo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2016 14:01:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3937D4BB9F;
	Wed, 16 Mar 2016 14:01:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=X4T+hSnAq+Mt
	F0z6b8q852KeuHU=; b=N1o7k8WRPdovjk7nBqaNf9Ec1BN346BeOz+P4zMozkvH
	5iAD96t6eYGLMFmlOJvhY6FXZqgN4Q8TQiQf3dQFRPKpacycrxTyly9pwYRhEWqz
	tBZWNlPS/He2Q4r0YQZfgoC5xI62mueEj/UX/ooLHEtVDVHsYnPxE6s9a+ZVegY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YOjHRR
	p9vM6vbJys6DZU9PrH3oZA0SlED9bBLIxkfH99y9oOlgfQDpW0gHIm87gmSOkiUc
	k+t0wqsilhG4NgDs8/qZ+/TLum5Bn+9bq60DulfpjbvRjHGRhl+DUigBDog177+U
	CUUra4k75eNXIc9xOBSSZiIwlagIKgW3OEoB0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 318994BB9E;
	Wed, 16 Mar 2016 14:01:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7AC0C4BB9A;
	Wed, 16 Mar 2016 14:01:40 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.20.1603160926060.13030@i7> (Linus Torvalds's
	message of "Wed, 16 Mar 2016 09:29:35 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 22777A86-EBA1-11E5-978B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289006>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Wed, 16 Mar 2016 09:15:53 -0700
> Subject: [PATCH] pretty-print: de-tabify indented logs to make things=
 line up properly
>
> This should all line up:
>
>   Column 1	Column 2
>   --------	--------
>   A		B
>   ABCD		EFGH
>   SPACES        Instead of Tabs
>
> Even with multi-byte UTF8 characters:
>
>   Column 1	Column 2
>   --------	--------
>   =C3=84		B
>   =C3=A5=C3=A4=C3=B6		100
>   A M=C3=B8=C3=B8se	once bit my sister..
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> This seems to work for me, and while there is some cost, it's minimal=
=2E=20
> Doing a "git log > /dev/null" of the current git tree is about 1% slo=
wer=20
> because of the tab-finding. A tree with a lot of tabs in the commit=20
> messages would be more noticeable, because then you actually end up=20
> hitting the whole "how wide is this" issue.
>
> (But if the tabs are all at the beginning of a line, you'd still be o=
k=20
> and avoid the utf8 width calculations).
>
> Comments?

I stared at it for a while, and didn't spot anything wrong with it.

I did wonder about two things, though:

 (1) if turning your "preparation; do { ... } while()" into
     "while () { }" would make the result a bit easier to read;

 (2) if we can somehow eliminate duplication of "tab + 1" (spelled
     differently on the previous line as "1+tab"), the end result
     may get easier to follow.

but both are minor.

>  pretty.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++--
>  1 file changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index 92b2870a7eab..0b40457f99f0 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1629,6 +1629,76 @@ void pp_title_line(struct pretty_print_context=
 *pp,
>  	strbuf_release(&title);
>  }
> =20
> +static int pp_utf8_width(const char *start, const char *end)
> +{
> +	int width =3D 0;
> +	size_t remain =3D end - start;
> +
> +	while (remain) {
> +		int n =3D utf8_width(&start, &remain);
> +		if (n < 0 || !start)
> +			return -1;
> +		width +=3D n;
> +	}
> +	return width;
> +}
> +
> +/*
> + * pp_handle_indent() prints out the intendation, and
> + * perhaps the whole line (without the final newline)
> + *
> + * Why "perhaps"? If there are tabs in the indented line
> + * it will print it out in order to de-tabify the line.
> + *
> + * But if there are no tabs, we just fall back on the
> + * normal "print the whole line".
> + */
> +static int pp_handle_indent(struct strbuf *sb, int indent,
> +			     const char *line, int linelen)
> +{
> +	const char *tab;
> +
> +	strbuf_addchars(sb, ' ', indent);
> +
> +	tab =3D memchr(line, '\t', linelen);
> +	if (!tab)
> +		return 0;
> +
> +	do {
> +		int width =3D pp_utf8_width(line, tab);
> +
> +		/*
> +		 * If it wasn't well-formed utf8, or it
> +		 * had characters with badly defined
> +		 * width (control characters etc), just
> +		 * give up on trying to align things.
> +		 */
> +		if (width < 0)
> +			break;
> +
> +		/* Output the data .. */
> +		strbuf_add(sb, line, tab - line);
> +
> +		/* .. and the de-tabified tab */
> +		strbuf_addchars(sb, ' ', 8-(width & 7));
> +
> +		/* Skip over the printed part .. */
> +		linelen -=3D 1+tab-line;
> +		line =3D tab + 1;
> +
> +		/* .. and look for the next tab */
> +		tab =3D memchr(line, '\t', linelen);
> +	} while (tab);
> +
> +	/*
> +	 * Print out everything after the last tab without
> +	 * worrying about width - there's nothing more to
> +	 * align.
> +	 */
> +	strbuf_add(sb, line, linelen);
> +	return 1;
> +}
> +
>  void pp_remainder(struct pretty_print_context *pp,
>  		  const char **msg_p,
>  		  struct strbuf *sb,
> @@ -1652,8 +1722,10 @@ void pp_remainder(struct pretty_print_context =
*pp,
>  		first =3D 0;
> =20
>  		strbuf_grow(sb, linelen + indent + 20);
> -		if (indent)
> -			strbuf_addchars(sb, ' ', indent);
> +		if (indent) {
> +			if (pp_handle_indent(sb, indent, line, linelen))
> +				linelen =3D 0;
> +		}
>  		strbuf_add(sb, line, linelen);
>  		strbuf_addch(sb, '\n');
>  	}
