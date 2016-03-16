From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty-print: de-tabify indented logs to make things line up properly
Date: Wed, 16 Mar 2016 14:55:42 -0700
Message-ID: <xmqq37rq3x5t.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxLyMaur8Kd_uyewEeehPeuZXu=Hn11SSbTYd9O6FdDBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:55:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agJPy-0003mT-Rq
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624AbcCPVzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:55:45 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750953AbcCPVzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:55:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE3494E08A;
	Wed, 16 Mar 2016 17:55:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y/hcyApI0lbpWDHGPHaQMtqlip8=; b=W4kWrr
	gG1J45qDnlK61RGuTuQ2ElTF4t8NuWYIrG1gQ4Ze0ssSZc8hByZ1nK5OGpfoIkXT
	rGXayWZHWTxYgHKhgXR56gx3osjPNwAXCz/wIyh4ZaSZI6XEeYJkFA+JrR8oEjAc
	qbnu/X94i7szD8pmK+e4e3x3oxqcioUeVOs4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sNbxFU3CKpmghAeKC9rnpcUqNq/w8K+b
	+JdpNnh5flBgkJyCSDCpJwJ+UOrKAzjzFAf/4lYtqlNGHKArgl4F0WcrLKcUp3K2
	iDPt29Gwl3lYlyzenhiUFxj0cGNCijEurxv5qy0PGmrZfgEz0JEBqbcMP5VU8ayl
	akc57JaGTG8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B57324E089;
	Wed, 16 Mar 2016 17:55:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 37B374E088;
	Wed, 16 Mar 2016 17:55:43 -0400 (EDT)
In-Reply-To: <CA+55aFxLyMaur8Kd_uyewEeehPeuZXu=Hn11SSbTYd9O6FdDBA@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 16 Mar 2016 12:50:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D494BC5E-EBC1-11E5-A2D8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289051>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Here's an incremental patch that could be just smushed into my
> previous one. It doesn't change the behavior of "pp_handle_indent()",
> but I think it clarifies the code and makes future changes much easier
> (partly because now nobody has to worry about the continue case and
> the newline at the end of the line, so you can just print whatever you
> want and then return).
>
> What do you think?

I actually was hoping that strbuf_tabexpand_add() would be an
independently useful addition to strbuf_add*() family that does not
have to know the indentation and pretty-print-context, so burying
that new logic deep in the callchain like the patch below, while
letting it still be aware of "indent" value (and adding the leading
indent) does not look like a good abstraction from that point of
view.

The change to pp_remainder() looks like a nice cleanup for people
who read that function.  I still think pp_add_line() should add the
indentation to sb in "if (indent)" block itself, and the called
helper should be a "I know how to tab-expand a string and add the
result to a strbuf" that we can eventually move to strbuf.[ch].

Things like adding CMIT_FMT_EXPAND_TABS can still then be done with
something like this:

	strbuf_grow();
	if (indent) {
		strbuf_addchars(sb, ' ', indent);
-        	strbuf_tabexpand_add();
+		if (pp->format == EXPAND_TABS)
+	        	strbuf_tabexpand_add();
+		else
+	        	strbuf_add();
	} else {
        	strbuf_add();
	}

in pp_add_line(), so there is no difference between the ease of
future changes, I'd think.

>                  Linus
>
>  pretty.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index 0b40457f99f0..b9374a1708d1 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1699,6 +1699,18 @@ static int pp_handle_indent(struct strbuf *sb, int indent,
>  	return 1;
>  }
>  
> +static void pp_add_line(struct pretty_print_context *pp,
> +			struct strbuf *sb, int indent,
> +			const char *line, int linelen)
> +{
> +	strbuf_grow(sb, linelen + indent + 20);
> +	if (indent) {
> +		if (pp_handle_indent(sb, indent, line, linelen))
> +			return;
> +	}
> +	strbuf_add(sb, line, linelen);
> +}
> +
>  void pp_remainder(struct pretty_print_context *pp,
>  		  const char **msg_p,
>  		  struct strbuf *sb,
> @@ -1721,12 +1733,7 @@ void pp_remainder(struct pretty_print_context *pp,
>  		}
>  		first = 0;
>  
> -		strbuf_grow(sb, linelen + indent + 20);
> -		if (indent) {
> -			if (pp_handle_indent(sb, indent, line, linelen))
> -				linelen = 0;
> -		}
> -		strbuf_add(sb, line, linelen);
> +		pp_add_line(pp, sb, indent, line, linelen);
>  		strbuf_addch(sb, '\n');
>  	}
>  }
