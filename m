From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revision walker: include a detached HEAD in --all
Date: Sun, 18 Jan 2009 15:06:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181442370.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <496EE559.3060901@viscovery.net> <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de> <200901151500.01876.trast@student.ethz.ch> <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901151517190.3586@pacific.mpi-cbg.de> <7vhc40s50t.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901161351460.3586@pacific.mpi-cbg.de> <7v8wp917c3.fsf@gitster.siamese.dyndns.org> <7v3afh15pi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 15:08:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOYJq-0001qA-36
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 15:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760730AbZAROGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 09:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760381AbZAROGl
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 09:06:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:47643 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759050AbZAROGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 09:06:40 -0500
Received: (qmail invoked by alias); 18 Jan 2009 14:06:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 18 Jan 2009 15:06:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lRmxgpSDlQl8AMLkpJZtEP56OrdSFSUJSRATxbw
	QKsghHcppM5+tJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v3afh15pi.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106188>

Hi,

On Sat, 17 Jan 2009, Junio C Hamano wrote:

> Subject: [PATCH] bundle: allow the same ref to be given more than once
> 
> "git bundle create x master master" used to create a bundle that lists
> the same branch (master) twice.  Cloning from such a bundle resulted in
> a needless warning "warning: Duplicated ref: refs/remotes/origin/master".
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  bundle.c |    2 ++
>  object.c |   19 +++++++++++++++++++
>  object.h |    1 +
>  3 files changed, 22 insertions(+), 0 deletions(-)

Yes, that would be good.  You have my ACK on that if you want.

Another thing I am thinking about on and off:

You cannot really use bundles as a replacement for regular transports 
(e.g. when you administrator does not let you ssh or git:// out, and you 
do not have an HTTP server available [*1*]).

Suppose you have two branches, 'master' and 'side'.  Now you make changes 
to 'master' and send the complete repository as a bundle to your friend.  
Now you delete the branch 'side', and send the next bundle (created with 
--all implying HEAD, and --since=$(stat -c %Y <first-bundle>)).

Then your friend has no idea if 'side' was deleted or untouched.

So I think we'd need some option for "create bundle" to list all specified 
refs, and if they have not really changed, their SHA-1s as prerequisites, 
too.  Maybe "--full-bundle", or just "--full"?

Another problem: suppose you have a branch, called 'private', that you 
excluded from your bundles.  Now you happened to make changes to it, and 
by mistake, the branch gets included in the incremental bundle.  No 
problem for you, as your friend lacks the prerequisites to reconstruct it.

But unfortunately, your friend cannot even pull 'master' from it, because 
of our overzealous verification process which refuses all fetches when 
some prerequisites are missing locally, even if they are not even needed.

This problem is much harder to solve, I think, and maybe we just want to 
leave it: as bundles are just fed into index-pack --fix-thin, which has no 
idea what objects can be skipped.  Maybe there is no clean solution to 
that to begin with.

Ciao,
Dscho

[*1*] When people are stuck behind such a stupidly restrictive firewall, 
often people come with "helpful" suggestions to use a VPN, or to publish 
your private repository, or get an external machine to HTTP proxy their 
connections.  I find it outright mean to waste the time of people who 
already have a big problem.

However, I believe that a mail based bundle exchange should be a 
relatively easy way out for those situations, once it works.
