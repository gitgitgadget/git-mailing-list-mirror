From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] Avoid a useless prefix lookup in strbuf_expand()
Date: Sun, 03 Feb 2008 13:53:32 -0800
Message-ID: <7vsl09u2oz.fsf@gitster.siamese.dyndns.org>
References: <1201950593-6119-1-git-send-email-mcostalba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 22:54:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLmnD-0001fR-FN
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 22:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbYBCVxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 16:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbYBCVxz
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 16:53:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbYBCVxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 16:53:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0735A329D;
	Sun,  3 Feb 2008 16:53:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 98C1B329A;
	Sun,  3 Feb 2008 16:53:44 -0500 (EST)
In-Reply-To: <1201950593-6119-1-git-send-email-mcostalba@gmail.com> (Marco
	Costalba's message of "Sat, 2 Feb 2008 12:09:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72409>

Marco Costalba <mcostalba@gmail.com> writes:

> diff --git a/pretty.c b/pretty.c
> index b987ff2..64ead65 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -282,16 +282,18 @@ static char *logmsg_reencode(const struct commit *commit,
>  	return out;
>  }
>  
> -static void format_person_part(struct strbuf *sb, char part,
> +/* returns placeholder length or 0 if placeholder is not known */

That "return placeholder length" is a bit confusing, and I suspect
the reason may be because the interface is misdesigned.

This function gets only a single character "part" and adds the
matching information to sb if found, otherwise it doesn't, so
the only possible return values are 0 or 2.

Wouldn't it be much cleaner if this returned a bool that says "I
found and substituted that 'part' you asked me to handle"?

> +static size_t format_person_part(struct strbuf *sb, char part,
>                                 const char *msg, int len)
>  {
> -	int start, end, tz = 0;
> -	unsigned long date;
> +	int start, end, tz = 0, end_of_data;
> +	unsigned long date = 0;
>  	char *ep;
>  
> -	/* parse name */
> +	/* advance 'end' to point to email start delimiter */
>  	for (end = 0; end < len && msg[end] != '<'; end++)
>  		; /* do nothing */
> +
>  	/*
>  	 * If it does not even have a '<' and '>', that is
>  	 * quite a bogus commit author and we discard it;
> @@ -301,65 +303,72 @@ static void format_person_part(struct strbuf *sb, char part,
>  	 * which means start (beginning of email address) must
>  	 * be strictly below len.
>  	 */
> -	start = end + 1;
> -	if (start >= len - 1)
> -		return;
> -	while (end > 0 && isspace(msg[end - 1]))
> -		end--;

The comment you can see in the context seems to refer to the
logic implemented by the part you are rewriting.  Don't you need
to update it?  Also the ealier part of the same comment talks
about safety against a malformed input and explains the "return;"
you are removing here.  It is not clear where that logic has
gone...

> +	end_of_data = (end >= len - 1);
> +

The variable name "end_of_data" is unclear.  What does this
boolean mean?  The line is without address and timestamp?
The item you are parsing is not properly terminated?

>  	if (part == 'n') {	/* name */
> -		strbuf_add(sb, msg, end);
> -		return;
> +		if (!end_of_data) {
> +			while (end > 0 && isspace(msg[end - 1]))
> +				end--;
> +			strbuf_add(sb, msg, end);
> +		}
> +		return 2;
>  	}
> +	start = ++end; /* save email start position */

What happens if end_of_data was already true in this case, I
have to wonder...  Language lawyers may point out that the
result of ++end would be undefined, which I do not personally
care about in this case, but this feels dirty if not wrong.

> @@ -451,23 +460,23 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
>  	/* these are independent of the commit */
>  	switch (placeholder[0]) {
>  	case 'C':
> -		switch (placeholder[3]) {
> -		case 'd':	/* red */
> +		if (!prefixcmp(placeholder + 1, "red")) {
>  			strbuf_addstr(sb, "\033[31m");
> -			return;
> -		case 'e':	/* green */
> +			return 4;
> +		} else if (!prefixcmp(placeholder + 1, "green")) {
>  			strbuf_addstr(sb, "\033[32m");
> -			return;
> -		case 'u':	/* blue */
> +			return 6;
> +		} else if (!prefixcmp(placeholder + 1, "blue")) {
>  			strbuf_addstr(sb, "\033[34m");
> -			return;
> -		case 's':	/* reset color */
> +			return 5;
> +		} else if (!prefixcmp(placeholder + 1, "reset")) {
>  			strbuf_addstr(sb, "\033[m");
> -			return;
> -		}
> +			return 6;
> +		} else
> +			return 0;

While these look much cleaner than using the magic "check the
third letter that happens to be unique" hack, the return values
can easily go out-of-sync.  I'd suggest to have a static array
of color names you support and iterate over it.

> @@ -528,66 +537,33 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
>  ...
>  void format_commit_message(const struct commit *commit,
>                             const void *format, struct strbuf *sb)
>  {
> -	const char *placeholders[] = {
> -		"H",		/* commit hash */
> ...
> -		"n",		/* newline */
> -		"m",		/* left/right/bottom */
> -		NULL
> -	};
>  	struct format_commit_context context;
>  
>  	memset(&context, 0, sizeof(context));
>  	context.commit = commit;
> -	strbuf_expand(sb, format, placeholders, format_commit_item, &context);
> +	strbuf_expand(sb, format, format_commit_item, &context);
>  }

This is much nicer.  We reduced duplicated data from our code.
