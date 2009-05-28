From: Misha Koshelev <mk144210@bcm.edu>
Subject: Re: Recover broken git index?
Date: Thu, 28 May 2009 16:02:33 -0500
Message-ID: <4A1EFBE9.7070805@bcm.edu>
References: <4A1DB700.4080705@bcm.edu> <4A1E52FD.6090801@op5.se> <4A1E86D7.3060401@bcm.edu> <alpine.LFD.2.01.0905281053030.3435@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 28 23:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9mie-0001U9-TO
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 23:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758561AbZE1VAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 17:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756638AbZE1VAs
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 17:00:48 -0400
Received: from mog.corp.bcm.tmc.edu ([128.249.159.98]:62383 "EHLO
	mog.corp.bcm.tmc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756881AbZE1VAr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 17:00:47 -0400
Received: from [192.168.2.50] (bcm229-173.vpn.dhcp.bcm.edu [128.249.229.173])
	by mog.corp.bcm.tmc.edu (8.13.6/8.13.6) with SMTP id n4SL0BQl026478;
	Thu, 28 May 2009 16:00:12 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <alpine.LFD.2.01.0905281053030.3435@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.56 on 128.249.159.98
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120229>

Wow, I am very honored just want to say to get this email.

Actually it was technically a _clean_ restart on Ubuntu 8.04. I suspect
there may have been some kind of strange hardware error though as
computer was very sluggish and BIOS took a while to start up. I replaced
battery (is a laptop - Dell Latitude D630) and seems to be working
better - was getting power management errors before so not sure if it
was related. I had a lot of matlab instances running so there was
probably a lot of disk I/O.

I tried the commands you suggested, they did not work unfortunately.
Luckily I do have the latest versions of my files (I do backups) just
sad I lost the index and commits (and changes).

I will send you the whole tar.bz2 personally in a separate email. It is
my PhD project so from the perspective of the code I'm not that
concerned, but I believe I added a mat file to the project and the data
in it is not public.

Thank you
Misha

misha@misha-d630:/tmp/code$ rm .git/index
misha@misha-d630:/tmp/code$ git reset --hard
error: git-checkout-index: unable to read sha1 file of comparetaus.m
(5e35b75e062c7688636a19334bd85e9e8a408b76)
error: git-checkout-index: unable to read sha1 file of modetau.m
(a3c848580df86762d5c975b311254ba7b6185cb5)
HEAD is now at c14764c... More modifications to plotting.
misha@misha-d630:/tmp/code$ git add .
misha@misha-d630:/tmp/code$ git write-tree
error: invalid object 5e35b75e062c7688636a19334bd85e9e8a408b76
fatal: git-write-tree: error building trees
misha@misha-d630:/tmp/code$


Linus Torvalds wrote:
> On Thu, 28 May 2009, Misha Koshelev wrote:
>   
>> I tried you checkout master && git reset --hard and it worked.
>>     
>
> It probably "worked" for some limited meaning of "worked". 
>
> It sounds like you have major corruption in your object database, and it 
> would be interesting to know how it happened. 
>
> I would suggest:
>
>  - back up your whole source directory - both .git _and_ your checked out 
>    tree. That's partly because I'd want you to do some destructive 
>    testing, but partly because it might be interesting to see the 
>    actual breakage. 
>
>    Is this a public project where you could expose the whole thing for us 
>    to look at?
>
>  - AFTER copying the whole tree, blow away your checked-out tree entirely 
>    (or just copy your ".git" directory somewhere else), and then do
>
> 	rm .git/index
> 	git reset --hard
>
> Now, I realize you already did a "git reset --hard", but since you had a 
> working tree _and_ you had a pre-existing index, that reset will have done 
> various shortcuts, rather than actually use the git database fully.
>
> For example, if the 'stat' information in the index matches the 
> checked-out copy, then git reset --hard will happily just ignore it. Also, 
> even if the stat info doesn't match, rather than writing a new file, it 
> will look at the old file and see if the contents match the SHA1, and then 
> just update the index. 
>
> So there's just a ton of those kinds of optimizations where git tries to 
> avoid causing unnecessary IO, and with a pre-existing index file and a 
> checked-out tree, it's entirely possible that git will not have even 
> bothered to check the objects themselves.
>
> Now, it's entirely possible that you can re-create a lot of the objects by 
> re-committing the last state (if the missing objects are all "recent" 
> ones). The simplest way is likely to just do something like
>
> 	git add .
> 	git write-tree
>
> in a version of the tree that has all files checked out. If the objects 
> are literally just missing (rather than corrupted), then this will 
> re-populate the git object database with the all the objects in the 
> current tree (but not in any previous trees!).
>
> Again, if you can make the whole tree available and there is no secret 
> data there, I'd be interested in taking a look. No guarantees that I can 
> fix anything, but the corruption patterns are always interesting, and so 
> I'd like to see what I can do, if anything.
>
>   
>> I guess the problem is when I try to make a commit:
>>  git commit -a -n
>> error: invalid object 5e35b75e062c7688636a19334bd85e9e8a408b76
>> fatal: Error building trees
>>     
>
> This very much implies that there are missing or corrupt objects in your 
> database. The fact that you had tons of fsck errors supports that too. 
> It's probably a pack-file that is corrupt.
>
>   
>> I first noticed this after my computer was acting sluggish (I was
>> running processor intensive tasks) and I restarted it.
>>     
>
> Restarted without a clean shutdown? What OS, and what kind of filesystem? 
> It very much sounds like some files in .git/objects were not fully written 
> to disk.
>
>
>
> 			Linus
>   


-- 
Misha Koshelev
MD/PhD Student

Human Neuroimaging Laboratory
One Baylor Plaza
S104
Baylor College of Medicine
Houston, TX 77030
