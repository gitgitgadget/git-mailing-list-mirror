From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] HOME must be set before calling git-init when creating
 test repositories
Date: Sat, 26 Mar 2011 10:11:18 -0400
Message-ID: <20110326141118.GA3475@sigill.intra.peff.net>
References: <20110325200528.GA7302@blimp.localdomain>
 <7vsjub53j2.fsf@alter.siamese.dyndns.org>
 <AANLkTimQzPVOWCUx1hr+DEmRfdFB8=UeY_xCaxzVSwFy@mail.gmail.com>
 <7voc4y6g6v.fsf@alter.siamese.dyndns.org>
 <AANLkTikO4=TtFtpsQ_JtmGKqQ1NzgTuo7e8cdaQca+T7@mail.gmail.com>
 <7vvcz64ygm.fsf@alter.siamese.dyndns.org>
 <AANLkTi=+SZGxLyP8vFPpmK8DZvke6-Tu-crwq5+89qWx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 15:11:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3UD9-0005d9-0V
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 15:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab1CZOLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Mar 2011 10:11:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35660
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab1CZOLU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 10:11:20 -0400
Received: (qmail 24230 invoked by uid 107); 26 Mar 2011 14:12:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Mar 2011 10:12:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Mar 2011 10:11:18 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=+SZGxLyP8vFPpmK8DZvke6-Tu-crwq5+89qWx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170054>

On Sat, Mar 26, 2011 at 11:08:06AM +0100, Alex Riesen wrote:

> >> Oh, it does. That's why the second patch (prefixed "[PATCH, fixed]=
").
> >> It makes HOME to be "$(pwd)/somewhere-else", or precisely:
> >>
> >> =C2=A0 HOME=3D"$(pwd)"/"$test"
> >> =C2=A0 export HOME
> >
> > What happens to people who has non-empty "$root", iow, their $test =
begins
> > with '/'?
>=20
> It's still under $test then.

No, it's totally broken. $(pwd)/$test is nonsensical. The code right
above your change guarantees that $test is an absolute path, either
because the user gave us an absolute $root or because it has been
prepended with $TEST_DIRECTORY (which itself comes from $(pwd)).

So the change you want is HOME=3D$test. But note that the code looks li=
ke
this then:

  HOME=3D$test
  export HOME
  test_create_repo "$test"
  cd -P "$test"

meaning that test_create_repo sees a non-existent HOME. I don't
think that matters, but if it did, you could do:

  HOME=3D$TEST_DIRECTORY
  export HOME
  test_create_repo "$test"
  cd -P "$test"
  HOME=3D$test

-Peff
