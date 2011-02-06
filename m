From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sun, 06 Feb 2011 17:11:45 +0100
Message-ID: <201102061711.45460.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102060104.37146.johan@herland.net>
 <AANLkTikmD8qZOE+hi1=aeeVJx2qQpzdm0tV1mLsx1tfB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 17:12:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm7DU-0007Bx-2G
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 17:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab1BFQLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 11:11:49 -0500
Received: from smtp.getmail.no ([84.208.15.66]:53366 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914Ab1BFQLs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 11:11:48 -0500
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG700FWSEBMJB40@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 06 Feb 2011 17:11:46 +0100 (MET)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 8B4901EF0294_D4EC842B	for <git@vger.kernel.org>; Sun,
 06 Feb 2011 16:11:46 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 501921EF0237_D4EC842F	for <git@vger.kernel.org>; Sun,
 06 Feb 2011 16:11:46 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG700GG4EBM4A20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 06 Feb 2011 17:11:46 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <AANLkTikmD8qZOE+hi1=aeeVJx2qQpzdm0tV1mLsx1tfB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166151>

On Sunday 06 February 2011, Dmitry Potapov wrote:
> On Sun, Feb 06, 2011 at 01:04:36AM +0100, Johan Herland wrote:
> >_
> >
> > As long as they point to the same object, there's no ambiguity, and
> > when you_ simply refer to tag "foo" (without specifying namespace) it
> > all works, like_ today. (Read footnote [2] of my proposal for more
> > details on handling_ ambiguity in tag names.)
> 
> I see no reason to create different namespaces, because semantically
> there is only one namespace.

In practice, there is almost always one namespace (i.e. your repo belongs to 
only one project with project-wide unique tags). However, in any distributed 
system, the only-one-namespace is fundamentally a myth. Sure, it's a 
convenient myth, and one that we - with good reason - strive towards 
fulfilling, but there are situations (described earlier in this thread) 
where the myth is busted. In those situations, I think the _least_ confusing 
thing we can do for our users is to handle all remote refs consistently, and 
allow them to discover/investigate the remote tags as they would other 
remote refs.

> > However, when the remote tags point to different objects (i.e. the
> > uncommon_ case), there is an ambiguity, and we should deal with that
> > ambiguity_ properly, instead of silently adopting one of them
> > arbitrarily.
> 
> To me, the proper handling ambiguity means that when I do "git fetch" I
> immediately see warning about tag clashes. So, I agree with you that
> current behavior is not good, but I disagree with you about having many
> namespaces, because it postpones detection of the conflict until I try
> to use. And well, git may detect ambiguity when I say "git show v1.0",
> but if I look at my branch in gitk and see "v1.0" and may say to someone
> that I use "v1.0" but that person looks at his tree and sees "v1.0" as
> something different.

In that case it would be wrong of gitk to display "v1.0". Instead it should 
display a longer, unambiguous name, e.g. "origin/v1.0".

> So, if there is two different tags with the same name, it is better to
> report the problem as soon as possible, i.e. during "git fetch", and
> then there is no reason to have separate namespaces for tags.

Yes, that is an alternative solution for tags. I guess it comes down to a 
question of how much special treatment we want to give tags. I'd rather have 
consistency between how tags and other remote refs are handled.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
