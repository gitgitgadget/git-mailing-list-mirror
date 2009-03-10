From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] rerere to recreate topic branches
Date: Tue, 10 Mar 2009 11:18:40 +0100
Message-ID: <20090310101840.GA21234@elte.hu>
References: <20090310093200.GA12931@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Debian TopGit maintainers <pkg-topgit@teams.debian.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 11:20:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgz4h-0001ke-9s
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 11:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbZCJKS4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 06:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbZCJKSz
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 06:18:55 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:33332 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135AbZCJKSy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 06:18:54 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1Lgz2r-0005g8-6x
	from <mingo@elte.hu>; Tue, 10 Mar 2009 11:18:51 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 10B8D3E2136; Tue, 10 Mar 2009 11:18:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090310093200.GA12931@pengutronix.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112800>


* Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
>=20
> Ingo sent a similar mail some time ago[1], that's why I Cc:=20
> him.

> [1] http://thread.gmane.org/gmane.comp.version-control.git/85176/

Just a few generic comments - i have written that mail 8 months=20
ago.

Since then our -tip workflow has shifted in the direction of=20
what i'd call an "append-mostly delta integration" workflow.

When i wrote that mail we used to do daily full reintegrations=20
of 100-200 topic branches using git-rerere, but that was not=20
really feasible in the long run for two reasons:

 - back then a full integration took up to 30 minutes with over=20
   a 100 branches and on a fast box - if it was all=20
   problem-free.

   [ It's much faster now both due to the speedups Git has done,
     due to smarter scripting we do and due to me using an SSD=20
     to host the -tip repo. ]

 - the full integration itself 'locked' the whole repo for a=20
   long time. The old integration branch was destroyed and a new=20
   one constructued - with 1000-2000 commits. This was fragile=20
   in a number of ways.

 - if there was any problem during the integration (a bad=20
   conflict resolution) it often had to be repeated which easily=20
   pushed the time to do the integration to over an hour.

So full integration of 1000-2000 commits spread out into 100+=20
topic branches required a lot of concentration and even then it=20
was too fragile.

So now we do full reintegrations only about every two weeks,=20
plus we do finegrained per commit and per pull "delta=20
integrations" that is based on:

 DELTA_BRANCHES=3D$(git branch --no-merged | cut -c3-)
 git merge $DELTA_BRANCHES

Plus we have the same finegrained topical setup that allows the=20
specific isolation of gone-bad topics without the collateral=20
damage of them holding the full tree and other contributors=20
hostage.

So when a topic goes bad i dont revert nor do i destroy those=20
commits - i just rewind/reset the integration branch to before=20
the bad topic merge point, exclude the topic from=20
delta-integration (add it to a blacklist) and re-run the delta=20
integration and notify the people who caused the breakage. It's=20
about 30 seconds to do so there's no noticeable workflow hickup.

When the fix comes in 1-2 days later, the 'bad' topic branch is=20
reactivated and gets picked up by delta integration.

So all in one, delta integration is a lot less stressful in=20
practice, and undo is possible and easy, as most of the=20
breakages are in fresh commits.

It's also very fast:

 earth4:~/tip> time todo-merge-all=20
 searching for updated branches ...
 excluded branches: core/kill-the-BKL tracing/dump-tracer
 Updated branches: tracing/ftrace
 merging tracing/ftrace ... Merge made by recursive.          =20
  kernel/trace/trace_workqueue.c |   14 +++++++-------
  1 files changed, 7 insertions(+), 7 deletions(-)
 merging linus ... ... merge done.                            =20

 real	0m5.402s
 user	0m5.002s
 sys	0m0.445s

Even though there are more than 400 branches it has to check,=20
100 of which are active (=3D=3Dcarry new commits relative to Linus's=20
latest kernel tree).

	Ingo
