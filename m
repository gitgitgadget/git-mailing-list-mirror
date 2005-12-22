From: Andreas Ericsson <ae@op5.se>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 17:52:39 +0100
Message-ID: <43AAD9D7.1070503@op5.se>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com> <7vacevgwqr.fsf@assigned-by-dhcp.cox.net> <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de> <7vek465cev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de> <43AA75D1.7040009@op5.se> <Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de> <43AA9BE6.7000601@op5.se> <Pine.LNX.4.63.0512221530570.18551@wbgn013.biozentrum.uni-wuerzburg.de> <43AACBE9.7060201@op5.se> <Pine.LNX.4.63.0512221700310.18982@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 17:52:51 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpTgJ-0006Tz-T7
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 17:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbVLVQwl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 11:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbVLVQwl
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 11:52:41 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:20612 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030180AbVLVQwl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 11:52:41 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id EB0146BD02; Thu, 22 Dec 2005 17:52:39 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512221700310.18982@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13955>

Johannes Schindelin wrote:
> Hi,
> 
> this is getting silly. The problem is: how to setup a shared repository, 
> i.e. a repository into which different users can push their updates.
> 

You're simplifying. Your question was
"How can I set up a repository for multiple users to write to without 
setting a global umask for non-interactive shells?"

Junio said:
"I agree the setting should not be limited to git-shell, but I do
not think setting "umask" from git configuration is the right
way either.  For files and directories under $GIT_DIR, maybe
imposing the policy git configuration file has is OK, but I
think honoring the user's umask is the right thing for working
tree files."

which I whole-heartedly agree with. I'd be completely furious if a tool 
ignored the umask I use for checking out files of a local repository 
just because I happen to do some work at the machine where the repo is 
stored (I imagine this couldn't possibly affect repositories cloned 
remotely, although that would surely have me going ballistic).

You answered that it would be good for hooks as well, although those can 
set their own umask easily enough (if you forget it there, you'll be 
hastily reminded the first time it breaks, so no real harm done).

The problem as I see it is to update only the $GIT_DIR files with the 
proper umask (or rather, just the objects/ and refs/ directories, since 
$GIT_DIR/. is never touched after being created and the other are for 
repo maintainers only).

Enter the nifty git-receive-pack, which does all the writing when a repo 
is being pushed to, unless bypassed from the /git/foo working tree for 
the /git/foo/.git repository. The latter is already discouraged, so we 
might as well ignore that. It's also nice because it will never mess 
with files that are for the repo maintainer only, although hooks can 
ofcourse do whatever they like to those files provided the repo 
maintainer allows it.

Now it's time to go home, but I'll have a patch by tonight unless you 
beat me to it. :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
