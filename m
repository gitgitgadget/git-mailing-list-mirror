From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/5] gitweb: Split validate_input into validate_pathname and validate_refname
Date: Tue, 26 Sep 2006 09:55:02 +0200
Message-ID: <200609260955.02869.jnareb@gmail.com>
References: <200609260153.08503.jnareb@gmail.com> <200609260157.03035.jnareb@gmail.com> <7v1wpzw9l9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 09:55:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS7mW-0002CL-Uf
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 09:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWIZHzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 26 Sep 2006 03:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWIZHzF
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 03:55:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:59462 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750778AbWIZHzD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 03:55:03 -0400
Received: by ug-out-1314.google.com with SMTP id o38so566594ugd
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 00:55:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sUGn2UkoAEXOuLlrEdvnWrMQ31oxis4DTd1zNfThqXExmqw/2BI+4vx+zbMwUGwtJjRprOovmtCr7IrKUGc3dNMWRL8eqAqx3ztMPN2u5yw16x1KH5BRz+FUkSI0VaSMrgZFvO7IEjRWRtEHGmv57SZXa18+SOYiTJuBfg3iEgY=
Received: by 10.67.91.6 with SMTP id t6mr413080ugl;
        Tue, 26 Sep 2006 00:55:02 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id 30sm2880627ugf.2006.09.26.00.55.01;
        Tue, 26 Sep 2006 00:55:01 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7v1wpzw9l9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27784>

Dnia wtorek 26. wrze=B6nia 2006 06:11, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > @@ -387,16 +400,37 @@ sub href(%) {
> >  ##=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  ## validation, quoting/unquoting and escaping
> > =20
> > -sub validate_input {
> > -	my $input =3D shift;
> > +sub validate_pathname {
> > +	my $input =3D shift || return undef;
> > =20
> > -	if ($input =3D~ m/^[0-9a-fA-F]{40}$/) {
> > -		return $input;
> > +	# no '.' or '..' as elements of path, i.e. no '.' nor '..'
> > +	# at the beginning, at the end, and between slashes.
> > +	if ($input =3D~ m!(^|/)(|\.|\.\.)(/|$)!) {
> > +		return undef;
> >  	}
> > -	if ($input =3D~ m/(^|\/)(|\.|\.\.)($|\/)/) {
> > +	# no doubled slashes
> > +	if ($input =3D~ m!//!) {
> >  		return undef;
> >  	}
>=20
> I do not think you need the second check for double-slash.  The
> pattern you borrowed from the original:
>=20
> 	/(^|\/)(|\.|\.\.)($|\/)/)
>=20
> cleverly matches an empty string with $2, so you already match
> double-slash with $1 =3D '/' $2 =3D '' $3 =3D '/', don't you?

Do I need to resend patch, then, to remove this unnecessary check?

> > +	# it must be correct pathname
> > +	$input =3D validate_pathname($input)
> > +		or return undef;
> > +	# restrictions on ref name according to git-check-ref-format
> > +	if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> >  		return undef;
> >  	}
>=20
> Why would you need validate_pathname here?

refname _must_ be a valid pathname, no? It means for example that it
cannot have double slashes, not NUL (the only thinkg not covered by
git-check-ref-format restrictions). Well, we could add that to regexp
instead...

--=20
Jakub Narebski
Poland
