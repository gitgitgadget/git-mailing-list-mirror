From: david@lang.hm
Subject: Re: Performance impact of a large number of commits
Date: Fri, 24 Oct 2008 22:29:58 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810242219440.20238@asgard.lang.hm>
References: <1224874946.7566.13.camel@localhost>  <alpine.DEB.1.10.0810241240100.27333@asgard.lang.hm>  <1224878202.7566.25.camel@localhost>  <alpine.DEB.1.10.0810241301430.27333@asgard.lang.hm> <1224911915.7566.35.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Samuel Abels <newsgroups@debain.org>
X-From: git-owner@vger.kernel.org Sat Oct 25 07:30:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtbjW-00084w-IL
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 07:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbYJYF3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 01:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbYJYF3U
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 01:29:20 -0400
Received: from mail.lang.hm ([64.81.33.126]:37510 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbYJYF3U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 01:29:20 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9P5TGLr022214;
	Fri, 24 Oct 2008 22:29:16 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <1224911915.7566.35.camel@localhost>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99094>

On Sat, 25 Oct 2008, Samuel Abels wrote:

> On Fri, 2008-10-24 at 13:11 -0700, david@lang.hm wrote:
>>> git commit explicitly (i.e., walking the tree to stat files for finding
>>> changes is not necessary).
>>
>> I suspect that your limits would be filesystem/OS limits more than git
>> limits
>>
>> at 5-10 files/commit you are going to be creating .5-1m files/day, even
>> spread across 256 directories this is going to be a _lot_ of files.
>
> The files are organized in a way that places no more than ~1.000 files
> into each directory. Will Git create a directory containing a larger
> number of object files? I can see that this would be a problem in our
> use case.

when git stores the copies of the files it does a sha1 hash of the file 
contents and then stores the file in the directory
.git/objects/<first two digits of the hash>/<hash>
this means that if you have files that have the same content they all fold 
togeather, but with lots of files changing rapidly the result is a lot of 
files in these object directories.

it would be a pretty minor change to git to have it use more directories 
(in fact, there's another thread going on today where people are looking 
at making this configurable, in that case to reduce the number of 
directories)

the other storage format that git has is the pack file. it takes a bunch 
of the objects, does some comparisons between them (to find duplicate bits 
of files), and then stores the result (base files plus deltas to re-create 
other files). the resulting compression is _extremely_ efficiant, and it 
collapses many file objects into one pack file (addressing the issues of 
many files in one directory)

>> packing this may help (depending on how much the files change), but with
>> this many files the work of doing the packing would be expensive.
>
> We can probably do that even if it takes several hours.

my concern is that spending time creating the pack files will mean that 
you don't have time to insert the new files.

that being said, there may be other ways of dealing with this data rather 
than putting it into files and then adding it to the git repository.

Git has a fast-import streaming format that is designed for programs to 
use that are converting repositories from other SCM systems. if you can 
tell more about what you are doing (how the data is being gathered, are 
the files re-created for each commit, or are they being modified? if they 
are being modified is it appending data, changing some data, or randomly 
writing throughout the file? etc) there may be some other options 
available.

at this point I don't know if git can work for you or not, but I'm pretty 
sure nothing else will have a chance with your size.

David Lang
