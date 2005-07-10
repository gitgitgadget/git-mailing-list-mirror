From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [RFC] Design for http-pull on repo with packs
Date: Sun, 10 Jul 2005 23:39:11 +0200
Message-ID: <42D1957F.1050609@gmail.com>
References: <Pine.LNX.4.21.0507101557510.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 23:45:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrjbW-0000v2-Bc
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 23:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVGJVmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 17:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVGJVjc
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 17:39:32 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:9912 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261792AbVGJVjS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 17:39:18 -0400
Received: by wproxy.gmail.com with SMTP id 67so790047wri
        for <git@vger.kernel.org>; Sun, 10 Jul 2005 14:39:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nfhUKktFtSbIFIjomDl/n99aP6KhTAhLDmkHs2KtolXcK/FH5YFIkWGdYSOKEkAtN7kSmS8gfl2H87piQNhYbaoeV2v9fpfDY95j5DYZix5pFT/13TyFC7RyKO9aOSgaXhR8cnAFOufHh42SQMxgssUI31xQNHgMO9wHoh07DBs=
Received: by 10.54.44.7 with SMTP id r7mr3297158wrr;
        Sun, 10 Jul 2005 14:39:14 -0700 (PDT)
Received: from ?192.168.0.5? ([80.217.52.214])
        by mx.gmail.com with ESMTP id 43sm5064777wri.2005.07.10.14.39.13;
        Sun, 10 Jul 2005 14:39:14 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0507101557510.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow wrote:
> On Sun, 10 Jul 2005, Dan Holmsand wrote:
>>Daniel Barkalow wrote:
>>> If an individual file is not available, figure out what packs are
>>>  available:
>>>
>>>   Get the list of pack files the repository has
>>>    (currently, I just use "e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135")
>>>   For any packs we don't have, get the index files.
>>
>>This part might be slightly expensive, for large repositories. If one 
>>assumes that packs are named as by git-repack-script, however, one might 
>>cache indexes we've already seen (again, see below). Or, if you go for 
>>the mandatory "pack-index-file", require that it has a reliable order, 
>>so that you can get the last added index first.
> 
> 
> Nothing bad happens if you have index files for pack files you don't have,
> as it turns out; the library ignores them. So we can keep the index files
> around so we can quickly check if they have the objects we want. That way,
> we don't have to worry about skipping something now (because it's not
> needed) and then ignoring it when the branch gets merged in.
> 
> So what I actually do is make a list of the pack files that aren't already
> downloaded that are available from the server, and download the index
> files for any where the index file isn't downloaded, either.

Aah. In other words, you do the caching thing as well. It seems a little 
ugly, though, to store the index-only index files with the rest of the 
pack. It might be preferable to introduce something like 
$GIT_DIR/index-cache or something, so than it can be easily cleaned (and 
don't follow us around forever when 
cloning-by-hardlinking-the-entire-object-directory).

You might end up with quite a large number of index files, after a while 
though, if you pull from several repositories that are regularly repacked.

>>>   Keep a list of the struct packed_gits for the packs the server has
>>>    (these are not used as places to look for objects)
>>>
>>> Each time we need an object, check the list for it. If it is in there,
>>>  download the corresponding pack and report success.
>>
>>Here you will need some strategy to deal with packs that overlap with 
>>what we've already got. Basically, small and overlapping packs should be 
>>unpacked, big and non-overlapping ones saved as is (since 
>>git-unpack-objects is painfully slow and memory-hungry...).
> 
> 
> I don't think there's an issue to having overlapping packs, either with
> each other or with separate objects. If the user wants, stuff can be
> repacked outside of the pull operation (note, though, that the index files
> should be truncated rather than removed, so that the program doesn't fetch
> them again next time some object can't be found easily).

Well, the only issue is obviously waste of space. If you fetch a lot of 
branches from independently packed repos, it might mean a lot of waste, 
though.

About truncating index files: this seems a bit ugly. You get a file that 
doesn't contain what it says it contains, which may cause trouble if for 
example the git prune thing is used.

You might be better off with a simple list of index files we know we 
have all the objects of (and make sure that git-prune-script deletes 
this file, since it possibly breaks the contract).

>>One could also optimize the pack-download bit, by figuring out the last 
>>object in the pack that we need (easy enough to do from the index file), 
>>  and just get the part of the pack file leading up to that object. That 
>>could be a huge win for independently packed repositories (I don't do 
>>that in my code below, though).
> 
> 
> That's only possible if you can figure out what you want to have before
> you get it. My code is walking the reachability graph on the client; it
> can only figure out what other objects it needs after it's mapped the pack
> file.

No, but we can find out which objects we *don't* want (i.e. the ones we 
have). And that may be a lot, e.g. if a repository is fully repacked, or 
if we track branches on several similar but independently packed 
repositories. And as far as I understand git-pack-objects, it tries to 
put recent objects in the front.

I don't have any numbers to back this up with, though. Some testing may 
be needed, but since the population of packed public repositories is 1, 
this is tricky...

> I might use that method for listing the available packs, although I'd sort
> of like to encourage a clean solution first.

Encouraging cleanliness is obviously a good thing :-)

/dan
