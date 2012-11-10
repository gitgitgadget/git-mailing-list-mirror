From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Sat, 10 Nov 2012 13:32:50 +0100
Message-ID: <20121110123250.GR12052@goldbirke>
References: <20121109192336.GA9401@sigill.intra.peff.net>
 <CAMP44s3yVtQ4wGqVTyHN-VfAM7iRo9WfNnAu+ns7Zkc_cPBH3g@mail.gmail.com>
 <20121110003331.GA12567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 13:33:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXAFX-0004Uf-9g
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 13:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357Ab2KJMdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 07:33:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:50062 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab2KJMdF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 07:33:05 -0500
Received: from localhost6.localdomain6 (p5B130AB1.dip0.t-ipconnect.de [91.19.10.177])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MMJXF-1TPkeU2edR-008Zsw; Sat, 10 Nov 2012 13:32:51 +0100
Content-Disposition: inline
In-Reply-To: <20121110003331.GA12567@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:Fd001R4PhGv4z+OnAR3zcMjdAEzly8UKUaZaV8GxoPn
 3mad7m+Jm/RCyk1kSeDrxwZUyeZ5QLSM45ZNXd66tNqWh1AO0a
 0Z7WpkDaUlY4GJz9Qffhdmy2dyMZLB0Ubq/mu8++6v4B1u1ks3
 +oux/hu4e/Ei59jA8UUW/V5FWpVbSJ1xKWjqYj/U8YpJ5jT7Xy
 wWl7dOm9LStvwEBc76rJiQkbfz5lBZX+EalBByE0keJholCe5E
 2sQ+pPgOFtfiUnPpBogrr0O/s4KtV1idcFprmyAQYlLqn93SUa
 6BzOSrph+oYndQhacFQJdEVaGtjw5zIxJ9J9GwgUlzTOlZC3xi
 72o6Q2/hPuKB+vEcUjXs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209273>

Hi,

On Fri, Nov 09, 2012 at 07:33:31PM -0500, Jeff King wrote:
> On Sat, Nov 10, 2012 at 12:21:48AM +0100, Felipe Contreras wrote:
> > > * fc/completion-test-simplification (2012-10-29) 2 commits
> > >  - completion: simplify __gitcomp test helper
> > >  - completion: refactor __gitcomp related tests
> > >
> > >  Clean up completion tests.
> > >
> > >  There were some comments on the list.
> > >
> > >  Expecting a re-roll.
> >=20
> > The second patch I can re-roll, but the first patch needs some
> > external input. My preference is that tests should also be simple a=
nd
> > maintainable, SZEDER's preference is that tests are better being
> > explicit and verbose (even if harder to maintain) to minimize possi=
ble
> > issues in the tests.
>=20
> I think it is better to keep the tests simple and maintainable.

Maintainable?  There is nothing to maintain here.  Users' completion
scripts depend on __gitcomp(), so its behavior shouldn't be changed.
It can only be extended by a fifth parameter or by quoting words when
necessary, but these future changes must not alter the current
behavior checked by these tests, therefore even then these tests must
be left intact.

Simple?  Currently you only need to look at __gitcomp() and the test
itself to understand what's going on.  With this series you'll also
need to look at test_gitcomp(), figure out what its parameters are
supposed to mean, and possibly get puzzled on the way why __gitcomp()
is now seemingly called with only one parameter.

So, I don't see much benefit in this series (except the part to use
print_comp instead of "change IFS && echo", but that's already done in
this patch:
http://article.gmane.org/gmane.comp.version-control.git/207927).

OTOH, this series has some serious drawbacks.

It makes debugging more difficult.  While working on the quoting
issues I managed to break completion tests many-many times lately.  In
normal tests I could add a few debugging instructions to the failed
test to find out where the breakage lies, without affecting other
tests.  However, if the failed test uses the test_completion() helper,
then I have to add debugging instructions to test_completion() itself,
too.  This is bad, because many tests use this helper function and are
therefore affected by the debugging instructions, producing truckloads
of output making it difficult to dig out the relevant parts, or, worse
yet, causing breakages in other tests.  With this series the same
difficulties will come to __gitcomp() tests, too.

It can also encourage writing bad tests, similar to those that managed
to cram many test_completion() lines into a single tests, giving me
headaches to figure out what went wrong this time.


Best,
G=E1bor
