From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V2] git-send-email.perl: Add --to-cmd
Date: Thu, 23 Sep 2010 18:20:54 -0700
Message-ID: <1285291254.25928.223.camel@Joe-Laptop>
References: <AANLkTinsM5jdU194FR8L3hTvBXk0Tr_oV2E5752NOUpq@mail.gmail.com>
	 <AANLkTikkJNwF4LS9rx5=bHM2R0Pm751Y1u9V8iAt0w1A@mail.gmail.com>
	 <1285227413.7286.47.camel@Joe-Laptop>
	 <Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
	 <20100923090931.GA29789@albatros> <20100923120024.GA26715@albatros>
	 <1285253867.31572.13.camel@Joe-Laptop>
	 <Pine.LNX.4.64.1009231757090.11585@ask.diku.dk>
	 <1285262237.31572.18.camel@Joe-Laptop>
	 <AANLkTin_Y8w4ujNGTqGJPNDNfYz7hcjBVLcOG0emBjYn@mail.gmail.com>
	 <1285263993.31572.25.camel@Joe-Laptop>
	 <AANLkTinCx=+n6bMZw4tQqrQ7WC1o_aeGG_n_PxywTyb8@mail.gmail.com>
	 <1285267520.31572.34.camel@Joe-Laptop>
	 <7v62xwqe7i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Julia Lawall <julia@diku.dk>, git <git@vger.kernel.org>,
	Vasiliy Kulikov <segooon@gmail.com>,
	matt mooney <mfmooney@gmail.com>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 03:21:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OywyE-0000US-5k
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 03:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756313Ab0IXBU4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 21:20:56 -0400
Received: from mail.perches.com ([173.55.12.10]:2325 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504Ab0IXBUz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 21:20:55 -0400
Received: from [192.168.1.156] (unknown [192.168.1.156])
	by mail.perches.com (Postfix) with ESMTP id AA1B024368;
	Thu, 23 Sep 2010 18:20:48 -0700 (PDT)
In-Reply-To: <7v62xwqe7i.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156930>

On Thu, 2010-09-23 at 15:37 -0700, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
>=20
> > +	if (defined $to_cmd) {
> > +		open(F, "$to_cmd \Q$t\E |")
> > +			or die "(to-cmd) Could not execute '$to_cmd'";
> > +		while(<F>) {
> > +			my $t =3D $_;
>=20
> "my $t" masks another $t in the outer scope; technically not a bug, b=
ut
> questionable as a style.
>=20
> > +			$t =3D~ s/^\s*//g;
> > +			$t =3D~ s/\n$//g;
> > +			next if ($t eq $sender and $suppress_from);
> > +			push @to, parse_address_line($t)
> > +			    if defined $t; # sanitized/validated later
>=20
> This "if defined $t" makes my head hurt.  Why?
>=20
>  * The "while (<F>)" loop wouldn't have given you an undef in $t in t=
he
>    first place;
>=20
>  * You would have got "Use of uninitialized value" warning at these t=
wo
>    s/// statements if $t were undef; and
>=20
>  * Even if $t were undef, these two s/// statements would have made $=
t a
>    defined, empty string.

all true.

> > +			printf("(to-cmd) Adding To: %s from: '%s'\n",
> > +				$t, $to_cmd) unless $quiet;
> > +		}
> > +		close F
> > +			or die "(to-cmd) failed to close pipe to '$to_cmd'";
> > +	}
>=20
> In any case, this whole codeblock obviously is a copy-and-paste from
> corresponding $cc_cmd codepath, and I wonder if you can refactor the
> original into a common helper function first and then use it to make =
the
> addition of this feature a smaller patch.
>=20
> 	if (defined $cc_cmd) {
>         	push @cc, recipients_cmd($cc_cmd, 'cc');
> 	}
>         if (defined $to_cmd) {
> 	        push @to, recipients_cmd($to_cmd, 'to');
> 	}

Overall, I believe it'll be more code, but all right.

> If you did so, the first patch that refactors to create a helper func=
tion
> can address issues =C3=86var raised in the review to clean things up,=
 no?

> I notice that you use parse_address_line() while $cc_cmd codepath doe=
sn't.
> I haven't studied other codepaths deeply, but my gut feeling is that =
the
> reason why the $cc_cmd codepath does not call parse_address_line() be=
fore
> pushing the result to @cc is _not_ because strings on @cc shouldn't b=
e
> sanitized (the codepath to parse "Cc: " calls parse_address_line and
> pushes the result to @cc), but because the code is simply sloppy.

Probably, I wrote some of those lines...
