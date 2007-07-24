From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rfe: bisecting with a tristate
Date: Tue, 24 Jul 2007 14:52:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241447200.14781@racer.site>
References: <Pine.LNX.4.64.0707241459460.18990@fbirervta.pbzchgretzou.qr>
 <20070724094017.d14688e5.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Engelhardt <jengelh@computergmbh.de>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:53:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDKov-0004O4-W8
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 15:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbXGXNw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 09:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbXGXNw7
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 09:52:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:59902 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753212AbXGXNw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 09:52:58 -0400
Received: (qmail invoked by alias); 24 Jul 2007 13:52:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 24 Jul 2007 15:52:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UQfpwLABUFWjJewrkDG7TnY0A/CVOlMOJ93H24F
	pO2osagwNvm9Hj
X-X-Sender: gene099@racer.site
In-Reply-To: <20070724094017.d14688e5.seanlkml@sympatico.ca>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53595>

Hi,

On Tue, 24 Jul 2007, Sean wrote:

> > git bisect start
> > git bisect bad v2.6.23-rc1
> > # bad: [f695baf2df9e0413d3521661070103711545207a] Linux 2.6.23-rc1
> > git bisect good v2.6.22
> > # good: [098fd16f00005f665d3baa7e682d8cb3d7c0fe6f] Linux 2.6.22
> > 
> > Then 1f1c2881f673671539b25686df463518d69c4649 will be the next commit 
> > git bisect hands out. Now let's assume this commit would not compile. 
> > What would the user do? git-bisect good or git-bisect bad?
> 
> Check out the section "Avoiding to test a commit" in the git-bisect
> man page; it addresses this issue.  Basically you just use git-reset
> to pick a different nearby commit to compile, and then continue with
> git bisect good/bad.

But a "git bisect dunno" would be handy.

However, it is a bit involved, since git-bisect.sh assumes that there is 
only one bad commit, and with that, the outcome would be possibly a commit 
range.

Two parts to it I see:

- builtin-rev-list.c:find_bisection() has to be told to ignore the dunno 
  commits when counting, in addition to uninteresting ones (but not stop 
  traversal). The easiest way I could see would be to add another option 
  to specify the dunno commits, and set a special flag on these.

- git-bisect.sh has to lose the assumption that there is only one bad 
  commit.  Instead, it has to traverse the parent(s) of "the" bad commit, 
  until it finds either no parents, or a known good one.  So maybe 
  something like

	echo $(git rev-list --boundary $bad --not $good |
		sed -n "s/^-/^/p") $bad

  would be enough.

Hth,
Dscho
