From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (BUGFIX) v2] gitweb: Fix handling of fractional timezones in parse_date
Date: Fri, 25 Mar 2011 17:50:54 +0100
Message-ID: <201103251750.56375.jnareb@gmail.com>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost> <201103251620.28811.jnareb@gmail.com> <AANLkTik5bLaR_0uhqGrNWW6U7z82KfmpNTyvRwkKFfj+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:51:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3AEF-0006lG-7U
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 17:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163Ab1CYQvI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 12:51:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64709 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782Ab1CYQvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 12:51:07 -0400
Received: by bwz15 with SMTP id 15so1043438bwz.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=cdridbrqVNtcDxEYAhQMb5izvcqCZZYQvbTXpl5IVaA=;
        b=yG3ineqWkODBE5uTxg2PMPWpVDHDDP/Qn9r2EKKCdlAAzVir1IYivUOymz51/N5PGY
         zL7PJ32jqHATLwbuNwzbMmMR5RlJ9yBbCUZI/ylqNHXFRJ1K1j4HYtB2QCoJrWPSXek+
         RTSapTIClf3uMzvlZ9pLd9jJq9dfOPXvo7ZtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BHVsoF1aGccWYxxWdZnhG3xspCNKKC5CIdWMCEYXI+4RnibcavxxV0zgrH9U3he0XA
         wJzJYDJDGFHyXtU5OgId/VzfbihWTqme66Scnrs0Wc7cEcvAmLOrtE6WCcmY0vK363Hk
         zQkaR01sCvi4ACg0V+ajgNGMLOgo1S/1rWQnY=
Received: by 10.204.140.18 with SMTP id g18mr932933bku.59.1301071865736;
        Fri, 25 Mar 2011 09:51:05 -0700 (PDT)
Received: from [192.168.1.13] (abwo211.neoplus.adsl.tpnet.pl [83.8.238.211])
        by mx.google.com with ESMTPS id c11sm879725bkc.14.2011.03.25.09.51.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 09:51:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTik5bLaR_0uhqGrNWW6U7z82KfmpNTyvRwkKFfj+@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169997>

On Fri, 25 Mar 2011, Kevin Cernekee wrote:
> 2011/3/25 Jakub Narebski <jnareb@gmail.com>:
> > @@ -2921,8 +2921,10 @@ sub parse_date {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0$date{'iso-8601'} =C2=A0=3D sprintf "%04=
d-%02d-%02dT%02d:%02d:%02dZ",
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1900+$year, 1+$mon, $mday, $hour ,$min, $s=
ec;
> >
> > - =C2=A0 =C2=A0 =C2=A0 $tz =3D~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
> > - =C2=A0 =C2=A0 =C2=A0 my $local =3D $epoch + ((int $1 + ($2/60)) *=
 3600);
> > + =C2=A0 =C2=A0 =C2=A0 my ($tz_sign, $tz_hour, $tz_min) =3D
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ($tz =3D~ m/^([+=
\-])([0-9][0-9])([0-9][0-9])$/);
>=20
> It's just a matter of personal preference, but I would find this
> regexp slightly easier to read:
>=20
> +               ($tz =3D~ m/^([+\-])([0-9]{2})([0-9]{2})$/);

I went for minimal changes, same as with the change below.

> > + =C2=A0 =C2=A0 =C2=A0 $tz_sign =3D ($tz_sign eq '-' ? -1 : +1);
> > + =C2=A0 =C2=A0 =C2=A0 my $local =3D $epoch + $tz_sign*($tz_hour + =
($tz_min/60.0))*3600;
>=20
> If you wanted to avoid floats, you could do something like:
>=20
> +       my $local =3D $epoch + $tz_sign * ($tz_hour * 3600 + $tz_min =
* 60);

Note that because valid $tz_min can be only 00, 30 or 45, see=20
e.g. http://en.wikipedia.org/wiki/List_of_time_zones_by_UTC_offset=20
therefore version using floats would not introduce any rounding
errors: 0, 0.5 and 0.75 can be represented exactly as 2-base float.

Anyway below is patch with above changes:

-- >8 --
Subject: [PATCH] gitweb: Fix handling of fractional timezones in parse_=
date

=46ractional timezones, like -0330 (NST used in Canada) or +0430
(Afghanistan, Iran DST), were not handled properly in parse_date; this
means values such as 'minute_local' and 'iso-tz' were not generated
correctly.

This was caused by two mistakes:

* sign of timezone was applied only to hour part of offset, and not
  as it should be also to minutes part (this affected only negative
  fractional timezones).

* 'int $h + $m/60' is 'int($h + $m/60)' and not 'int($h) + $m/60',
  so fractional part was discarded altogether ($h is hours, $m is
  minutes, which is always less than 60).


Note that positive fractional timezones +0430, +0530 and +1030 can be
found as authortime in git.git repository itself.

=46or example http://repo.or.cz/w/git.git/commit/88d50e7 had authortime
of "Fri, 8 Jan 2010 18:48:07 +0000 (23:48 +0530)", which is not marked
with 'atnight', when "git show 88d50e7" gives correct author date of
"Sat Jan 9 00:18:07 2010 +0530".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0178633..7b9f90b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2921,8 +2921,10 @@ sub parse_date {
 	$date{'iso-8601'}  =3D sprintf "%04d-%02d-%02dT%02d:%02d:%02dZ",
 	                     1900+$year, 1+$mon, $mday, $hour ,$min, $sec;
=20
-	$tz =3D~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
-	my $local =3D $epoch + ((int $1 + ($2/60)) * 3600);
+	my ($tz_sign, $tz_hour, $tz_min) =3D
+		($tz =3D~ m/^([+\-])([0-9]{2})([0-9]{2})$/);
+	$tz_sign =3D ($tz_sign eq '-' ? -1 : +1);
+	my $local =3D $epoch + $tz_sign*($tz_hour*3600 + $tz_min*60);
 	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) =3D gmtime($loc=
al);
 	$date{'hour_local'} =3D $hour;
 	$date{'minute_local'} =3D $min;
--=20
1.7.3
