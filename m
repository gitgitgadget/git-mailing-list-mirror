From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: local URLs are not for ssh
Date: Mon, 14 Oct 2013 20:12:59 -0400
Message-ID: <20131015001259.GB10415@sigill.intra.peff.net>
References: <201309282137.21802.tboegi@web.de>
 <CACsJy8B-wA=bX6+E6O6UvX2vEtOwnR1PCMZNoi-q0x_jacB89Q@mail.gmail.com>
 <524C6885.8020602@web.de>
 <CACsJy8DjPiwpMvLe2p+dGBdpU6iTg2my7tddBsQwLnHiHdG8wQ@mail.gmail.com>
 <20131003013127.GA7917@sigill.intra.peff.net>
 <52506D15.9040206@web.de>
 <525AFBCC.4080303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 15 02:13:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVsGD-0007oT-Nu
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 02:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758065Ab3JOANG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Oct 2013 20:13:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:49411 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757614Ab3JOANC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 20:13:02 -0400
Received: (qmail 26202 invoked by uid 102); 15 Oct 2013 00:13:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Oct 2013 19:13:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Oct 2013 20:12:59 -0400
Content-Disposition: inline
In-Reply-To: <525AFBCC.4080303@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236155>

On Sun, Oct 13, 2013 at 10:00:12PM +0200, Torsten B=C3=B6gershausen wro=
te:

> On 05.10.13 21:48, Torsten B=C3=B6gershausen wrote:
> > On 2013-10-03 03.31, Jeff King wrote:
> >>
> >>   http://article.gmane.org/gmane.comp.version-control.git/235473
> What do we think about extending the test a little bit:

I never mind more tests, but note that my tests are now part of Duy's
8d3d28f, so you would want to build on top.

> diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec=
=2Esh
> index 3f353d9..790896f 100755
> --- a/t/t5602-clone-remote-exec.sh
> +++ b/t/t5602-clone-remote-exec.sh

Mine were in t5601...should these go there, too, or is there a reason t=
o
do it in t5602?

> +test_expect_success 'setup ssh wrapper' '
> [...]
> +clear_ssh () {
> [...]
> +expect_ssh () {

If we're going to put these in multiple spots, it may be time to factor
them out to lib-ssh.sh or similar (I _almost_ did in my initial patch,
but since there was only one caller, I refrained).

> +# git clone could fail, so break the && chain and ignore the exit co=
de
> +# clone local
> +test_expect_success './foo:bar is not ssh' '
> +	clear_ssh &&
> +	git clone "./foo:bar" foobar
> +	expect_ssh none
> +'

Please use test_might_fail instead of breaking the &&-chaining. I'm not
sure I understand why it might fail, though. If it is because foo:bar
does not exist, then please create it (and guard it appropriately with
"NOT_MINGW,NOT_CYGWIN" as the test in t5601 does). Or are we trying to
test the behavior when the path does not exist? In that case, I think w=
e
would want test_must_fail, along with expect_ssh (to make sure that we
couldn't proceed, but that we didn't try to use ssh).

> +test_expect_success './[nohost:123]:src is not ssh' '
> [...]
> +test_expect_success '[nohost:234] is not ssh' '
> [...]
> +test_expect_success ':345 is not ssh' '
> [...]
> +test_expect_success '456: is not ssh' '

These all make sense from to me (though I admit I did not even know
about the []-syntax until this thread, so there may be something I am
missing).

> +test_expect_success 'myhost:567 is ssh' '
> [...]
> +test_expect_success '[myhost:678]:src is ssh' '

These two are redundant with what's in t5601 already.

> +#clone url looks like ssh, but is on disk
> +test_expect_success SYMLINKS 'dir:123 on disk' '
> +	clear_ssh &&
> +	ln -s src.git dir:123 &&
> +	git clone dir:123 dir_123 &&
> +	expect_ssh none
> +'
> +
> +test_expect_success SYMLINKS '[dir:234]:src on disk' '
> +	clear_ssh &&
> +	ln -s src.git [dir:234]:src &&
> +	git clone [dir:234]:src dir_234_src &&
> +	expect_ssh none
> +'

I think you may need extra prerequisites here for systems that support
symlinks, but can't handle colons in paths (cygwin on a sane
filesystem?). Also, this first is redundant with what's in t5601 now, I
think.

> +test_expect_success 'ssh://host.xz/~user/repo' '
> [...]
> +test_expect_success 'ssh://host.xz:22/~user/repo' '
> [...]
> +test_expect_success 'ssh://[::1]:22/~user/repo' '

Looks sensible.

> And we need this on top of Duys patch:
>=20
> diff --git a/connect.c b/connect.c
> index e8473f3..09be2b3 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -611,7 +611,7 @@ struct child_process *git_connect(int fd[2], cons=
t char *url_orig,
>                 end =3D host;
> =20
>         path =3D strchr(end, c);
> -       if (path && !has_dos_drive_prefix(end)) {
> +       if (path && host !=3D path && !has_dos_drive_prefix(end)) {
>                 if (c =3D=3D ':') {
>        if (host !=3D url || path < strchrnul(host, '/')) {
>                                 protocol =3D PROTO_SSH;

I'm not clear on which case this was meant to affect. When you write a
commit message, it should be more obvious. ;) But you may also want to
introduce the battery of tests (most of which pass) in one commit, and
then have a follow-up which adds the new test (or flips it from
expect_failure to expect_success).

-Peff
