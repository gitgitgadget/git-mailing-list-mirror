From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with	non-ascii
 characters
Date: Sun, 30 Mar 2008 16:40:53 +1300
Message-ID: <47EF0BC5.4040102@vilain.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803291039.43355.robin.rosenberg.lists@dewire.com> <20080329094322.GA21814@coredump.intra.peff.net> <200803291354.47269.robin.rosenberg.lists@dewire.com> <20080329214516.GB30851@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 30 05:38:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfoNX-0007fH-Mq
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 05:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbYC3DiA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Mar 2008 23:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbYC3Dh7
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 23:37:59 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:44795 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbYC3Dh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 23:37:59 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id E5EC921C96F; Sun, 30 Mar 2008 16:37:56 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 7948421C967;
	Sun, 30 Mar 2008 16:37:51 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080329214516.GB30851@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78497>

Jeff King wrote:
> My point is that we don't _know_ what is happening in between the dec=
ode
> and encode. Does that intermediate form have the information required=
 to
> convert back to the exact same bytes as the original form?

No, it doesn't.  If you want that, save a copy of the string (it's a
lazy copy anyway).

The module that will let you see into the strings to see what it
happening is Devel::Peek.  Using that, you will see the state of the
UTF8 scalar flag.  For example;

 maia:~$ perl -Mutf8 -MDevel::Peek -le 'Dump "G=C3=BCt"'
 SV =3D PV(0x605d08) at 0x62f230
   REFCNT =3D 1
   FLAGS =3D (PADBUSY,PADTMP,POK,READONLY,pPOK,UTF8)
   PV =3D 0x60cd20 "G\303\274t"\0 [UTF8 "G\x{fc}t"]
   CUR =3D 4
   LEN =3D 8

By default, all strings that are read from files will NOT have this fla=
g
set, unless the filehandle that was read from was marked as being utf-8
(in order to preserve C semantics by default);

 maia:~$ echo "G=C3=BCt" | perl -MDevel::Peek -nle 'Dump $_'
 SV =3D PV(0x6052d0) at 0x604220
   REFCNT =3D 1
   FLAGS =3D (POK,pPOK)
   PV =3D 0x62f0e0 "G\303\274t"\0
   CUR =3D 4
   LEN =3D 80
 maia:~$ echo "G=C3=BCt" | perl -MDevel::Peek -nle 'BEGIN { binmode STD=
IN,
":utf8" } Dump $_'
 SV =3D PV(0x6052d0) at 0x604220
   REFCNT =3D 1
   FLAGS =3D (POK,pPOK,UTF8)
   PV =3D 0x62f100 "G\303\274t"\0 [UTF8 "G\x{fc}t"]
   CUR =3D 4
   LEN =3D 80

> But it still feels a little wrong to test by converting.

utf8::decode works in-place; it is essentially checking that the string
is valid, and if so, marking it as UTF8.

   my ($encoding);
   if (utf8::decode($string)) {
       if (utf8::is_utf($string)) {
           $encoding =3D "UTF-8";
       }
       else {
           $encoding =3D "US-ASCII";
       }
   }
   else {
       $encoding =3D "ISO8859-1"
   }

=46or US-ASCII, you'll only have to encode if the string contains speci=
al
characters (those below \037) or any "=3D" characters.

You could try using langinfo CODESET instead of hardcoding ISO8859-1
like that, but at least on my system can return bizarre values like
ANSI_X3.4-1968, which may be in some contexts a "correct" description o=
f
the encoding, but is unlikely to be understood by mail clients.

> There must be
> some way to ask "is this valid utf-8" (there are several candidate
> functions, but I don't think either of us quite knows the right way t=
o
> invoke them).

I think you were just reading the note on the utf8::valid function a
little too strongly.

You could use this block;

   if ($string =3D~ m/[\200-\377]/) {
       Encode::_utf8_on($string);
       if (!utf8::valid($string)) {
           Encode::_utf8_off($string);
       }
   }

Anyway, I guess all this rubbish is why people use CPAN modules, so tha=
t
they don't have to continually rediscover every single protocol quirk
and reinvent the wheel.

ie, it would be much, much simpler to use MIME::Entity->build for all o=
f
this, and remove the duplication of code.

Sam.
