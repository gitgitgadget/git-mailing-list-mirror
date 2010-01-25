From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 22:42:39 +0100
Message-ID: <201001252242.40117.robin.rosenberg@dewire.com>
References: <201001250155.47664.robin.rosenberg@dewire.com> <201001252107.45745.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jan 25 22:44:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZWim-0002JU-Er
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 22:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929Ab0AYVmr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 16:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753935Ab0AYVmq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 16:42:46 -0500
Received: from mail.dewire.com ([83.140.172.130]:23564 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859Ab0AYVmo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 16:42:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DCE231025B79;
	Mon, 25 Jan 2010 22:42:42 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UXruBYUH+HtW; Mon, 25 Jan 2010 22:42:42 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 0DF261023036;
	Mon, 25 Jan 2010 22:42:42 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
In-Reply-To: <201001252107.45745.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137997>

m=E5ndagen den 25 januari 2010 21.07.44 skrev  Johannes Sixt:
> On Montag, 25. Januar 2010, Robin Rosenberg wrote:
> > In Windows paths beginning with // are knows as UNC paths. They are
> > absolute paths, usually referring to a shared resource on a server.
> >
> > Examples of legal UNC paths
> >
> > 	\\hub\repos\repo
> > 	\\?\unc\hub\repos
> > 	\\?\d:\repo
>=20
> I agree that that the problem that you are addressing needs a solutio=
n.
>=20
> However, the solution is not a whole-sale replacement of
> have_dos_drive_prefix() by a function that is only a tiny bit fancier=
=2E
> Accompanying changes are needed, and perhaps more code locations need
>  change.

I was hoping to get help in identifying these and perhaps more cases to=
 test
than then ones I thought of at first.

> > @@ -648,7 +648,7 @@ int safe_create_leading_directories_const(const=
 char
> > *path);
> >  char *enter_repo(char *path, int strict);
> >  static inline int is_absolute_path(const char *path)
> >  {
> > -	return path[0] =3D=3D '/' || has_dos_drive_prefix(path);
> > +	return path[0] =3D=3D '/' || has_win32_abs_prefix(path);
>=20
> Perhaps we need is_dir_sep(path[0]) here? But since I have not observ=
ed any
> breakage in connection with this code, I think that all callers feed =
only
> normalized paths (i.e. with forward slash). (Note that our getcwd()
probably true.

> implementation converts backslashes to forward slashes.) This means t=
hat a
> full-fledged check is not needed.
ack.

> > @@ -5,7 +5,7 @@ char *gitbasename (char *path)
> >  {
> >  	const char *base;
> >  	/* Skip over the disk name in MSDOS pathnames. */
> > -	if (has_dos_drive_prefix(path))
> > +	if (has_win32_abs_prefix(path))
> >  		path +=3D 2;
>=20
> This change is unnecessary; it really is only to skip an initial driv=
er
> prefix. If you want to support \\?\X: style paths, more work is neede=
d here
> so that you do not return X: or ? as the basename.

late night hacks aren't always good.

> > +#define has_win32_abs_prefix(path) \
>=20
> Do we really have to name everything "win32" when it is about Windows=
?
hmm

> > @@ -535,7 +535,7 @@ struct child_process *git_connect(int fd[2], co=
nst
> > char *url_orig,
> >  		end =3D host;
> >
> >  	path =3D strchr(end, c);
> > -	if (path && !has_dos_drive_prefix(end)) {
> > +	if (path && !has_win32_abs_prefix(end)) {
>=20
> This change is wrong because the check is really only about the drive
>  prefix: It checks that we do not mistake c:/foo as a ssh connection =
to
>  host c, path /foo. Yes, it does mean that on Windows we cannot have
>  remotes to hosts whose name consists only of a single letter using t=
he rcp
>  notation (you must say ssh://c/foo if you mean it).
right.

> > @@ -409,7 +409,7 @@ int normalize_path_copy(char *dst, const char *=
src)
> >  {
> >  	char *dst0;
> >
> > -	if (has_dos_drive_prefix(src)) {
> > +	if (has_win32_abs_prefix(src)) {
> >  		*dst++ =3D *src++;
> >  		*dst++ =3D *src++;
> >  	}
>=20
> Is skipping just two characters for \\ or \\?\whatever paths the righ=
t
>  thing?
I shouldn't skip anything. I wasn't converting the first two \'s to //.

> > @@ -342,7 +342,7 @@ const char *setup_git_directory_gently(int
> > *nongit_ok) die_errno("Unable to read current working directory");
> >
> >  	ceil_offset =3D longest_ancestor_length(cwd, env_ceiling_dirs);
> > -	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
> > +	if (ceil_offset < 0 && has_win32_abs_prefix(cwd))
> >  		ceil_offset =3D 1;
>=20
> I doubt that this is correct. The purpose of this check is that "c:/"=
 is
>  the last directory that is checked (on Unix it would be "/") when pa=
th
>  components are stripped from cwd. For UNC paths this must be adjuste=
d
>  depending on how you want to support \\server\share and \\?\c:\paths=
: You
>  do not want to check whether \\server\.git or \\.git or \\?\.git are=
 git
>  directories.

\\server\.git seems valid. Probably not a good idea, but who am I to ju=
dge?

>=20
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -797,7 +797,7 @@ static int is_local(const char *url)
> >  	const char *colon =3D strchr(url, ':');
> >  	const char *slash =3D strchr(url, '/');
> >  	return !colon || (slash && slash < colon) ||
> > -		has_dos_drive_prefix(url);
> > +		has_win32_abs_prefix(url);
>=20
> This check is again to not mistake c:/foo as rcp style connection. No
>  change needed.
>=20
> As I said, changes to other parts are perhaps also needed, most
>  prominently, make_relative_path() that prompted this patch. What abo=
ut
> make_absolute_path() and make_non_relative_path()?

Thanks for the feedback.=20

-- robin
