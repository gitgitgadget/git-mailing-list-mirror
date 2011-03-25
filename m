From: Eli Barzilay <eli@barzilay.org>
Subject: Re: `*' gitignores and nested ignores
Date: Fri, 25 Mar 2011 05:37:10 -0400
Message-ID: <19852.25158.340116.57859@winooski.ccs.neu.edu>
References: <19851.6264.179471.935771@winooski.ccs.neu.edu>
	<4D8C4FCF.5060900@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:37:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q33SQ-0005eV-2a
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 10:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633Ab1CYJhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 05:37:15 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:60665 "EHLO
	winooski.ccs.neu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567Ab1CYJhO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 05:37:14 -0400
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id p2P9bB9m003367;
	Fri, 25 Mar 2011 05:37:11 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id p2P9bAHX003345;
	Fri, 25 Mar 2011 05:37:10 -0400
In-Reply-To: <4D8C4FCF.5060900@viscovery.net>
X-Mailer: VM 8.1.93a under 23.2.1 (x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169973>

An hour ago, Johannes Sixt wrote:
> Am 3/24/2011 11:10, schrieb Eli Barzilay:
> > According to the man page, a .gitignore file that is deeper has
> > higher precedence, and a `!' line overrides lower precedence
> > ignores.  I tried that, and it works in cases like the last
> > "vmlinux*" example.
> > 
> > But it doesn't work if the lower precedence directory has a "*"
> > pattern.  [...]
> > 
> > Is this a bug?
> 
> This has been discussed before, and IMNSHO, this is not a bug:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/157190

To reply to what you wrote there:

> You should update your expectations to match what you got.

That kind of an answer is a thick hint that something is not
documented right.  As things stand, I don't see anything in the man
page that describes the actual algorithm that is used.  I also found a
similar weirdness now -- the man page says

  within one level of precedence, the last matching pattern decides
  the outcome

but this is not true for nested files in this case:

  *
  !foo

So some description of what's going on is needed.  Perhaps it's
exactly what Seth's suggested patch describes.


In any case, it seems possible to do something that works more as
expected.  As suggested in that thread -- scanning only directories
that have committed files would not make things slow, since the files
need to be checked anyway.  This is not even hard to describe in a man
page.  It seems like some arbitrariness that buys performance, but its
less so than the current situation.

There's also the option of scanning only .gitignore files that are
checked in, but that will probably be too confusing when the files are
created and/or modified.

Yet another alternative is to say that an ignored .gitignore file is
ignored, and making this:

  /*
  !.gitignore

an idiom for doing the slow thing in case you really want it.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
