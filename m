From: Andreas Ericsson <ae@op5.se>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 16:53:13 +0100
Message-ID: <43AACBE9.7060201@op5.se>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com> <7vacevgwqr.fsf@assigned-by-dhcp.cox.net> <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de> <7vek465cev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de> <43AA75D1.7040009@op5.se> <Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de> <43AA9BE6.7000601@op5.se> <Pine.LNX.4.63.0512221530570.18551@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 16:53:20 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpSko-0001hR-6s
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 16:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbVLVPxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 10:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVLVPxP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 10:53:15 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:4484 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1030217AbVLVPxO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2005 10:53:14 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id B86A16BD02; Thu, 22 Dec 2005 16:53:13 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512221530570.18551@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13952>



Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 22 Dec 2005, Andreas Ericsson wrote:
> 
> 
>>Johannes Schindelin wrote:
>>
>>>Okay, so there you are. You have a write-shared repository with the HEAD
>>>checked out. Somebody wants to push to that with different credentials than
>>>the user who checked out the files. Do you plainly deny updating the current
>>>HEAD?
>>>
>>>If you do, then you better give the pushing user (pun intended) a way to
>>>update the checked out files. You can do this by (tadaah) setting the umask
>>>to 0002 also for working files.
>>>
>>
>>Ahh. Sorry. We use this method a lot, really, but always only for running gitk
>>and archaeology tools to check newly pushed changes, so the write-shared repo
>>is only write-shared for remote users, and the local one never does a commit.
>>It's perhaps a bit of a weird setup, but it lets you get an overview faster
>>than gitweb and works well enough with samba. Noted should be that having the
>>repo checked out is merely a convenience thing to let one browse the files at
>>leisure. People know to do
>>	git checkout -f HEAD
>>
>>whenever they want to dig around.
> 
> 
> Better to do this with a post-update hook, right? You can't forget to 
> checkout this way. *Plus* you can make sure the umask is correct in the 
> hook.
> 

What prevents you from setting umask 002 in the hook? If the files are 
already checked out with some other (write-denying) umask by some other 
user it will fail regardless of where the umask comes from.

> 
>>>Yes, we could find out exactly where writes happen inside GIT_DIR and plug
>>>in shared.umask which is only applied in these cases, but I am totally
>>>unconvinced that this is worth the hassle. In my cases, I am perfectly
>>>helped by a umask which is respected throughout git, and the patch is simple
>>>enough to be reviewed in 5 minutes.
>>>
>>
>>But adding
>>
>>	umask 002
>>
>>to /etc/bashrc would do exactly the same thing, so why have it a setting for
>>the repository only? In my experience, most servers used for hosting git repos
>>host *lots* of them (look at master.kernel.org), so a server-wide setting
>>really makes much more sense. If the server admin can't be bothered you can
>>always change $HOME/.bashrc.
> 
> 
> In my very special setup, it is a server on which you have your personal 
> files, too. So, setting umask = 0002 globally is not an option.
> 

scp -p preserves the umask you have on your desktop/laptop, so unless 
you frequently do

	ssh somewhere "echo 'Gawds, this is an awkward way of editing files' >> 
somefile"

you should be good with the bashrc setting. You can override it from 
bash_profile to make sure you get a safely sane umask when logging in 
interactively.

> 
>>So long as people remember that .bash_profile isn't read for non-interactive
>>shells this should do nicely. If they can't remember that they won't remember
>>adding the setting to the repository either.
> 
> 
> Problem is, what if one of your users is a tcsh zealot? Or simply forgot 
> to set it. Trouble in China. Also, I simply can not memorize what startup 
> script gets called when.
> 

tcsh zealot? Not familiar with that one. If you're trying to cover every 
angle I think you'll be in for a disappointment though. Users are 
usually fairly ingenious when it comes to finding ways of causing trouble.

As for forgetting to set it, I was talking about the /etc/bashrc file 
here. There is a /etc/cshrc as well, although this tcsh zealot shell 
might ignore it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
