From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in
 bundle
Date: Sun, 11 Mar 2007 23:28:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703112302140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
 <45F17EF0.5060008@gmail.com> <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703101637300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F2D955.8050800@gmail.com> <Pine.LNX.4.63.0703101749270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F2F934.8060407@gmail.com> <Pine.LNX.4.63.0703110201450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7m4y3cn.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703110244130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F41787.4080506@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 23:28:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQWWt-00008y-Bi
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 23:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933588AbXCKW2f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 18:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933584AbXCKW2f
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 18:28:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:34190 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933588AbXCKW2e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 18:28:34 -0400
Received: (qmail invoked by alias); 11 Mar 2007 22:28:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 11 Mar 2007 23:28:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TyZVgZPST7fyS6Onh6MMZDox+lvxmy/MUM1YtmK
	qLMkOLLv69kVGW
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45F41787.4080506@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41999>

Hi,

On Sun, 11 Mar 2007, Mark Levedahl wrote:

> Johannes Schindelin wrote:
> > git-bundle (as is in "next") has clearly defined semantics.
>
> git-bundle on next with the patch in 
> <Pine.LNX.4.63.0703091726530.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
> works well enough for me, but absent that latter patch is too punishing.

I don't want to punish you! But I want to prevent "Huh?" moments early on.

> > I've been wondering if we can define prereqs per listed head.
>
> Currently, a bundle has a single pack. The bundle's prerequisites 
> are that pack's dependencies. Splitting prerequisites per head requires 
> either creating one pack per head or unpacking at the receiving and and 
> extracting only the objects needed for the selected head. I'm not sure 
> that either is warranted, and my uses of bundle do not require this 
> regardless.

You can just store the pack and update the ref (at least as long as the 
pack is not thin): we have a long-standing tradition of guaranteeing the 
integrity of commit chains _only_ when the commits are reachable by at 
least one ref.

> I think we need to restate purpose here. git-bundle is an alternate 
> transport mechanism: git-bundle + git-fetch over sneakernet allows doing 
> what git-push or git-fetch can do when directly connected.

But would that not mean that we expect the user of the bundle to update 
_all_ refs contained in the bundle?

> However, there are limitations due to the lack of direct connect, 
> specifically the user of git-bundle needs to specify the prerequisites 
> as the protocol cannot negotiate these. The exchange needs to be robust 
> in that git-bundle+git-fetch must never result in leaving a repository 
> in a corrupted state: the current prerequisites list + use of git-fetch 
> seem to satisfy this.

Yes. I think we definitely need to ensure the integrity _before_ updating 
the refs (and not rely on the prereqs in the bundle). And yes, that means 
I changed my mind from when I argued against your use of fsck, and _for_ 
prereqs.

> With appropriate remote settings in .git/config, I can have git-fetch 
> get all branches, or all branches and tags, and never complain when no 
> update is required for something.

Makes sense.

> While it is possible to fetch a particular ref from the bundle rather 
> than taking all, the monolithic pack structure and protocol dictates 
> that you will get all objects regardless.

... but a subsequent git-gc will strip them away.

> At some point, we have to make a clear distinction between what rules 
> the protocol should enforce for "correctness" vs what an "intelligent" 
> use of bundle is, and not try to enforce the latter in the software.

Concur. But I think that we have to make sure that the "correctness" 
enforcing means that you do not end up with something that people want to 
use for what it cannot be used for.

> Bottom line, I strongly advocate Dscho's last patch + what is on next be 
> promoted to master. We can revisit how well it is working and refine it 
> after it gets some usage from others defining additional use-cases.

FWIW my plans are to make the pack thin _only_ when there is only one 
prereq and/or ref in the bundle (this prevents a _wanted_ object being 
deltified against a not-wanted object).

Also, as mentioned above, I think that we have to check that "git rev-list 
--objects <new-refs> --not --all" does not result in missing objects.

Ciao,
Dscho
