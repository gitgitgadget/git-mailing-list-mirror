From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv2 5/9] add generic terminal prompt function
Date: Thu, 15 Dec 2011 07:48:51 -0500
Message-ID: <20111215124851.GA6907@padd.com>
References: <20111210103943.GA16478@sigill.intra.peff.net>
 <20111210104101.GE16648@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 13:49:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbAkJ-0006mY-G9
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 13:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519Ab1LOMtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 07:49:04 -0500
Received: from honk.padd.com ([74.3.171.149]:49518 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932400Ab1LOMtB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 07:49:01 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 317F3278;
	Thu, 15 Dec 2011 04:49:00 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C558B31467; Thu, 15 Dec 2011 07:48:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20111210104101.GE16648@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187205>

peff@peff.net wrote on Sat, 10 Dec 2011 05:41 -0500:
> +static struct termios old_term;
> +
> +static void restore_term(void)
> +{
> +	if (term_fd < 0)
> +		return;
> +
> +	tcsetattr(term_fd, TCSAFLUSH, &old_term);
> +	term_fd = -1;
> +}

Restores from static old_term.

> +char *git_terminal_prompt(const char *prompt, int echo)
> +{
> +	static struct strbuf buf = STRBUF_INIT;
> +	int r;
> +	FILE *fh;
> +
> +	fh = fopen("/dev/tty", "w+");
> +	if (!fh)
> +		return NULL;
> +
> +	if (!echo) {
> +		struct termios t;
> +
> +		if (tcgetattr(fileno(fh), &t) < 0) {
> +			fclose(fh);
> +			return NULL;
> +		}
> +
> +		old_term = t;

Which is only saved if echo is true.

> +		term_fd = fileno(fh);
> +		sigchain_push_common(restore_term_on_signal);
> +
> +		t.c_lflag &= ~ECHO;
> +		if (tcsetattr(fileno(fh), TCSAFLUSH, &t) < 0) {
> +			term_fd = -1;
> +			fclose(fh);
> +			return NULL;
> +		}
> +	}
> +
> +	fputs(prompt, fh);
> +	fflush(fh);
> +
> +	r = strbuf_getline(&buf, fh, '\n');
> +	if (!echo) {
> +		putc('\n', fh);
> +		fflush(fh);
> +	}
> +
> +	restore_term();

Perhaps this line should go in !echo.

And why no sigchain_pop() for the signal handler?

		-- Pete
