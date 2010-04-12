From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] diff: add --word-diff option that generalizes
 --color-words
Date: Mon, 12 Apr 2010 09:31:04 -0700
Message-ID: <7v8w8sljjr.fsf@alter.siamese.dyndns.org>
References: <cover.1271077334.git.trast@student.ethz.ch>
 <09bfc1bfe19d47267167b264ed03a677ce20013f.1271077334.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 12 18:31:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1MXx-0003Jm-OA
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 18:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab0DLQbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 12:31:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab0DLQba (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 12:31:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DEC7AA2D3;
	Mon, 12 Apr 2010 12:31:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+dWymTEFdsST8O86HdurAwK881A=; b=YfJ13q
	W//EUXRyEpniRaSjXrZjiiRApyr11R30n2Rl5avvXwVZgRWa2VWmxAN1BcpluYM7
	ZrS9/hkrv11IJsIgfgl/uI61x5VkpUPmxiA/CSk8gg1iB2eubBCiso3+i7xEj6LL
	Nu/7RCFlDv6jwZ6kwEsXLXXCh656O7bLGsCLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r79dxkoCUOhfFlp+lECu6aJFmeXX7WQ8
	f7Mjsa7tP289nyC7D11uONSJKbjNap1W6RlIQp/mj3+lrVLVzP02uMtElEpjcYoA
	HoXP5o2p1pDAOSKn6bfi/tjN1WSa/ex9M3/KSk752yO6AKBJXF7TK+ALHT8UOWt7
	uJrnUdCh6/s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76E6BAA2C4;
	Mon, 12 Apr 2010 12:31:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19E65AA2C0; Mon, 12 Apr
 2010 12:31:05 -0400 (EDT)
In-Reply-To: <09bfc1bfe19d47267167b264ed03a677ce20013f.1271077334.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon\, 12 Apr 2010 15\:07\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2E237E6-4650-11DF-96A4-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144754>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/diff.c b/diff.c
> index 7effdac..ca054d4 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -560,16 +560,83 @@ static void diff_words_append(char *line, unsigned long len,
>  	buffer->text.ptr[buffer->text.size] = '\0';
>  }
>  
> +struct diff_words_style_elem
> +{
> +	const char *prefix;
> +	const char *suffix;
> +	const char *color; /* NULL; filled in by the setup code if
> +			    * color is enabled */
> +};

The reader makes a mental note that this is a 12- to 24-byte structure...

> +struct diff_words_style
> +{
> +	enum diff_words_type type;
> +	struct diff_words_style_elem new, old, ctx;
> +	const char *newline;
> +};
> +
> +struct diff_words_style diff_words_styles[] = {
> +	{ DIFF_WORDS_PORCELAIN,
> +	  {"+", "\n", NULL},
> +	  {"-", "\n", NULL},
> +	  {" ", "\n", NULL},
> +	  "~\n"
> +	},
> +	{ DIFF_WORDS_PLAIN,
> +	  {"{+", "+}", NULL},
> +	  {"[-", "-]", NULL},
> +	  {"", "", NULL},
> +	  "\n"
> +	},
> +	{ DIFF_WORDS_COLOR,
> +	  {"", "", NULL},
> +	  {"", "", NULL},
> +	  {"", "", NULL},
> +	  "\n"
> +	}
> +};

Beautiful.

The style might be a bit iffy.  Shouldn't an opening "{", unless closed on
the same line with a matching "}", stand on its own line?

> +static int fn_out_diff_words_write_helper(FILE *fp,
> +					  struct diff_words_style_elem st_el,

Do you need to pass this by value?

> +					  const char *newline,
> +					  size_t count, const char *buf)
> +{
> +	while (count) {
> +		char *p = memchr(buf, '\n', count);
> +		if (p != buf) {
> +			if (st_el.color && fputs(st_el.color, fp) < 0)
> +				return -1;
> +			if (fputs(st_el.prefix, fp) < 0 ||
> +			    fwrite(buf, p ? p - buf : count, 1, fp) != 1 ||
> +			    fputs(st_el.suffix, fp) < 0)
> +				return -1;
> +			if (st_el.color && strlen(st_el.color)

I would avoid strlen() only for boolean result here---the compilers may
not be as clever as you are.

	if (st_elp->color && *st_elp->color
