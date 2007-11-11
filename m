From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Use the best available exec path only
Date: Sun, 11 Nov 2007 22:17:32 +0100
Message-ID: <20071111211732.GA11871@atjola.homenet>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com> <Pine.LNX.4.64.0711111557370.4362@racer.site> <FCFF59B3-D3F1-4BEB-B3C3-D07DD5D5D8EF@silverinsanity.com> <7v3avcefg9.fsf@gitster.siamese.dyndns.org> <20071111203318.GA32671@atjola.homenet> <Pine.LNX.4.64.0711112047170.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 22:17:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrKBk-0001bs-TC
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 22:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbXKKVRi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 16:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbXKKVRh
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 16:17:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:56907 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751701AbXKKVRh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 16:17:37 -0500
Received: (qmail invoked by alias); 11 Nov 2007 21:17:35 -0000
Received: from i577B84F1.versanet.de (EHLO localhost) [87.123.132.241]
  by mail.gmx.net (mp030) with SMTP; 11 Nov 2007 22:17:35 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+3U1ggWt+3mzYPvTAYpl1cownaEGOjhv3a0TPcgY
	I2H9ohC4iU+lg7
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711112047170.4362@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64515>

On 2007.11.11 20:50:40 +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Sun, 11 Nov 2007, Bj?rn Steinbrink wrote:
>=20
> > On 2007.11.11 11:43:02 -0800, Junio C Hamano wrote:
> > > Brian Gernhardt <benji@silverinsanity.com> writes:
> > >=20
> > > > I'm sorry, I should have been more clear.  I was referring to t=
he=20
> > > > GIT_EXEC_PATH build variable, not the environment variable.  Th=
e git=20
> > > > wrapper always adds the path determined during build to the fro=
nt of=20
> > > > PATH.  When I was changing my build script, this got set to "/u=
sr/=20
> > > > local/bin" (I usually use /usr/local/stow/git, instead).  Since=
 I=20
> > > > have a /usr/local/bin/vim, PATH for git-commit.sh during the te=
st=20
> > > > was:
> > > >
> > > > - my git build directory
> > > > - /usr/local/bin (containing a symlink vi -> vim)
> > > > - the t/trash directory, added by the test via `PATH=3D".:$PATH=
"`
> > > > (containing the test vi script)
> > > > - my normal path
> > >=20
> > > Maybe that is what is broken.  t/test-lib.sh makes the environmen=
t=20
> > > variable point at the build directory, and that should override t=
he=20
> > > path that is compiled in, shouldn't it?
> >=20
> > Maybe you prefer this patch then? "make test" survived up to 9101/2=
5,=20
> > but that fails with the current master anyway and I didn't bother t=
o run=20
> > the remaining tests manually, so it seems to be fine. Might break s=
ome=20
> > weird setups that rely on being able to set multiple additional pat=
hs=20
> > though (not that I think that that is a good idea to begin with).
> >=20
> > Bj?rn
> > ---
> > Instead of adding all possible exec paths to PATH, only add the bes=
t
> > one, following the same rules that --exec-path, without arguments, =
uses
> > to figure out which path to display.
> >=20
> > Signed-off-by: Bj?rn Steinbrink <B.Steinbrink@gmx.de>
> > ---
>=20
> For easy application by the maintainer, please make the commit messag=
e the=20
> first part, then have a single "---", and then the quoted mail.

OK.

> > diff --git a/exec_cmd.c b/exec_cmd.c
> > index 2d0a758..9c376ad 100644
> > --- a/exec_cmd.c
> > +++ b/exec_cmd.c
> > @@ -48,9 +48,7 @@ void setup_path(const char *cmd_path)
> > =20
> >  	strbuf_init(&new_path, 0);
> > =20
> > -	add_path(&new_path, argv_exec_path);
> > -	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
> > -	add_path(&new_path, builtin_exec_path);
> > +	add_path(&new_path, git_exec_path());
> >  	add_path(&new_path, cmd_path);
>=20
> I wonder why cmd_path is still there, then.  (I'd have expected somet=
hing=20
> like
>=20
> 	add_path(&new_path, cmd_path ? cmd_path : git_exec_path());

Wouldn't that break setups where only the "git" wrapper is in $PATH?
cmd_path is just the path to the called executable (argv[0]). As I read
the code, it seems that cmd_path is just a worst case fallback, when th=
e
"real" exec path is messed up somehow. I figured that I'd better keep
it, instead of just dropping it without knowing its intended purpose.
But if you're going to change anything about it, I'd guess that the onl=
y
option is to drop it, or change its relative position in PATH.

> In related news, IMO cmd_path should be made absolute if it is not al=
ready=20
> the case.

add_path() already takes care of that.

Bj=F6rn
