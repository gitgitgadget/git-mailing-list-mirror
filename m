From: Jeff King <peff@peff.net>
Subject: Re: git_getpass regression?
Date: Sat, 30 Jun 2012 14:36:07 -0400
Message-ID: <20120630183607.GA19739@sigill.intra.peff.net>
References: <CABPQNSa4uvgijjGCSJDXDMqHC3UkqQKKujG3xDFqnQ13LNrKdQ@mail.gmail.com>
 <20120629173954.GA3804@sigill.intra.peff.net>
 <CABPQNSZ4NhEA1CBiCBD_YNJZcnK8u=NtQ3PeDa5c0NDROPDyrQ@mail.gmail.com>
 <20120629203001.GA12937@sigill.intra.peff.net>
 <CABPQNSY3hJse6J7fDo0S5=ySZA4_7=JisfzLBUu135gR2nSF-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 20:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sl2XN-0005IX-J7
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jun 2012 20:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab2F3SgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jun 2012 14:36:13 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50631
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054Ab2F3SgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2012 14:36:12 -0400
Received: (qmail 25191 invoked by uid 107); 30 Jun 2012 18:36:15 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 30 Jun 2012 14:36:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Jun 2012 14:36:07 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSY3hJse6J7fDo0S5=ySZA4_7=JisfzLBUu135gR2nSF-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200836>

On Sat, Jun 30, 2012 at 01:27:09PM +0200, Erik Faye-Lund wrote:

> > If the backspacing doesn't work, then there is a configuration mism=
atch
> > between what linux's tty driver expects and what your terminal emul=
ator
> > is sending (the former is probably expecting ^? as the erase charac=
ter,
> > and the latter is sending ^H).
>=20
> The only thing I actually tested, was that getpass behaved correctly.
> I just assumed fgetc returned the input right away. I had no idea tha=
t
> fgetc didn't fetch characters until a whole line was entered. I guess
> you learn something every day ;)

I think this is one of those places where unix people like me take it
for granted that the world works one way, but it is completely foreign
for people coming from other systems. :)

> >> > If you run "stty erase ^H" and then run git, does it work?
> [...]
> But now, I see that "stty erase ^H" makes the terminal behave all
> strange when it comes to the backspace character; it starts printing
> "^?" instead.

OK. Then that implies your terminal is sending ^?, which is reasonable.
So I take it that everything is now working on your Linux box? Did you
figure out what caused the problems before?

> >> > =C2=A0I think (3) is the only sane thing,
> >> > though.
>=20
> Yes, you are right. But perhaps with one exception: we probably want
> to piggy-back on those terminal-handling goodies on Windows. If only
> to get git to behave more consistently with other applications.

Yeah, that makes sense. The idea of abstracting git_terminal_prompt was
to do whatever would make the most sense for user input on the given
platform; I just had no idea how to do that on Windows.

> So perhaps we should do something like this?

That looks like a good direction overall. I'm not really qualified to
comment on the Windows-specific bits, of course, but:

> +	if (!echo) {
> +		hconin =3D CreateFile("CONIN$", GENERIC_READ | GENERIC_WRITE,
> +		    FILE_SHARE_READ, NULL, OPEN_EXISTING,
> +		    FILE_ATTRIBUTE_NORMAL, NULL);
> +		if (hconin =3D=3D INVALID_HANDLE_VALUE) {
> +			fclose(input_fh);
> +			fclose(output_fh);
> +			return NULL;
> +		}
> +		GetConsoleMode(hconin, &cmode);
> +		if (!SetConsoleMode(hconin, cmode & (~ENABLE_ECHO_INPUT))) {
> +			fclose(input_fh);
> +			fclose(output_fh);
> +			return NULL;
> +		}

The HAVE_DEV_TTY version takes care to reset this on signal death or
premature exit (so if you ^C out of the program, your terminal is not
left in a funny state). You might want to do something similar here.

> +	r =3D strbuf_getline(&buf, input_fh, '\n');
> +	if (!echo) {
> +		putc('\n', output_fh);
> +		fflush(output_fh);
> +
> +		SetConsoleMode(hconin, cmode);
> +		CloseHandle(hconin);
> +	}
> +
> +	if (buf.buf[buf.len - 1] =3D=3D '\r')
> +		strbuf_setlen(&buf, buf.len - 1);

This will read random memory if buf.len =3D=3D 0 (no clue if that can e=
ver
happen on Windows, but it's nice to be defensive).

> Notice how this looks very similar to the HAVE_TTY code-path, with th=
e
> exception of needing two file handles instead of one, and the actual
> enabling/resetting of the prompt-setting. So the code-paths can
> probably be refactored to share code...

I'd be OK with leaving them separate, too. The shared parts are small
enough (and are mostly in strbuf_getline) that I think it might end up
less readable. But I'd withhold my judgement until seeing how good or
bad the refactored version looked. :)

> Yes, I absolutely agree. Sorry for getting confused and wasting your
> time with unfounded accusations.
>=20
> But perhaps something good came from it; the Windows-prompt doesn't
> support erasing until the patch above is applied. I don't know if you
> care or not, but I certainly do ;)

No problem at all. Progress usually starts with somebody wondering
whether and how something is broken.

-Peff
