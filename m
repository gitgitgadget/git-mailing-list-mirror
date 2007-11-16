From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: [BUG] encoding problem with format-patch + send-email
Date: Fri, 16 Nov 2007 12:14:50 +0100
Message-ID: <20071116111450.GA22783@bre-cln-ukleine.digi.com>
References: <20071115105726.GA18555@bre-cln-ukleine.digi.com> <20071116104907.GA13087@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brian Swetland <swetland@google.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 16 12:13:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isz8r-0000Lc-4Z
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 12:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668AbXKPLN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 06:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755838AbXKPLN1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 06:13:27 -0500
Received: from mail164.messagelabs.com ([216.82.253.131]:59891 "HELO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752891AbXKPLN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 06:13:27 -0500
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-12.tower-164.messagelabs.com!1195211605!19861974!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Received: (qmail 9460 invoked from network); 16 Nov 2007 11:13:25 -0000
Received: from unknown (HELO owa.digi.com) (66.77.174.21)
  by server-12.tower-164.messagelabs.com with SMTP; 16 Nov 2007 11:13:25 -0000
Received: from mtk-sms-mail01.digi.com ([10.10.8.120]) by owa.digi.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 16 Nov 2007 05:13:24 -0600
Received: from zentaur.digi.com ([10.100.10.144]) by mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 16 Nov 2007 05:13:23 -0600
Received: by zentaur.digi.com (Postfix, from userid 1080)
	id 2692A49A5E; Fri, 16 Nov 2007 12:14:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071116104907.GA13087@sigill.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 16 Nov 2007 11:13:24.0341 (UTC) FILETIME=[B4536A50:01C82841]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65216>

Hello Jeff,

>  sub unquote_rfc2047 {
>  	local ($_) =3D @_;
> -	if (s/=3D\?utf-8\?q\?(.*)\?=3D/$1/g) {
> +	my $encoding;
> +	if (s/=3D\?([^?]+)\?q\?(.*)\?=3D/$2/g) {
> +		$encoding =3D $1;
>  		s/_/ /g;
>  		s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
>  	}
> -	return "$_";
> +	return wantarray ? ($_, $encoding) : $_;
>  }
I don't know perl very well, but that wantarray seems hacky.  (Somethin=
g
in my head wants to have it always return ($_, $encoding) and fix all
callers. :-)

>  [...]
> @@ -756,6 +769,21 @@ foreach my $t (@files) {
> =20
>  	if (defined $author) {
>  		$message =3D "From: $author\n\n$message";
> +		if (defined $author_encoding) {
> +			if ($has_content_type) {
> +				if ($body_encoding eq $author_encoding) {
> +					# ok, we already have the right encoding
> +				}
> +				else {
> +					# uh oh, we should re-encode
IMHO we should bail here or do the recoding (and bail if that fails).
OTH this patch improves send-emails behaviour because currently it
doesn't bother at all and with this patch it could at least fix the
common cases.

So

	Acked-by: Uwe Kleine-K=F6nig <Uwe.Kleine-Koenig@digi.com>

but note I only read the code, I didn't run it.

> +				}
> +			}
> +			else {
> +				push @xh,
> +				  'MIME-Version: 1.0',
> +				  "Content-Type: text/plain; charset=3D$author_encoding";
> +			}
> +		}
>  	}

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
