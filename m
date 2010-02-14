From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Die if there are parsing errors in config file
Date: Sun, 14 Feb 2010 22:46:28 +0100
Message-ID: <201002142246.29478.jnareb@gmail.com>
References: <20100207093744.29846.6468.stgit@localhost.localdomain> <7v8wava55y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "J.H." <warthog19@eaglescrag.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 22:47:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgmIy-0003BY-31
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 22:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925Ab0BNVqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 16:46:39 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:63979 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab0BNVqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 16:46:38 -0500
Received: by fxm27 with SMTP id 27so15263fxm.25
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 13:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4WW3RESD9TcaSiUU+srrB52N5igQwbsLRihcdAJUDVI=;
        b=tXBizDXCQ/8paX7D6Rq2I4vCZ/USXtu5ToLZQJ3Oq7iAEuE/WHqYJR6EeyEF1XuZp4
         Pi1hCwu+zIZip9kpZXKZnG57iImwFU4GYL4ulivmoMRfdN5oFQkVxI37+7IHpP10J8x6
         JWJO7Sxx1dSdkH5gWfRlZUJgC5wb69Y+MIhcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bCvrY16+wjmnrEUlbX20ibjtc4fEMYAgWuXqpXUW8hfqB5McyhvIIUI1wIC9PPjsfo
         f36OfusQ2D6H1VsziSS4XmNzcdx8NIlXZsgK01hhyQl3jne8A9Cmd20zA3V0oxKhkMDZ
         10ISyvacjekTSTxl0rjD64/unuEP9PlAMjqGA=
Received: by 10.223.145.140 with SMTP id d12mr3501593fav.7.1266183996563;
        Sun, 14 Feb 2010 13:46:36 -0800 (PST)
Received: from ?192.168.1.13? (abwr159.neoplus.adsl.tpnet.pl [83.8.241.159])
        by mx.google.com with ESMTPS id 22sm8951662fkr.27.2010.02.14.13.46.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 13:46:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8wava55y.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139943>

Dnia niedziela 14. lutego 2010 22:17, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 1f6978a..a5bc359 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -556,6 +556,8 @@ if (-e $GITWEB_CONFIG) {
> >  	our $GITWEB_CONFIG_SYSTEM =3D $ENV{'GITWEB_CONFIG_SYSTEM'} || "++=
GITWEB_CONFIG_SYSTEM++";
> >  	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
> >  }
> > +# die if there are errors parsing config file
> > +die $@ if $@;
>=20
> I cannot figure out $@ from which command this if statement modifier =
is
> checking when none of GITWEB_CONFIG or GITWEB_CONFIG_SYSTEM candidate=
s is
> present.  Neither of the "do" executes in such a case.  Do you end up
> checking the result from the very first eval that checks if Time::HiR=
es
> can be "require"d successfully?

Good catch.  There is corrected patch.

-- >8 --
Subject: [PATCH] gitweb: Die if there are parsing errors in config file

Otherwise the errors can propagate, and show in damnest places, and
you would spend your time chasing ghosts instead of debugging real
problem (yes, it is from personal experience).

This follows (parts of) advice in `perldoc -f do` documentation.

This required restructoring code a bit, so we die only if we are readin=
g
(executing) config file.  As a side effect $GITWEB_CONFIG_SYSTEM is alw=
ays
available, even when we use $GITWEB_CONFIG.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Probably-Acked-by: John 'Warthog9' Hawley <warthog9@kernel.org>

 gitweb/gitweb.perl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1f6978a..20106a4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -550,11 +550,14 @@ sub filter_snapshot_fmts {
 }
=20
 our $GITWEB_CONFIG =3D $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
+our $GITWEB_CONFIG_SYSTEM =3D $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWE=
B_CONFIG_SYSTEM++";
+# die if there are errors parsing config file
 if (-e $GITWEB_CONFIG) {
 	do $GITWEB_CONFIG;
-} else {
-	our $GITWEB_CONFIG_SYSTEM =3D $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITW=
EB_CONFIG_SYSTEM++";
-	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
+	die $@ if $@;
+} elsif (-e $GITWEB_CONFIG_SYSTEM) {
+	do $GITWEB_CONFIG_SYSTEM;
+	die $@ if $@;
 }
=20
 # Get loadavg of system, to compare against $maxload.
--=20
1.6.6.1
