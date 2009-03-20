From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Tracking of local branches
Date: Fri, 20 Mar 2009 15:22:38 +0100
Message-ID: <49C3A6AE.7020104@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 15:24:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkfe2-0003H0-VT
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 15:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbZCTOW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 10:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755564AbZCTOW4
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 10:22:56 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35724 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752481AbZCTOWz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 10:22:55 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id CD30B2F3EBB;
	Fri, 20 Mar 2009 10:22:53 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 20 Mar 2009 10:22:53 -0400
X-Sasl-enc: k5LQGE4Hs9oZFmIva8m+6ojckDyKyhzt+CfHwsVHhWil 1237558973
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 23D6E1B82D;
	Fri, 20 Mar 2009 10:22:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090320 Lightning/1.0pre Shredder/3.0b3pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113963>

Hi there,

me again. In connection with Dscho's recent patch which rang the bell on
tracked branches I noticed that local branches are treated somewhat
inconsistently by git. There are 2 ways to fix it, and I ask you for
your input on which one to choose.

First of all:
The documentation seems to imply that it's okay to follow local
branches, i.e. to have tracked local branches. Specifically, the option
--track allows setting up tracking info (branch.foo.merge) in cases
where it's not set up automatically (it is when you branch off a remote
tracking branch).

If it's not OK to say "git checkout -b newbranch --track local" when
local is a local branch you can stop reading here and tell me to stop
writing...

Now, assuming it's okay to have a local branch being tracked, the
current situation is:

git fetch/pull is okay (respects the setting)
git status/checkout/rev-parse BEL is not (acts as if there is no
tracking info)

I think I have tracked it down (pun intended) to the fact that one sort
of commands looks at the struct member branch->merge, the other at
branch->merge_name. The latter is set for branches which follow
something, the former only for followers of remote branches.

I semi-successfully messed around in remote.c (format_tracking_info(),
stat_tracking_info()) to make it use branch->merge_name rather than
branch->merge. This makes "git status" work as expected ("Your branch
is... severely screwed.") for tracked local branches. (It's messed up
for remote ones but hey it was a first shot; merge[0]->dst is really
needed here I guess.)

Now I could go after sha1_name.c and do the same,

OR

make it so that all branches have their merge member set up, uhm. Any
possible side effects?

What do you think?
Michael
