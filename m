From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-daemon virtual hosting implementation.
Date: Wed, 23 Aug 2006 22:56:07 +0200
Organization: Polytechnique.org
Message-ID: <200608232256.10108.madcoder@debian.org>
References: <11563591572194-git-send-email-madcoder@debian.org> <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1289014.IgpVMiKz7N";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 22:56:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFzlr-0003uo-5Y
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 22:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWHWU4P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 16:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbWHWU4P
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 16:56:15 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:65461 "EHLO
	mx1.polytechnique.org") by vger.kernel.org with ESMTP
	id S965196AbWHWU4O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 16:56:14 -0400
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id F3300331CB;
	Wed, 23 Aug 2006 22:56:12 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Wed Aug 23 22:56:13 2006 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.000000, queueID=42F65331CC
X-Org-Mail: pierre.habouzit.2000@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25928>

--nextPart1289014.IgpVMiKz7N
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le mer 23 ao=FBt 2006 22:11, Junio C Hamano a =E9crit :
> Pierre Habouzit <madcoder@debian.org> writes:
> > just add the hostname in the path when using --base-path and
> > --user-path. this should be enough for most needs.
> >
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >  Here is a proposal for daemon side virtualhosting support.
> >
> > @@ -158,6 +160,11 @@ static char *path_ok(char *dir)
> >  		return NULL;
> >  	}
> >
> > +	if (use_vhosts && !vhost) {
> > +		logerror("using virtual hosting, and not host=3D was specified
> > !"); +		return NULL;
> > +	}
> > +
>
> This part is objectionable -- older clients do not give "host=3D".
> I think the plan, when virtual hosting was proposed and we added
> this to the client side first, was to treat older clients as if
> they specified the "primary" host.  So we would need some
> mechanism to say where the repositories of the "primary" host
> lives.

fair enough, so I suppose there is many choices:
 * replace --use-vhosts with --use-vhosts=3D${default hostname}
   but I do not like it very much
 * use `hostname -f` as the default hostname (not very nice either)
 * use the magic _default_ (=E0 la apache) hostname ?

But just note that if a git repository is accessible on an host that is=20
not the default, and only on that one, an older client won't be able to=20
clone the repository anyway, because he will be redirected to the=20
default virtual host. Meaning, that someone that uses virtual hosts=20
will break older clients anyway.

what would be nicer would be a way to gracefully reject older clients in=20
that case with an understandable error message, so that the user knows=20
why it does not work. I don't know PROTO_GIT very well yet,so I don't=20
know if older client support such communications yet or not.

> > +			if (use_vhosts) {
> > +				loginfo("host <%s>, "
> > +					"userpath <%s>, request <%s>, "
> > +					"namlen %d, restlen %d, slash <%s>",
> > +					vhost,
> > +					user_path, dir,
> > +					namlen, restlen, slash);
> > +				snprintf(rpath, PATH_MAX, "%.*s/%s/%s%.*s",
> > +					 namlen, dir, user_path, vhost,
> > +					 restlen, slash);
>
> I am not sure if the interaction between user-path and vhost
> should go like this, but I do not think of a good alternative to
> suggest right now.  Your code allows ~user/host1 and ~user/host2
> to host different set of repositories, but I suspect if somebody
> is setting up a virtual hosting of two hosts, he might want to
> have two distinct set of users (iow to pretend that ~user exist
> only on host1 but not on host2).  I dunno.

Another option would be not to support virtual hosts, but instead=20
superseed the --base-path and --user-path with some --base-path-fmt=20
and --user-path-fmt where the user can specify how to build the path=20
with simple sprintf-like formats. One could e.g. support:
 * %% obviously ;
 * %h that will be replaced with the hostname
 * %u (only for --user-path-fmt)
 * %p (asked path)
 * ...

I think that's more clever, and allow more flexible use of the virtual=20
hosting code. It e.g. allow to use the virtual host scheme for the=20
`base-path` repos and to disallow it for the users.

=2D-*-path and --*-path-fmt are obviously mutually exclusive.

What do you think ?

=2D-=20
=B7O=B7  Pierre Habouzit
=B7=B7O                                                madcoder@debian.org
OOO                                                http://www.madism.org

--nextPart1289014.IgpVMiKz7N
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE7MDqvGr7W6HudhwRAtCOAJ0efggcGmn68ssHHilqoieC3bpcWgCdHTDN
oe5ccIDp+r0ihy6QzvsLw0w=
=GD1o
-----END PGP SIGNATURE-----

--nextPart1289014.IgpVMiKz7N--
