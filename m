From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: for-each-ref output order change in 2.7.0
Date: Sat, 9 Jan 2016 16:40:02 +0100 (CET)
Message-ID: <1674931730.811704.1452354002885.JavaMail.zimbra@imag.fr>
References: <CAGyf7-FSP3Z7HO=LpoQck8q9sSj3fGYCx1=gNa6fXEkovxAxHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>,
	Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 17:06:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHw2A-0002k8-4p
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 17:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbcAIQG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2016 11:06:26 -0500
Received: from mx2.imag.fr ([129.88.30.17]:58277 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754869AbcAIQGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2016 11:06:25 -0500
X-Greylist: delayed 1199 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jan 2016 11:06:24 EST
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u09Fe1Ox030046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 9 Jan 2016 16:40:01 +0100
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u09Fe3Gn029829;
	Sat, 9 Jan 2016 16:40:03 +0100
In-Reply-To: <CAGyf7-FSP3Z7HO=LpoQck8q9sSj3fGYCx1=gNa6fXEkovxAxHw@mail.gmail.com>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: for-each-ref output order change in 2.7.0
Thread-Index: kCqcHHsqMevuHSZ8/sAXueNdVvsDnw==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 09 Jan 2016 16:40:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u09Fe1Ox030046
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1452958803.10657@vB6M7mbofJK9qQq8SrHtDQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283603>

Hi,

Cc-ing Karthik to draw his attention on the message.

----- Original Message -----
> In one of our tests, we have a set of branches whose names are all
> special characters (%, @, etc). Most of them branches have identical
> tip commits and just have different names. In 2.7.0, when ordering by
> -committerdate, the branches are now returned in a different order. I
> don't think this is a bug, based on the commit it bisects to, but I'm
> wondering if someone can confirm.
> 
> 2.6.5 and prior (tested all the way back to 1.7.6, so this was
> consistent for a long time):
> 
> refs/heads/!@#% -> Tue Jan 3 17:04:06 2012 +1100
> refs/heads/!@#$% -> Tue Jan 3 17:00:51 2012 +1100
> refs/heads/% -> Tue Jan 3 17:00:51 2012 +1100
> refs/heads/@#$% -> Tue Jan 3 17:00:51 2012 +1100
> refs/heads/@#% -> Tue Jan 3 17:00:51 2012 +1100
> 
> 2.7.0:
> 
> refs/heads/!@#% -> Tue Jan 3 17:04:06 2012 +1100
> refs/heads/@#% -> Tue Jan 3 17:00:51 2012 +1100
> refs/heads/@#$% -> Tue Jan 3 17:00:51 2012 +1100
> refs/heads/% -> Tue Jan 3 17:00:51 2012 +1100
> refs/heads/!@#$% -> Tue Jan 3 17:00:51 2012 +1100
> 
> I've bisected this back to:
> 
> bturner@ubuntu:~/Development/oss/git/git$ git bisect bad
> 9e468334b41c1d1fc715de177ef1f61a36c1cf01 is the first bad commit
> commit 9e468334b41c1d1fc715de177ef1f61a36c1cf01
> Author: Karthik Nayak <karthik.188@gmail.com>
> Date:   Fri Oct 30 14:15:28 2015 +0530
> 
>     ref-filter: fallback on alphabetical comparison
> 
> The message for that commit indicates that sorting numerics (which I
> assume is the implementation for committerdate) now falls back on
> alphabetical for identical values, suggesting this order change is
> actually intentional and correct.

And also that the previous order was arbitrary (just letting the sort
algorithm chose which one to put first in case of equality on the main
sorting criterion), so the fact that it was stable previously is more
or less just luck. Now it should be stable.

> Is that right?
> 
> (Note: The alphabetical-ness of the branch names is reversed, which
> seems logical given my original sort was -committerdate. A
> --sort=refname looks like this.
> 
> refs/heads/!@#$% -> Tue Jan 3 17:00:51 2012 +1100
> refs/heads/!@#% -> Tue Jan 3 17:04:06 2012 +1100
> refs/heads/% -> Tue Jan 3 17:00:51 2012 +1100
> refs/heads/@#$% - >Tue Jan 3 17:00:51 2012 +1100
> refs/heads/@#% -> Tue Jan 3 17:00:51 2012 +1100
> 
> That's probably more correct too.)
> 
> Best regards,
> Bryan Turner

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
