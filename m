From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 07/10] send-email: reduce dependencies impact on parse_address_line
Date: Tue, 07 Jul 2015 15:27:17 +0200
Message-ID: <vpq8uasqeru.fsf@anie.imag.fr>
References: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435666611-18429-8-git-send-email-Matthieu.Moy@imag.fr>
	<559B9DEB.9030409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 07 15:27:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCSuR-0007Xk-Ez
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 15:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757270AbbGGN1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2015 09:27:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37562 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756672AbbGGN13 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 09:27:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t67DRFWm008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 7 Jul 2015 15:27:15 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t67DRH7G004173;
	Tue, 7 Jul 2015 15:27:17 +0200
In-Reply-To: <559B9DEB.9030409@web.de> ("Torsten \=\?iso-8859-1\?Q\?B\=F6gersha\?\=
 \=\?iso-8859-1\?Q\?usen\=22's\?\= message of
	"Tue, 7 Jul 2015 11:37:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 07 Jul 2015 15:27:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t67DRFWm008578
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436880437.26618@lzo+HZK4A0XFqxtQYeXOrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273500>

Torsten B=F6gershausen <tboegi@web.de> writes:

> #!/usr/bin/perl
>
> Should we have hard-coded PATH to perl here ?

This is what is done in other tests:

$ head t*/test.pl -n 1
=3D=3D> t0202/test.pl <=3D=3D
#!/usr/bin/perl

=3D=3D> t9000/test.pl <=3D=3D
#!/usr/bin/perl

=3D=3D> t9700/test.pl <=3D=3D
#!/usr/bin/perl

We actually don't use it when running the testsuite properly, since we
call

  perl "$TEST_DIRECTORY"/t9000/test.pl

and perl is defined as

  perl () {
  	command "$PERL_PATH" "$@"
  }

So, it's OK.

> /usr/bin/perl --version
> This is perl, v5.10.0 built for darwin-thread-multi-2level
> (with 2 registered patches, see perl -V for more detail)
>
>> +
>> +my $is_passing =3D Test::More->builder->is_passing;
>> +exit($is_passing ? 0 : 1);
>>=20
>
> This seems to give problems:
> debug=3Dt verbose=3Dt ./t9000-addresses.sh

Indeed, is_passing seems too recent for your version of perl. A similar
problem was solved in t9700 by 635155f (t9700: Use Test::More->builder,
not $Test::Builder::Test, 2010-06-26). I'll use the same solution:

my $is_passing =3D eval { Test::More->is_passing };
exit($is_passing ? 0 : 1) unless $@ =3D~ /Can't locate object method/;

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
