From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Teach git submodule update to use distributed
	repositories
Date: Fri, 18 Jul 2008 11:16:08 +0200
Message-ID: <20080718091608.GL10151@machine.or.cz>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com> <alpine.DEB.1.00.0807171311010.8986@racer> <320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com> <320075ff0807170521s26693381m60648468cce1c41c@mail.gmail.com> <alpine.DEB.1.00.0807171351380.8986@racer> <320075ff0807170703l57fe26d2h1e9c4db1c38dd6f1@mail.gmail.com> <alpine.DEB.1.00.0807171513560.8986@racer> <320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com> <20080717182253.GZ32184@machine.or.cz> <320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:17:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJm5S-0008HP-BX
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbYGRJQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbYGRJQM
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:16:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55502 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753552AbYGRJQL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:16:11 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E2A9C2C4C028; Fri, 18 Jul 2008 11:16:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89016>

  Hi,

  _please_, trim the parts of quoted e-mails that you are not reacting
to. It makes your mails easier to read.

On Fri, Jul 18, 2008 at 09:11:53AM +0100, Nigel Magnay wrote:
> No.
> "Someone says 'please review the state of my tree, _before_ I push it
> out to a (central) repository"
> 
> Fred is a person (and != origin). His tree(s) are entirely correct and
> consistent, and he doesn't yet wish to push to origin (and perhaps he
> cannot, because he does not have permission to do so).
> 
> All the tutorials give credit to the fact that in git you don't need a
> central server - you can pull directly from people. Except in the case
> where you're using submodules, where you're basically forced to
> hand-modify .git/config (in this instance, to point to where 'fred' is
> storing his submodule trees) before doing a submodule update. This
> makes git complicated for users.

Ok! Handling this case makes sense, though I would have wished you to
word this use case this clearly from the beginning; or maybe I'm just
slow. :-)

Now, we (at least we two) agree that this use case is worth supporting,
I still don't like the solution you propose, though. The problem that we
are trying to solve is:

	"How do we mass-supply custom submodule URLs when publishing the
	customized main repository at a custom location too?"

Now, the most natural solution is for Fred to actually customize
.gitmodules content when committing the submodule updates:

  (i) Either just give submodule update a hypothetical flag that will
ignore .git/config for that particular run or,

  (ii) even much better, actually change logical submodule names in
.gitmodules; this is appropriate as you want the modules to actually
point at a significantly different repository. Thus,

	[submodule "boo"]
	path=boo
	url=git://repo.or.cz/boo.git

will become

	[submodule "boo/fred"]
	path=boo
	url=git://repo.or.cz/boo/fred.git

  Also, you will be able to redefine the URL of boo/fred too in
.git/config (e.g. you're behind a firewall that lets only HTTP
through; I'm actually behind such a firewall these days at my
(non-SUSE ;) work).


This should be reasonably elegant, works with no Git changes, however
still has one significant problem - you very much do not want such a
.gitmodules change in any of the commits you merge, since it breaks
bisectability in case Fred or his repositories go away.

In that case, several possibilities come up on my mind:

  (1) Fred will prepare special branch for testing with modified
.gitmodules and then for a merge he offers a different branch with clean
.gitmodules. This works, but it is obnoxious.

  (2) Fred will pass a patch for .gitmodules as a part of his review
request. This works too and is obnoxious in slightly different aspects
than (1).

  (3) Fred will offer a rewrite rule that you will pass to submodule
update, like your solution proposed, but much more universal so that it
is not tailored just to your particular repository hierarchy. A simple
sed script could work fine.

  (4) Something else that I'm not realizing.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
