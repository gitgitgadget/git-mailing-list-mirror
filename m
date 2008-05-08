From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: help with git usage
Date: Thu, 08 May 2008 22:01:06 +0200
Message-ID: <48235C02.9010808@dirk.my1.cc>
References: <200804291738.m3THc2hC030601@rs40.luxsci.com> <alpine.LNX.1.00.0804291354070.19665@iabervon.org> <m3tzhjokox.fsf@localhost.localdomain> <200805072242.m47Mg1o0015578@rs40.luxsci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Daniel Quinlan <danq@brtt.com>
X-From: git-owner@vger.kernel.org Thu May 08 22:02:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuCJi-0002zy-Gh
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 22:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbYEHUBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 16:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbYEHUBM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 16:01:12 -0400
Received: from smtprelay07.ispgateway.de ([80.67.29.7]:55809 "EHLO
	smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbYEHUBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 16:01:09 -0400
Received: from [84.176.119.123] (helo=[192.168.2.100])
	by smtprelay07.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JuCId-0006xU-7H; Thu, 08 May 2008 22:01:07 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <200805072242.m47Mg1o0015578@rs40.luxsci.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81554>

Hi,

what about using git-describe? At work we use sth. similar to the
following script. Let's call it 'git-stamp':

-------------
#!/usr/bin/bash

if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
    here=$(pwd)
    topdir=$(git rev-parse --show-cdup)
    cd ${topdir:-'./'}
    desc=$(git describe)
    if [ $(git diff-index --name-only HEAD | wc -l) -ne 0 ]; then
        desc="$desc-dirty"
    fi
    cd $here
    echo $desc
    exit 0;
else
    echo "Not inside a git working tree."
    exit 1;
fi
-------------

Basically it outputs the output of 'git-describe'. When something
whithin your working dir is currently *not* checked in, it outputs
"$(git-describe)-dirty".

Some sort of "-D$(git-stamp)" compiler switch would do the thing.
Depending on your makefile or scons-script this would yield to a
complete recompile of everything when only one file has changed.

In our environment we patch $(git-stamp) into some "version.c"
so the whole application only gets recompiled when version.c
has changed.

HTH,
    Dirk



Daniel Quinlan schrieb:
> Thanks for your earlier responses, they were very helpful.
>
> On Apr 30, 2008, at 1:39 AM, Jakub Narebski wrote:
>
>> Daniel Barkalow <barkalow@iabervon.org> writes:
>>
>>> On Tue, 29 Apr 2008, Daniel Quinlan wrote:
>>>
>>>> I've been trying to use git for awhile now, (and I've read a lot
>>>> of documentation, though maybe my comprehension has not been high
>>>> enough) but there are several operations which I can't figure out:
>>
>> Many of answers to your questions can be found on GitFaq,
>> http://git.or.cz/gitwiki/GitFaq
>
> I should have read this earlier.  I don't really understand the
> details, but I get the idea:  make the central repository bare.
>
>>
>
>>>> 3) Similarly, I can't use the little context diffs I can see in
>>>> git-gui -- I need to see side by side comparisons; I've become
>>>> accustomed to tkdiff.  It seems like git mergetool knows how to do
>>>> that in some restricted circumstances, but I want to do it outside
>>>> the context of a merge.
>>>
>>> This I don't know, but you can get particular files from particular
>>> commits output with "git show <commit>:<path>", and you can likely wire
>>> something up.
>>
>> From the various graphical comparison tools, Meld has supposedly Git
>> support (http://meld.sourceforge.net/).  Supposedly only because I
>> have not tested this; see
>> http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-00fbd1ac45fe93dac4653cad3639b3df73d8657e 
>>
>>
>
> I found no mention of git on the meld man page or in the meld mailing 
> list.
>
> Here's a (perhaps naive) perl script which uses "git show" and wraps 
> around
> the original tkdiff.  Other cvs users might find it useful, though it 
> can surely
> be improved.
>
>
>
>
>
> I'm looking for a way to embed some identifying information about version
> into compiled programs.  I hasten to add that I am not looking to 
> expand RCS-like
> tags.  Unlike CVS/RCS, git provides a single value that characterizes 
> the whole
> distribution, at least if everything is committed.  So, something like 
> "git log | head -1 | awk '{print $2}'"
> probably provides a value which I can embed into executables and 
> libraries, tying
> them to a particular source configuration.  I'm just curious if 
> there's a better approach
> to getting the commit hash.
>
> -- danq
>
>
