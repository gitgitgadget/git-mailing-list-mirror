From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git.c: Re-introduce sane error messages on missing commands.
Date: Wed, 28 Jun 2006 13:53:26 +0200
Message-ID: <44A26DB6.1080408@op5.se>
References: <20060627083508.E912A5BBAB@nox.op5.se> <7vpsgu6wba.fsf@assigned-by-dhcp.cox.net> <44A23A38.3090206@op5.se> <Pine.LNX.4.63.0606281118330.29667@wbgn013.biozentrum.uni-wuerzburg.de> <7vr71938t4.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0606281240480.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 13:54:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvYcI-0002Tr-Qw
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 13:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423292AbWF1Lxb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 07:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423290AbWF1Lxa
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 07:53:30 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:41412 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1423291AbWF1Lx2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 07:53:28 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id ED1FA6BCBF; Wed, 28 Jun 2006 13:53:26 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606281240480.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22805>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 28 Jun 2006, Junio C Hamano wrote:
> 
> 
>>Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>
>>>Try this:
>>>
>>>$ mkdir 5
>>>$ cd 5
>>>$ git-init-db
>>>$ rm .git/config # yes, really.
>>>$ git abc
>>
>>Thanks for trying to help, but not really.
> 
> 
> Okay. Does not happen with 'next' here, too. I have some changes in my 
> private repo (which eventually should culminate in the big mmap()ed sooper 
> config parsing / writing thingie), which make it break. The following 
> patch fixes this (and potentially Andreas' problem, too).
> 

It should, although the command it tried to execute will still be empty 
if it fails for some other reason (file not executable / permission 
denied), since it only does the right thing on ENOENT.

This is also, imo, a bit worse than preserving the errno from the 
execve() call in the caller, since errno is sometimes a macro (yes, only 
in threaded apps atm, but still...), and it will be easy to forget to 
look in handle_alias() if other things change in main() that makes this 
bug resurface.

Oh, and the part of my patch removing the git_command variable from 
git.c:main() still has to be applied for arbitrary error-messages to 
look sane.

$ grep -B1 git_command git.c
         char *slash = strrchr(cmd, '/');
         char git_command[PATH_MAX + 1];
--
         fprintf(stderr, "Failed to run command '%s': %s\n",
                 git_command, strerror(errno));


Btw, Junio, did you try this with 'master' as of yesterday morning (git 
version 1.4.1.rc1.g1ef9)? It's reproducible on every machine I've tried 
so far (well, only five, but still), so it seems odd that you don't see it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
