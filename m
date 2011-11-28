From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] echo usernames as they are typed
Date: Sun, 27 Nov 2011 22:53:21 -0500
Message-ID: <20111128035321.GA15640@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111127082744.GA32068@sigill.intra.peff.net>
 <CABPQNSb09kxjvdvz2P-WqU2VtMspaaA8ujTNLJ4+MuCrV=2zsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 04:53:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUsHZ-0002tQ-O7
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 04:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624Ab1K1DxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 22:53:24 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53886
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab1K1DxY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 22:53:24 -0500
Received: (qmail 19467 invoked by uid 107); 28 Nov 2011 03:59:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 27 Nov 2011 22:59:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Nov 2011 22:53:21 -0500
Content-Disposition: inline
In-Reply-To: <CABPQNSb09kxjvdvz2P-WqU2VtMspaaA8ujTNLJ4+MuCrV=2zsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185999>

On Sun, Nov 27, 2011 at 10:17:26AM +0100, Erik Faye-Lund wrote:

> > And here's something I've been meaning to do on top: actually echo
> > characters at the username prompt. We can't do this portably, but we can
> > at least stub out a compatibility layer and let each system do something
> > sensible.
>
> Interesting, I've been working on something pretty similar: getting
> rid of getpass usage all together:
> 
> https://github.com/kusma/git/tree/work/askpass
> 
> My reason to write a getpass replacement was to avoid capping input to
> PASS_MAX, which can be as low as 8 characters (and AFAIK is just that
> on Solaris)...

Yeah, if there are really bad getpass implementations, we would want to
work around them. If we are going to do so, it might make sense to
combine the effort with my getpass_echo wrapper, as they are really the
same function, modulo tweaking the echo settings.

It would also be nice to make getpass a little more predictable. If
/dev/tty can't be opened, glibc's getpass will fall back to writing the
prompt to stderr and reading the password from stdin. But we definitely
don't want to do that in git-remote-curl, where stdin is already talking
a special protocol with the parent fetch process.

So I think it might be best to just write our own getpass. However,
your implementation looks wrong to me:

> diff --git a/password.c b/password.c
> new file mode 100644
> index 0000000..727ed84
> --- /dev/null
> +++ b/password.c
> @@ -0,0 +1,94 @@
> +#include "cache.h"
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +#include "run-command.h"
> +
> +#ifndef WIN32
> +
> +static void ask_password(struct strbuf *sb, const char *prompt)
> +{
> +	struct termios attr;
> +	tcflag_t c_lflag;
> +
> +	if (tcgetattr(1, &attr) < 0)
> +		die("tcgetattr failed!");
> +	c_lflag = attr.c_lflag;

This is getting the terminal attributes for stdout. But in many
cases, stdout will not be connected to the terminal (in particular,
remote-curl, as I mentioned above, will have its stdio connected to the
parent fetch process).  Stderr is a better guess, as you do here:

> +	fputs(prompt, stderr);

but even that is not foolproof. With getpass(), this should work:

  git clone ... 2>errors

with the prompt going to the terminal. But it doesn't with your patch.

You really want to open "/dev/tty" on most Unix systems (which is what
getpass() does). I have no idea what would be appropriate on Windows.

> +	for (;;) {
> +		int c = getchar();
> +		if (c == EOF || c == '\n')
> +			break;
> +		strbuf_addch(sb, c);
> +	}

And this is even worse. You're reading from stdin, which will get
whatever cruft is in the pipe coming from the parent process (or may
even cause a hang, as the parent is probably blocking waiting to read
from the child helper).

-Peff
