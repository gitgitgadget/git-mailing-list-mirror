From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 21:41:15 +0200
Message-ID: <20070907194115.GA23483@artemis.corp>
References: <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org> <20070907094120.GA27754@artemis.corp> <fbs79k$tac$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="G4iJoqBmSsgzjUCe";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 21:41:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITjhq-0004fy-1z
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 21:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758191AbXIGTlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 15:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758216AbXIGTlY
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 15:41:24 -0400
Received: from pan.madism.org ([88.191.52.104]:38273 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbXIGTlX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 15:41:23 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BAE7B1E858;
	Fri,  7 Sep 2007 21:41:21 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 9F296E6E6; Fri,  7 Sep 2007 21:41:15 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Walter Bright <boost@digitalmars.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <fbs79k$tac$1@sea.gmane.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58062>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2007 at 07:03:24PM +0000, Walter Bright wrote:
> Pierre Habouzit wrote:
> >  Well, to me D has two significant drawbacks to be "ready to use". The
> >first one is that it doesn't has bit-fields. I often deal with=20
> >bit-fields
> >on structures that have a _lot_ of instances in my program, and the
> >bit-field is chosen for code readability _and_ structure size=20
> >efficiency.
> >I know you pretend that using masks manually often generates better
> >code. But in my case, speed does not matter _that_ much. I mean it does,
> >but not that this micro-level as access to the bit-field is not my
> >inner-loop.
>=20
> I'm surprised this is such an important issue. Others have mentioned it,=
=20
> but regard it as a minor thing. Interestingly, the htod program (which=20
> converts C .h files to D import files) will convert bit fields to inline=
=20
> functions, giving equivalent functionality.

  Well htod does that, but it's very impractical to write them from
scratch. Especially if you want to benefit from the fact that padding
and integer sizes are very well defined to map e.g. structs onto a raw
stream, avoiding deserialization and so on. And for that bit-fields are
a really really fast and simple way to describe things.

  I mean, take your classical example of the foreach loop. Your whole
point is that it's way shorter, and safer. And now you are saying that
people should instead of sth like:

  struct my_struct {
    unsigned some_field : 2;
    unsigned has_this_property : 1;
    unsigned is_in_this_state  : 1;
    unsigned priority_level    : 2;
    ...
  }

  people should write (IIRC it works since ->some_field =3D 2 calls
->some_field(2) if the member does not exists, or maybe it's
set_some_field, it's not very relevant anyway):

  struct my_struct {
    unsigned some_field() {
      return this->real_field >> 30;
    }

    void some_field(unsigned value) {
      this->real_field |=3D (value & 3) << 30;
    }

    ...

  private:
    unsigned real_field;
  }

  Please it has to be a joke: there is 42 ways for people to write it
wrong (wrong shifts, wrong masks, and so on), it's horribly obfuscated,
hence needs a lot of comments, whereas the bitfield is 90% self
documented, and the syntax is _very_ clear, you cannot beat that. I
would be absolutely fine with it being syntactical sugar for some kind
of template call though.

  Not to mention that the usual C idiom:

  union {
    unsigned flags;
    struct {
      // many bitfields
    };
  };

  Would need an explicit copy_flags(const my_struct foo) function to
work. Not pretty, not straightforward.

  Really, I feel this is a big lack, for a language that aims at
simplicity, conciseness _and_ correctness.

  OK, maybe I'm biased, I work with networks protocols all day long, so
I often need bitfields, but still, a lot of people deal with network
protocols, it's not a niche.

> >  The other second issue I have, is that there is no way to do:
> >  import (C) "foo.h"
> >  And this is a big no-go (maybe not for git, but as a general issue)
> >because it impedes the use of external libraries with a C interface a
> >_lot_. E.g. I'd really like to use it to use some GNU libc extensions,
> >but I can't because it has too many dependencies (some async getaddrinfo
> >interface, that need me to import all the signal events and so on
> >extensions in the libc, with bitfields, wich send us back to the first
> >point).
>=20
> D does come with htod, which converts C .h files to D files.

  Last time I checked it was only available on windows, and closed
source, both are an impediment for many people. It's definitely clear
that gcc being opensource and available on so many platforms helped to
make C what it is today. Lacking portable and free (as in speech) tools
are an impediment to the succes of a language. Right now, for D, only
gdc exists, it lags behind dmd quite a lot afaict, and there is no other
toolchain helpers yet.

> It's not possible to do a perfect job (because of macros), but it
> comes pretty darned close. The reason htod gets so close is because it
> is actually a real C compiler front end, not a perl or regex string
> processing hack.
>=20
> Because it (may) require a little hand tweaking of the results (again,=20
> because C headers may include awful things like:
> 	#define BEGIN {
> 	#define print printf(
> ), it's a separate program rather than built-in.

  Yeah I'm fine with that, but sadly it's not available everywhere like
I said.

> >  I also have a third, but non critical issue, I absolutely don't like
> >phobos :)
>=20
> You're not the only one <g>. But I'll add that access to the standard C=
=20
> runtime library *is* a part of D, so at some level it can't be worse than=
=20
> C. There's also another runtime library available, Tango, which is very=
=20
> popular.

  I completely agree, and I knew about Tango, and anyways, I'm so used
to C, and D has so few to bring to my code style when I deal with low
level system functions, that I'm totally fine with std.c.* anyways :)

  For the record I wasn't suggesting to rewrite git in D at all. I just
happened to see your post, and being very interested in where D is going
because I feel it's an excellent langage, and saw an opportunity to
mention a few quirks I feel it has, so, well, I answered :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4albvGr7W6HudhwRAjsEAJ9fLsPrcWN0zYQQS2W2JhQnRLSY0ACeIOs/
YqX72AR1tHtebQxFP7Wmb2c=
=FjMg
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
