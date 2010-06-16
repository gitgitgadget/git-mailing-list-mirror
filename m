From: Johan Herland <johan@herland.net>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Wed, 16 Jun 2010 23:32:56 +0200
Message-ID: <201006162332.56700.johan@herland.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006160205.20705.johan@herland.net> <4C1906FA.7010906@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 16 23:33:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP0EM-0001tC-4z
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 23:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759658Ab0FPVc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 17:32:59 -0400
Received: from smtp.getmail.no ([84.208.15.66]:57870 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755087Ab0FPVc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 17:32:58 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4400KBPMIXM730@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 16 Jun 2010 23:32:57 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 49C8B1EEED3F_C194309B	for <git@vger.kernel.org>; Wed,
 16 Jun 2010 21:32:57 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 0D5251EEBFE6_C194309F	for <git@vger.kernel.org>; Wed,
 16 Jun 2010 21:32:57 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L44000ZCMIWKC10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 16 Jun 2010 23:32:57 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <4C1906FA.7010906@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149277>

On Wednesday 16 June 2010, Jens Lehmann wrote:
> Am 16.06.2010 02:05, schrieb Johan Herland:
> > - If the purpose is to re-use existing submodule merges then I'm afraid
> > (as I've argued above) that this would happen too seldom to be useful
> > in practice (and even then you would already have had to set up the
> > appropriate config for your branch, to enable Git to find this
> > pre-existing merge at all).
> 
> That this is all but happening seldom for us is the reason for this WIP
> patch from Heiko. And other use cases won't be harmed by this change, no?
> And if some are, we can add a config option to .gitmodules to control
> that.

Ok. I'm still not sure I see how this can happen frequently in practice, but 
since you both probably use submodules more heavily than I do, I will not 
stand in the way of progress.

> > Taking a step back and comparing the merging of submodules vs. the
> > merging of regular files:
> > 
> > Git's rules are simple and straightforward for regular files: If both
> > sides/branches have changed the same area of code (and the changes
> > don't exactly coincide), you get a conflict. There's no
> > magic/cleverness applied to try to figure out what a good resolution
> > would look like; it's a conflict, and the user must resolve it. Simple
> > as that.
> > 
> > I'd argue that the submodule case should be the same: If both
> > sides/branches change the submodule (and the SHA1s don't exactly
> > match), you get a conflict, and it's up to the user to resolve it.
> > 
> > We may to make an exception for the case where one SHA1 is a descendant
> > of the other (i.e. a fast-forward situation), since that seems like a
> > safe choice in most situations, but I don't feel safe doing much
> > beyond that.
> 
> Yes, I would like to see that fast-forward case silently handled by a
> merge in the superproject.
> 
> And if it is no fast-forward but you find a unique merge where both of
> these SHA1s are included, you could advertise it as a possible solution
> but not automagically add it to the index. So you give the maintainer of
> the superproject the opportunity to assess a possible solution but spare
> him the chore of trying to find the reason why the merge failed and what
> he can do about it by showing him the right direction. He might then
> decide to take a later commit of the submodule or resolve the whole
> issue differently, but that is up to him.

I still particularily don't like the added config variable for specifying 
which branch(es) are considered "stable". Would it be possible to instead 
search all submodule branches for the earliest commits that reconcile the 
two commits, and then inform the user that these may be interesting to look 
at when trying to find a resolution? Something like:

  Cannot auto-resolve conflict between $a_sha1 and $b_sha1 in submodule
  $foo. The following merge commits in submodule $foo may help you resolve
  this conflict:
    - $sha1 (present in branches $a, $b, $c)
    - $sha2 (present in branches $c, $d)
    - $sha3 (present in branches $e, $f)

Thus the user/maintainer gets the full picture, and are given as many 
alternatives as possible to help resolve the conflict, instead of 
automatically getting one (possibly wrong) resolution, just because the 
"stable" config was unset or incorrect.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
