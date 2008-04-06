From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Achieving efficient storage of weirdly structured repos
Date: Sat, 05 Apr 2008 17:13:30 -0700
Message-ID: <4A31E284-E7F1-4748-A2CB-D8682748D3D6@sun.com>
References: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com>
 <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org>
 <1207351858.13123.52.camel@work.sfbay.sun.com>
 <alpine.LFD.1.00.0804041634180.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 06 02:14:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiIWn-0001XA-4I
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 02:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbYDFANh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 20:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbYDFANh
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 20:13:37 -0400
Received: from brmea-mail-1.Sun.COM ([192.18.98.31]:45875 "EHLO
	brmea-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbYDFANg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 20:13:36 -0400
Received: from fe-amer-09.sun.com ([192.18.109.79])
	by brmea-mail-1.sun.com (8.13.6+Sun/8.12.9) with ESMTP id m360DZGd023257
	for <git@vger.kernel.org>; Sun, 6 Apr 2008 00:13:35 GMT
Received: from conversion-daemon.mail-amer.sun.com by mail-amer.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JYV00A01MZU8K00@mail-amer.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Sat, 05 Apr 2008 18:13:35 -0600 (MDT)
Received: from [192.168.0.100] ([129.150.64.148])
 by mail-amer.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0JYV004OTNALEYC0@mail-amer.sun.com>; Sat,
 05 Apr 2008 18:13:35 -0600 (MDT)
In-reply-to: <alpine.LFD.1.00.0804041634180.14670@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78871>

Hi Linus,

On Apr 4, 2008, at 4:57 PM, Linus Torvalds wrote:
> On Fri, 4 Apr 2008, Roman Shaposhnik wrote:
>>
>> That turned out to be a perfect suggestion. Thank you. I'm now the
>> happiest camper ever. And I'm also also pretty dumbfounded ;-)
>
> Ok, the dumbfounded we can help with.

Great!

>> Here's what happened.
>>
>> I started with a a repository filled with "loose" (one object per  
>> file)
>> objects (the reason I needed it was for the ease of sleuthing through
>> individual objects and it was created by git-unpack-objects from that
>> initial 1.1Gb pack). And I tried to pack it exactly like you
>> suggested:
>>    $ git-pack-objects --depth=100 --window=100 --delta-base-offset  
>> --progress pack < objects
>
> Well, that's not exactly like I suggested, that's a *really* old- 
> fashioned
> way.

It sure is old-fashioned. My only excuse is that since git repack is  
a shell
script around git-pack-objects I've always felt comfortable just using
the lower level utility.

> But the part you left off was what the "objects" file contained?

It was pretty much the result of (cd .git/objects ; find . -type f |  
tr -d './')
Omitting that was quite silly on my part, but I was really convinced
that because of the internal sorting the original ordering of objects
wouldn't matter at all.

> In particular, "git pack-objects" can take just a raw list of  
> objects, and
> it will *work*, but without the naming information and without the
> ordering information on the objects, the end result will generally  
> suck.
>
> So how did you generate the "objects" file? You can do it by just  
> listing
> every single loose object you have, and it will work, but the end  
> result
> won't be very pretty.

So it seems that my list of objects was different from what git-rev- 
list/setup_revisions()
would have provided in two ways:
     1. the order of objects was arbitrary
     2. the naming of blobs and trees was missing
#2 was, indeed, a huge oversight on my part. At the same time, I've  
always thought
that #1 shouldn't matter, because, as you pointed out, the objects get
sorted by <type, namehash, length> anyway. However, it seems that  
because
of the lack of naming there was much less sorting done by  
type_size_sort()
and the original order persevered (at least within type-size  
partitions).
It did matter after all!

Now, in my particular case, the ordering was braindead and it  
resulted in
a highly visible inefficiency. On the other hand, it seems that creative
ordering could very well be used to exploit localities which go beyond
how default name hashing in builtin-pack-objects.c works.

In fact, it starts to look awfully like custom MPEG profiles where if  
you know
your footage you can achieve a much higher compression ratio
compared to what the default might give you. It also makes it very
clear that Git's approach of doing away with per-file content tracking
is quite superior to the in-file deltas. Cool!

Here's my final question on that issue: wouldn't it be great to give  
users
a direct control over specifying the list of objects in exactly the  
order
they would like them to be tried for deltifying? Something like -- 
preserve-order
option available for git-pack-objects?

>>     Total 1159628 (delta 614516), reused 0 (delta 0)
>
> Ie you got a much better 60% delta ratio, and obviously a much smaller
> pack. But it's not just smaller, because the resulting pack will  
> also have
> the objects in topological order, so that objects that are "new"
> (ie more closely reachable from the top-of-tree) will be at the  
> front of
> the pack, so you'll also generally have better IO patterns in the  
> packfile
> itself.

Got it! This makes total sense.

>> Is there any documentation that describes the heuristics involved in
>> creating a pack?
>
> It's been explained a few times on the mailing list, but I don't  
> know if
> there is some write-up.
>
> The git pack format is a bit more relaxed than any other SCM format  
> I know
> about, since it literally is just a "bunch of objects with deltas  
> randomly
> between them". So a pack can look just about any way it wants -  
> there are
> no real ordering requirements (--delta-base-offset does require  
> that the
> delta follows the base, but even that is really just a trivial  
> practical
> "because otherwise you could never know what the offset in the pack- 
> file
> was" issue rather than anything else).
>
> So you can order the objects and make deltas just about any way you  
> want.
> What "git repack" will do is to sort objects by <type, namehash,  
> length>,
> and then walk the list with the window of the specified size to see  
> the
> best pairing it can do.
>
> The "namehash" is just designed so that files that have the same  
> name sort
> together (and it's also not a real "hash" - it's really a meaningless
> number, but one that is designed so that even if the names aren't  
> exactly
> the same, they sort closer together if they end in similar character
> sequences - so a file that moves from one directory to another but  
> keeps
> the same basename will sort source and destination together).
>
> See "type_size_sort()" in builtin-pack-objects.c to see what's up.
>
> (The preferred_base thing is just to keep objects we actually want to
> *keep* in the pack separated from the objects we may be using for
> references - but that is only used for transferring objects over  
> the wire,
> never for standalone packs).
>
> Oh. And now I notice that there is *some* documentation on this in
>
> 	Documentation/technical/pack-heuristics.txt
>
> but that's pretty old (not that I think it has really changed) and not
> very deep. Just taken from some #irc discussion.
>
>> P.S. Oh, and here's one extra tiny question that I also have: what
>> does the output:
>>    Total 1159628 (delta 614516), reused 0 (delta 0)
>> really mean?
>
> It just means that there were a million objects total, the pack was
> created with 614k of them as deltas against other objects, and none of
> them were re-used from previous packs.
>
> You'll see that when you do incremental repacks, 99% of all the  
> objects
> and deltas get re-used from the old pack, which is how we can make
> repacking fairly efficient. That's imporant because the native git
> protocol format itself is just a pack-file (plus the handshake to  
> figure
> out what both sides have, of course). So a "git clone" implies a  
> repack.

Very nice summary! Many, many thanks for providing it!

Thanks,
Roman.
