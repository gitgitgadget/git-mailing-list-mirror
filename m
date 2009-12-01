From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 5/6] stg mail: add basic support for git send-email
Date: Mon, 30 Nov 2009 17:00:48 -0700
Message-ID: <20091201000048.GL12733@ldl.fc.hp.com>
References: <20091128194056.949.88791.stgit@bob.kio> <20091128195037.949.63611.stgit@bob.kio> <b8197bcb0911291354m674d3698m929a1d542a59ed9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 01:00:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFGAn-0005m0-SD
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 01:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbZLAAAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2009 19:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbZLAAAm
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 19:00:42 -0500
Received: from g4t0017.houston.hp.com ([15.201.24.20]:47738 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926AbZLAAAm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 19:00:42 -0500
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
	by g4t0017.houston.hp.com (Postfix) with ESMTP id AEDC83811C;
	Tue,  1 Dec 2009 00:00:48 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g1t0038.austin.hp.com (Postfix) with ESMTP id 88E2130058;
	Tue,  1 Dec 2009 00:00:48 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 6C9E3CF000D;
	Mon, 30 Nov 2009 17:00:48 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z-5q7mUlGXtN; Mon, 30 Nov 2009 17:00:48 -0700 (MST)
Received: by ldl (Postfix, from userid 17609)
	id 57432CF0007; Mon, 30 Nov 2009 17:00:48 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <b8197bcb0911291354m674d3698m929a1d542a59ed9f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134151>

* Karl Wiberg <kha@treskal.com>:
> On Sat, Nov 28, 2009 at 8:50 PM, Alex Chiang <achiang@hp.com> wrote:
>=20
> > + =A0 =A0# XXX: yuck, there's gotta be a more pythonic way. Ideally=
 we'd like
> > + =A0 =A0# to use the git_opts dictionary as our mapping between st=
g mail and
> > + =A0 =A0# git send-email; extract k, v pairs from git_opts, and us=
e those
> > + =A0 =A0# to iterate across options somehow.
> > + =A0 =A0git_opts =3D { 'to': '--to=3D', 'cc': '--cc=3D', 'bcc': '-=
-bcc=3D' }
> > + =A0 =A0if options.to:
> > + =A0 =A0 =A0 =A0for a in options.to:
> > + =A0 =A0 =A0 =A0 =A0 =A0cmd.append("--to=3D%s" % a)
> > + =A0 =A0if options.cc:
> > + =A0 =A0 =A0 =A0for a in options.cc:
> > + =A0 =A0 =A0 =A0 =A0 =A0cmd.append("--cc=3D%s" % a)
> > + =A0 =A0if options.bcc:
> > + =A0 =A0 =A0 =A0for a in options.bcc:
> > + =A0 =A0 =A0 =A0 =A0 =A0cmd.append("--bcc=3D%s" % a)
> > + =A0 =A0if not options.auto:
> > + =A0 =A0 =A0 =A0cmd.append("--suppress-cc=3Dbody")
>=20
> Like this?
>=20
> for x in ['to', 'cc', 'bcc']:
>     if getattr(options, x):
>         cmd.extend('--%s=3D%s' % (x, a) for a in getattr(options, x))

Yeah, that looks nice. Re-implemented with your suggestion.

> > + =A0 =A0(fd, path) =3D mkstemp()
> > + =A0 =A0os.write(fd, msg.as_string(options.mbox))
> > + =A0 =A0os.close(fd)
> > +
> > + =A0 =A0try:
> > + =A0 =A0 =A0 =A0cmd.append(path)
> > + =A0 =A0 =A0 =A0call(cmd)
> > + =A0 =A0except Exception, err:
> > + =A0 =A0 =A0 =A0os.unlink(path)
> > + =A0 =A0 =A0 =A0raise CmdException, str(err)
> > +
> > + =A0 =A0os.unlink(path)
>=20
> To avoid having to remember to call unlink in all paths, you can writ=
e
>=20
> try:
>     try:
>         cmd.append(path)
>         call(cmd)
>     except Exception, e:
>         raise CmdException(str(e))
> finally:
>     os.unlink(path)
>=20
> (The combined try...except...finally statement didn't appear until
> python 2.5, but we'd like to stay compatible with 2.4.)

This statement confuses me a bit. The way I read it, I shouldn't
use your suggestion due to compat reasons?

Thanks,
/ac
