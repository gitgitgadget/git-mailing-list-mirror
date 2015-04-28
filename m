From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/5] setup: add gentle version of read_gitfile
Date: Tue, 28 Apr 2015 16:19:19 -0400
Message-ID: <20150428201918.GA10902@peff.net>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
 <1430030985-14499-2-git-send-email-erik.elfstrom@gmail.com>
 <20150428061741.GL24580@peff.net>
 <CAMpP7Nb3aiMoTjtPJNJPv38G54ZawS8B+NDX0x2iNe6FA-L+Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: erik =?utf-8?B?ZWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 22:19:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnByZ-0005Pu-N9
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 22:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965792AbbD1UTW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2015 16:19:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:51319 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965350AbbD1UTW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 16:19:22 -0400
Received: (qmail 7369 invoked by uid 102); 28 Apr 2015 20:19:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 15:19:21 -0500
Received: (qmail 19844 invoked by uid 107); 28 Apr 2015 20:19:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 16:19:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 16:19:19 -0400
Content-Disposition: inline
In-Reply-To: <CAMpP7Nb3aiMoTjtPJNJPv38G54ZawS8B+NDX0x2iNe6FA-L+Lw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267938>

On Tue, Apr 28, 2015 at 10:07:43PM +0200, erik elfstr=C3=B6m wrote:

> On Tue, Apr 28, 2015 at 8:17 AM, Jeff King <peff@peff.net> wrote:
> >
> > There was a discussion not too long ago on strategies for returning
> > errors, and one of the suggestions was to return an "error strbuf"
> > rather than a code[1]. That's less flexible, as the caller can't re=
act
> > differently based on the type of error. But for cases like this, wh=
ere
> > the only fate for the code is to get converted back into a message,
> > it can reduce the boilerplate.
> >
> > What you have here is OK to me, and I don't want to hold up your pa=
tch
> > series in a flamewar about error-reporting techniques. But I think =
it's
> > an interesting case study.
> >
> > -Peff
>=20
> Thanks. I haven't had time to look through that thread yet, I'll try
> to get to that later.
>=20
> My initial reaction is a bit skeptical though. For this case we
> currently don't want any error reporting, the NULL return is
> sufficient and even allocating and sending in the int* is pure noise.
> Allocating and releasing a strbuf seems like a lot more overhead for
> this type of caller? The one other potential candidate caller for
> read_gitfile_gently that I have seen (clone.c:get_repo_path) don't
> want any error code or message either as far as i can tell.

I had envisioned that the strbuf would be optional. I.e., you would
have:

  /* like error(), but dump the message in a strbuf instead of stderr *=
/
  int error_buf(struct strbuf *buf, const char *fmt, ...)
  {
	if (buf) {
		va_list ap;
		va_start(ap, fmt);
		strbuf_vaddf(buf, fmt, ap);
		va_end(ap);
	}
	return -1;
  }

and then in the error-reporting function:

  const char *read_gitfile_gently(const char *path, struct strbuf *err)
  {
	...
	fd =3D open(path, O_RDONLY);
	if (fd < 0) {
		error_buf(err, "unable to open %s: %s", path, strerror(errno));
		return NULL; /* or goto cleanup if necessary */
	}
  }

and then one caller can do:

  if (!read_gitfile_gently(path, NULL)) {
	/* we know there was an error, but we did not ask for details */
	...
  }

and the non-gentle read_gitfile() becomes:

  const char *read_gitfile(const char *path)
  {
	struct strbuf err =3D STRBUF_INIT;
	const char *ret =3D read_gitfile_gently(path, &err);
	if (!ret)
		die("%s", err.buf);
	/* no need to free err; if there was no error, nothing was written */
	return path;
  }

Note that the "return -1" from error_buf() is not useful here, but it
might be used as a shortcut in other situations (e.g., the same places
we call "return error()" now).

> Also if it turns out that we actually need to treat the "file too
> large" error differently in clean (as discussed in thread on the file
> size check) then we can no longer communicate that back using the
> strbuf interface.

Yeah, agreed. This system breaks down as soon as you need to
programatically know which error happened.

-Peff
