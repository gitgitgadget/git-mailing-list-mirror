From: Adam Williamson <awilliam@redhat.com>
Subject: Re: 'simple' push check that branch name matches does not work if
 push.default is unset (and hence implicitly simple)
Date: Thu, 27 Nov 2014 09:12:27 -0800
Organization: Red Hat
Message-ID: <1417108347.18654.4.camel@redhat.com>
References: <1417040968.12457.78.camel@redhat.com>
	 <20141127034306.GA5341@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 27 18:12:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xu2cX-0001jf-4k
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 18:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbaK0RMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 12:12:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40272 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbaK0RMk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 12:12:40 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sARHCUKm022765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Nov 2014 12:12:30 -0500
Received: from mail.happyassassin.net (ovpn-113-42.phx2.redhat.com [10.3.113.42])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sARHCTiM018388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 27 Nov 2014 12:12:29 -0500
Authentication-Results: mail.happyassassin.net; dmarc=none header.from=redhat.com
In-Reply-To: <20141127034306.GA5341@peff.net>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260348>

On Wed, 2014-11-26 at 22:43 -0500, Jeff King wrote:
> On Wed, Nov 26, 2014 at 02:29:28PM -0800, Adam Williamson wrote:
> 
> > Hi, folks. Ran into an unfortunate issue with git which helped me mess
> > up a Fedora package repo today :/
> > 
> > The problem can be reproduced thus:
> > 
> > 1. Create an empty repo, clone it
> > 2. Push its master branch with something in it (just to get started)
> > 3. git branch --track moo origin/master
> > 4. git checkout moo
> > 5. echo moo >> moo && git commit -a -m "create moo"
> > 6. git push
> > ** BUG HAPPENS - CHANGES ARE PUSHED TO origin/master **
> > 7. git config --local push.default simple
> > 8. echo moo2 >> moo && git commit -a -m "update moo"
> > 9. git push
> > ** PUSH IS CORRECTLY REJECTED **
> > 
> > In both those cases, the push behaviour is supposed to be 'simple' - at
> > step 6 it's *implicitly* set to 'simple' (according to the
> > documentation), while at step 9 it's *explicitly* set to 'simple'. At
> > step 6, a warning is printed to the console:
> 
> Ugh. Yeah, this never worked properly, even in the original v2.0.0
> release. Worse, our tests did not notice it at all.  Patch is below.

I've got a pile of Fedora stuff to do today so I don't know if I'll get
time to dig any further into the history of this and see if there are
any hidden wrinkles, but on the face of it, Jeff's patch looks good to
me. I'll try and find a moment to test it at least, but the approach
makes sense and is what I would've gone for too.

It might also be worth improving the warn_unspecified_push_default_msg[]
text to mention the name matching behaviour? At present it doesn't
clearly explain this (you could argue it's *sort of* implied, but I
doubt many people will read it that way - I didn't), you have to follow
the chain into 'git help config' to find the description. Something
like:

   "Since Git 2.0, Git defaults to the more conservative 'simple'\n"
   "behavior, which only pushes the current branch to the corresponding\n"
   "remote branch that 'git pull' uses to update the current branch, \n"
   "if the names of those two branches match.\n"
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net
