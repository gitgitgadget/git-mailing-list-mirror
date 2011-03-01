From: Jonathan Nieder <jrnieder@gmail.com>
Subject: gitweb: cloud tags feature produces malformed XML for errors
Date: Tue, 1 Mar 2011 16:21:41 -0600
Message-ID: <20110301222141.GB7918@elie>
References: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, admin@repo.or.cz,
	John Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 23:21:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuXx3-0006hb-FQ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 23:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575Ab1CAWVs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 17:21:48 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43151 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab1CAWVs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 17:21:48 -0500
Received: by wyg36 with SMTP id 36so5186053wyg.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 14:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3v1kmD4Bo7qwBZVCbpOH7Wk6I/nrL4sTNNBIM/VaZC8=;
        b=NedjvwJuVcy5nwHEWrgrtEpQ8r8bw5ZCqlwE13mrf6Tu7gsrDNLuecuLFBdSeLx9K5
         nO7pw1XvsHWOvp9rhXlbvGrMmYpxoKrwbLYJOx39P3I4JG8IyvNZcnLfxJdm31WpotG+
         /OQ6O41dk03U1uZ4mX3a3Bqs0Wk8qK12KfNa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JlbeUCrulNgDUEBo1fCRoye8PdsYnv6LvJZERyMxo1EfIQ6nPiwwqsXLjsoDTWV79y
         CBYMX0I6WV9ByBoxDrXb5u/UC4pimbHbcfOv4gBJVkY9d/gSNEfMiFC2U1IGVniFDs22
         SqY5M25722cu1/WlSnqUg1y+/JhO+JPpotwTY=
Received: by 10.216.71.13 with SMTP id q13mr6592747wed.21.1299018106217;
        Tue, 01 Mar 2011 14:21:46 -0800 (PST)
Received: from elie (adsl-76-206-235-173.dsl.chcgil.sbcglobal.net [76.206.235.173])
        by mx.google.com with ESMTPS id a50sm2746461wer.42.2011.03.01.14.21.44
        (version=SSLv3 cipher=OTHER);
        Tue, 01 Mar 2011 14:21:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168266>

(resending, censored for vger; sorry for the noise)
Hi Jakub et al,

Uwe Kleine-K=C3=B6nig wrote [1]:

> I experiment with $feature{'ctags'}.  After installing
> libhtml-tagcloud-perl (0.34-1) and adding
>
>	$feature{'ctags'}{'default'} =3D [1];
>
> to gitweb.conf and doing
>
> 	mkdir ctags
> 	echo Linux > ctags/Linux
>
> in the only repository served by gitweb makes iceweasel barf on the
> output (see attachment).

With chromium I get:

	This page contains the following errors:

	error on line 26 at column 6: XML declaration allowed only at the star=
t of the document
	Below is a rendering of the page up to the first error.

=46irst, we hit

	if ($show_ctags) {
		my %ctags;
		foreach my $p (@projects) {
			foreach my $ct (keys %{$p->{'ctags'}}) {
				$ctags{$ct} +=3D $p->{'ctags'}->{$ct};

which produces a warning warning in error.log:

	index.cgi: Argument "Linux" isn't numeric in addition (+) at /usr/shar=
e/gitweb/index.cgi line 4819.

in error.log.  Then we hit git_show_project_tagcloud, which dies in
"$cloud->html_and_css($count);" with

	HTML::TagCloud..
	index.cgi: Can't take log of 0 at /usr/share/perl5/HTML/TagCloud.pm li=
ne 67.

=46or some reason, the result is an _embedded_ error page:

	<form method=3D"get" action=3D"/gitweb/" enctype=3D"application/x-www-=
form-urlencoded">=20
	<p class=3D"projsearch">Search:
	<input type=3D"text" name=3D"s"  />=20
	</p>=20
	</form>=20
	Content-type: {a content type which shall not be named}
	=20
	<?xml version=3D"1.0" encoding=3D"utf-8"?>=20
 [...]
	500 - Internal Server Error

So I suspect there are two bugs here.

Ideas?
Jonathan

[1] http://bugs.debian.org/616005
