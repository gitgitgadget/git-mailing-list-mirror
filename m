From: Jeff King <peff@peff.net>
Subject: Re: bug related to branches using / in name
Date: Thu, 26 Jun 2008 23:02:46 -0400
Message-ID: <20080627030245.GA7144@sigill.intra.peff.net>
References: <1214509350.28344.31.camel@odie.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Simon Holm =?utf-8?Q?Th=C3=B8gersen?= <odie@cs.aau.dk>
X-From: git-owner@vger.kernel.org Fri Jun 27 05:03:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC4FV-00065w-U4
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 05:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbYF0DCt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2008 23:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbYF0DCt
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 23:02:49 -0400
Received: from peff.net ([208.65.91.99]:1652 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbYF0DCs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 23:02:48 -0400
Received: (qmail 31281 invoked by uid 111); 27 Jun 2008 03:02:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 26 Jun 2008 23:02:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jun 2008 23:02:46 -0400
Content-Disposition: inline
In-Reply-To: <1214509350.28344.31.camel@odie.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86517>

On Thu, Jun 26, 2008 at 09:42:30PM +0200, Simon Holm Th=C3=B8gersen wro=
te:

> The last command does not succeed, but produces the following output
>=20
> error: unable to resolve reference refs/remotes/origin/sched/devel: N=
ot
> a directory
> >From file:///tmp/git-bug
>  * [new branch]      sched/devel -> origin/sched/devel
> error: unable to resolve reference refs/remotes/origin/sched/urgent: =
Not
> a directory
>  * [new branch]      sched/urgent -> origin/sched/urgent

So to summarize, the problem is that you have an old tracking branch
"refs/remotes/sched" that exists on the client, but upstream has since
removed it in favor of "sched/devel", which you are now trying to fetch=
=2E
And of course there is a conflict, because of the ref naming rules.

This doesn't work seamlessly because git-fetch never removes old
tracking branches, even if they have been deleted upstream. And normall=
y
there is no conflict; leaving the old branches means they don't
disappear from under you.

In this case, of course, it's inconvenient. The "right" way to solve it
is to tell git to clean up your tracking branches for "origin":

  git remote prune origin

which should delete the old "sched" tracking branch (since it no longer
exists on the remote), and then you are free to fetch.

It might be nicer if this were handled automatically, but it would
violate git-fetch's rule about never deleting branches. And presumably
this comes up infrequently enough that it isn't a problem. Perhaps a
better error message suggesting git-prune might make sense?

-Peff
