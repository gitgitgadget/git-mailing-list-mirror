From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: Fix UTF Encoding issue
Date: Mon, 3 Dec 2007 17:38:56 +0100
Message-ID: <20071203163856.GA24269@auto.tuwien.ac.at>
References: <4753D419.80503@clearchain.com> <7v7ijwjd9o.fsf@gitster.siamese.dyndns.org> <200712031332.36187.ismail@pardus.org.tr> <m3prxougmx.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>,
	Benjamin Close <Benjamin.Close@clearchain.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 18:12:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzEqK-0006BP-Mk
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 18:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbXLCRLs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2007 12:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbXLCRLs
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 12:11:48 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:53419 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbXLCRLr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 12:11:47 -0500
X-Greylist: delayed 1965 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2007 12:11:47 EST
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 264938BE0E96;
	Mon,  3 Dec 2007 17:38:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OanTMX7iUlj6; Mon,  3 Dec 2007 17:38:56 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 9A0E88BE0E89; Mon,  3 Dec 2007 17:38:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3prxougmx.fsf@roke.D-201>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66926>

On Mon, Dec 03, 2007 at 04:06:48AM -0800, Jakub Narebski wrote:
> Ismail D=F6nmez <ismail@pardus.org.tr> writes:
> > Monday 03 December 2007 Tarihinde 12:14:43 yazm??t?:
> >> Benjamin Close <Benjamin.Close@clearchain.com> writes:
> >>> -	eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
> >>> -	if (defined $res) {
> >>> -		return $res;
> >>> -	} else {
> >>> -		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
> >>> -	}
> >>> +	eval { return ($res =3D decode_utf8($str, Encode::FB_CROAK)); }=
;
> >>> +	return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
> >>>  }

This version is broken on Debian sarge and etch. Feeding a UTF-8 and a =
latin1
encoding of the same character sequence yields to different results.

> >>
> >> I thought the standard catch ... throw idiom in Perl was to do the=
 above
> >> like this:
> >>
> >> 	my $res;
> >>         eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
> >>         if ($@) {
> >>         	return decode($fallback_encoding, $str, Encode::FB_DEFAUL=
T);
> >> 	}
> >> 	return $res;
> >=20
> > I think this is correct, but the current code in gitweb doesn't loo=
k correct=20
> > since it checks for $res and not $@.
>=20
> First version of the patch was created by Martin Koegler. I have
> participated in creating the version which is now in gitweb, but I
> have to say that I wrote it based on decode_utf8
> documentation... which doesn't necessarily agree with facts :-(

eval { $res =3D decode_utf8(...); }
if ($@)=20
     return decode(...);
return $res

or

eval { $res =3D decode_utf8(...); }
if (defined $res)
      return $res;
else
    return decode(...);

show the same (wrong) behaviour on Debian sarge. They do not always
decode non UTF-8 characters correctly, eg.
#=F6=E4=FC does not work
#=E4=F6=FC=E4 does work

On Debian etch, both versions are working.

> I'm all for the "throw idion" version. Ack.


mfg Martin K=F6gler
