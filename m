From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git push bug?
Date: Sat, 20 Oct 2007 10:29:59 +0200
Message-ID: <5513C211-DE33-411C-8EE6-2259B41DC3EA@zib.de>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se>  <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de> <1192723269.9433.21.camel@gentoo-jocke.transmode.se> <Pine.LNX.4.64.0710181720010.25221@racer.site> <9EEDF284-22BE-44BF-A9B8-116407784BEB@zib.de> <Pine.LNX.4.64.0710182258000.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 20 10:28:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij9hO-0005TT-EI
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 10:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbXJTI2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 04:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbXJTI2f
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 04:28:35 -0400
Received: from mailer.zib.de ([130.73.108.11]:61651 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217AbXJTI2e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 04:28:34 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9K8SU8h000288;
	Sat, 20 Oct 2007 10:28:30 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1a6f2.pool.einsundeins.de [77.177.166.242])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9K8STHE002887
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 20 Oct 2007 10:28:30 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710182258000.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61813>


On Oct 18, 2007, at 11:58 PM, Johannes Schindelin wrote:

>
> On Thu, 18 Oct 2007, Steffen Prohaska wrote:
>
>> On Oct 18, 2007, at 6:21 PM, Johannes Schindelin wrote:
>>
>>> On Thu, 18 Oct 2007, Joakim Tjernlund wrote:
>>>
>>>> Seems like it is a bit too easy to make mistakes here. Why can I  
>>>> delete
>>>> a branch with :linus but not create one with linus:linus?
>>>
>>> I wonder why you bother with the colon at all.  Just
>>>
>>> 	git push <remote> linus
>>>
>>> and be done with it.  The colon is only there to play interesting  
>>> games,
>>> not something as simple as "push this branch" or "push this tag".
>>
>> But you need a full refspec starting with 'refs/heads/' if you  
>> want to
>> create a new branch on the remote side.
>
> No.  Not if the name is the same on the local side.

You're right. The documentation of git-send-pack says what you're
saying:

'''
When one or more <ref> are specified explicitly, it can be either a  
single pattern, or a pair of such pattern separated by a colon  
":" (this means that a ref name cannot have a colon in it). A single  
pattern <name> is just a shorthand for <name>:<name>
'''

Here it says that <name> is a shorthand for <name>:<name>.
An later it states

'''
If <dst> does not match any remote ref, either
    * it has to start with "refs/"; <dst> is used as the destination  
literally in this case.
    * <src> == <dst> and the ref that matched the <src> must not  
exist in the set of remote refs; the ref matched <src> locally is  
used as the name of the destination.
'''

If <src> == <dst> then <dst> will be created even if it didn't exist.

I think the current implementation though is a bit different.
It will created a new branch for a colon-less refspec, that is

    git push origin work/topic

will create a new ref on the remote. But

    git push origin work/topic:work/topic

will _not_.


Until you corrected me, I believed that new branches will never
be created on the remote side unless a full ref is used. That is
I expected that only

    git push origin refs/heads/work/topic

would work.

I thought this would be another safety net -- kind of a reminder
not to push the wrong branch by accident.

I still like the idea, but apparently git didn't ever support what
I thought it would.

Maybe adding some command line flags making the different tasks
explicit could help:

     git push --create origin work/new-topic
     git push --delete origin work/old-topic
     git push --non-standard origin refs/funny/ref

We already have similar flags

     --all: all branches
     --tags: all tags
     --force: force non-fast-forward.

I haven't fully thought this through. Maybe I'll come up with a patch
later.

	Steffen
