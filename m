From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 5/9] add generic terminal prompt function
Date: Thu, 15 Dec 2011 08:39:39 -0500
Message-ID: <20111215133939.GA2241@sigill.intra.peff.net>
References: <20111210103943.GA16478@sigill.intra.peff.net>
 <20111210104101.GE16648@sigill.intra.peff.net>
 <20111215124851.GA6907@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 14:39:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbBXI-0006sE-1t
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 14:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab1LONjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 08:39:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50481
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022Ab1LONjm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 08:39:42 -0500
Received: (qmail 8428 invoked by uid 107); 15 Dec 2011 13:46:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Dec 2011 08:46:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2011 08:39:39 -0500
Content-Disposition: inline
In-Reply-To: <20111215124851.GA6907@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187206>

On Thu, Dec 15, 2011 at 07:48:51AM -0500, Pete Wyckoff wrote:

> peff@peff.net wrote on Sat, 10 Dec 2011 05:41 -0500:
> > +static struct termios old_term;
> > +
> > +static void restore_term(void)
> > +{
> > +	if (term_fd < 0)
> > +		return;
> > +
> > +	tcsetattr(term_fd, TCSAFLUSH, &old_term);
> > +	term_fd = -1;
> > +}
> 
> Restores from static old_term.

Right. But note that it is protected by term_fd being set.

> > +char *git_terminal_prompt(const char *prompt, int echo)
> > +{
> > +	static struct strbuf buf = STRBUF_INIT;
> > +	int r;
> > +	FILE *fh;
> > +
> > +	fh = fopen("/dev/tty", "w+");
> > +	if (!fh)
> > +		return NULL;
> > +
> > +	if (!echo) {
> > +		struct termios t;
> > +
> > +		if (tcgetattr(fileno(fh), &t) < 0) {
> > +			fclose(fh);
> > +			return NULL;
> > +		}
> > +
> > +		old_term = t;
> 
> Which is only saved if echo is true.

Yes, but just below:

> > +		term_fd = fileno(fh);
> > +		sigchain_push_common(restore_term_on_signal);

We set up term_fd, and then:

> > +		t.c_lflag &= ~ECHO;
> > +		if (tcsetattr(fileno(fh), TCSAFLUSH, &t) < 0) {
> > +			term_fd = -1;
> > +			fclose(fh);
> > +			return NULL;
> > +		}

On error, disable it again.

> > +	}
> > +
> > +	fputs(prompt, fh);
> > +	fflush(fh);
> > +
> > +	r = strbuf_getline(&buf, fh, '\n');
> > +	if (!echo) {
> > +		putc('\n', fh);
> > +		fflush(fh);
> > +	}
> > +
> > +	restore_term();
> 
> Perhaps this line should go in !echo.

It could, but it's a no-op as-is, as term_fd will be -1.

I agree it might be a little more obvious to put it there (I think what
happened is my initial revision did not look at "echo" ever again, and
then that conditional was added later when I realized that the "!echo"
case needed us to print the newline manually).

> And why no sigchain_pop() for the signal handler?

Because I used sigchain_push_common, which has no pop_common analog. But
it's OK, because calling restore_term sets term_fd to -1, making further
calls a no-op. So leaving the handler in place is fine.

Another option would be to add sigchain_pop_common, which pops the
same signals from push_common.

-Peff
