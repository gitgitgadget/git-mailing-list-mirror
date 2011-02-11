From: Johan Herland <johan@herland.net>
Subject: Re: Using Origin hashes to improve rebase behavior
Date: Fri, 11 Feb 2011 12:40:29 +0100
Message-ID: <201102111240.29746.johan@herland.net>
References: <m21v3fvbix.fsf@hermes.luannocracy.com>
 <AANLkTikrVPCr92XHirn1u=73eM--T190V-7nbE6fo8ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, John Wiegley <johnw@boostpro.com>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 11 12:40:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnrMd-0001y0-D3
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 12:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120Ab1BKLkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 06:40:33 -0500
Received: from smtp.getmail.no ([84.208.15.66]:59948 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755759Ab1BKLkc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 06:40:32 -0500
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGG005DQB3JYU80@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 11 Feb 2011 12:40:31 +0100 (MET)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id DA41C1EEEFBF_D55202EB	for <git@vger.kernel.org>; Fri,
 11 Feb 2011 11:40:30 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id B54B91EEEFAF_D55202EF	for <git@vger.kernel.org>; Fri,
 11 Feb 2011 11:40:30 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGG008BCB3IUO00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 11 Feb 2011 12:40:30 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <AANLkTikrVPCr92XHirn1u=73eM--T190V-7nbE6fo8ng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166553>

On Friday 11 February 2011, skillzero@gmail.com wrote:
> On Thu, Feb 10, 2011 at 1:13 PM, John Wiegley <johnw@boostpro.com> wrote:
> >    a   b   c   3'  d   e*  f
> >    o---o---o---o---o---o---o
> >             \
> >              o---o---o---o
> >              1   2   3   4
> > 
> > At a later date, I want to rebase the private branch onto master.  What
> > will happen is that the changes in 3 will conflict with the rewritten
> > changes in e*.  However, I'd like Git to know that 3 was already
> > incorporated at some earlier time, and *not consider it during the
> > rebase*, since it doesn't need to.
> 
> I don't know very much about how git really works so what I'm saying
> may be dumb, but rather than record where a commit came from, would it
> be reasonable for rebase to look at the patch-id for each change on
> the topic branch after the merge base and automatically remove topic
> branch commits that match that patch-id? So in your example, rebase
> would check each topic branch commit against 3', d, e*, and f and see
> that the 3' patch-id is the same as the topic branch 3 and remove
> topic branch 3 before it gets to e*?

I believe "git rebase" already does exactly what you describe [1].

However, comparing patch-ids stops working when the cherry-pick (3 -> 3') 
has conflicts. IINM, it is the conflicting cases that John is interested in 
solving...


...Johan

[1]: I tested the above scenario, and got no conflicts:

$ git init
$ FOO=a && echo $FOO > $FOO && git add $FOO && git commit -m $FOO
$ FOO=b && echo $FOO > $FOO && git add $FOO && git commit -m $FOO
$ FOO=c && echo $FOO > $FOO && git add $FOO && git commit -m $FOO
$ git checkout -b topic
$ FOO=1 && echo $FOO > $FOO && git add $FOO && git commit -m $FOO
$ FOO=2 && echo $FOO > $FOO && git add $FOO && git commit -m $FOO
$ FOO=3 && echo $FOO > $FOO && git add $FOO && git commit -m $FOO
$ FOO=4 && echo $FOO > $FOO && git add $FOO && git commit -m $FOO
$ git checkout master
$ git cherry-pick topic^
$ FOO=d && echo $FOO > $FOO && git add $FOO && git commit -m $FOO
$ echo e >> 3 && git add 3
$ FOO=e && echo $FOO > $FOO && git add $FOO && git commit -m $FOO
$ FOO=f && echo $FOO > $FOO && git add $FOO && git commit -m $FOO
$ git checkout topic
$ git rebase master
First, rewinding head to replay your work on top of it...
Applying: 1
Applying: 2
Applying: 4
$ # Look, no conflicts.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
