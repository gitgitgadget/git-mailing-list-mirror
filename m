From: Michael Wagner <accounts@mwagner.org>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Thu, 15 May 2014 20:48:09 +0200
Message-ID: <20140515184808.GA7964@localhost.localdomain>
References: <20140514184145.GA25699@localhost.localdomain>
 <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
 <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
 <20140515050820.GA30785@localhost.localdomain>
 <alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu May 15 20:48:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl0hX-0000ef-CK
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 20:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611AbaEOSsP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 May 2014 14:48:15 -0400
Received: from caelum.uberspace.de ([95.143.172.212]:38810 "EHLO
	caelum.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293AbaEOSsP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 14:48:15 -0400
Received: (qmail 22191 invoked from network); 15 May 2014 18:48:10 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by caelum.uberspace.de with SMTP; 15 May 2014 18:48:10 -0000
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249179>

On Thu, May 15, 2014 at 10:04:24AM +0100, Peter Krefting wrote:
> Michael Wagner:
>=20
> >Decoding the UTF-8 encoded file name (again with an additional print
> >statement):
> >
> >$ REQUEST_METHOD=3DGET QUERY_STRING=3D'p=3Dnotes.git;a=3Dblob_plain;=
f=3Dwork/G%C3%83%C2%BCtekriterien.txt;hb=3DHEAD' ./gitweb.cgi
> >
> >work/G=FCtekriterien.txt
> >Content-disposition: inline; filename=3D"work/G=FCtekriterien.txt"
>=20
> You should fix the code path that created that URI, though, as it is =
not
> what you expected.
>=20
> %C3%83 decodes to U+00C3 Latin Capital Letter A With Tilde
> %C2%BC decodes to U+00BC Vulgar Graction One Quarter
>=20
> The proper UTF-8 encoding for =FC (U+00FC) is, as you can probably gu=
ess from
> looking at which two characters the sequence above yielded, C3 BC, wh=
ich in
> a URI is represented as %C3%BC.
>=20
> Your QUERY_STRING should thus be
>=20
>   p=3Dnotes.git;a=3Dblob_plain;f=3Dwork/G%C3%BCtekriterien.txt;hb=3DH=
EAD
>=20
> which probably works as expected.

Obviously, you are right, thanks.

>=20
> What is happening is that whatever is generating the URI us UTF-8-enc=
oding
> the string twice (i.e., it generates a string with the proper C3 BC i=
n it,
> and then interprets it as iso-8859-1 data and runs that through a UTF=
-8
> encoder again, yielding the C3 83 C2 BC sequence you see above).
>=20

The subroutine "git tree" generates the tree view. It stores the output
of "git ls-tree -z ..." in an array named "@entries". Printing the cont=
ent
of this array yields the following result:

00644 blob 6419cd06a9461c38d4f94d9705d97eaaa887156a     520 G=C3=BCtekr=
iterien.txt

This leads to the "doubled" encoding. Declaring the encoding in the cal=
l
to open yields the following result:

100644 blob 6419cd06a9461c38d4f94d9705d97eaaa887156a     520 G=FCtekrit=
erien.txt

---

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a9f57d6..f1414e1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7138,7 +7138,7 @@ sub git_tree {
        my @entries =3D ();
        {
                local $/ =3D "\0";
-               open my $fd, "-|", git_cmd(), "ls-tree", '-z',
+               open my $fd, "-|encoding(UTF-8)", git_cmd(), "ls-tree",=
 '-z',
                        ($show_sizes ? '-l' : ()), @extra_options, $has=
h
                        or die_error(500, "Open git-ls-tree failed");
                @entries =3D map { chomp; $_ } <$fd>;

> --=20
> \\// Peter - http://www.softwolves.pp.se/
