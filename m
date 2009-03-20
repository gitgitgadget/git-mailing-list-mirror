From: david@lang.hm
Subject: Re: Git Large Object Support Proposal
Date: Thu, 19 Mar 2009 17:23:49 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903191718140.16753@asgard.lang.hm>
References: <d411cc4a0903191514n1e524ebava5895d708a2927c4@mail.gmail.com> <7veiwt6t6a.fsf@gitster.siamese.dyndns.org> <d411cc4a0903191618x503db946n62d3132eece69175@mail.gmail.com> <7vzlfh5b7y.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0903191650160.16753@asgard.lang.hm>
 <7vtz5p59zp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 01:26:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkSYq-0006Jw-Jh
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 01:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758647AbZCTAYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 20:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755342AbZCTAYG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 20:24:06 -0400
Received: from mail.lang.hm ([64.81.33.126]:43793 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757682AbZCTAYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 20:24:05 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2K0Nnkj015817;
	Thu, 19 Mar 2009 16:23:53 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7vtz5p59zp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113873>

On Thu, 19 Mar 2009, Junio C Hamano wrote:

> david@lang.hm writes:
>
>> On Thu, 19 Mar 2009, Junio C Hamano wrote:
>>
>>> Scott Chacon <schacon@gmail.com> writes:
>>>
>>>> The point is that we don't keep this data as 'blob's - we don't try to
>>>> compress them or add the header to them, they're too big and already
>>>> compressed, it's a waste of time and often outside the memory
>>>> tolerance of many systems. We keep only the stub in our db and stream
>>>> the large media content directly to and from disk.  If we do a
>>>> 'checkout' or something that would switch it out, we could store the
>>>> data in '.git/media' or the equivalent until it's uploaded elsewhere.
>>>
>>> Aha, that sounds like you can just maintain a set of out-of-tree symbolic
>>> links that you keep track of, and let other people (e.g. rsync) deal with
>>> the complexity of managing that side of the world.
>>>
>>> And I think you can start experimenting it without any change to the core
>>> datastructures.  In your single-page web site in which its sole html file
>>> embeds an mpeg movie, you keep track of these two things in git:
>>>
>>> 	porn-of-the-day.html
>>>        porn-of-the-day.mpg -> ../media/6066f5ae75ec.mpg
>>>
>>> and any time you want to feed a new movie, you update the symlink to a
>>> different one that lives outside the source-controlled tree, while
>>> arranging the link target to be updated out-of-band.
>>
>> that would work, but the proposed change has some advantages
>>
>> 1. you store the sha1 of the real mpg in the 'large file' blob so you
>> can detect problems
>
> You store the unique identifier of the real mpg in the symbolic link
> target which is a blob payload, so you can detect problems already.  I
> deliberately said "unique identifier"; you seem to think saying SHA-1
> brings something magical but I do not think it needs to be even blob's
> SHA-1.  Hashing that much data costs.

but hashing the data and using that as the unique identifier gives you 
some advantages.

1. you can detect file corruption

2. you can trivially detect duplicates (even if the duplicates come from 
different sources)

3. it's repeatable (you will always get the same hash from the same input)

> In any case, you can have a script (or client-side hook) that does:
>
>    (1) find the out-of-tree symlinks in the index (or in the work tree);
>
>    (2) if it is dangling, and if you have definition of where to get that
>        hierarchy from (e.g ../media), run rsync or wget or whatever
>        external means to grab it.
>
> and call it after "git pull" updates from some other place.  The "git
> media" of Scott's message could be an alias to such a command.
>
> Adding a new type "external-blob" would be an unwelcome pain.  Reusing
> "blob" so that existing "blob" codepath now needs to notice special "0"
> that is not length "0" is even bigger pain than that.
>
> And that is a pain for unknown benefit, especially when you can start
> experimenting without any changes to the existing data structure.  In the
> worst case, the experiment may not pan out as well as you hoped and if
> that is the end of the story, so be it.  It is not a great loss.  If it
> works well enough and we can have the external large media support without
> any changes to the data structure, that would be really great.  If it
> sort-of works but hits limitation, we can analyze how best to overcome
> that limitation, and at that time it _might_ turn out to be the best
> approach to introduce a new blob type.
>
> But I do not think we know that yet.
>
> In the longer run, as you speculated in your message, I think the native
> blob codepaths need to be updated to tolerate a large, unmappable objects
> better.  With that goal in mind, I think it is a huge mistake to
> prematurely introduce an arbitrary distinct "blob" and "large blob" types,
> if in the end they need to be merged back again; it would force the future
> code indefinitely to care about the historical "large blob" types that was
> once supported.

valid point.

keep in mind that what's a "large, unmappable object" on one system may be 
no problem on another.

>> 2. since it knows the sha1 of the real file, it can auto-create the
>> real file as needed, without wasting space on too many copies of it.
>
> Hmm, since when SHA-1 is reversible?

when it is processing a new, unknown file it can hash it, and look to see 
if a file with that hash exists. if so the work is done, if not it can 
create a file with that hash.

by far the best long-term option would be to make all the codepaths handle 
unmappable files, the question is how large a task that would be.

David Lang
