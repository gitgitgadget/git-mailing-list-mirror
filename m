From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Heads up: rebase -i -p will be made sane again
Date: Tue, 27 Jan 2009 10:29:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271012550.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Stephen Haberman <stephen@exigencecorp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 10:30:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRkHU-0002wa-GD
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 10:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbZA0J31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 04:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbZA0J30
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 04:29:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:46663 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751124AbZA0J30 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 04:29:26 -0500
Received: (qmail invoked by alias); 27 Jan 2009 09:29:23 -0000
Received: from pD9EB30BF.dip0.t-ipconnect.de (EHLO noname) [217.235.48.191]
  by mail.gmx.net (mp069) with SMTP; 27 Jan 2009 10:29:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9nmgIrnb9vsQ72HxVjDH5FpMLLIzrgM1RUoWcmk
	RmyL53T6SpcWeq
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107324>

Dear list,

I am progressing to a point where I am almost comfortable to send the 
patch series; I want to use the thing myself first, and I want to fix a 
design bug.

As always, my code is public, but will be rebased frequently.  You have 
been warned.

BTW I am really sorry for the state I left the --preserve-merges code for 
a long time.  Originally, it was never meant to be used interactively, and 
that shows sorely.

As for the design bug I want to fix: imagine this history:

  ------A
 /     /
/     /
---- B
\     \
 \     \
  C-----D-----E = HEAD

A, C and D touch the same file, and A and D agree on the contents.

Now, rebase -p A does the following at the moment:

  ------A-----E' = HEAD
 /     /
/     /
---- B

In other words, C is truly forgotten, and it is pretended that D never 
happened, either.  That is exactly what test case 2 in t3410 tests for 
[*1*].

This is insane.

So after my rebase -i -p revamp, this will happen instead: in the 
interactive version you will get the script

	pick C
	merge parents B' original D
	pick E

In the non-interactive version -- or if you change nothing, in the 
interactive version, too -- this will lead to a conflict while picking C.

As it should.

Ciao,
Dscho

[*1*] The code in t3410 was not really easy to read, even if there was an 
explanation what it tried to do, but the test code was inconsitent, 
sometimes tagging, sometimes not, sometimes committing with -a, sometimes 
"git add"ing first, yet almost repetitive.

In my endeavor not only to understand it, and either fix my code or the 
code in t3410, I refactored it so that others should have a much easier 
time to understand what it actually does.
