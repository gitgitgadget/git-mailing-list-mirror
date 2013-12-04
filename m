From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH 1/3] gitweb: Move check-ref-format code into separate
 function
Date: Wed, 04 Dec 2013 14:06:44 +0100
Message-ID: <1386162404.2173.15.camel@localhost.localdomain>
References: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
	 <1386082603-8404-2-git-send-email-krzesimir@endocode.com>
	 <xmqqd2ldoj0s.fsf@gitster.dls.corp.google.com>
	 <CANQwDwd0_bgKfjsRFjohmzBAnN7vDm-pYYsfe0Q71Za2K7Hw4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 14:07:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoCAT-00009P-Ov
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 14:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489Ab3LDNG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 08:06:58 -0500
Received: from mail-ea0-f169.google.com ([209.85.215.169]:44861 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932415Ab3LDNGr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 08:06:47 -0500
Received: by mail-ea0-f169.google.com with SMTP id l9so10883193eaj.28
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 05:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=MSFz+weKjRJ48JHGNsOonP9iW49QULD1wVvSLoK3Lqk=;
        b=lld4WaVYGdv5m8t8IbAhrj2vQ9kQ4OAEkU63ozm18vabyLEaomEtjMnxKMeAqUwphL
         ADVNWNyBeoawO1MzJoxLVd3ZavqqsrG9Kpdn5sHDeG8g0E/PWzylFRR87H3UWdym+1fD
         S6P0t0XTtctHF74rIq0huroTyC7+69pK7x5s7otoQxw2gIMVAa2qFQeW1LL1xDZjh9wR
         k7Sdf/0z+oYxS3BSgxAPzr8c/57vbor6PPaMSEwl1/Z2DIdmQz9b64I3e9tnkoro5INt
         J9sYsc82/VceraprfsYZ5V9I0dzxmEK3VYcXnMF3Iy5puZkj0/fF0nn61ZUxZiau3zqG
         5sMQ==
X-Gm-Message-State: ALoCoQnHvjlBaPUzYXLQJv2Ai9Lq7ckI28kHuExO2+/tSCxNrKFDcfcDWXhATFtpWvUv2d2EZVIy
X-Received: by 10.14.105.7 with SMTP id j7mr3962731eeg.95.1386162406373;
        Wed, 04 Dec 2013 05:06:46 -0800 (PST)
Received: from [192.168.1.100] (95-91-240-208-dynip.superkabel.de. [95.91.240.208])
        by mx.google.com with ESMTPSA id b41sm70767180eef.16.2013.12.04.05.06.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 04 Dec 2013 05:06:45 -0800 (PST)
In-Reply-To: <CANQwDwd0_bgKfjsRFjohmzBAnN7vDm-pYYsfe0Q71Za2K7Hw4w@mail.gmail.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238775>

On Tue, 2013-12-03 at 20:38 +0100, Jakub Nar=C4=99bski wrote:
> On Tue, Dec 3, 2013 at 8:02 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> > Krzesimir Nowak <krzesimir@endocode.com> writes:
>=20
> >> +sub check_ref_format {
> >> +     my $input =3D shift || return undef;
> >> +
> >> +     # restrictions on ref name according to git-check-ref-format
> >> +     if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> >> +             return undef;
> >> +     }
> >> +     return $input;
> >> +}
> [...]
> >> @@ -1462,10 +1472,9 @@ sub validate_refname {
> >>       # it must be correct pathname
> >>       $input =3D validate_pathname($input)
> >>               or return undef;
> >> -     # restrictions on ref name according to git-check-ref-format
> >> -     if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> >> -             return undef;
> >> -     }
> >
> > So far, so good.
> >
> >> +     # check git-check-ref-format restrictions
> >> +     $input =3D check_ref_format($input)
> >> +             or return undef;
> >>       return $input;
> >
> > Hmmm.  Why do you need "<LF><INDENT>or return under" here?  It woul=
d
> > not hurt too much per-se (strictly speaking, if the $input were a
> > string "0", this will return undef instead of "0", which should be
> > an OK name as far as the regexp is concerned), but it seems to be
> > making the logic unnecessarily complex for no real gain.
>=20
> I think this simply follows  "$input =3D validate_sth($input) or retu=
rn undef;"
> pattern used in this area of gitweb code (perhaps mis-used).
>=20

Reading the validate_* subs and check_ref_format sub makes me think tha=
t
they should just return either 0 when validation fails or 1 when it
succeeds.

If I add an extra branch ref named "0", then check_ref_format just
returns "0" as it matches the git-check-ref-format style regex. But "0"
is coerced to 0 and validate_and_filter_extra_branches will error out. =
I
actually reproduced that.

> Stricly speaking pure refactoring (no functional change, e.g. no assi=
gn
> to $input) would be  "check_ref_format($input) or return undef;", or =
even
> "return check_ref_format($input);" if we keep check_ref_format() pass=
thru
> on valid refname.
>=20

I fixed that too.

--=20
Krzesimir Nowak
Software Developer
Endocode AG

krzesimir@endocode.com

------
Endocode AG, Johannisstra=C3=9Fe 20, 10117 Berlin
info@endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Karl Beecher, Chris K=C3=BChl, Sebastian Sucker
Aufsichtsratsvorsitzende: Jennifer Beecher

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B
