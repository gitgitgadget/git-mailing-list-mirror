From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 20:45:28 +0100
Message-ID: <201001252045.28778.robin.rosenberg@dewire.com>
References: <201001250155.47664.robin.rosenberg@dewire.com> <alpine.DEB.1.00.1001251553150.8733@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 20:48:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZUsT-0003Um-C1
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 20:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab0AYTpe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 14:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908Ab0AYTpd
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 14:45:33 -0500
Received: from mail.dewire.com ([83.140.172.130]:20629 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab0AYTpd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 14:45:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EB3801025B79;
	Mon, 25 Jan 2010 20:45:31 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRbiXJdKh7S7; Mon, 25 Jan 2010 20:45:31 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id C87EF80034C;
	Mon, 25 Jan 2010 20:45:30 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
In-Reply-To: <alpine.DEB.1.00.1001251553150.8733@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137984>

m=E5ndagen den 25 januari 2010 18.34.01 skrev  Johannes Schindelin:
> Hi,
>=20
> On Mon, 25 Jan 2010, Robin Rosenberg wrote:
> > >From 37a74ccd395d91e5662665ca49d7f4ec49811de0 Mon Sep 17 00:00:00 =
2001
> >
> > From: Robin Rosenberg <robin.rosenberg@dewire.com>
> > Date: Mon, 25 Jan 2010 01:41:03 +0100
> > Subject: [PATCH] Handle UNC paths everywhere
> >
> > In Windows paths beginning with // are knows as UNC paths. They are
> > absolute paths, usually referring to a shared resource on a server.
>=20
> And even a simple "cd" with them does not work.
>=20
> > Examples of legal UNC paths
> >
> > 	\\hub\repos\repo
> > 	\\?\unc\hub\repos
> > 	\\?\d:\repo
> >
> > Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> > ---
> >  cache.h           |    2 +-
> >  compat/basename.c |    2 +-
> >  compat/mingw.h    |    8 +++++++-
> >  connect.c         |    2 +-
> >  git-compat-util.h |    9 +++++++++
> >  path.c            |    2 +-
> >  setup.c           |    2 +-
> >  sha1_file.c       |   20 ++++++++++++++++++++
> >  transport.c       |    2 +-
> >  9 files changed, 42 insertions(+), 7 deletions(-)
>=20
> Ouch.  You should know better than to clutter non-Windows-specific pa=
rts
> with that ugly kludge.
>=20
> > diff --git a/cache.h b/cache.h
> > index 767a50e..8f63640 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -648,7 +648,7 @@ int safe_create_leading_directories_const(const=
 char
> > *path);
> >  char *enter_repo(char *path, int strict);
> >  static inline int is_absolute_path(const char *path)
> >  {
> > -	return path[0] =3D=3D '/' || has_dos_drive_prefix(path);
> > +	return path[0] =3D=3D '/' || has_win32_abs_prefix(path);
>=20
> Why?  We can still keep the name.  Well, maybe not, see below.

I do think function names should imply something about their behaviour.

>=20
> > diff --git a/compat/mingw.h b/compat/mingw.h
> > index 1b528da..d1aa8be 100644
> > --- a/compat/mingw.h
> > +++ b/compat/mingw.h
> > @@ -210,7 +210,13 @@ int winansi_fprintf(FILE *stream, const char
> > *format, ...) __attribute__((format
> >   * git specific compatibility
> >   */
> >
> > -#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] =
=3D=3D
> > ':') +#define has_dos_drive_prefix(path) \
> > +	(isalpha(*(path)) && (path)[1] =3D=3D ':')
>=20
> Why?

To avoid very long lines and format this (now) set of related macros=20
uniformely.

> > +#define has_unc_prefix(path) \
> > +	(is_dir_sep((path)[0]) && is_dir_sep((path)[1]))
> > +#define has_win32_abs_prefix(path) \
> > +	(has_dos_drive_prefix(path) || has_unc_prefix(path))
>=20
> "c:hello.txt" is not an absolute path.
Ok. Nevertheless that was how it was treated before, It's not relative,
either, but some quasirelative thing. has_win32_quasi_abs_prefix?

> > diff --git a/connect.c b/connect.c
> > index 7945e38..9d4556c 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -535,7 +535,7 @@ struct child_process *git_connect(int fd[2], co=
nst
> > char *url_orig,
> >  		end =3D host;
> >
> >  	path =3D strchr(end, c);
> > -	if (path && !has_dos_drive_prefix(end)) {
> > +	if (path && !has_win32_abs_prefix(end)) {
> >  		if (c =3D=3D ':') {
>=20
> Why?  Do we really have to exclude UNC paths from that ":" handling?

That colon is about URL-ish things... Right.

> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index ef60803..0de9dac 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -170,6 +170,15 @@ extern char *gitbasename(char *);
> >  #define has_dos_drive_prefix(path) 0
> >  #endif
> >
> > +#ifndef has_unc_prefix
> > +#define has_unc_prefix(path) 0
> > +#endif
> > +
> > +#ifndef has_win32_abs_prefix
> > +#error no abs
ouch, a leftover from trying to figure out a complation message.=20

>=20
> Yeah, sure.  I do have abs, thank you very much.
>=20
> In general, I am _very_ worried about your patch.  It does not acknow=
ledge
> that there is a fundamental difference between DOS drive prefixes and=
 UNC
> paths, and not being able to "cd" to the latter is just a symptom.

As I said. Most programs including bash, but excluding cmd.exe can set =
the
working directory to an UNC path. I cannot fix cmd.exe and rarely use i=
t
with git, but the patch helps even if you cannot cd from a UNC challeng=
ed
shell.

> I am also not quite sure if you can get away with having the same off=
set
> for both: if I have "C:\blah" and strip off "C:", I always have a
> directory separator to bounce against, whereas I do not have that if =
I
> strip off the two "\\" of a UNC path.  Besides, I maintain that the h=
ost
> name, and maybe even the share name, should not ever be stripped off!

When creating directoties you only strip them off for the purpose of fi=
nding
paths to mkdir. The server and share part you cannot mkdir anyway, they
must exist before attempting to create a directory, hence I skip past t=
hose =20
portions. As for the \-less path beginning with a drive I'll reconsider=
=2E I did
not test that one.

-- robin
