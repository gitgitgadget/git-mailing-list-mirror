From: David Lang <david@lang.hm>
Subject: Re: Watchman support for git
Date: Fri, 9 May 2014 11:27:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1405091124150.5876@nftneq.ynat.uz>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>   <536428224adfb_200c12912f010@nysa.notmuch>  <1399083897.5310.0.camel@stross>   <5364654088dc4_4d2010fb2ec7d@nysa.notmuch> <536BD864.5090804@gmail.com>   <alpine.DEB.2.02.1405090002000.17457@nftneq.ynat.uz>
  <1399655858.11843.119.camel@stross>  <alpine.DEB.2.02.1405091103200.5876@nftneq.ynat.uz> <1399659442.11843.125.camel@stross>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 09 20:27:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WipVz-0000bx-8Z
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 20:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096AbaEIS1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 14:27:18 -0400
Received: from mail.lang.hm ([64.81.33.126]:39749 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757221AbaEIS1P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 14:27:15 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s49IRCmY012567;
	Fri, 9 May 2014 11:27:12 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <1399659442.11843.125.camel@stross>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248606>

On Fri, 9 May 2014, David Turner wrote:

> On Fri, 2014-05-09 at 11:08 -0700, David Lang wrote:
>> On Fri, 9 May 2014, David Turner wrote:
>>
>>> On Fri, 2014-05-09 at 00:08 -0700, David Lang wrote:
>>>> On Thu, 8 May 2014, Sebastian Schuberth wrote:
>>>>
>>>>> On 03.05.2014 05:40, Felipe Contreras wrote:
>>>>>
>>>>>>>> That's very interesting. Do you get similar improvements when doing
>>>>>>>> something similar in Merurial (watchman vs . no watchman).
>>>>>>>
>>>>>>> I have not tried it.  My understanding is that this is why Facebook
>>>>>>> wrote Watchman and added support for it to Mercurial, so I would assume
>>>>>>> that the improvements are at least this good.
>>>>>>
>>>>>> Yeah, my bet is that they are actually much better (because Mercurial
>>>>>> can't be so optimized as Git).
>>>>>>
>>>>>> I'm interested in this number because if watchman in Git is improving it
>>>>>> by 30%, but in Mercurial it's improving it by 100% (made up number),
>>>>>> therefore it makes sens that you might want it more if you are using hg,
>>>>>> but not so much if you are using git.
>>>>>>
>>>>>> Also, if similar repositories with Mercurial+watchman are actually
>>>>>> faster than Git+watchman, that means that there's room for improvement
>>>>>> in your implementation. This is not a big issue at this point of the
>>>>>> process, just something nice to know.
>>>>>
>>>>> The article at [1] has some details, they claim "For our repository, enabling Watchman integration has made Mercurial's status command more than 5x faster than Git's status command".
>>>>>
>>>>> [1] https://code.facebook.com/posts/218678814984400/scaling-mercurial-at-facebook/
>>>>
>>>> a lot of that speed comparison is going to depend on your storage system and the
>>>> size of your repository.
>>>>
>>>> if you have a high-end enterprise storage system that tracks metadata very
>>>> differently from the file contents (I've seen some that have rackes worth of
>>>> SATA drives for contents and then 'small' arrays of a few dozen flash drives for
>>>> the metadata), and then you have very large repositories (Facebook has
>>>> everything in a single repo), then you have a perfect storm where something like
>>>> watchman that talks the proprietary protocol of the storage array can be FAR
>>>> faster than anything that needs to operate with the standard POSIX calls.
>>>>
>>>> That can easily account for the difference between the facebook announcement and
>>>> the results presented for normal disks that show an improvement, but with even
>>>> stock git being faster than improved mercurial.
>>>
>>> As I recall from Facebook's presentation[1] on this (as well as from the
>>> discussion on the git mailing list[2]), Facebook's test respository is
>>> much larger than any known git repository.  In particular, it is larger
>>> than WebKit.
>>
>> agreed, it's huge, it's the entire codebase history of every tool that they use
>> crammed together in one rep
>>
>>> These performance improvements are not for server-side
>>> tasks, but for client-side (e.g. git/hg status).  Facebook also made
>>> other improvements for the client-server communication, and for
>>> log/blame, but these are not relevant to watchman.
>>
>> well, in their situation they have shared storage that clients use for this huge
>> repo, so I don't think they have a clear client/server boundry the way you are
>> thinking. Even clients have this huge repo to deal with, and they can do so
>> efficiently by querying the storage device rather than trying to walk the tree
>> or monitor access directly.
>
> That's not my understanding from Durham Goode's talk in January.  Yes,
> operations involving history go to the server.  But the client also
> maintains a copy of the working tree, and it is for this that watchman
> is used.  Otherwise, why bother with watchman at all?  The server knows
> when it changes files and could simply maintain its own index of what's
> changed.  Watchman is built on inotify/fsevents -- it doesn't have
> anything to do with any sort of storage device beyond a vanilla hard
> drive.

When you have such a massive repo, your clients aren't storing the data on their 
local drives, they are accessing the data on a network attached storage (via NFS 
or through a fuse mount). So they can have their watchman send queries to the 
storage server to find out what has changed in this massive repo rather than 
having to walk the directory tree (or try to monitor it for changes on the 
client machine)

David Lang
