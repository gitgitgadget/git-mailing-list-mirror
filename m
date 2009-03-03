From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit] Multiple concurrent sets of patches
Date: Tue, 3 Mar 2009 20:42:32 +0100
Message-ID: <20090303194232.GB18423@pengutronix.de>
References: <20090303113741.GO12820@jones.dk> <20090303130316.GA17702@piper.oerlikon.madduck.net> <20090303192221.GV12820@jones.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>
To: Jonas Smedegaard <dr@jones.dk>
X-From: git-owner@vger.kernel.org Tue Mar 03 20:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeaXA-0004Sx-AF
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbZCCTmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 14:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738AbZCCTmg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:42:36 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41297 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbZCCTmf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 14:42:35 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LeaVd-0007sP-PU; Tue, 03 Mar 2009 20:42:33 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LeaVc-0004nq-Tg; Tue, 03 Mar 2009 20:42:32 +0100
Content-Disposition: inline
In-Reply-To: <20090303192221.GV12820@jones.dk>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112158>

On Tue, Mar 03, 2009 at 08:22:21PM +0100, Jonas Smedegaard wrote:
> On Tue, Mar 03, 2009 at 02:03:16PM +0100, martin f krafft wrote:
> >also sprach Jonas Smedegaard <dr@jones.dk> [2009.03.03.1237 +0100]:
> >> It seems to me that TopGit is incapable of handling this. That it =
can=20
> >> only handle patchset against a single branch, and if the need aris=
e=20
> >> for restructuring an additional patchset for e.g. a stable or=20
> >> oldstable branch, then quilt needs to be used manually anyway.
> >
> >Let me try to understand you: you want TopGit to maintain a single
> >feature branch against two different source branches? How should
> >that work? Could you elaborate a bit so that your needs become a bit
> >more obvious?
>=20
> Not quite. I want TopGit to maintain multiple feature branches,=20
> preferrably related.
>=20
> With "related" I mean that I would like to be able to "fork" a chain =
of=20
> interdependent feature branches.
>=20
> TopGit easily support one chain of branches:
>=20
> upstream + pristine-tar -> master -> build
>=20
> I want TopGit to additionally support the following:
>=20
> upstream + pristine-tar -> stable-master -> stable-build
>=20
> upstream + pristine-tar -> oldstable-master -> oldstable-build
>=20
>=20
> E.g. in addition to TopGit branches t/fix_01 and t/feature_01 I would=
=20
> want to fork those branches as t_stable/fix_01 and t_stable/feature_0=
1.
>=20
>=20
> I know that I can create all those TopGit branches one by one, but I=20
> would then need to explicitly declare a list of TopGit branches to ap=
ply=20
> each time I want to (re)generate a quilt patchlist.
=46or my kernel development I use topgit topic branches that collect
topgit patch branches.  Take this dependency graph:

	linus/master <- t/armmisc/patch1 <- t/armmisc-master <- t/armmisc-pu
	         ^ ^----t/armmisc/patch2 <--'                   |
                 `------t/armmisc/patch3 <----------------------'

So t/armmisc-master collects patches that are ready for upstream, -pu
patches that need some more work.

With etch <- lenny <- squeeze <- sid you could do the same.  The only
Consider you have a security fix that is relevant for all
releases starting at lenny. Then you do

	tg create t/fixes-lenny/CVE-2009-abcd master-lenny
	... apply patch
	... fill .topmsg
	git commit

	git checkout t/fixes-lenny-master
	tg depend add t/fixes-lenny/CVE-2009-abcd

	tg create t/fixes-squeeze/CVE-2009-abcd master-squeeze t/fixes-etch/CV=
E-2009-abcd
	... no need to apply patch
	... cherry-pick .topmsg from t/fixes-lenny/CVE-2009-abcd
	git commit

	git checkout t/fixes-squeeze-master
	tg depend add t/fixes-squeeze/CVE-2009-abcd
=09
And if you notice that etch needs the same fix, you can create
t/fixes-etch/CVE-2009-abcd based on master-etch and then do

	git checkout t/fixes-lenny/CVE-2009-abcd
	tg depend add t/fixes-etch/CVE-2009-abcd

tatata, I think that's it for packaging.

But this doesn't help me for my kernel problem, because here I don't
have that ordering on releases.  I want to manage patches on top of
linux-tip and the ARM tree, but none of these contains the other :-/

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
Peiner Strasse 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-=
0    |
Amtsgericht Hildesheim, HRA 2686              | Fax:   +49-5121-206917-=
5555 |
