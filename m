From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] add git-quote: shell and C quoting tool
Date: Sun, 23 Jul 2006 22:49:53 -0700
Message-ID: <7vwta3h7r2.fsf@assigned-by-dhcp.cox.net>
References: <20060716222757.GA10135@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 24 07:50:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4tKY-0006Zw-Gh
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 07:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWGXFt4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 01:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWGXFt4
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 01:49:56 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37102 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751405AbWGXFtz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 01:49:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060724054954.PTYM22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Jul 2006 01:49:54 -0400
To: fork0@t-online.de (Alex Riesen)
In-Reply-To: <20060716222757.GA10135@steel.home> (Alex Riesen's message of
	"Mon, 17 Jul 2006 00:27:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24114>

fork0@t-online.de (Alex Riesen) writes:

> In case anyone asks why isn't it a standalone tool nor is it put into
> git-stripspace: I don't know. Maybe it should be.

This organization is fine by me.

 * unquote?
 * doc?

> +enum {SHELL_QUOTE, C_QUOTE};
> +static int style = SHELL_QUOTE,
> +	   use_stdin = 0;

Shouldn't style be of type which is that unnamed enum?

> +static const char *separator = NULL; /* default is space */
> +static unsigned sep_len = 0;

It is not clear if this is separator of input side or output
side (after reading the code it becomes somewhat obvious that
you are talking about output separator), and if the default is
space wouldn't it make more sense to set that here?

> +static const char builtin_quote_usage[] =
> +"git-quote [--c] [--sep=<c-quoted> | -z] ( [--stdin] | [--] ... )";
> +
> +static void print_quoted(const char *text)
> +{
> +	switch (style)
> +	{
> +	case SHELL_QUOTE:
> +		sq_quote_print(stdout, text);
> +		break;
> +	case C_QUOTE:
> +		quote_c_style(text, NULL, stdout, 0);
> +		break;
> +	}

Not a big deal but aren't these going to write out things quoted
when they do not need to?  To help scripts, it might be worth
adding "check if this needs quoting" interface perhaps?

> +int cmd_quote(int argc, const char **argv, char **envp)
> +{
> +	int i;
> +	for (i = 1; i < argc; i++) {
> +		const char *arg = argv[i];
> +
> +		if (arg[0] != '-')
> +			break;
> +		if (!strcmp(arg, "--")) {
> +			i++;
> +			break;
> +		}
> +		if (!strcmp(arg, "--stdin")) {
> +			use_stdin = 1;
> +			if ( !separator ) {
> +				separator = "\n";
> +				sep_len = 1;
> +			}
> +			break;
> +		}
> +		if (!strcmp(arg, "--c")) {

Perhaps "--c-style" with "-c" as a shorthand, (and
"--shell-style" with "-s" to complement)?

> +			style = C_QUOTE;
> +			continue;
> +		}
> +		if (!strcmp(arg, "-z")) {
> +			separator = "";
> +			sep_len = 1;
> +			continue;
> +		}

Is it plausible that somebody might want to feed you NUL
terminated sequence as input (iow you might want to give them
choice of separator on the input side)?

> +		if (!strncmp(arg, "--sep=", 6)) {

Perhaps "--separator" (or "--output-separator") with whatever
shorthand is handy?

> +			const char *end;
> +			char *tmp;
> +			arg += 6;
> +			if ('"' == *arg)
> +				tmp = strdup(arg);
> +			else {
> +				size_t l = strlen(arg);
> +				tmp = malloc(l + 3);
> +				sprintf(tmp, "\"%s\"", arg);
> +			}
> +			separator = unquote_c_style(tmp, &end);
> +			sep_len = strlen(separator);

If the parameter is a malformed c-quoted string, you would dump
core here.

> +			/* this will leak if multiple --sep= given */
> +			continue;
> +		}
> +		die(builtin_quote_usage);
> +	}
> +	if (!separator) {
> +		sep_len = 1;
> +		separator = "\x20";

Any reason you needed to spell it in hex?  Is this trying to
be portable to EBCDIC (or trying to prevent the code to be
ported there)?  I dunno.

> +	}
> +	if (use_stdin) {
> +		size_t size = BUFSIZ;
> +		char *buf = xmalloc(size);
> +		int ch, pos = 0;
> +		while (EOF != (ch = fgetc(stdin))) {
> +			if (pos == size)
> +				buf = xrealloc(buf, size <<= 1);
> +			buf[pos++] = ch;
> +			if ('\n' == ch) {
> +				buf[--pos] = '\0';
> +				pos = 0;
> +				print_quoted(buf);
> +			}
> +		}

Looks similar to strbuf.c::read_line() loop...
