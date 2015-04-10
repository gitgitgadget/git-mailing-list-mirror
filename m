From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] grep: correctly initialize help-all option
Date: Fri, 10 Apr 2015 07:22:50 +0200
Message-ID: <20150410052250.GA372@pks-pc.localdomain>
References: <1428586916-22679-1-git-send-email-ps@pks.im>
 <5526F535.4020407@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 10 07:23:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgRPG-0006FB-OL
	for gcvg-git-2@plane.gmane.org; Fri, 10 Apr 2015 07:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbbDJFXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2015 01:23:00 -0400
Received: from sender1.zohomail.com ([74.201.84.162]:53126 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbbDJFW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2015 01:22:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; 
  b=JriZbmudMSL4K1m17+a1pur85G4nwiCAz3+HQjMB4YPLfsFRR7NJ9+XWrLDbyIHEvCd6fiVT56eZ
    gYHvTzhGQSeHvPKxVT3zGLt4wLIwpNFbAzPJQcV5VWhX1FH58uXd0wlnA0p8oARqR86yFbAPcY7C
    7CjZNNhPDPjZvASKloE=  
Received: from localhost (f052133176.adsl.alicedsl.de [78.52.133.176]) by mx.zohomail.com
	with SMTPS id 1428643376945744.4327859351413; Thu, 9 Apr 2015 22:22:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5526F535.4020407@web.de>
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267006>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2015 at 11:55:01PM +0200, Ren=E9 Scharfe wrote:
> Am 09.04.2015 um 15:41 schrieb Patrick Steinhardt:
> > The "help-all" option is being initialized with a wrong value.
> > While being semantically wrong this can also cause a gcc
> > segmentation fault on ARMv7 hardfloat platforms with a hardened
> > toolchain. Fix this by initializing with the correct value.
>=20
> Thanks for your report and patch.  A few comments:
>=20
> Sign-off?  (See "Sign your work" in Documentation/SubmittingPatches)

Fixed in v2 of the patch already.

>=20
> > ---
> >   builtin/grep.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index abc4400..c0bf005 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -738,7 +738,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
> >   			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
> >   		OPT_BOOL(0, "ext-grep", &external_grep_allowed__ignored,
> >   			 N_("allow calling of grep(1) (ignored by this build)")),
> > -		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, N_("show usage"),
> > +		{ OPTION_CALLBACK, 0, "help-all", &opt, NULL, N_("show usage"),
> >   		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
> >   		OPT_END()
> >   	};
>=20
> help_callback() returns -1 immediately, IOW the value pointer is never=20
> used anyway.  So why does your change make a difference?  *puzzled*
>=20
> We could pass NULL instead, as in builtin/show-ref.c, which would make=20
> it clear that the pointer is just a dummy.

Changed in v2, as well.

In general the change won't make any difference when running the
command. But as said in the commit message it caused gcc (gcc
version 4.8.3 (Gentoo Hardened 4.8.3 p1.1, pie-0.5.9), ARMv7 HF)
to segfault when &options was passed in as value. Even though
this is probably an error in gcc we can easily work around it by
doing the Right Thing here.

> Q: Why does the callback exist in the first place?  A: parse_options()=20
> handles -h and --help-all automatically by showing the list of available=
=20
> options.  This is good for most commands for consistency's sake, but bad=
=20
> for commands that want to use -h for something else.  That's why it can=
=20
> be turned off with the flag PARSE_OPT_NO_INTERNAL_HELP, but that flag=20
> disables the long option as well.  It's added back by grep and show-ref=
=20
> explicitly, to at least provide --help-all consistently across all comman=
ds.
>=20
> We could solve this problem centrally by checking for -h and --help-all=
=20
> only after looking through the struct option list supplied to=20
> parse_options_step() instead of before and getting rid of the then=20
> unneeded callbacks for --help-all in grep and show-ref.  Are there any=20
> downsides to that approach?

I'll leave that question to the folks more experienced with the
code base.

> Ren=E9

Thanks for your feedback.

Patrick

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVJ14qAAoJEBF8Z7aeq/Esrx4QAKiWb2OVfDJG1qF6oim7Vl69
fVgZNKI1jfxP+EBAaExiQqzD9IgtLjlDnNi+4oz/VoFrQV4FKJuRMiHv2szZVu7w
/djgUpL91LbXqeXXmLHz7gfpGsdOvtx4WdMWOEiP2S3iEoz4dg8ioWYjJ7b01e0x
/+2fnpZc0wrF37Sy69j8D8edAQCrulFVRX1YqmEs7m7jUlF4Gzr11dXLpV95s8g/
vjt3oR5oL6NU00qJ4j8qh1XEMzMHplGZly5h5vlh717/2h5T8TCLQ1w+pQ0ysyRK
TZ2lnC0Gd5tFQVeBlWADX0Yg7c23lFYYNj7/6yGvVemaDqI7tCeJANr3skeOKXgi
VINFY4Bx4sFXFRgfyexS9mo4Zy05wL181H+szv1/y8iUAejBnT5EgfyigdO9QGeV
Blqmn2cVgc+4S6aSZxYew5D3x2KOIswGlePOZVLa6FOBM/peX1qbufh7/z2Zqxri
/JUGaDvc00pbxzKvJkfRzl0SNXuBvEJ77b+7PcDTVDKcSJ0draIbEvZSmh8lHi46
S1/nYVFm9eA/eFU4NfAnHx8dprMvBgqPOn8uEeiz0C8XvTRcsDxuoama2m73Zqkk
1Xq6hClu+lj7W5KWV38r1iMcmbje0HI/ftG8gvHiqSq+BSxU+tR9vOh6ABbn2IrG
arzucaIryhN8yptA0Ake
=nZs/
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
