From: Sam Vilain <sam@vilain.net>
Subject: Re: Continue git clone after interruption
Date: Sun, 23 Aug 2009 22:37:09 +1200
Message-ID: <1251023829.8115.23.camel@maia.lan>
References: <1250509342.2885.13.camel@cf-48>
	 <200908200937.05412.jnareb@gmail.com>
	 <alpine.LFD.2.00.0908201358010.6044@xanadu.home>
	 <200908211207.38555.jnareb@gmail.com>
	 <alpine.LFD.2.00.0908211614220.6044@xanadu.home>
	 <1250896025.19039.7.camel@maia.lan>
	 <alpine.LFD.2.00.0908212324130.6044@xanadu.home>
	 <1250920259.3644.11.camel@maia.lan>
	 <alpine.LFD.2.00.0908220155240.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tomasz Kontusz <roverorna@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Aug 23 12:34:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfAP8-00072U-Hr
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 12:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993AbZHWKeW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2009 06:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755980AbZHWKeW
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 06:34:22 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:54400 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755957AbZHWKeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 06:34:21 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id DC14F21C4ED; Sun, 23 Aug 2009 22:34:21 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 1013921C34D;
	Sun, 23 Aug 2009 22:34:17 +1200 (NZST)
In-Reply-To: <alpine.LFD.2.00.0908220155240.6044@xanadu.home>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126854>

On Sat, 2009-08-22 at 04:13 -0400, Nicolas Pitre wrote:
> > Ok, but right now there's no way to specify that you want a thin pa=
ck,
> > where the allowable base objects are *newer* than the commit range =
you
> > wish to include.
>=20
> Sure you can.  Try this:
>=20
> 	( echo "-$(git rev-parse v1.6.4)"; \
> 	  git rev-list --objects v1.6.2..v1.6.3 ) | \
> 		git pack-objects --progress --stdout > foo.pack
>=20
> That'll give you a thin pack for the _new_ objects that _appeared_=20
> between v1.6.2 and v1.6.3, but which external delta base objects are=20
> found in v1.6.4.

Aha.  I guess I had made an assumption about where that '-' lets
pack-objects find deltas from that aren't true.

> > What I said in my other e-mail where I showed how well it works tak=
ing
> > a given bundle, and slicing it into a series of thin packs, was tha=
t it
> > seems to add a bit of extra size to the resultant packs - best I go=
t for
> > slicing up the entire git.git run was about 20%.  If this can be
> > reduced to under 10% (say), then sending bundle slices would be qui=
te
> > reasonable by default for the benefit of making large fetches
> > restartable, or even spreadable across multiple mirrors.
>=20
> In theory you could have about no overhead.  That all depends how you=
=20
> slice the pack.  If you want a pack to contain a fixed number of comm=
its=20
> (such that all objects introduced by a given commit are all in the sa=
me=20
> pack) then you are of course putting a constraint on the possible del=
ta=20
> matches and compression result might be suboptimal.  In comparison, w=
ith=20
> a single big pack a given blob can delta against a blob from a=20
> completely distant commit in the history graph if that provides a bet=
ter=20
> compression ratio.
 [...]
> If you were envisioning _clients_ =C3=A0 la BitTorrent putting up pac=
k slices=20
> instead, then in that case the slices have to be well defined entitie=
s,=20
> like packs containing objects for known range of commits, but then we=
're=20
> back to the delta inefficiency I mentioned above.

I'll do some more experiments to try to quantify this in light of this
new information; I still think that if the overhead is marginal there
are significant wins to this approach.

> And again this might=20
> work only if a lot of people are interested in the same repository at=
=20
> the same time, and of course most people have no big insentive to "se=
ed"=20
> once they got their copy. So I'm not sure if that might work that wel=
l=20
> in practice.

Throw away terms like "seeding" and replace with "mirroring".  Sites
which currently house mirrors could potentially be helping serve git
repos, too.  Popular projects could have many mirrors and on the edges
of the internet, git servers could mirror many projects for users in
their country.

Sam
