From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC/PATCH] define the way new representation types are encoded
 in the pack
Date: Fri, 28 Oct 2011 08:44:56 -0700
Message-ID: <CAJo=hJt-YZcdxw+D=1S4haPmY-8-LLjXD=MvDGeWbdJ88_VOGw@mail.gmail.com>
References: <7v62j9veh3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 17:45:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJocW-0005Nk-AZ
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 17:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996Ab1J1PpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Oct 2011 11:45:19 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33043 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab1J1PpS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 11:45:18 -0400
Received: by ywm3 with SMTP id 3so3775217ywm.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 08:45:17 -0700 (PDT)
Received: by 10.236.192.132 with SMTP id i4mr4665007yhn.80.1319816717248; Fri,
 28 Oct 2011 08:45:17 -0700 (PDT)
Received: by 10.147.125.20 with HTTP; Fri, 28 Oct 2011 08:44:56 -0700 (PDT)
In-Reply-To: <7v62j9veh3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184414>

On Thu, Oct 27, 2011 at 23:04, Junio C Hamano <gitster@pobox.com> wrote=
:
> In addition to four basic types (commit, tree, blob and tag), the pac=
k
> stream can encode a few other "representation" types, such as REF_DEL=
TA
> and OFS_DELTA. As we allocate 3 bits in the first byte for this purpo=
se,
> we do not have much room to add new representation types in place, bu=
t we
> do have one value reserved for future expansion.

We have 2 values reserved, 0 and 5.

> When bit 4-6 encodes type 5, the first byte is used this way:
>
> =A0- Bit 0-3 denotes the real "extended" representation type. Because=
 types
> =A0 0-7 can already be encoded without using the extended format, we =
can
> =A0 offset the type by 8 (i.e. if bit 0-3 says 3, it means representa=
tion
> =A0 type 11 =3D 3 + 8);
>
> =A0- Bit 4-6 has the value "5";
>
> =A0- Bit 7 is used to signal if the _third_ byte needs to be read for=
 larger
> =A0 size that cannot be represented with 8-bit.

This is very complicated. We don't need more complex logic in the pack
encoding. We _especially_ do not need yet another variant of how to
store a variable length integer in the pack file. I'm sorry, but we
already have two different variants and this just adds a third. It is
beyond crazy.

Last time (this is now years ago but whatever) Nico and I discussed
adding a new type to packs it was for the alternate tree encoding in
"pack v4". Trees happen so often that type code 5 is a good value to
use for these. Later you talked about using the extended type to store
a cattree blob thing, which would not appear nearly as often as a
normal directory listing type tree that was encoded using the pack v4
style encoding... I think saving type 5 for a small frequently
occurring type is a good thing.

> As it is unlikely for us to pack things that do not need to record an=
y
> size, the second byte is always used in full to encode the low 8-bit =
of
> the size.
>
> I haven't started using type=3D8 and upwards for anything yet, but be=
cause
> we have only one "future expansion" value left, I want us to be extre=
mely
> careful in order to avoid painting us into a corner that we cannot ge=
t out
> of, so I am sending this out early for a preliminary review.

I would have said something more like:

When bit 4-6 encodes "0", then:

- Bit 0-3 and bit 7 are used normally to encode a variable length
"size" integer. These may be 0 indicating no size information.

- 2nd-nth bytes store remaining "size" information, if bit 7 was set.

- The immediate next byte encodes the extended type. This type is
stored using the OFS_DELTA offset varint encoding, and thus may be
larger than 256 if we ever need it to be.
