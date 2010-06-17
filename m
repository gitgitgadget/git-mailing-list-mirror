From: Johan Herland <johan@herland.net>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Thu, 17 Jun 2010 02:39:01 +0200
Message-ID: <201006170239.01951.johan@herland.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006162332.56700.johan@herland.net>
 <7vy6eed3w0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 02:39:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP38T-00010S-8P
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 02:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab0FQAjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 20:39:07 -0400
Received: from smtp.getmail.no ([84.208.15.66]:42357 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab0FQAjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 20:39:06 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4400JMJV52RT00@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 17 Jun 2010 02:39:02 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id A2D611EEED3F_C196EA6B	for <git@vger.kernel.org>; Thu,
 17 Jun 2010 00:39:02 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 3FDB31EEC018_C196EA6F	for <git@vger.kernel.org>; Thu,
 17 Jun 2010 00:39:02 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4400ERTV52FD30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 17 Jun 2010 02:39:02 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <7vy6eed3w0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149280>

On Thursday 17 June 2010, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > On Wednesday 16 June 2010, Jens Lehmann wrote:
> >> Am 16.06.2010 02:05, schrieb Johan Herland:
> >> > - If the purpose is to re-use existing submodule merges then I'm
> >> > afraid (as I've argued above) that this would happen too seldom to
> >> > be useful in practice (and even then you would already have had to
> >> > set up the appropriate config for your branch, to enable Git to
> >> > find this pre-existing merge at all).
> >> 
> >> That this is all but happening seldom for us is the reason for this
> >> WIP patch from Heiko. And other use cases won't be harmed by this
> >> change, no? And if some are, we can add a config option to
> >> .gitmodules to control that.
> > 
> > Ok. I'm still not sure I see how this can happen frequently in
> > practice, but since you both probably use submodules more heavily than
> > I do, I will not stand in the way of progress.
> 
> At least it would be useful to learn how they manage to often produce the
> submodule merge G.  Your scenario description was very clearly written
> and in that particular workflow I didn't think it would be plausible to
> have such a merge before it is needed.  IOW, their workflow must be
> quite different from your scenario description, and I would like to see
> a plausible scenario description that is as clearly written as yours;
> perhaps that workflow can even be advertised as one of the BCP.
> 
> One possibility that comes to mind is perhaps Alice notices the presence
> of F after she recorded D, merges D and F in the submodule to produce G
> in the submodule repository, but does _not_ update the superproject to
> point at it yet, for some reason.  Perhaps she hasn't tested the
> superproject with the merged submodule yet.  Whatever the reason is, the
> tip of her branch in the submodule would be ahead of what her
> superproject commit D points at, but the commit is available to the
> maintainer to fetch.

Dubious. If Alice's merge of D and F hasn't been properly tested yet, I 
don't see why it should exist on the submodule's master branch, and if it 
doesn't, it simply isn't considered, due to Heiko's "stable" branch magic.

> Then the maintainer would see G in the submodule (after fetching both
> superproject and submodule from Alice) already prepared to be used in a
> merge between D and F.
> 
> I dunno.

Me neither, but after some more thinking I have another alternative as to 
why the merge G might exist (on the submodule master branch) before the 
superproject merge is started:

If the submodule happens to be maintained as a truly separate project (with 
its own maintainer), then the maintainer of that submodule may have decided 
to merge Alice's feature_a branch on its own merits, without looking at the 
superproject at all. When the superproject maintainer later performs the 
superproject merge he can just pick up the submodule merge done by the 
submodule maintainer.

But this is pure speculation, and as you say, I'd like to see what workflows 
Jens and Heiko are actually using.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
