From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] quote: implement "sq_dequote_many" to unwrap many
 args in one string
Date: Sun, 29 Mar 2009 23:45:01 -0700
Message-ID: <7vocvjjyqa.fsf@gitster.siamese.dyndns.org>
References: <20090329114444.5579813c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 08:46:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoBGg-0006eW-2M
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 08:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbZC3GpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 02:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbZC3GpQ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 02:45:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbZC3GpO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 02:45:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3C9D5A69D6;
	Mon, 30 Mar 2009 02:45:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5BFC6A69D0; Mon,
 30 Mar 2009 02:45:03 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 517B151C-1CF6-11DE-A629-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115087>

Christian Couder <chriscool@tuxfamily.org> writes:

> @@ -92,6 +92,8 @@ char *sq_dequote(char *arg)
>  		switch (*++src) {
>  		case '\0':
>  			*dst = 0;
> +			if (next)
> +				*next = 0;

	*next = NULL;

>  			return arg;
>  		case '\\':
>  			c = *++src;



> diff --git a/quote.h b/quote.h
> index c5eea6f..c2f98e7 100644
> --- a/quote.h
> +++ b/quote.h
> @@ -39,6 +39,14 @@ extern void sq_quote_argv(struct strbuf *, const char **argv, size_t maxlen);
>   */
>  extern char *sq_dequote(char *);
>  
> +/*
> + * Same as the above, but can unwraps many arguments in the same string

"can unwrap"

> + * separated by space. "next" is changed to point to the next argument
> + * that should be passed as first parameter. When there are no more
> + * arguments to be dequoted, then "next" is changed to point to NULL.
> + */
> +extern char *sq_dequote_many(char *arg, char **next);
> +
>  extern int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
>  extern size_t quote_c_style(const char *name, struct strbuf *, FILE *, int no_dq);
>  extern void quote_two_c_style(struct strbuf *, const char *, const char *, int);

I think dequote_many() is misnamed, as it only does one but has a slightly
more helpful interface than the bare sq_dequote() when the caller is
willing to dequote many.  It probably should be called dequote_step().

But do not send in replacements just yet.
