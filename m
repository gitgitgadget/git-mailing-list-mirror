From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 16:47:38 +0200
Message-ID: <448ADB8A.3070506@dawes.za.net>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>	<46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>	<46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>	<Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>	<Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>	<9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>	<Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>	<9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com>	<87y7w5lowc.wl%cworth@cworth.org>	<Pine.LNX.4.64.0606092001590.5498@g5.osdl.org>	<448A847C.20105@dawes.za.net> <7vzmglgyz0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 16:47:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fp4kj-0003Y5-48
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 16:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWFJOru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 10:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWFJOru
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 10:47:50 -0400
Received: from mailbigip2.dreamhost.com ([208.97.132.53]:2204 "EHLO
	spunkymail-a3.dreamhost.com") by vger.kernel.org with ESMTP
	id S1030422AbWFJOrt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 10:47:49 -0400
Received: from [192.168.201.67] (dsl-165-2-55.telkomadsl.co.za [165.165.2.55])
	by spunkymail-a3.dreamhost.com (Postfix) with ESMTP id DEA34111E2D;
	Sat, 10 Jun 2006 07:47:46 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Newsgroups: gmane.comp.version-control.git
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmglgyz0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21607>

Junio C Hamano wrote:
> Rogan Dawes <lists@dawes.za.net> writes:
> 
>> Here's an idea. How about separating trees and commits from the actual
>> blobs (e.g. in separate packs)?
> 
> If I remember my numbers correctly, trees for any project with a
> size that matters contribute nonnegligible amount of the total
> pack weight.  Perhaps 10-25%.

Out of curiosity, do you think that it may be possible for tree objects 
to compress more/better if they are packed together? Or does the 
existing pack compression logic already do the diff against similar tree 
objects?

>> In this way, the user has a history that will show all of the commit
>> messages, and would be able to see _which_ files have changed over
>> time e.g. gitk would still work - except for the actual file level
>> diff, "git log" should also still work, etc
> 
> I suspect it would make a very unpleasant system to use.
> Sometimes "git diff -p" would show diffs, and other times it
> mysteriously complain saying that it lacks necessary blobs to do
> its job.  You cannot even run fsck and tell from its output
> which missing objects are OK (because you chose to create such a
> sparse repository) and which are real corruption.

The fsck problem could be worked around by maintaining a list of objects 
that are explicitly not expected to be present. As the list gets shorter 
(perhaps as diffs are performed, other parts of the blob history are 
retrieved, etc), the list will get shorter until we have a complete 
clone of the original tree.

Of course diffs against a version further back in the history would 
fail. But if you start with a checkout of a complete tree, any changes 
made since that point would at least have one version to compare against.

In effect, what we would have is a caching repository (or as Jakub said, 
a lazy clone). An initial checkout would effectively be pre-seeding the 
cache. One does not necessarily even need to get the complete set of 
commit and tree objects, either. The bare minimum would probably be to 
get the HEAD commit, and the tree objects that correspond to that commit.

At that point, one could populate the "uncached objects" list with the 
parent commits. One would not be in a position to get any history at 
all, of course.

As the user performs various operations, e.g. git log, git could either 
go and fetch the necessary objects (updating the uncached list as it 
goes), or fail with a message such as "Cannot perform the requested 
operation - required objects are not available". (We may require another 
utility that would list the objects required for an operation, and 
compare it against the list of "uncached objects", printing out a list 
of which are not yet available locally. I realise that this may be 
expensive. Maybe a repo configuration option "cached" to enable or 
disable this.)

As Jakub suggested, it would be necessary to configure the location of 
the source for any missing objects, but that is probably in the repo 
config anyway.

> A shallow clone with explicit cauterization in grafts file at
> least would not have that problem. Although the user will still
> not see the exact same result as what would happen in a full
> repository, at least we can say "your git log ends at that
> commit because your copy of the history does not go back beyond
> that" and the user would understand.

Or, we could say, perform the operation while you are online, and can 
access the necessary objects. If the user has explicitly chosen to make 
a lazy clone, then they should expect that at some point, whatever they 
do may require them to be online to access items that they have not yet 
cloned.

Rogan
