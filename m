From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] word diff: comments, preparations for regex
 customization
Date: Sun, 11 Jan 2009 14:19:57 -0800
Message-ID: <7vljthpjsi.fsf@gitster.siamese.dyndns.org>
References: <cover.1231669012.git.trast@student.ethz.ch>
 <4aea85caafd38a058145c5769fe8a30ffdbd4d13.1231669012.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Teemu Likonen <tlikonen@iki.fi>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 11 23:21:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM8gd-0003c3-Sa
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 23:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbZAKWUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 17:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbZAKWUK
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 17:20:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33309 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbZAKWUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 17:20:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 738A41C45D;
	Sun, 11 Jan 2009 17:20:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7166E1C45C; Sun,
 11 Jan 2009 17:19:59 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 00A05CA6-E02E-11DD-B414-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105238>

Thomas Rast <trast@student.ethz.ch> writes:

> +/* unused right now */
> +enum diff_word_boundaries {
> +	DIFF_WORD_UNDEF,
> +	DIFF_WORD_BODY,
> +	DIFF_WORD_END,
> +	DIFF_WORD_SPACE,
> +	DIFF_WORD_SKIP
> +};

Don't do this.  Please introduce them when you start using them.

>  struct diff_words_buffer {
>  	mmfile_t text;
>  	long alloc;
>  	long current; /* output pointer */
>  	int suppressed_newline;
> +	enum diff_word_boundaries *boundaries;
>  };

Likewise.  Especially because this raises eyebrows "Huh, a pointer to an
enum, or perhaps he allocates an array of enums?" without allowing the
reader to figure it out much later when the field is actually used.

>  static void diff_words_append(char *line, unsigned long len,
> @@ -339,16 +349,23 @@ static void diff_words_append(char *line, unsigned long len,
>  struct diff_words_data {
>  	struct diff_words_buffer minus, plus;
>  	FILE *file;
> +	regex_t *word_regex; /* currently unused */
>  };

I see having this here and keeping it NULL in this patch makes the later
patch to diff_words_show() more readable, so this probably should stay
here.

> -static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, int color,
> +/*
> + * Print 'len' characters from the "real" diff data in 'buffer'.  Also
> + * returns how many characters were printed (currently always 'len').
> + * With 'suppress_newline', we remember a final newline instead of
> + * printing it.
> + */

"... Even in such a case, 'len' that is returned counts the suppressed
newline", or something like that?  If you can concisely describe why the
caller wants the returned count not match the number of actually printed
chars (i.e. it includes the suppressed newline), it would help the reader
understand the logic.  I am _guessing_ it is because this is called to
print matching words from the preimage buffer, and the return value is
used to skip over the same part in the postimage buffer, and by definition
they have to be of the same length (otherwise they won't be matching).

> +static int print_word(FILE *file, struct diff_words_buffer *buffer, int len, int color,
>  		int suppress_newline)
>  {
>  	const char *ptr;
>  	int eol = 0;
>  
>  	if (len == 0)
> -		return;
> +		return len;
>  
>  	ptr  = buffer->text.ptr + buffer->current;
>  	buffer->current += len;
> @@ -368,18 +385,30 @@ static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, in
>  		else
>  			putc('\n', file);
>  	}
> +
> +	/* we need to return how many chars to skip on the other side,
> +	 * so account for the (held off) \n */

Multi-line comment style?  I won't repeat this but you have many...

> +	return len+eol;
>  }
>  
> +/*
> + * Callback for word diff output
> + */

Without saying "to do what", the comment adds more noise than signal.
"Called to parse diff between pre- and post- image files converted into
one-word-per-line format and concatenate them to into lines by dropping
some of the end-of-lines but keeping some others", or something like that?

Thanks.
