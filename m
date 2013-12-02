From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH v3] gitweb: Add an option for adding more branch refs
Date: Mon, 02 Dec 2013 11:13:19 +0100
Message-ID: <1385979199.2054.2.camel@localhost.localdomain>
References: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>
	 <CAPig+cSjzpSatp9EhpwA9b_XScAPUpkMxmPo70qJCxxakMwq3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 11:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnQVs-0002d3-6L
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 11:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab3LBKN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 05:13:28 -0500
Received: from mail-bk0-f43.google.com ([209.85.214.43]:41248 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab3LBKNX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 05:13:23 -0500
Received: by mail-bk0-f43.google.com with SMTP id mz12so5317052bkb.30
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 02:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=eqDikqH+xSDpILD7NuBgAo6Nhej8MGBNFbIxXLEadjU=;
        b=FZ533DHXMsWAzYVwa13dB5lWbst7dnZC0pW7p3SxSkgPCiu0kwI9RSX4W/KaE2HVrZ
         jt+CEVvknpJEanNP0cFjmpVB0u0HQ4gsFeHGnrf8QwGmo9YHkBp+NOVcbk5nYnFI6Bm/
         NJrB0bEoqYPYxDj1wEQW9xmoQ3VJRuo1/hUhBmWahrYtNNl0glz1b+zk5cAeRFh/hh6H
         FFL4/hEIZMPG7riNPirHG0msr8AEpAplj4kCpmzIdP+TDIBZg++rZatRnRi+MFAcp/OH
         PlYAYRcCEtaHCL3oCEVgy/bAPxJTaI6fNpKTYj7G+lqluD0UXlDD28x/sIu9Wnd+lCWx
         J49w==
X-Gm-Message-State: ALoCoQm2J8UGS/TWY015ecV+p423Kim3EJ3oX1U0EbbQSzyC7DjDl6BkmIGKmsYmWEY9JexxBtvv
X-Received: by 10.204.242.4 with SMTP id lg4mr77119bkb.103.1385979201669;
        Mon, 02 Dec 2013 02:13:21 -0800 (PST)
Received: from [192.168.1.100] (95-91-241-36-dynip.superkabel.de. [95.91.241.36])
        by mx.google.com with ESMTPSA id on10sm74259113bkb.13.2013.12.02.02.13.20
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 02 Dec 2013 02:13:21 -0800 (PST)
In-Reply-To: <CAPig+cSjzpSatp9EhpwA9b_XScAPUpkMxmPo70qJCxxakMwq3Q@mail.gmail.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238623>

On Thu, 2013-11-28 at 20:13 -0500, Eric Sunshine wrote:
> On Thu, Nov 28, 2013 at 6:44 AM, Krzesimir Nowak <krzesimir@endocode.=
com> wrote:
> > Allow @additional_branch_refs configuration variable to tell gitweb=
 to
> > show refs from additional hierarchies in addition to branches in th=
e
> > list-of-branches view.
> >
> > Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> > ---
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 68c77f6..25e1d37 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -680,6 +688,19 @@ sub read_config_file {
> >         return;
> >  }
> >
> > +# performs sanity checks on parts of configuration.
> > +sub config_sanity_check {
> > +       # check additional refs validity
> > +       my %unique_branch_refs =3D ();
> > +       for my $ref (@additional_branch_refs) {
> > +               die_error(500, "Invalid ref '$ref' in \@additional_=
branch_refs") unless (validate_ref($ref));
> > +               # 'heads' are added implicitly in get_branch_refs()=
=2E
> > +               $unique_branch_refs{$ref} =3D 1 if ($ref ne 'heads'=
);
> > +       }
> > +       @additional_branch_refs =3D sort keys %unique_branch_refs;
> > +       %unique_branch_refs =3D undef;
> > +}
>=20
> %unique_branch_refs is going out of scope here, so clearing it seems
> unnecessary.

I am cleaning it in case when more sanity checking code gets added. So
there is no need to keep the data further.=20

>=20
> Moreover, with warnings enabled, perl should be complaining about an
> "Odd number of elements in hash assignment". (Normally, you would
> clear a hash with '%foo=3D()' or 'undef %foo'.)
>=20

Gah, ok. I'll fix it. Thanks.

> > +
> >  our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM, $GITWEB_CONFIG_COMMON)=
;
> >  sub evaluate_gitweb_config {
> >         our $GITWEB_CONFIG =3D $ENV{'GITWEB_CONFIG'} || "++GITWEB_C=
ONFIG++";

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
