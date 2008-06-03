From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Strbuf documentation: document most functions
Date: Tue, 03 Jun 2008 10:42:40 +0200
Message-ID: <20080603084240.GB13627@artemis.madism.org>
References: <1212447591-4870-1-git-send-email-vmiklos@frugalware.org> <alpine.DEB.1.00.0806030048010.13507@racer.site.net> <1212447591-4870-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="X1bOJ3K7DJ5YkBrT";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 03 10:43:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3S7N-0006nu-Aq
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 10:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbYFCImq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 04:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbYFCImq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 04:42:46 -0400
Received: from pan.madism.org ([88.191.52.104]:58830 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbYFCImo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 04:42:44 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id C3A8F2CC1D;
	Tue,  3 Jun 2008 10:42:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7A46213733; Tue,  3 Jun 2008 10:42:40 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806030048010.13507@racer.site.net> <1212447591-4870-1-git-send-email-vmiklos@frugalware.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83628>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2008 at 10:59:51PM +0000, Miklos Vajna wrote:
> +strbufs has some invariants that are very important to keep in mind:
> +
> +. The `->buf` member is always malloc-ed, hence strbuf's can be used to
> +  build complex strings/buffers whose final size isn't easily known.
> ++
> +It is *not* legal to copy the `->buf` pointer away. `strbuf_detach()` is
> +the operation that detachs a buffer from its shell while keeping the
> +shell valid wrt its invariants.
> +
> +. The `->buf` member is a byte array that has at least `->len + 1` bytes
> +  allocated. The extra byte is used to store a `'\0'`, allowing the
> +  `->buf` member to be a valid C-string. Every strbuf function ensure th=
is
> +  invariant is preserved.
> ++

  I wouldn't write that part this way at all: I have a personal
implementation of things that look like strbufs that are able to use an
`alloca`-ed buffers and deals with overflows with malloc's, possibility
to stream and so on (implemented with skips, meaning that what is the
->buf member is, isn't always the real start of the allocated memory
block).  And I don't think it's a good idea to carve such informations
into stone. So what I'd says in summary is:

  (1) it is totally safe to touch anything in the buffer pointed by the
      buf member between the index 0 and buf->len excluded.

  (1b) what you write later: it's also possible to write after buf->len
       if not after strbuf_avail() _BUT_ then you have when you're done
       the task to reset the (2) invariant yourself, using
       strbuf_setlen().

  (2) ->buf[->len] =3D=3D '\0' holds _ALL TIME_.

  (3) ->buf is never ever NULL so it can be used in any usual C string
      ops safely.

  (4) do NOT assume anything on what ->buf really is (allocated memory
      or not e.g.), use strbuf_detach to unwrap a memory buffer from its
      strbuf shell in a safe way. That is the sole supported way. This
      will give you a malloced buffer that you can later free().


> +* Life cycle
> +
> +`strbuf_init`::
> +
> +	Initializes the structure. The second parameter can be zero or a bigger
> +	number to allocate memory, in case you want to prevent further reallocs.

  I'd add that it is _MANDATORY_ to initialize strbufs, and that a
static allocation (for global variables e.g.) can be done using
the STRBUF_INIT static initializer.

> +`strbuf_release`::
> +
> +	Releases a string buffer and the memory it used. You should not use the
> +	string buffer after using this function, unless you initialize it again.

  Actually this is wrong because strbuf_release performs a new init
since init allocates 0 memory and that it's idiot-proof. But it could be
changed in the future and it should not be relied upon.

> +`strbuf_detach`::
> +
> +	Detaches the string from the string buffer. The function returns a
> +	pointer to the old string and empties the buffer.

  Not really strbuf_detach unwraps the embedded buffer for sure, but it
doesn't "empties" the buffer, strbuf_detach is like strbuf_release:
after a release, strbuf should be init-ed again (even if for now
strbuf_release does so).


> +`strbuf_attach`::
> +
> +	Attaches a string to a buffer. You should specify the string to attach,
> +	the current length of the string and the amount of allocated memory.

  In addition to what Johannes said: size must be > len. Because the
string you pass is supposed to be a NUL-terminated string.


> +* Related to the size of the buffer
> +
> +`strbuf_avail`::
> +
> +	Determines the amount of allocated but not used memory.
> +
> +`strbuf_grow`::
> +
> +	Allocated extra memory for the buffer.

  I'd put that this way: ensure that at least this amount of available
memory is available. This is used when you know a typical size for what
you will do and want to avoid repetitive automatic resize of the
underlying buffer. This is never a needed operation, but can be critical
for performance in some cases.

> +`strbuf_setlen`::
> +
> +	Sets the length of the buffer to a given value.

  This function does NOT allocate new memory, so you should not perform
a strbuf_setlen to a length that is larger than sb->len + strbuf_avail(sb).
strbuf_setlen is just meant as a "please fix invariants from this strbuf
I just messed with)"

> +`strbuf_add`::
> +
> +	Add data of given length to the buffer.
> +
> +`strbuf_addstr`::
> +
> +	Add a NULL-terminated string to the buffer.

  Please use NUL, '\0' is NUL (as in its ascii name), NULL is (void *)0.
In addition to that, I'd say that strbuf_addstr will ALWAYS be
implemented as an inline or a macro that expands to:
  strbuf_add(..., s, strlen(s))

Meaning that this is efficient to write things like:
  strbuf_addstr(sb, "immediate string").

> +`strbuf_expand`::

  This function is a pretty printer that expands magic formats string
thanks to callbacks, so that it's done in a generic way. It's what is
used to generate git-log e.g. I'm not its author, so I'm not really best
placed to describe it.

> +`strbuf_fread`::
> +
> +	Read a given size of data from a FILE* pointer to the buffer.
> +
> +`strbuf_read`::
> +
> +	Read the contents of a given file descriptor. The third argument can be
> +	used to give a hint about the file, to avoid reallocs.
> +
> +`strbuf_read_file`::
> +
> +	Read the contents of a file, specified by its path. The third argument
> +	can be used to give a hint about the file, to avoid reallocs.
> +
> +`strbuf_getline`::
> +
> +	Read a line from a FILE* pointer. The second argument specifies the line
> +	terminator character, like `'\n'`.
> +

  For all: the buffer is rewinded if the read fails.
  If -1 is returned, errno must be consulted, like you would do for
read(3).


On Tue, Jun 03, 2008 at 12:00:33AM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> I am no author of strbuf, but hey, I thought I'd just give you a few=20
> comments...
>=20
> In general, I'd rather leave the "->" from the members, since you have=20
> many instances where you access them with ".".
>=20
> On Tue, 3 Jun 2008, Miklos Vajna wrote:
>=20
> > diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/tec=
hnical/api-strbuf.txt
> > index a52e4f3..3879e0e 100644
> > --- a/Documentation/technical/api-strbuf.txt
> > +++ b/Documentation/technical/api-strbuf.txt
> > @@ -1,6 +1,175 @@
> >  strbuf API
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > -Talk about <strbuf.h>
> > +strbuf's can be use in many ways: as a byte array, or to store arbitra=
ry
> > +long, overflow safe strings.
>=20
> I think that you should not suggest using strbufs as byte array, even if=
=20
> that is certainly possible.  Rather, you should say something like:
>=20
> 	An strbuf is NUL terminated for convenience, but no function in=20
> 	the strbuf API actually relies on the string being free of NULs.

  ACK. I'd add the fact that strbuf are meant to be used with all the
usual C string and memory APIs. Given that the length of the buffer is
known, it's often better to use the mem* functions than a str* one
(memchr vs. strchr e.g.). Though, one has to be careful about the fact
that str* functions often stop on NULs and that strbufs may have
embedded NULs.


> > +strbufs has some invariants that are very important to keep in mind:
> > +
> > +. The `->buf` member is always malloc-ed, hence strbuf's can be used to
> > +  build complex strings/buffers whose final size isn't easily known.
>=20
> Is this true?  I thought the initial string is empty, but not alloc'ed.
>=20
> So I'd rather have something like
>=20
> 	The "buf" member is never NULL, so you can safely strcmp() it.
>=20
> I'd like to see a comment that strbuf's _have_ to be initialized either b=
y=20
> strbuf_init() or by "=3D STRBUF_INIT" before the invariants, though.

  Well I'd go even further like I proposed above.

> > +`strbuf_attach`::
> > +
> > +	Attaches a string to a buffer. You should specify the string to attac=
h,
> > +	the current length of the string and the amount of allocated memory.
>=20
> .... This string _must_ be malloc()ed, and after attaching, the pointer=
=20
> cannot be relied upon anymore, and neither be free()d directly.

  ACK.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIRQQAvGr7W6HudhwRAmF9AJ4gs8sOh9tL4hX2kvzhkLc7I9q0OgCeP6Tf
lb+25xXM5AsWF/RxnmRUnlg=
=PxTw
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
