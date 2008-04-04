From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Achieving efficient storage of weirdly structured repos
Date: Fri, 04 Apr 2008 16:30:58 -0700
Message-ID: <1207351858.13123.52.camel@work.sfbay.sun.com>
References: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com>
 <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 01:24:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhvHD-0001zq-9q
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 01:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbYDDXYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 19:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbYDDXYL
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 19:24:11 -0400
Received: from sca-es-mail-1.Sun.COM ([192.18.43.132]:48046 "EHLO
	sca-es-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbYDDXYK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 19:24:10 -0400
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m34NO8Ge017658
	for <git@vger.kernel.org>; Fri, 4 Apr 2008 16:24:08 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JYT00A01Q8QIZ00@fe-sfbay-10.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Fri, 04 Apr 2008 16:24:08 -0700 (PDT)
Received: from [129.146.84.200] by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0JYT00BDAQC5Q3G0@fe-sfbay-10.sun.com>; Fri,
 04 Apr 2008 16:24:05 -0700 (PDT)
In-reply-to: <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org>
X-Mailer: Evolution 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78822>

Hi Linus!

On Thu, 2008-04-03 at 14:11 -0700, Linus Torvalds wrote:
> 
> On Thu, 3 Apr 2008, Roman Shaposhnik wrote:
> > 
> > The repository was created using hg2git (the one based on git-fast-import)
> > and it was GC'ed and REPACK'ed just in case.
> 
> Before going any further - exactly _how_ was it repacked?

I believe it was the following two steps:
   $ git gc --aggressive
   $ git repack

> In particular, when using importers that do partial packing on their own 
> (and any "git-fastimport" user is that by definition - and I think 
> hg2git does that), at the end of it all you have to make sure to repack in 
> a way where the repacking will totally discard the import-time packfiles.

Good point. Speaking of which: do you have an FAQ for importers? The
entries in the official FAQ (http://git.or.cz/gitwiki/GitFaq#head-929a8825d04dde226c2530f5337d3b3ed8dcc7ce)
seem a bit stale for such an important issue. After all, importing from
an existing SCM is what usually forms a first time impression of Git's
effectiveness.

> IOW, that's one of the very few times you should use "-f" to git repack.

Got it!

> It's usually also a good place to make sure that since you ignore the old 
> packing information, it's best to also make sure that the new packing info 
> is good by using a bigger window (and perhaps a bigger depth). That makes 
> the packing much slower, of course, but this is meant to be a one-time 
> event.
> 
> So try something like
> 
> 	git repack -a -d -f --depth=100 --window=100
> 
> if you have a good CPU and plenty of memory.

That turned out to be a perfect suggestion. Thank you. I'm now the
happiest camper ever. And I'm also also pretty dumbfounded ;-)

Here's what happened. 

I started with a a repository filled with "loose" (one object per file)
objects (the reason I needed it was for the ease of sleuthing through
individual objects and it was created by git-unpack-objects from that
initial 1.1Gb pack). And I tried to pack it exactly like you
suggested:
   $ git-pack-objects --depth=100 --window=100 --delta-base-offset --progress pack < objects
   Generating pack...
   Counting objects: 1096305
   Done counting 1159628 objects.
   Deltifying 1159628 objects...
      100% (1159628/1159628) done
   Writing 1159628 objects...
   dd134c407324dc55b0cd2aa3a9e1b3420c2bba3f

   Total 1159628 (delta 386980), reused 0 (delta 0)

and it payed off reasonably well:
    $ du -s NB-clone
    670M NB-clone

It still was bigger than the Mercurial repository but at least it got
2 times smaller than the original result of hg2git. Now, if it wasn't
for a friend of mine, I probably would've stopped there. But he
showed up and saved the day ;-) His comments made me try something
that I didn't consider to be of any use -- repacking a freshly packed
pack with the *same* --depth=100 --window=100:
    $ git repack -a  -f --window=100 --depth=100 
    Generating pack...
    Counting objects: 1056829
    Done counting 1159628 objects.
    Deltifying 1159628 objects...
       100% (1159628/1159628) done
    Writing 1159628 objects...
       100% (1159628/1159628) done
    Total 1159628 (delta 614516), reused 0 (delta 0)
    Pack pack-dd134c407324dc55b0cd2aa3a9e1b3420c2bba3f created.
And then, a miracle occurred:
     $ du -sh NB-small 
     268M NB-small

Now, don't get me wrong: I'm as happy as a clam. The repository is now
*smaller* than the Mercurial's and because the structure of the
tree is so weird Git gets major points here. The only question that
is still bothering me is: how did it happen? Why did repacking 
a repository with exactly the same set of objects and the only
difference being where these objects resided (former case filesystem,
the later case an intermediate pack) made so huge a difference?

Please help!

> > The last item (trees) also seem to take the most space and the most 
> > reasonable explanation that I can offer is that NetBeans repository has 
> > a really weird structure where they have approximately 700 (yes, seven 
> > hundred!) top-level subdirectories there. They are clearly 
> > Submodules-shy, but that's another issue that I will need to address 
> > with them.
> 
> Trees taking the biggest amount of space is not unheard of, and it may 
> also be that the name heuristics (for finding good packing partners) could 
> be failign, which would result in a much bigger pack than necessary. 

Is there any documentation that describes the heuristics involved in
creating a pack?

> So if you already did an aggressive repack like the above, I'd happily 
> take a look at whether maybe it's bad heuristics for finding tree objects 
> to pair up for delta-compression. Do you have a place where you can put 
> that repo for people to clone and look at?

Unfortunately I don't. The only thing I can do is I can always create
a *.tar.bz2 and put and on  Sun's ftp server. Actually, that makes me
wonder: is there any public Git hosting available such that publishing
a hefty repository for the forensic purposes only wouldn't violate their
terms of use?

Thanks,
Roman.

P.S. Oh, and here's one extra tiny question that I also have: what
does the output:
   Total 1159628 (delta 614516), reused 0 (delta 0)
really mean?
