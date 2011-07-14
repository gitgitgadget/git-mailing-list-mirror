From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/3] implement generic key/value map
Date: Thu, 14 Jul 2011 20:52:04 +0200
Message-ID: <CAKPyHN0-VbzjMaMJFZeGGrGX6HuGNEBHNVNf0cexB2vu21_13g@mail.gmail.com>
References: <20110714173454.GA21657@sigill.intra.peff.net>
	<20110714175105.GA21771@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 20:52:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhR1A-00025i-OA
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 20:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160Ab1GNSwH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 14:52:07 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57051 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab1GNSwF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 14:52:05 -0400
Received: by vxb39 with SMTP id 39so404917vxb.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=sMoF+DDGfG3JUGiq2IyImqRhQ7cQ3yx6ONk9A9wp5xs=;
        b=FKXJ7aeUbUizNgsBfBZQbqu3tjDWP4jI0dy7A/xLTN90B5zOGqLyE74PQ4FvJF4qDb
         7lQ54lx944f3H9uDjqcKxK/9hWd7S5yaysVUABtrSYKd65D7zpefu+6DbSZ6an7UTpH6
         YjuEvScE7pFreKA7RsHIExltWljiBty93rcfA=
Received: by 10.52.65.231 with SMTP id a7mr3045187vdt.61.1310669524459; Thu,
 14 Jul 2011 11:52:04 -0700 (PDT)
Received: by 10.52.107.228 with HTTP; Thu, 14 Jul 2011 11:52:04 -0700 (PDT)
In-Reply-To: <20110714175105.GA21771@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177152>

On Thu, Jul 14, 2011 at 19:51, Jeff King <peff@peff.net> wrote:
> It is frequently useful to have a fast, generic data
> structure mapping keys to values. We already have something
> like this in the "decorate" API, but it has two downsides:
>
> =C2=A01. The key type must always be a "struct object *".
>
> =C2=A02. The value type is a void pointer, which means it is
> =C2=A0 =C2=A0 inefficient and cumbersome for storing small values.
> =C2=A0 =C2=A0 One must either encode their value inside the void
> =C2=A0 =C2=A0 pointer, or allocate additional storage for the pointer
> =C2=A0 =C2=A0 to point to.
>
> This patch introduces a generic map data structure, mapping
> keys of arbitrary type to values of arbitrary type.
>
> One possible strategy for implementation is to have a struct
> that points to a sequence of bytes for each of the key and
> the value, and to try to treat them as opaque in the code.
> However, this code gets complex, has a lot of casts, and
> runs afoul of violating alignment and strict aliasing rules.
>
> This patch takes a different approach. We parameterize the
> types in each map by putting the declarations and
> implementations inside macros, and expand the macros with
> the correct types. This lets the compiler see the actual
> code, with its real types, and figure out things like struct
> packing and alignment itself.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> In addition to switching from using void pointers to macro expansion,
> this has one other difference from my previous patch: it handles
> arbitrary types for keys, not just object pointers. This was mentione=
d
> by Jakub, and would allow things like a fast bi-directional map for S=
VN
> revision numbers and commits.
>
> I tried to keep the implementation simple. Two things that could be c=
hanged:
>
> =C2=A01. We can't assume that the map key is a pointer. So the sentin=
el
> =C2=A0 =C2=A0 "NULL" value isn't necessarily available to use, and we=
 have to
> =C2=A0 =C2=A0 keep a separate bit in each hash entry to say "is this =
valid".
> =C2=A0 =C2=A0 This means when we _do_ store a pointer, we end up with=
 an extra
> =C2=A0 =C2=A0 32 bits or so in each hash entry for the "used" flag.
>
> =C2=A0 =C2=A0 We could add a macro parameter for sentinel values, so =
that types
> =C2=A0 =C2=A0 which _can_ handle this efficiently don't have to pay t=
he price.
> =C2=A0 =C2=A0 Or we could decide that mapping arbitrary keys isn't wo=
rth the
> =C2=A0 =C2=A0 hassle. I wrote this way to be flexible for future use;=
 I don't
> =C2=A0 =C2=A0 personally have plans to add svn revision number mappin=
gs.
>
> =C2=A02. It assumes values are assignable. That means storing somethi=
ng like
> =C2=A0 =C2=A0 "unsigned char sha1[20]" doesn't work. You can wrap it =
in a struct,
> =C2=A0 =C2=A0 but do we assume that struct assignment works everywher=
e? I didn't
> =C2=A0 =C2=A0 check, but I think it is in C89 but some antique compil=
ers didn't
> =C2=A0 =C2=A0 allow it. Switching it to use memcpy() would be easy en=
ough (or
> =C2=A0 =C2=A0 again, parameterizing so that assignable things don't h=
ave to pay
> =C2=A0 =C2=A0 the price).
>
> =C2=A0Makefile | =C2=A0 =C2=A02 +
> =C2=A0map.c =C2=A0 =C2=A0| =C2=A0 86 ++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++
> =C2=A0map.h =C2=A0 =C2=A0| =C2=A0 24 +++++++++++++++++
> =C2=A03 files changed, 112 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 map.c
> =C2=A0create mode 100644 map.h
>
> diff --git a/Makefile b/Makefile
> index 46793d1..6242321 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -530,6 +530,7 @@ LIB_H +=3D list-objects.h
> =C2=A0LIB_H +=3D ll-merge.h
> =C2=A0LIB_H +=3D log-tree.h
> =C2=A0LIB_H +=3D mailmap.h
> +LIB_H +=3D map.h
> =C2=A0LIB_H +=3D merge-file.h
> =C2=A0LIB_H +=3D merge-recursive.h
> =C2=A0LIB_H +=3D notes.h
> @@ -621,6 +622,7 @@ LIB_OBJS +=3D ll-merge.o
> =C2=A0LIB_OBJS +=3D lockfile.o
> =C2=A0LIB_OBJS +=3D log-tree.o
> =C2=A0LIB_OBJS +=3D mailmap.o
> +LIB_OBJS +=3D map.o
> =C2=A0LIB_OBJS +=3D match-trees.o
> =C2=A0LIB_OBJS +=3D merge-file.o
> =C2=A0LIB_OBJS +=3D merge-recursive.o
> diff --git a/map.c b/map.c
> new file mode 100644
> index 0000000..378cecb
> --- /dev/null
> +++ b/map.c
> @@ -0,0 +1,86 @@
> +#include "cache.h"
> +#include "map.h"
> +#include "object.h"
> +
> +static unsigned int hash_obj(const struct object *obj, unsigned int =
n)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned int hash;
> +
> + =C2=A0 =C2=A0 =C2=A0 memcpy(&hash, obj->sha1, sizeof(unsigned int))=
;
> + =C2=A0 =C2=A0 =C2=A0 return hash % n;
> +}
> +
> +static unsigned int cmp_obj(const struct object *a, const struct obj=
ect *b)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return b =3D=3D a;
> +}
> +
> +#define MAP_IMPLEMENT(name, ktype, vtype, cmp_fun, hash_fun) \

This define should probably in the header too. Else this is completely =
useless.

Bert
