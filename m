From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: feature request: git-log should accept sth like
 v2.6.26-rc8-227
Date: Fri, 11 Jul 2008 21:35:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807112129290.8950@racer>
References: <200807102057.15063.toralf.foerster@gmx.de> <200807111539.06606.toralf.foerster@gmx.de> <37fcd2780807110744k3b2a332csdf788dabd172622c@mail.gmail.com> <200807111658.40626.toralf.foerster@gmx.de> <20080711192902.GD1721@dpotapov.dyndns.org>
 <alpine.DEB.1.00.0807112041470.8950@racer>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1417154506-1215808530=:8950"
Cc: =?ISO-8859-15?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 22:36:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHPLz-0001YF-5Z
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 22:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336AbYGKUfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 16:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754804AbYGKUfc
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 16:35:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:42470 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755235AbYGKUfb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 16:35:31 -0400
Received: (qmail invoked by alias); 11 Jul 2008 20:35:29 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp018) with SMTP; 11 Jul 2008 22:35:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7vxZu5EP7EzQGCfE2G42XAQ5T9pphXrpPYzs83E
	lnkl5HKSG3Mn3m
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0807112041470.8950@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88170>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1417154506-1215808530=:8950
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 11 Jul 2008, Johannes Schindelin wrote:

> On Fri, 11 Jul 2008, Dmitry Potapov wrote:
> 
> > On Fri, Jul 11, 2008 at 04:58:40PM +0200, Toralf Förster wrote:
> > > 
> > > $> git-log v2.6.26-rc9.. --pretty=short | grep "^commit" | cut -f2 -d' ' | xargs -n 1 git describe | grep '\-56\-'
> > 
> > The fastest way to do the same would be:
> > 
> > git rev-list v2.6.26-rc9.. | xargs git describe | grep '\-56\-'
> 
> You forgot the "--all" option to rev-list.
> 
> And I doubt it would be the "fastest" way, in terms of execution speed.
> 
> Also, it leaves out this case:
> 
> rc9 - A - B - C - D - F
>     \               /
>       ----- E -----
> 
> F would be "rc9-5", but also "rc9-2".
> 
> Oh, and this would leave out reflogs, too.
> 
> Can we please let this concept die now?

Heh, just as an intellectual exercise, I could not resist trying to brush 
up my l33t py7h0n sk1llz (and I am sure somebody will teach me something 
useful again):

-- snipsnap --
#!/usr/bin/python

import os
import sys

if len(sys.argv) != 2:
	print 'Usage:', sys.argv[0], '<pseudo-describe>'

# split argument
dash = sys.argv[1].rindex('-')
tag = sys.argv[1][0:dash]
generation = int(sys.argv[1][dash + 1:])

# get sha1 of given tag's commit
pipe = os.popen('git rev-parse ' + tag + '^{commit}')
sha1 = pipe.readlines()[0].strip()
pipe.close()

# 'number' will contain (positive) distance to given commit
number = dict()
number[sha1] = set()
number[sha1].add(0)

pipe = os.popen('git rev-list ^' + sha1 + ' --all --parents')
rev_list = pipe.readlines()
pipe.close()

rev_list.reverse()
for line in rev_list:
	list = line.strip().split(' ')
	number[list[0]] = set()
	for parent in list[1:]:
		if parent in number:
			for n in number[parent]:
				number[list[0]].add(n + 1)
	for n in number[list[0]]:
		if n == generation:
			print list[0]
--8323329-1417154506-1215808530=:8950--
