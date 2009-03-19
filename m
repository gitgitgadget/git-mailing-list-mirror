From: david@lang.hm
Subject: Re: Git Large Object Support Proposal
Date: Thu, 19 Mar 2009 16:42:31 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903191625360.16753@asgard.lang.hm>
References: <d411cc4a0903191514n1e524ebava5895d708a2927c4@mail.gmail.com> <7veiwt6t6a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 00:44:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkRuA-0002UR-9C
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 00:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190AbZCSXmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 19:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754938AbZCSXmh
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 19:42:37 -0400
Received: from mail.lang.hm ([64.81.33.126]:41842 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241AbZCSXmh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 19:42:37 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2JNgVsm010169;
	Thu, 19 Mar 2009 15:42:31 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7veiwt6t6a.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113864>

On Thu, 19 Mar 2009, Junio C Hamano wrote:

> Scott Chacon <schacon@gmail.com> writes:
>
>> But where Git instead stores a stub object and the large binary object
>> is pulled in via a separate mechanism. I was thinking that the client
>> could set a max file size and when a binary object larger than that is
>> staged, Git instead writes a stub blob like:
>>
>> ==
>> blob [size]\0
>> [sha of large blob]
>> ==
>
> An immediate pair of questions are, if you can solve the issue by
> delegating large media to somebody else (i.e. "media server"), and that
> somebody else can solve the issues you are having, (1) what happens if you
> lower that "large" threashold to "0 byte"?  Does that somebody else still
> work fine, and does the git that uses indirection also still work fine?
> If so why are you using git instead of that somebody else altogether?

ideally the difference between useing git with 'large' set to 0 and git 
with no pack file should be an extra lookup for the indirection.

it may be that some other file manipulation may not be possible for 
'large' files, resulting in some reduced functionality.

in any case, the added efficiancy of using pack files (both for local 
storage and for network transport) will make handling the 'large' files 
worse than the same size files through git (assuming that they can benifit 
from delta compression)

> and
> (2) what prevents us from stealing the trick that somebody else uses so
> that git itself can natively handle large blobs without indirection?

the key thing is that large files do not get mmaped or considered for 
inclusion in pack files (including cloning and pulling pack files)

to make them full first-class citizens you would need to make alternate 
code paths for everything that currently does mmap, making those paths 
either process the file a different way. in the long run that may be the 
best thing to do, but that's a lot of change compared to the proposed 
change.

> Without thinking the ramifications through myself, this sounds pretty much
> like a band-aid and will nend up hitting the same "blob is larger than we
> can handle" issue when you follow the indirection eventually, but that is
> just my gut feeling.

it depends on what you are doing with that file when you get to it. if you 
have to mmap it you may run into the same problem. but if the file is a 
streaming video, you can transport it around (with rsync, http, etc) 
without a problem, and using the file (playing the video) never keeps much 
of the file in memory, so it will be very useful on systems that would 
never have a chance of accessing the entire file through mmap.

David Lang
