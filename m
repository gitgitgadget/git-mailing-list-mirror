From: david@lang.hm
Subject: Re: looking for suggestions for managing a tree of server configs
Date: Sun, 21 Oct 2012 16:33:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1210211553420.31862@asgard.lang.hm>
References: <alpine.DEB.2.02.1210131413240.6253@asgard.lang.hm> <7vpq4l1x86.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.02.1210132153040.6253@asgard.lang.hm> <CAM9Z-nmHxyqnyq1fChhv7hP_awgsaO2FT1t29PAwrvZkaA-hgg@mail.gmail.com> <alpine.DEB.2.02.1210201931130.31862@asgard.lang.hm>
 <CAM9Z-n=VGM4cjrZxMz=n5LwDsvuG6uwXymh4J3Gjq4mYJoGPcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 01:34:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ51t-00054N-Mh
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 01:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727Ab2JUXdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 19:33:50 -0400
Received: from mail.lang.hm ([64.81.33.126]:40446 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932721Ab2JUXdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 19:33:49 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id q9LNXgiw021916;
	Sun, 21 Oct 2012 16:33:42 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CAM9Z-n=VGM4cjrZxMz=n5LwDsvuG6uwXymh4J3Gjq4mYJoGPcg@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208165>

On Sun, 21 Oct 2012, Drew Northup wrote:

> On Sat, Oct 20, 2012 at 10:34 PM,  <david@lang.hm> wrote:
>> On Sat, 20 Oct 2012, Drew Northup wrote:
>>> On Sun, Oct 14, 2012 at 12:57 AM,  <david@lang.hm> wrote:
>>>> On Sat, 13 Oct 2012, Junio C Hamano wrote:
>>>>> david@lang.hm writes:
>>>>>>
>>>>>> today I have just a single git tree covering everything, and I make a
>>>>>> commit each time one of the per-server directories is updated, and
>>>>>> again when the top-level stuff is created.
>>>>>
>>>>> if a large portion of the configuration for these servers are
>>>>> shared, it might not be a bad idea to have a canonical "gold-master"
>>>>> configuration branch, to which the shared updates are applied, with
>>>>> a branch per server that forks from that canonical branch to keep
>>>>> the machine specific tweaks
>>>>
>>>> In an ideal world yes, but right now these machines are updated by many
>>>> different tools (unforuntantly including 'vi'), so
>>>> these directories aren't the config to be pushed out to the boxes, it's
>>>> instead an archived 'what is', the result of changes from all the tools.
>
> So you need to save what is there before pulling changes from the
> master. That's no different from doing development work on an active
> code base.

I think I've done a poor job of explaining my problem.

I'm not looking for tips on how to manage the systems themselves, I'm 
looking for suggestions on how to manage this data that I'm already 
gathering on this reporting server.

I have the problem that different departments have their own (different) 
preferred tools for implementing changes. There are 6 different 
departments that need to be involved with a single system to build and 
maintain it. Each department has their 'standard' way of doing things. At 
least two of these departments are using different, central configuration 
(i.e. puppet like) tools.

As a result, I am not looking to pull changes from the central location. 
I'm just trying to gather information and be able to produce reports about 
the systems (Including "This is what all the different configs files on 
this server were like at time X"). I'm not using the distributed features 
of git at this time.

I've got existing tools that do a very similar job to what it sounds like 
sysconfcollect does that gather the non-sensitive info from all my remote 
machines and sends the data to my central server. These tools send an 
update whenever 'significant' changes are made, and in addition do a 
scheduled update to catch less significant changes.

On my central server I have the directory configs-current that then has a 
subdirectory details/systemname for each system that contains all the 
information about htat system (populated by scripts that parse apart the 
data mentioned above)

In other files and directories in configs-current I have lots of more 
global data and reports. This includes things like a report of every 
interface on every machine, the IP address, does it have link, what speed 
is it at, etc.

Right now I have one git tree for configs-current and each time I update a 
details/systemname tree I do

git add -a configs-current/details/$systemname
git commit -m'system update from $servername'

then when I run the summary scripts I do

git add -a configs-current
git commit -m'summary update'

This has been working for a few years

However, trying to go back in history to find a change on one system is a 
pain.

Right now the updates accumulate until I manually trigger a processing 
cycle to update the files. I would like to make it so that the updates to 
each system's details/systemname directory is done automatically as the 
e-mail from that system arrives, and this could result in parallel 
updates. I don't think that git will handle this well in one tree with the 
existing process (different processes doing git add and git commits in 
parallel will end up mixing their data)

As one big tree, this has lots of commits (a couple hundred each update), 
and this is making it slow to try and track changes to a particular file 
in a particular system.

I'm thinking that splitting the history tracking per-server should make 
everything faster.

I'm wondering if I should do a subproject for each details/systemname 
directory, or if there is something else I can do to make this tracking of 
the data better.

Doing a single repository with lots of branches doesn't seem like it would 
work as I need to get at the data from all the branches at the same time. 
I guess I could do something with branches on one repository, with a 
different worktree for each system, but that seems a bit fragile (one 
command with the wrong environment variables and it coudl really tangle 
things up)

David Lang
