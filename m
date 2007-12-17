From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git.c option parsing
Date: Mon, 17 Dec 2007 10:20:13 +0100
Message-ID: <20071217092013.GD7453@artemis.madism.org>
References: <1197631424-52586-1-git-send-email-win@wincent.com> <1197631424-52586-2-git-send-email-win@wincent.com> <7vejdml92c.fsf@gitster.siamese.dyndns.org> <F6F3247E-4E71-4977-9626-F0571278E1E6@wincent.com> <7vsl21aeqw.fsf@gitster.siamese.dyndns.org> <25018761-80E8-410C-BB18-DD799F58308A@wincent.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="oj4kGyHlBMXGt3Le";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 10:20:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4C9V-0000gx-WE
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 10:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbXLQJUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 04:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbXLQJUR
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 04:20:17 -0500
Received: from pan.madism.org ([88.191.52.104]:50662 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753619AbXLQJUP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 04:20:15 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2F2142BC7A;
	Mon, 17 Dec 2007 10:20:14 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 739943ECE; Mon, 17 Dec 2007 10:20:13 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <25018761-80E8-410C-BB18-DD799F58308A@wincent.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68527>


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 09:01:56AM +0000, Wincent Colaiuta wrote:
> El 17/12/2007, a las 9:48, Junio C Hamano escribi=C3=B3:
>=20
> >Wincent Colaiuta <win@wincent.com> writes:
> >
> >>Of course, the above plan will only work for builtins, not for
> >>scripts. An additional step would be needed to enable scripts to
> >>handle these options; perhaps teaching "git rev-parse" something...
> >
> >As long as special options stay special and we make a rule not to allow
> >any subcommand to assign its own meaning to them, the git wrapper can
> >lookahead and reorder, when seeing a command line:
> >
> >	git scripted-command --special
> >
> >into
> >
> >	git --special scripted-command
> >
> >And that approach would work well for built-ins as well, I would
> >imagine.
>=20
> Yes, and it would be simpler to implement also. The only downside is that=
=20
> without all the other proposed changes things like "git-dashed --special"=
=20
> wouldn't work; only teaching the builtins to actually handle the special=
=20
> options would work in that case. And in the interests of consistency I=20
> think it's pretty important that "git subcommand --special" and=20
> "git-subcommand --special" both work the same as the user would=20
> (reasonably) expect them to...

  There is a simple way to do that, that wouldn't conflict with the git
grep -e one, that would be to define an array of "Special" flags, in a
macro, and have every builtin using parseopt adding that macro at the
end.

  Then in git.c, you would have to scan for the command name when called
through `git --opt1 --opt2 foo`, and pass it to parseopt with as argc
the position of `foo` in the argument array. Parseopt will trust you for
it, and if it returns a non zero count, you have to barf, then you just
need to work on the rest of the array. That would mean in pseudo code
that this would work like:

    // ...
    /* when in `git --opt1 --opt2 foo -a -b -c` mode: */
    int cmd_pos =3D git_find_builtin_command_name(argc, argv);
    int count =3D parse_options(cmd_pos, argv, git_generic_options,
	"git [special-options] cmd [options]", 0);
    if (count)
	die("unknown git command: `%s`", argv[0]);
    argv +=3D cmd_pos;
    argc -=3D cmd_pos;
    /* here we simulate an argv of {"foo", "-a", "-b", "-c"} */

  Of course this only works on builtins that do support parseopt other
ones will need the massage you describe. For them the sole thing to
change would be to replace the OPT_END() with a GIT_SPECIAL_OPTS() or
sth alike.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZj9NvGr7W6HudhwRAgAyAJ9VL17Kp2TV7c5y/m0YAEPNBubJ2QCgkSN2
FbV+hxvqp5hZ5Y/82KkUYP0=
=KpZ0
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
