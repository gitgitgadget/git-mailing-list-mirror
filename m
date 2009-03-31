From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCHv3 1/6] pretty.c: add %f format specifier to format_commit_message()
Date: Wed, 01 Apr 2009 00:17:49 +0200
Message-ID: <49D2968D.6010108@lsrfire.ath.cx>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com> <cover.1237773604.git.bebarino@gmail.com> <baa327d88b54efae40b6d9df09a2fe482672101e.1237773604.git.bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:19:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LomIs-0005KX-5a
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 00:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744AbZCaWR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 18:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756520AbZCaWR6
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 18:17:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:60098 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbZCaWR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 18:17:58 -0400
Received: from [10.0.1.101] (p57B7F9E3.dip.t-dialin.net [87.183.249.227])
	by india601.server4you.de (Postfix) with ESMTPSA id 77E052F8044;
	Wed,  1 Apr 2009 00:17:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <baa327d88b54efae40b6d9df09a2fe482672101e.1237773604.git.bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115323>

Stephen Boyd schrieb:
> This specifier represents the sanitized and filename friendly subject
> line of a commit. No checks are made against the length of the string,
> so users may need to trim the result to the desired length if using as a
> filename. This is commonly used by format-patch to massage commit
> subjects into filenames and output patches to files.
> 
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>  Documentation/pretty-formats.txt |    1 +
>  pretty.c                         |   38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 5c6e678..2a845b1 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -121,6 +121,7 @@ The placeholders are:
>  - '%d': ref names, like the --decorate option of linkgit:git-log[1]
>  - '%e': encoding
>  - '%s': subject
> +- '%f': sanitized subject line, suitable for a filename
>  - '%b': body
>  - '%Cred': switch color to red
>  - '%Cgreen': switch color to green
> diff --git a/pretty.c b/pretty.c
> index efa7024..97de415 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -493,6 +493,41 @@ static void parse_commit_header(struct format_commit_context *context)
>  	context->commit_header_parsed = 1;
>  }
>  
> +static int istitlechar(char c)
> +{
> +	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
> +		(c >= '0' && c <= '9') || c == '.' || c == '_';

How about this?

	return isalnum(c) || c == '.' || c == '_';

> +}
> +
> +static void format_sanitized_subject(struct strbuf *sb, const char *msg)
> +{
> +	size_t trimlen;
> +	int space = 0;
> +
> +	for (; *msg && *msg != '\n'; msg++) {
> +		if (istitlechar(*msg))
> +		{
> +		    if (space) {
> +			strbuf_addch(sb, '-');
> +			space = 0;
> +		    }
> +		    strbuf_addch(sb, *msg);
> +		    if (*msg == '.')
> +			while (*(msg+1) == '.')
> +				msg++;
> +		}
> +		else
> +			space = 1;
> +	}
> +

> +	// trim any trailing '.' or '-' characters
> +	trimlen = 0;
> +	while (sb->buf[sb->len - 1 - trimlen] == '.'
> +		|| sb->buf[sb->len - 1 - trimlen] == '-')
> +		trimlen++;
> +	strbuf_remove(sb, sb->len - trimlen, trimlen);

You need to make sure that trimming stops as soon as the strbuf has been
shortened to its original length.  E.g. for a subject line of "..."
you'd access the char before the first dot currently, or sb->buf[-1] if
the strbuf was empty initially.

(One could also check for sb->len > 0 to just prevent the buffer
underrun, but %f sometimes eating preceding dots and dashes is
counter-intuitive to me.)

> +}
> +
>  const char *format_subject(struct strbuf *sb, const char *msg,
>  			   const char *line_separator)
>  {
> @@ -683,6 +718,9 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
>  	case 's':	/* subject */
>  		format_subject(sb, msg + c->subject_off, " ");
>  		return 1;
> +	case 'f':	/* sanitized subject */
> +		format_sanitized_subject(sb, msg + c->subject_off);
> +		return 1;
>  	case 'b':	/* body */
>  		strbuf_addstr(sb, msg + c->body_off);
>  		return 1;
