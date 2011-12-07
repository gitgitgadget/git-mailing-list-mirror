From: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
Subject: Re: Auto update submodules after merge and reset
Date: Wed, 07 Dec 2011 10:07:34 +0100
Message-ID: <jbnadt$hf8$1@dough.gmane.org>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 10:08:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYDUS-0002yf-1C
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 10:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130Ab1LGJIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 04:08:30 -0500
Received: from lo.gmane.org ([80.91.229.12]:51268 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab1LGJI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 04:08:28 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RYDUI-0002vv-OR
	for git@vger.kernel.org; Wed, 07 Dec 2011 10:08:26 +0100
Received: from brln-4dba4613.pool.mediaways.net ([77.186.70.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 10:08:26 +0100
Received: from andreas.t.auer_gtml_37453 by brln-4dba4613.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 10:08:26 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: brln-4dba4613.pool.mediaways.net
User-Agent: KNode/4.4.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186449>

Jens Lehmann wrote:

> Am 30.11.2011 01:55, schrieb Max Krasnyansky:
> I'm working on a patch series to teach Git to optionally update the
> submodules work trees on checkout, reset merge and so on, but I'm not
> there yet.
>
>> I'm thinking about adding a config option that would enable automatic
>> submodule update but wanted to see if there is some fundamental reason
>> why it would not be accepted.
Because there is no good way to do so. It would be fine when you just track 
the submodules "read-only", but if you are actually working on submodules, 
it is a bad idea to always get a detached HEAD. It is also a bad idea to 
merge or rebase on the currently checkedout branch. Because if you are 
working on a maint branch in the submodule and then you checkout a pu branch 
in the superproject, because you have forgotten that maint branch in the 
submodule then all the proposed updates go to the maintenance branch -> bad. 
So auto-update is not easy. But below I describe an idea that might solve 
these issues and help auto-udpate to work in a sane way.
 
> I think adding something like an "submodule.autoupdate" config makes lots
> of sense, but IMO it should affect all work tree updating porcelain
> commands, not just merge.

I was thinking about submodule integration and had the idea to bind a 
submodule to the superproject by having special references in the submodule 
like refs/super/master, refs/super/featureX... So these references are like 
tracking branches for the refs/heads/* of the superproject.

If you have tracking branches, the supermodule can just update the 
corresponding branch. If this branch is currently checkedout and the work 
area is clean, then the work area is updated, too. If there is currently a 
local branch or a diffent super-branch checked out then the working area 
should be considered "detached" from the superproject and not updated. 

With this concept you could even switch branches in the superproject and the 
attached submodules follow - still having no detached HEAD. When you want to 
do some local work on the submodule you checkout a local branch and merge 
back into the super branch later. The head of that super branch might have 
changed by the update procedure meanwhile, but that is fine, then you just 
have a merge instead of a fast-forward.

Another nice feature would be a recursive commit. So all changed index files 
in the _attached_ submodules would first be committed in their submodules 
and then the superproject commits too - all with one command. Currently it 
feels a little bit like CVS - commit one file(submodule), commit the other 
file(submodule) and then apply a label(commit the superproject) to keep the 
changes together. 

If the submodule is not attached the commit in the superproject can still 
detect changes that have been made to the corresponding tracking branch and 
pick these up.

As a summary: Tracking submodule branches in the superproject instead of 
only the current HEAD of the submodule gives you more freedom to install 
sane auto-update procedures. Even though it will raise a lot of detailed 
questions like "should the refs/super/* be pushed/pulled when syncing the 
submodule repositories".
