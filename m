From: "J.H." <warthog9@kernel.org>
Subject: Re: gitweb: cloud tags feature produces malformed XML for errors
Date: Tue, 01 Mar 2011 17:06:03 -0800
Message-ID: <4D6D97FB.3050106@kernel.org>
References: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek> <20110301222141.GB7918@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
	<u.kleine-koenig@pengutronix.de>, admin@repo.or.cz
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 02:06:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuaWG-0005EO-Iq
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 02:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757658Ab1CBBGS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 20:06:18 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:41725 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757552Ab1CBBGR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 20:06:17 -0500
Received: from voot-cruiser.eaglescrag.net (173-23-136-205.client.mchsi.com [173.23.136.205])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p22163lb000773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 1 Mar 2011 17:06:04 -0800
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <20110301222141.GB7918@elie>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Tue, 01 Mar 2011 17:06:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168286>

On 03/01/2011 02:21 PM, Jonathan Nieder wrote:
> (resending, censored for vger; sorry for the noise)
> Hi Jakub et al,
>=20
> Uwe Kleine-K=C3=B6nig wrote [1]:
>=20
>> I experiment with $feature{'ctags'}.  After installing
>> libhtml-tagcloud-perl (0.34-1) and adding
>>
>> 	$feature{'ctags'}{'default'} =3D [1];
>>
>> to gitweb.conf and doing
>>
>> 	mkdir ctags
>> 	echo Linux > ctags/Linux
>>
>> in the only repository served by gitweb makes iceweasel barf on the
>> output (see attachment).
>=20
> With chromium I get:
>=20
> 	This page contains the following errors:
>=20
> 	error on line 26 at column 6: XML declaration allowed only at the st=
art of the document
> 	Below is a rendering of the page up to the first error.
>=20
> First, we hit
>=20
> 	if ($show_ctags) {
> 		my %ctags;
> 		foreach my $p (@projects) {
> 			foreach my $ct (keys %{$p->{'ctags'}}) {
> 				$ctags{$ct} +=3D $p->{'ctags'}->{$ct};
>=20
> which produces a warning warning in error.log:
>=20
> 	index.cgi: Argument "Linux" isn't numeric in addition (+) at /usr/sh=
are/gitweb/index.cgi line 4819.
>=20
> in error.log.  Then we hit git_show_project_tagcloud, which dies in
> "$cloud->html_and_css($count);" with
>=20
> 	HTML::TagCloud..
> 	index.cgi: Can't take log of 0 at /usr/share/perl5/HTML/TagCloud.pm =
line 67.
>=20
> For some reason, the result is an _embedded_ error page:
>=20
> 	<form method=3D"get" action=3D"/gitweb/" enctype=3D"application/x-ww=
w-form-urlencoded">=20
> 	<p class=3D"projsearch">Search:
> 	<input type=3D"text" name=3D"s"  />=20
> 	</p>=20
> 	</form>=20
> 	Content-type: {a content type which shall not be named}
> 	=20
> 	<?xml version=3D"1.0" encoding=3D"utf-8"?>=20
>  [...]
> 	500 - Internal Server Error
>=20
> So I suspect there are two bugs here.
>=20

As a general note the cloud tags code that's there has a whole slew of
problems, including a pretty trivial way to crash gitweb entirely if th=
e
tags file is malformed in any way to what it's expecting.

I've said it before, I'd rather see that code reverted or completely
overhauled, and as far as I know repo.or.cz is the only place even usin=
g
the code at all.

I also think I reported this particular error a couple of years ago
(with the file being malformed and causing all kinds of problems).  The
fact that the tags don't follow the repository when it's cloned more or
less makes this entire feature a giant PITA, couple that with no good
documentation on how to create the tag files (I think the file itself
needs to have filename of tag, and *ONLY* contain 1 for it's contains
for it to work)

Linux:
1
EOF

- John 'Warthog9' Hawley
