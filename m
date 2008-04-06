From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Achieving efficient storage of weirdly structured repos
Date: Sat, 5 Apr 2008 17:48:43 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804051729230.11277@woody.linux-foundation.org>
References: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com> <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org> <1207351858.13123.52.camel@work.sfbay.sun.com> <alpine.LFD.1.00.0804041634180.14670@woody.linux-foundation.org>
 <4A31E284-E7F1-4748-A2CB-D8682748D3D6@sun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Roman Shaposhnik <rvs@sun.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 02:49:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiJ4q-0007FP-CN
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 02:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbYDFAst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 20:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbYDFAst
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 20:48:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50268 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751015AbYDFAss (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Apr 2008 20:48:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m360miqK007022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 5 Apr 2008 17:48:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m360mhWf031313;
	Sat, 5 Apr 2008 17:48:43 -0700
In-Reply-To: <4A31E284-E7F1-4748-A2CB-D8682748D3D6@sun.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.376 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78872>



On Sat, 5 Apr 2008, Roman Shaposhnik wrote:
> 
> It was pretty much the result of (cd .git/objects ; find . -type f | tr -d
> './')

Ok, that explains it. And yes, it definitely works, but I think you now 
understand why it gave you that oddly pessimised pack-file.

That said, I think it's also a really good example of how the git 
pack-files really are just a "bag of objects", and the fact that it worked 
but was non-optimal is a very good way to show something very fundamental 
about git.

> So it seems that my list of objects was different from what
> git-rev-list/setup_revisions()
> would have provided in two ways:
>    1. the order of objects was arbitrary
>    2. the naming of blobs and trees was missing
> #2 was, indeed, a huge oversight on my part. At the same time, I've always
> thought
> that #1 shouldn't matter, because, as you pointed out, the objects get
> sorted by <type, namehash, length> anyway. However, it seems that because
> of the lack of naming there was much less sorting done by type_size_sort()
> and the original order persevered (at least within type-size partitions).
> It did matter after all!

Well, a pack actually as two *different* orderings, in that there's one 
ordering that is used for laying out the result in the pack-file, and 
another ordering that is used for actually finding the deltas with the 
sliding window.

And the input order is actually used for the layout ordering.

And both matter. The  <type, namehash, length> is the one that determines 
how large the resulting pack is, but the layout order is what causes the 
IO patterns for most common uses, so if the pack-file is cold in the 
cache, it can matter quite a bit for performance.

So the layout order is the one you give as input to "git pack-objects". 
And if that input has no particular ordering, then the final layout will 
also have no particular ordering and you get random IO patterns when 
loading from disk.

> Now, in my particular case, the ordering was braindead and it resulted in
> a highly visible inefficiency. On the other hand, it seems that creative
> ordering could very well be used to exploit localities which go beyond
> how default name hashing in builtin-pack-objects.c works.

Yes. We've changed some of the heuristics subtly over time (eg the whole 
name-hashing was a tweak that was added later), but you're absolutely 
right - it's an area where some *particular* usage model could come up 
with a special ordering to optimize a some special load. The defaults are 
meant to be "good enough", and there has been some thought put into them, 
but yes, there's probably room for specialization there.

In particular, one thing I've wanted to do is to do some "fingerprint 
hash" and perhaps use that as a sorting guide for finding deltas even more 
aggressively than we do now, but I've never really found the energy to try 
something like that out.

> In fact, it starts to look awfully like custom MPEG profiles where if you know
> your footage you can achieve a much higher compression ratio
> compared to what the default might give you. It also makes it very
> clear that Git's approach of doing away with per-file content tracking
> is quite superior to the in-file deltas. Cool!

Well, one thing that git doesn't do, but that I find intriguing is if it 
could be possible to do deltas not even between different files, but even 
*across* files. 

One thing that the git model sucks at is how it's not very good at 
handling large objects. I've often wondered if I should have made "object" 
be more fine-grained and tried to build up large files from multiple 
smaller objects.

[ That said, I think git does the right thing - for source code. The 
  blocking-up of files would cause a rather more complex model, and one of 
  the great things about git is how simple the basic model is. But the
  large-file thing does mean that git potentially sucks really badly for 
  some other loads ]

> Here's my final question on that issue: wouldn't it be great to give users
> a direct control over specifying the list of objects in exactly the order
> they would like them to be tried for deltifying? Something like
> --preserve-order option available for git-pack-objects?

See above: there's actually two orders, so you'd need to specify *both* 
orders some way, since the input order already has meaning (it's assumed 
to be the "topological ordering".

You *can* approximate what you descibe by playing games with the filenames 
(which you can give in the input too - they're just strings on the same 
line as the SHA1), and that would be a total hack to give that secondary 
ordering. And yes, I agree that it might be cool to do this explicitly 
some way. If only to give a way to test experimental versions of the type 
sorting.

[ To see how the filename thing works, do

	git rev-list --objects --all > object-list
	git pack-objects ... < object-list

  and you can look at the "object-list" file to see how it's not just the 
  list of SHA1, it now has the filename info in it too. Imagine changing 
  that filename to generate a "custom" pack order ]

				Linus
