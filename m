From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Mon, 10 Jun 2013 22:19:33 +0200
Message-ID: <20130610201933.GI2091@goldbirke>
References: <7vd2rvqgra.fsf@alter.siamese.dyndns.org>
 <CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com>
 <7vy5ajozuj.fsf@alter.siamese.dyndns.org>
 <CAMP44s38T9EUOe8EBKy1kxa-rEu7g0jb7+HB019AgCub+2SVnw@mail.gmail.com>
 <7vfvwrowd0.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Qr54+8hbkZ+jmXB628SCPwg1zZo80UBhFe2PCrgQP4Q@mail.gmail.com>
 <20130610093904.GG2091@goldbirke>
 <7vppvuj6wl.fsf@alter.siamese.dyndns.org>
 <20130610172708.GH2091@goldbirke> <51B623DA.4050802@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jun 10 22:19:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um8ZA-0000a5-T6
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 22:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab3FJUTp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 16:19:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:52509 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab3FJUTo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 16:19:44 -0400
Received: from localhost6.localdomain6 (g227025092.adsl.alicedsl.de [92.227.25.92])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0M9z92-1UfVni1Pia-00B3ON; Mon, 10 Jun 2013 22:19:34 +0200
Content-Disposition: inline
In-Reply-To: <51B623DA.4050802@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:wRgsY2iXuNqNeUC0VBmBgivXne79RFKw7I2Vayh9gFS
 sDa/wJIu/tAMv3ZLEaUx8MPas6PbcyXHclm+pTy58QIFwIuPb1
 HbGD24pqTDhhho89sB49rJQ2HPHz5aThilD087CouijD6EtMEt
 hHsHXtT4LdbbVgUkOorNWj81HWiUn9NcS7JsdgPtmfQw2+uJS+
 //apEvoPPCkw5sKJOI1CGecuzoShVJQ5eEm+ZdpZa/I0jD+/wU
 4VmpjAQRGZE1NDkGd3LBZRFczrfPCpkUu5V+Yb2+Wn9HcI4XCT
 6wca4HmFObZ90exgYhY2Mp5DI4aWJNUp9TjmrO6U7LxI8az3Lg
 yyb7EQi8v0cQiPwWNHRg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227371>

On Mon, Jun 10, 2013 at 09:07:06PM +0200, Johannes Sixt wrote:
> Am 10.06.2013 19:27, schrieb SZEDER G=E1bor:
> > My main motivation is that, like in your example, in the bash promp=
t
> > tests I only have to check a single line of output, but because of
> > debuggability I always did:
> >=20
> >   echo "(master)" >expected
> >   __git_ps1 >actual
> >   test_cmp expected actual
>=20
> Chained by &&, I presume.

Sure.

> > With such a helper function this could be reduced to a single line:
> >=20
> >   test_string_equal "(master)" "$(__git_ps1)"
> >=20
> > without loss of functionality
>=20
> Not quite: A non-zero exit code of the $(__git_ps1) is lost. (It
> probably doesn't matter here, but it certainly does if the command is
> $(git rev-parse foo) or similar.)

Ouch, indeed.  Yeah, the exit code doesn't matter for the prompt tests
(I mean for __git_ps1() tests, but maybe it does matter for some
__gitdir() tests), but I suppose it does matter everywhere else where
the same construct is used.  We could still do

  actual=3D"$(git foo)" &&
  test_string_equal "good" "$actual"

to preserve and check the exit code, and this is still one line
shorter, but overall not that appealing anymore.

However.  The git command's exit code is lost the same way in 'test
good =3D $(git foo)' constructs, too, and plenty of such constructs are
all over the test suite.  Shouldn't we avoid using such constucts
then?


G=E1bor
