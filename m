From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUGFIX PATCH 1/4] git-instaweb: Fix issue with static files for 'plackup' server
Date: Thu, 30 Dec 2010 01:40:06 +0100
Message-ID: <201012300140.07843.jnareb@gmail.com>
References: <201012291743.41213.jnareb@gmail.com> <201012291747.01288.jnareb@gmail.com> <7v1v50rvat.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tadeusz Sosnierz <tadzikes@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 30 01:40:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY6Z7-0004sd-I5
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 01:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab0L3AkQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Dec 2010 19:40:16 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54077 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab0L3AkO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 19:40:14 -0500
Received: by bwz15 with SMTP id 15so11384342bwz.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 16:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/aPnLmClI4wfU+TS2bUeIxhZUfYjacSmSPMvrY40n4w=;
        b=XFiYBZ2YOiuD7f0z+j7HLER4NP2XtUMBQFQnywp7O3IhQ0xq/sznhj97asOqaZWb6b
         KPI4BCXhWJv/OHBi+cejTk8MoCaAlVDuGstryRnzaL+gPPGpqUDVM1Mag7ip1mMfLKdW
         rncKXIQVitAM3e1siOUfZSA1/ID7iABI0BEz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EAd1xlG631MW1/4/agjCa7uTgrEG1nV7Pe7JbZJ/wC5Q+Z3n3BVHvS9KPr0Z+tR/A7
         cbYvxZSUzlMSeMWqWVgdm6cpyz2ysV81fONKT141g59m3XqVa6Sc0VoVQgitPP1q/oan
         AnS1u27UCXA85fb3TP8yDUsQ4B0QgiR/m5HcY=
Received: by 10.204.72.130 with SMTP id m2mr4126015bkj.15.1293669613569;
        Wed, 29 Dec 2010 16:40:13 -0800 (PST)
Received: from [192.168.1.13] (abvc66.neoplus.adsl.tpnet.pl [83.8.200.66])
        by mx.google.com with ESMTPS id b6sm8121849bkb.22.2010.12.29.16.40.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 16:40:12 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v1v50rvat.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164342>

On Thu, 30 Dec 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > The default (in gitweb/Makefile) is to use relative paths for gitwe=
b
> > static files, e.g. "static/gitweb.css" for GITWEB_CSS.  But the
> > configuration for Plack::Middleware::Static in plackup_conf assumed
> > that static files must be absolute paths starting with "/gitweb/"
> > prefix which had to be stripped, e.g. "/gitweb/static/gitweb.css".
> > This in turn caused web server run by "git instaweb --httpd=3Dplack=
up"
> > to not access static files (e.g. CSS) correctly.
> >
> > This is a minimal fixup, making 'plackup' web server in git-instawe=
b
> > work with default gitweb build configuration.
> >
> > Reported-by: Tadeusz So=C5=9Bnierz <tadzikes@gmail.com>
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> > The regexp is probably too strict: qr{^/static/} should be enough,
> > but I didn't want to change too much at once.
[...]
> > diff --git a/git-instaweb.sh b/git-instaweb.sh
> > index 10fcebb..bb57d81 100755
> > --- a/git-instaweb.sh
> > +++ b/git-instaweb.sh
> > @@ -549,7 +549,7 @@ my \$app =3D builder {
> >  	};
> >  	# serve static files, i.e. stylesheet, images, script
> >  	enable 'Static',
> > -		path =3D> sub { m!\.(js|css|png)\$! && s!^/gitweb/!! },
> > +		path =3D> qr{^/static/.*(?:js|css|png)\$},
>=20
> I wonder if you meant qr{^/static/.*\\.(?:js|css|png)\$} here, to mak=
e
> sure that these three tokens are file suffixes, not just random
> substring.

Yes, it should be qr{^/static/.*\\.(?:js|css|png)\$} though as I said:
"The regexp is probably too strict: qr{^/static/} should be enough,"

--=20
Jakub Narebski
Poland
