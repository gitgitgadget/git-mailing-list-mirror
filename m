From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 15:01:22 -0700
Message-ID: <86k5u7zf7x.fsf@blue.stonehenge.com>
References: <18031.64456.948230.375333@lisa.zopyra.com>
	<86zm33291h.fsf@blue.stonehenge.com>
	<20070613192828.GB3412@steel.home>
	<86645r1wh8.fsf@blue.stonehenge.com>
	<20070613204711.GC3412@steel.home>
	<86odjjziek.fsf@blue.stonehenge.com>
	<20070613213931.GD3412@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 00:01:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyau6-0008Md-17
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 00:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbXFMWBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 18:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbXFMWBY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 18:01:24 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:45951 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbXFMWBX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 18:01:23 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 549A01DEFB7; Wed, 13 Jun 2007 15:01:22 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.7.2; tzolkin = 1 Ik; haab = 10 Zotz
In-Reply-To: <20070613213931.GD3412@steel.home> (Alex Riesen's message of "Wed, 13 Jun 2007 23:39:31 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50136>

>>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:

Alex> You left the process of figuring out what files should be temporarily
Alex> added to the index. _Automatically_. Because that's what you need if
Alex> you want "git pull" to just work. Otherwise it just fails.

I'd just commit *all* of it in my scenerio.  There won't be any *other* files.
And because of the final git-reset --soft and git-reset, it won't matter if I
commited more than I'd ever commit on the final hit.

The result of my sequence (I believe) is that my topic commits will appear
rebased on top of the new upstream, and that I'll have a dirty working
directory that represents things as they were, ready for the next commit.

I *lose* the idea of what files were partially added before the last commit,
but I can always reconstruct that by hand, because I should already be
thinking about that before the next commit.

Using those famous trees, if I start with:

A--B--C--D origin
         --E--F--G my_topic
                 --(X) dirty tree

and upstream commits P Q R, the result will be:

A--B--C--D--P--Q--R origin
                  --E'--F'--G' (E, F, G rebased and merged) my_topic
                            --(X') dirty tree rebased

This works because I temporarily make H, which follows E, F, G
and then rebase E-F-G-H onto origin,
and then simply "uncommit" H'.

Oops.  I see the problem.  I don't need the "WIP" tag.  I want to uncommit to
G' not to G.  Is that what you were referencing?

In which case, it's even simpler:

git-add . # add *everything* that's not .gitignored
git-commit -a -m WIP # save for replay (H above)
git-fetch origin # get upstream (P Q R)
git-rebase origin # creates E' F' G' H'
git-reset --soft HEAD^ # back up to G'
git-reset # mark everything un-added as of G'

Yeah, this is far easier.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
