From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 07/11] run-command: support input-fd
Date: Fri, 27 Nov 2009 21:14:13 +0100
Message-ID: <200911272114.13107.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <200911262253.59641.j6t@kdbg.org> <40aa078e0911270639n1de36517w5fdf6ef38e931b19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 27 21:14:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE7D5-000463-Gt
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 21:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbZK0UOU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 15:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbZK0UOU
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 15:14:20 -0500
Received: from [93.83.142.38] ([93.83.142.38]:63684 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751928AbZK0UOT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 15:14:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 30C7619F610;
	Fri, 27 Nov 2009 21:14:13 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e0911270639n1de36517w5fdf6ef38e931b19@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133931>

On Freitag, 27. November 2009, Erik Faye-Lund wrote:
> On Thu, Nov 26, 2009 at 10:53 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
> >> @@ -327,7 +327,10 @@ int start_async(struct async *async)
> >> =A0{
> >> =A0 =A0 =A0 int pipe_out[2];
> >>
> >> - =A0 =A0 if (pipe(pipe_out) < 0)
> >> + =A0 =A0 if (async->out) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pipe_out[0] =3D dup(async->out);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pipe_out[1] =3D dup(async->out);
> >> + =A0 =A0 } else if (pipe(pipe_out) < 0)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error("cannot create pipe: %s",=
 strerror(errno));
> >> =A0 =A0 =A0 async->out =3D pipe_out[0];
> >
> > Hm. If async->out !=3D 0:
> >
> > =A0 =A0 =A0 =A0pipe_out[0] =3D dup(async->out);
> > =A0 =A0 =A0 =A0async->out =3D pipe_out[0];
> >
> > This is confusing.
>
> What do you find confusing about it? The idea is to use a provided
> bi-directional fd instead of a pipe if async->out is non-zero. The
> currently defined rules for async is that async->out must be zero
> (since the structure should be zero-initialized).

It is just the code structure that is confusing. It should be

	if (async->out) {
		/* fd was provided */
		do all that is needed in this case
	} else {
		/* fd was requested */
		do all for this other case
	}
	/* nothing to do anymore here */

(Of course, this should only replace the part that is cited above, not =
the=20
whole function.)

> > Moreover, you are assigning (a dup of) the same fd to the writable =
end.
> > This assumes a bi-directional channel. I don't yet know what I shou=
ld
> > think about this (haven't studied the later patches, yet).
>
> Indeed it does. Do we want to extend it to support a set of
> unidirectional channels instead?

Yes, I think so. We could pass a regular int fd[2] array around with th=
e clear=20
definition that both can be closed independently, i.e. one must be a du=
p() of=20
the other. struct async would also have such an array.

Speaking of dup(): The underlying function is DuplicateHandle(), and it=
s=20
documentation says:

"You should not use DuplicateHandle to duplicate handles to the followi=
ng=20
objects: ... o Sockets. ... use WSADuplicateSocket."

But then the docs of WSADuplicateSocket() talk only about duplicating a=
 socket=20
to a separate process. Perhaps DuplicateHandle() of a socket within the=
 same=20
process Just Works?

-- Hannes
