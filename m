From: Andreas Ericsson <ae@op5.se>
Subject: Re: Question about possible git races
Date: Thu, 23 Mar 2006 00:28:30 +0100
Message-ID: <4421DD9E.7030201@op5.se>
References: <200603201724.12442.astralstorm@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 00:28:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMCkm-0003oh-E2
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 00:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWCVX2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 18:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWCVX2d
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 18:28:33 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:28870 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932532AbWCVX2c
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 18:28:32 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id DC73D6BCFE; Thu, 23 Mar 2006 00:28:30 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Radoslaw Szkodzinski <astralstorm@o2.pl>
In-Reply-To: <200603201724.12442.astralstorm@o2.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17832>

Radoslaw Szkodzinski wrote:
> I'd like to write a multithreaded application using git,

Why on earth? The git tools aren't written to be thread-safe in that 
manner, so you'll run into all sorts of problems. Unless you're talking 
about managing the code for a multithreaded application with git, in 
which case you should just go read the tutorial. However, feeling 
slightly tipsy and in a distinctly good mood, I shall try to answer your 
questions anyway.


> so I'd like to see if 
> there are any races:
> 
> - push vs pull
> One thread pushes to the repository while another is pulling from it at the 
> same time. I should get the older commit.
> 

You will. Git atomizes (atomicizes? atomicifies?) pushes by updating the 
branch head being pushed to after all the commit-, tree- and 
blob-objects are written. Tags are handled separately but equally 
atomically.


> - push vs push
> Both threads push at the same time. What happens?
> Any good way to merge those pushes?
> (I have full access to both repos)
> 
> Possibly those two aren't fast-forward of each other.
> I think one of the pushes should abort in this case unless I force it.
> 

Read the source to find out if it's locking the repo while updating or 
not (I think it is, but I'm not sure). If it isn't the last one to 
finish pushing wins out since the branch head update from that push will 
overwrite the previous one.


> - fetch vs fetch
> I mean that two threads try to fetch from different repositories to a single 
> one. Possibly those two aren't fast-forward of each other.
> Any good way to merge those fetches?
> (I have full access to both repos)
> 

git help octopus

You can fetch those two remote branch heads to local branches 
simultaneously and then do the octopus in the master-thread while no 
other updates are happening. Doing several simultanous merges to a 
single branch is quite frankly so insane I have to go get myself a drink 
just from thinking about it.

> I'm meaning really bare git there, w/o bash+perl scripts.
> 

I don't think you can do it without Python. The default merge strategy 
is written in python, so.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
