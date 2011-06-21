From: Jeff King <peff@github.com>
Subject: Re: [RFC/PATCH 0/7] user-configurable git-archive output formats
Date: Tue, 21 Jun 2011 12:01:59 -0400
Message-ID: <20110621160159.GA17334@sigill.intra.peff.net>
References: <20110614181732.GA31635@sigill.intra.peff.net>
 <20110614181821.GA32685@sigill.intra.peff.net>
 <4DF7B90B.9050802@lsrfire.ath.cx>
 <20110614201433.GB1567@sigill.intra.peff.net>
 <20110614204521.GA12776@sigill.intra.peff.net>
 <20110615223030.GA16110@sigill.intra.peff.net>
 <4DFCBB92.5040308@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jun 21 18:02:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ3Ox-0001b4-Hv
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 18:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911Ab1FUQCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jun 2011 12:02:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48375
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756913Ab1FUQCB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 12:02:01 -0400
Received: (qmail 3803 invoked by uid 107); 21 Jun 2011 16:02:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 12:02:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 12:01:59 -0400
Content-Disposition: inline
In-Reply-To: <4DFCBB92.5040308@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176165>

On Sat, Jun 18, 2011 at 04:52:02PM +0200, Ren=C3=A9 Scharfe wrote:

> >> The gzip path is not configurable at all. Probably it should read =
the
> >> path and arguments from the config file. In fact, we could even al=
low
> >> arbitrary config like:
> >>
> >>   [tarfilter "tgz"]
> >>     command =3D gzip -c
> >>     extension =3D tgz
> >>     extension =3D tar.gz
>=20
> Configuration options whose values are appended instead of overwritte=
n
> by duplicate definitions are a new concept for git, I think.  Perhaps
> it's not a big thing, but I think it's better avoided.
>=20
> The only (stupid) practical shortcoming I can think if is this, thoug=
h:
> You can't remove anything from the list of supported extensions in a
> user config if the system config already contains e.g. tgz and tar.gz=
=2E

Yeah, I have mixed feelings on that.

As Jakub pointed out, we already have them in several places. I don't
know that removal is that big a deal in this instance. If we did want t=
o
support it, I think it would make more sense to have a generic solution
at the config level, like:

  [some-section]
    multivalue =3D foo
    multivalue =3D bar
    !multivalue
    multivalue =3D baz
    multivalue =3D whee

at which point the value is ("baz", "whee"). That matches what we do on
the command line, where:

  git foo --multivalue=3Dfoo --multivalue=3Dbar --no-multivalue \
          --multivalue=3Dbaz --multivalue=3Dwhee

handles the same issue in a similar way.

The other option, of course, is having a single value with list
semantics. But then you have to invent separator syntax. In this
instance whitespace would probably be fine, but I'd rather that each ne=
w
multi-valued option did not invent its own syntax, and in the general
case you may need to handle quoting. Plus you may need some kind of
append syntax. For example, if we support "tgz" and "tar.gz" internally=
,
how do you say 'add "pax.gz"' to that list without reiterating the whol=
e
list?

> The pax format is identical to the ustar format, which --format=3Dtar
> produces.  The other major format that comes to mind is cpio.  The
> (never merged) predecessor of tar-tree actually used that format.

Thanks, cpio is probably the most likely example.

> Since then I have been waiting for users to request being able to exp=
ort
> using cpio format (which is simpler and slightly smaller than tar), b=
ut
> that never happened.  It seems the existence of the pax format really
> has pacified the tar vs. cpio war of old.

=46air enough. I haven't heard anybody clamoring for it either. I just
didn't want to paint us into a corner. Since it seems like the most
likely format and nobody really wants it, it's perhaps not worth
worrying about.

> I'm not sure "filter" is a good name, though.  We have core.pager, wh=
ich
> is technically a filter as well, but for a specific purpose.

Yeah, any name would have to be "archive filter" or similar. But I woul=
d
think being under the "tar" section would be enough to disambiguate it.

> And we have the tar.umask setting as a precedence for format specfic
> config options.  So how about tar.<extension>.compressor?
>=20
> 	[tar "tgz"]
> 		compressor =3D gzip -cn
> 	[tar "tar.gz"]
> 		compressor =3D gzip -cn
> 	[tar "tar.bz2"]
> 		compressor =3D bzip2 -c

My two complaints are:

  1. The user has to repeat themselves in describing the command for
     multiple extensions. In practice, that's probably not a big deal,
     though.

  2. The namespace for user-defined extensions is the same as the
     namespace for tar options. I guess we can disambiguate based on th=
e
     number of dots (so, e.g., I know that "tar.umask" is not the umask
     extension, because it doesn't have a third component). It does
     limit us a little bit for adding future options.

     I don't know if it's worth caring about. We have the same problem
     with the diff.* namespace (e.g., diff.color.* exists, but is not a
     userdiff driver). In that case, besides the code being a little
     careful to be tolerant of the clash, I don't think it has been a
     problem.

> We don't need a compressionlevels option here because we can simply
> assume that the compressor commands do support them.

But we discussed elsewhere the concept of a tar-to-7z filter. I'm not
sure I'd call that a "compressor" as much as a filter. And it wouldn't
want the compression-level options (or maybe you would; I don't use it,
but skimming the manpage, it looks like you would want to convert -5
into "-mx=3D5"; so maybe you would want a wrapper script anyway).

> (Side note: this is not fully true for bzip2, as it doesn't support
> -0, but I don't think this is worth special consideration in our code=
,
> as long as errors of the filter are displayed properly.)

Yeah, I think that can be ignored. bzip can take care of complaining
itself.

> And we can also add a config option to restrict the formats creatable=
 by
> upload-archive, to address concerns over DoS attacks with expensive
> compressors:
>=20
> 	[archive]
> 		remoteFormats =3D tar zip tgz tar.gz

Right. It does have the ad-hoc list syntax I complained about above,
though.

-Peff
