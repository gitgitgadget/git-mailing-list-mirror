From: Jeff King <peff@peff.net>
Subject: Re: Confused over packfile and index design
Date: Fri, 8 Apr 2011 20:20:48 -0400
Message-ID: <20110409002047.GB7445@sigill.intra.peff.net>
References: <m2d3kw70su.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 02:21:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8LvK-0007kr-67
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 02:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757986Ab1DIAUw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 20:20:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33995
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757977Ab1DIAUv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 20:20:51 -0400
Received: (qmail 7391 invoked by uid 107); 9 Apr 2011 00:21:38 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 20:21:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 20:20:48 -0400
Content-Disposition: inline
In-Reply-To: <m2d3kw70su.fsf@Spindle.sehlabs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171177>

On Fri, Apr 08, 2011 at 07:58:41PM -0400, Steven E. Harris wrote:

> ,----
> | Importantly, packfile indexes are /not/ neccesary to extract object=
s
> | from a packfile, they are simply used to quickly retrieve individua=
l
> | objects from a pack. The packfile format is used in upload-pack and
> | receieve-pack programs (push and fetch protocols) to transfer objec=
ts
> | and there is no index used then - it can be built after the fact by
> | scanning the packfile.
> `----
>=20
> That suggests that it's possible to read the packfile linearly and
> deduce where the various objects start and end, without the index
> available.

Yes. For example, when we do a "git fetch", we get _just_ the packfile
and create our own local index.

> Later, in the section on the packfile format, we find this:
>=20
> ,----
> | It is important to note that the size specified in the header data =
is
> | not the size of the data that actually follows, but the size of tha=
t
> | data /when expanded/. This is why the offsets in the packfile index=
 are
> | so useful, otherwise you have to expand every object just to tell w=
hen
> | the next header starts.
> `----
>=20
> Now that makes it sound like without the index, even if one knows whe=
re
> a packed object starts, reading its header tells its /inflated/ size,
> /not/ the number of remaining payload bytes representing the object. =
If
> that's true, then how does one figure out where one object ends and t=
he
> next one begins /without the index/?

The actual object data (whether it is the object itself or a delta) is
all zlib-encoded, so it has its own size header and checksum there, I
believe. The pack-format documentation is a bit vague, but a quick read
of unpack_raw_entry and unpack_entry_data in builtin/index-pack.c seems
to confirm that this is how it works.

Take that response with a grain of salt, though. That is just from my
quick read of the code, so I could be wrong.

> Recall that the first paragraph quoted above says that the index can =
be
> built from the packfile, as opposed to it being essential to reading =
the
> packfile. Is one of these paragraphs incorrect?

No, if I'm correct, it is just that there is an extra header that
neither mentions. :)

> The Git documentation on the pack format=C2=B2 mentions that the pack=
ed
> object headers represent the lengths as variable-sized integers
>=20
> ,----
> | n-byte type and length (3-bit type, (n-1)*7+4-bit length)
> `----
>=20
> but it doesn't say whether that's the number of (deflated) payload by=
tes
> or the inflated object size, as the Git Book asserts.

That should be the inflated object size.

> I imagine that if the format is meant to record the size of the defla=
ted
> payload, then it would be challenging to compress the data straight i=
nto
> the packfile, because one wouldn't know the final size until it was
> written, which means that one wouldn't know how many bytes will be
> necessary to write its length in the header, which means one wouldn't
> know where to start writing the deflated payload.

I believe zlib handles streaming it out for us. I'm not too familiar
with zlib's format, but I assume it outputs in chunks with occasional
headers. So finding the end of stream means while reading through the
whole stream and skipping past each chunk.

> Are there any other clarifying documents you can recommend to underst=
and
> the design?

Not that I know of; what's in docs/technical is generally authoritative=
,
except for reading the code.

-Peff
