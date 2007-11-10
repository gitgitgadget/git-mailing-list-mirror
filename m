From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Make builtin-tag.c use parse_options.
Date: Sat, 10 Nov 2007 14:13:27 +0100
Message-ID: <20071110131327.GC25204@artemis.corp>
References: <473463E0.7000406@gmail.com> <7vabpmpr9y.fsf@gitster.siamese.dyndns.org> <1b46aba20711100425o2f351ac5o81537adc6f09dc80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="0ntfKIWw70PvrIHh";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 14:13:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqq9g-0002pd-W5
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 14:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbXKJNNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 08:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbXKJNNa
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 08:13:30 -0500
Received: from pan.madism.org ([88.191.52.104]:36469 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbXKJNN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 08:13:29 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 06C672966C;
	Sat, 10 Nov 2007 14:13:27 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5B4521E228; Sat, 10 Nov 2007 14:13:27 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Carlos Rica <jasampler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1b46aba20711100425o2f351ac5o81537adc6f09dc80@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64344>


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 10, 2007 at 12:25:44PM +0000, Carlos Rica wrote:
> 2007/11/10, Junio C Hamano <gitster@pobox.com>:
> > Carlos Rica <jasampler@gmail.com> writes:

> A solution not needing memory allocation into the option parser
> could be setting a callback running over the repeated option
> arguments, passing them to the function one per each call.
> Then, the user will be able to decide if he wants the arguments
> concatenated or only need one of them and prefers erroring out.
>=20
> Is this already possible with the current parser or the callback
> mode only calls using the last option?

  Everything is possible, you just have to code it. With a callback
you have in the struct option two places to store "things". The void*
value pointer and the intptr_t defval. _Usually_ the void* is the
pointer to the data that will be _written_ and the defval the data that
will be put into the void* under some circumstances (e.g. when your
option is negated).

  For Your case I'd go with some kind of string list pointed into the
void * value, defval has no or little use. You don't really care about
allocating memory in the option parser, I mean, option parsing is done
once at the initialization phase. It's not evil. In pseudo-C here is how
I would write the callback:

int parse_opt_stringlist(const struct option *opt, const char *arg, int uns=
et)
{
    string_list **l =3D opt->value;
    string_list_elem *e;

    if (unset) { /* negationg option clears the list */
	while (*l) {
	    string_list_elem_free(string_list_pop(l));
	}
	return 0;
    }

    e =3D string_list_elem_new();
    e->data =3D arg;
    string_list_push(l, e);
    return 0;
}

  And you're done, you can do what you want with that list from the caller.
There probably is such a structure in git, if not, it can probably be hacked
in a few lines.

  Remember, callbacks give you _full_ control on what you can do in the opt=
ion
parser, and if you're not happy with Turing complete expressivity, there is=
n't
anything I can do for you :P Note that if you do write such a generic
callback, it belongs to parse-options.[hc].

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHNa53vGr7W6HudhwRAhmfAJ4qKkS86L7zaZd0+aEhffXx7AbCZgCgjnD0
lsHBTye2OXBXStK5ZFQMt/I=
=j74M
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
