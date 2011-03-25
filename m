From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix handling of fractional timezones in parse_date
Date: Fri, 25 Mar 2011 09:26:22 -0700
Message-ID: <AANLkTik5bLaR_0uhqGrNWW6U7z82KfmpNTyvRwkKFfj+@mail.gmail.com>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>
	<1300925335-3212-2-git-send-email-warthog9@eaglescrag.net>
	<201103241617.37400.jnareb@gmail.com>
	<201103251620.28811.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:26:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q39qS-0000dF-BH
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 17:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311Ab1CYQ0d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 12:26:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61558 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228Ab1CYQ0b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 12:26:31 -0400
Received: by fxm17 with SMTP id 17so1279738fxm.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HYZHa+nC+F9VxcYqnP148c+kc3bNKOYLke/kDDpbwYw=;
        b=RGYGLsp4l1jkl5nLTL/m44wfInTp1FIa8x2+I5ZijPQH6c9sOF72c8+6F2QRJwH9Ey
         CX53jdCsi/FV2I19UGqjcyqX0NO9sTEI8ERl8aGogVoNNW/njOg9thmg7jtRII+OJwzW
         /8qEDHdnPb1hbS+1QU6znJYEltzScvpF0FLsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=THPDje/fdQeYxOymQf7AMtL2GWdZRGyteuZilCXrxt+P2aD8IbalC3OT3hTQGGbnsw
         cpE0ViMq5fO936KAF/xDbFHT93tzSnwxPAUQT/Us8BZUMrr6LWtSEaU6fufP11wNDvM4
         BmxkTvlA3p/ki3hQVDJRlx6hX1SS7c4igZqHo=
Received: by 10.223.14.22 with SMTP id e22mr1116300faa.64.1301070382864; Fri,
 25 Mar 2011 09:26:22 -0700 (PDT)
Received: by 10.223.145.131 with HTTP; Fri, 25 Mar 2011 09:26:22 -0700 (PDT)
In-Reply-To: <201103251620.28811.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169996>

2011/3/25 Jakub Narebski <jnareb@gmail.com>:
> @@ -2921,8 +2921,10 @@ sub parse_date {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$date{'iso-8601'} =C2=A0=3D sprintf "%04d-=
%02d-%02dT%02d:%02d:%02dZ",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1900+$year, 1+$mon, $mday, $hour ,$min, $s=
ec;
>
> - =C2=A0 =C2=A0 =C2=A0 $tz =3D~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
> - =C2=A0 =C2=A0 =C2=A0 my $local =3D $epoch + ((int $1 + ($2/60)) * 3=
600);
> + =C2=A0 =C2=A0 =C2=A0 my ($tz_sign, $tz_hour, $tz_min) =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ($tz =3D~ m/^([+\-=
])([0-9][0-9])([0-9][0-9])$/);

It's just a matter of personal preference, but I would find this
regexp slightly easier to read:

+               ($tz =3D~ m/^([+\-])([0-9]{2})([0-9]{2})$/);

> + =C2=A0 =C2=A0 =C2=A0 $tz_sign =3D ($tz_sign eq '-' ? -1 : +1);
> + =C2=A0 =C2=A0 =C2=A0 my $local =3D $epoch + $tz_sign*($tz_hour + ($=
tz_min/60.0))*3600;

If you wanted to avoid floats, you could do something like:

+       my $local =3D $epoch + $tz_sign * ($tz_hour * 3600 + $tz_min * =
60);
