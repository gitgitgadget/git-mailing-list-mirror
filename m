From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 06/17] gitweb/lib - Simple select(FH) based output capture
Date: Thu, 7 Oct 2010 01:22:24 +0200
Message-ID: <201010070122.25355.jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com> <1286402526-13143-7-git-send-email-jnareb@gmail.com> <AANLkTinO+wo8z_peiDragtZ1Y8rJZ1UziMXh2YqSJaLD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Thu Oct 07 01:22:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3dJz-0000ep-0x
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758992Ab0JFXWd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 19:22:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49399 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0JFXWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 19:22:32 -0400
Received: by bwz11 with SMTP id 11so88543bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 16:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9MywYf/i9fE5fRPQhqNzkxYM2uHbYMyGuu0KvMRRDHw=;
        b=MKy9ew07MvlsH0ylyFRO0GnRI0pFWMhgXVdQWoie0xOmN3gjwzzGxWn1MnBUH3F2jD
         HEJqsP6E80RxePI8fGEuBqx8MsBxDeMj5/aur2DFu+9j/yiQ2lBCK93tsqZaVWnolIyQ
         etp1wP1TJh/dgDxhLO24Z72MD4KkNh8gc3HHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YCw5NVZMKgXf6KvoLN/3iVURGALD34ZnnQmMo3q4XfXaJUFF3kuCTNKyZCSKIxixz5
         kOY7lsFe41y/0cTHGzmpf7Il2076FbT1hpjLgmKFF7Z9gYmSnvIY1GPMyV5z9EdV//c7
         TH7d42yXGvHF6GHbGN187mrRT2E+s/tzlHPK4=
Received: by 10.204.117.205 with SMTP id s13mr10243779bkq.140.1286407349762;
        Wed, 06 Oct 2010 16:22:29 -0700 (PDT)
Received: from [192.168.1.13] (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 11sm1094682bkj.11.2010.10.06.16.22.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 16:22:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTinO+wo8z_peiDragtZ1Y8rJZ1UziMXh2YqSJaLD@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158352>

Thomas Adam wrote:
> On 6 October 2010 23:01, Jakub Narebski <jnareb@gmail.com> wrote:

> > +sub capture {
> > + =C2=A0 =C2=A0 =C2=A0 my ($self, $code) =3D @_;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 $self->start();
> > + =C2=A0 =C2=A0 =C2=A0 $code->();
>=20
> unless( defined $code and ref($code) eq 'CODE' )
> {
>        # Error?
>         ....
> }

But what to do if $code is *not* a code reference?  Well, except perhap=
s
providing better error message...

> > + =C2=A0 =C2=A0 =C2=A0 return $self->stop();
> > +}
> > +
> > +# Wrap caching data; capture only STDOUT
> > +sub capture_block (&) {
>=20
> This is prototyped deliberately?

Yes, it is prototyped deliberately to be able to use it like this

  my $data =3D capture_block {
     ...
  }

similarly to the API used by Capture::Tiny (which is not in core, which
captures also STDERR, and which do not provide capture_stop() equivalen=
t
for die_error to be not captured and cached).

Only to explicitely discard prototype with '&capture_block($code)', whe=
n
using it in ->cache_output_* methods in GitwebCache::CacheOutput ;-)

--=20
Jakub Narebski
Poland
