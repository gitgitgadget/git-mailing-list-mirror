From: Michael Wagner <accounts@mwagner.org>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Thu, 15 May 2014 07:08:20 +0200
Message-ID: <20140515050820.GA30785@localhost.localdomain>
References: <20140514184145.GA25699@localhost.localdomain>
 <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
 <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 07:08:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wknu9-0008TG-BB
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 07:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbaEOFIZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 May 2014 01:08:25 -0400
Received: from caelum.uberspace.de ([95.143.172.212]:46533 "EHLO
	caelum.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbaEOFIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 01:08:24 -0400
Received: (qmail 1538 invoked from network); 15 May 2014 05:08:22 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by caelum.uberspace.de with SMTP; 15 May 2014 05:08:22 -0000
Content-Disposition: inline
In-Reply-To: <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249058>

On Thu, May 15, 2014 at 12:25:45AM +0200, Jakub Nar=C4=99bski wrote:
> On Wed, May 14, 2014 at 11:57 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
> > Michael Wagner <accounts@mwagner.org> writes:
> >
> >> Perl has an internal encoding used to store text strings. Currentl=
y, trying to
> >> view files with UTF-8 encoded names results in an error (either "4=
04 - Cannot
> >> find file" [blob_plain] or "XML Parsing Error" [blob]). Converting=
 these UTF-8
> >> encoded file names into Perl's internal format resolves these erro=
rs.
>=20
> Could you give us an example?  What is important is whether filename
> is passed via path_info or via query string.
>=20

There is a file named "G=C3=BCtekriterien.txt" in my repository. Trying=
 to
view this file as "blob_plain" produces an 404 error (displaying the
file name with an additional print statement):

$ REQUEST_METHOD=3DGET QUERY_STRING=3D'p=3Dnotes.git;a=3Dblob_plain;f=3D=
work/G%C3%83%C2%BCtekriterien.txt;hb=3DHEAD' ./gitweb.cgi

work/G=C3=83=C2=BCtekriterien.txt
Status: 404 Not Found

Decoding the UTF-8 encoded file name (again with an additional print
statement):

$ REQUEST_METHOD=3DGET QUERY_STRING=3D'p=3Dnotes.git;a=3Dblob_plain;f=3D=
work/G%C3%83%C2%BCtekriterien.txt;hb=3DHEAD' ./gitweb.cgi

work/G=C3=BCtekriterien.txt
Content-disposition: inline; filename=3D"work/G=C3=BCtekriterien.txt"

> Because in evaluate_uri() there is
>=20
>      our $path_info =3D decode_utf8($ENV{"PATH_INFO"});
>=20
> and in evaluate_query_params() there is
>=20
>     $input_params{$name} =3D decode_utf8($cgi->param($symbol));
>=20
> >> Signed-off-by: Michael Wagner <accounts@mwagner.org>
> >> ---
> >
> > Cc'ing Jakub, who have been the area maintainer, for comments.
> >
> > One thing I wonder is that, if there are some additional calls to
> > encode() necessary before we embed $file_name (which are now decode=
d
> > to the internal string form, not a byte-sequence that happens to be
> > in utf-8) in the generated pages, if we were to do this change.

The generated pages show the correct file names.=20

>=20
> There should be no problem with output encoding.  esc_path(), which
> should be used for filenames, includes to_utf8, which in turn uses
> decode($fallback_encoding, $str, Encode::FB_DEFAULT);
>=20
> >>  gitweb/gitweb.perl | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> >> index a9f57d6..6046977 100755
> >> --- a/gitweb/gitweb.perl
> >> +++ b/gitweb/gitweb.perl
> >> @@ -1056,7 +1056,7 @@ sub evaluate_and_validate_params {
> >>               }
> >>       }
> >>
> >> -     our $file_name =3D $input_params{'file_name'};
> >> +     our $file_name =3D decode("utf-8", $input_params{'file_name'=
});
> >>       if (defined $file_name) {
> >>               if (!is_valid_pathname($file_name)) {
> >>                       die_error(400, "Invalid file parameter");
>=20
> Hmm... all %input_params should have been properly decoded
> already, how it was missed?
>=20
> Also, branchname (hash_base etc.), search query, filename in file_par=
ent,
> project name can be UTF-8 too, so it is at best partial fix.
>=20
> --=20
> Jakub Nar=C4=99bski
