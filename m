From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] add interface for /dev/tty interaction
Date: Sun, 05 Aug 2012 13:11:47 -0700
Message-ID: <7vsjc12j5o.fsf@alter.siamese.dyndns.org>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1344192340-19415-1-git-send-email-rctay89@gmail.com>
 <1344192340-19415-2-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 22:12:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy7Bl-0004mP-FW
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 22:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894Ab2HEULu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 16:11:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35999 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754772Ab2HEULu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 16:11:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 992B79C09;
	Sun,  5 Aug 2012 16:11:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dPWcK/CKZE1jxL6niuP/RjzHAFs=; b=kuWW00
	HbhQW7VbCPu28Sjii7zY8Hm7H5RVhe1W+N1o7av2w5ZSgHvh6EHjTD6kgxuagDX2
	8VMxG1btYnzEzYpkH9JYmuoLvhc5NTfBuL/oHA/0DX4jWm/ihz25l/MPVytYWlzA
	DOqNfBIbyERHTzliGmtIQF8pK4Lrf+C1tOA/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IofBDuWSuOJwbUyjQvfVkAdveqUqfTT0
	psoNN8i0Q0Ko7NPpHoefBvUzzzXO+vHTOGUySB6I1+EzzW4jHhLHKKSgmhIBem+5
	f8toYf+b0zjpkc+xnSQB0KyA1PfQwxvN2tTEvhaZIcwYOAkhABzX/7fBD/22TjG9
	et05jxPY5EM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 870D89C07;
	Sun,  5 Aug 2012 16:11:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B38CC9C05; Sun,  5 Aug 2012
 16:11:48 -0400 (EDT)
In-Reply-To: <1344192340-19415-2-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Mon, 6 Aug 2012 02:45:39 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9ABC320-DF39-11E1-83A1-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202921>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Factor out the opening and closing of /dev/tty from
> git_terminal_prompt(), so that callers may first test if a controlling
> terminal is available before proceeding with prompting proper.
>
> When HAVE_DEV_TTY is not defined, terminal_open() falls back to checking
> tty-ness of stdin and stderr, as getpass() uses them both.
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---

This is not your fault but seeing term_t made me go "eek, yuck".

As far as I can see, use of "FILE *" in existing compat/terminal.c
is not buying us anything useful.  The stdio calls made on FILE *fh
are only fopen(), fputs(), fflush() and fclose(), and everything
else goes through fileno(fh).

So perhaps it is a saner approach to fix that function first before
this patch so that it works on file descriptors.

>  compat/terminal.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--------
>  compat/terminal.h | 10 ++++++++++
>  2 files changed, 54 insertions(+), 8 deletions(-)
>
> diff --git a/compat/terminal.c b/compat/terminal.c
> index 6d16c8f..c85d5c7 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -24,15 +24,21 @@ static void restore_term_on_signal(int sig)
>  	raise(sig);
>  }
>  
> -char *git_terminal_prompt(const char *prompt, int echo)
> +term_t terminal_open(void)
> +{
> +	return fopen("/dev/tty", "w+");
> +}
> +
> +int terminal_close(term_t term)
> +{
> +	return fclose(term);
> +}
> +
> +char *terminal_prompt(term_t term, const char *prompt, int echo)
>  {
>  	static struct strbuf buf = STRBUF_INIT;
>  	int r;
> -	FILE *fh;
> -
> -	fh = fopen("/dev/tty", "w+");
> -	if (!fh)
> -		return NULL;
> +	FILE *fh = term;
>  
>  	if (!echo) {
>  		struct termios t;
> @@ -64,18 +70,48 @@ char *git_terminal_prompt(const char *prompt, int echo)
>  	}
>  
>  	restore_term();
> -	fclose(fh);
>  
>  	if (r == EOF)
>  		return NULL;
>  	return buf.buf;
>  }
>  
> +char *git_terminal_prompt(const char *prompt, int echo)
> +{
> +	char *ret;
> +	term_t term;
> +
> +	term = terminal_open();
> +	if (!term)
> +		return NULL;
> +
> +	ret = terminal_prompt(term, prompt, echo);
> +
> +	terminal_close(term);
> +
> +	return ret;
> +}
> +
>  #else
>  
> -char *git_terminal_prompt(const char *prompt, int echo)
> +term_t terminal_open()
> +{
> +	return isatty(0) && isatty(2);
> +}
> +
> +int terminal_close(term_t term)
> +{
> +	return 0;
> +}
> +
> +char *terminal_prompt(term_t term, const char *prompt, int echo)
>  {
>  	return getpass(prompt);
>  }
>  
> +char *git_terminal_prompt(const char *prompt, int echo)
> +{
> +	return terminal_prompt(prompt, echo);
> +}
> +
>  #endif
> diff --git a/compat/terminal.h b/compat/terminal.h
> index 97db7cd..cf2aa10 100644
> --- a/compat/terminal.h
> +++ b/compat/terminal.h
> @@ -1,6 +1,16 @@
>  #ifndef COMPAT_TERMINAL_H
>  #define COMPAT_TERMINAL_H
>  
> +#ifdef HAVE_DEV_TTY
> +typedef FILE *term_t;
> +#else
> +typedef int term_t;
> +#endif
> +
> +term_t terminal_open();
> +int terminal_close(term_t term);
> +char *terminal_prompt(term_t term, const char *prompt, int echo);
> +
>  char *git_terminal_prompt(const char *prompt, int echo);
>  
>  #endif /* COMPAT_TERMINAL_H */
