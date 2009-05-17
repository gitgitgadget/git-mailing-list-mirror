From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On data structures and parallelism
Date: Sun, 17 May 2009 10:06:26 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905170950230.3301@localhost.localdomain>
References: <20090517152335.GC11543@zakalwe.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Heikki Orsila <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Sun May 17 19:06:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5joq-000359-Tq
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 19:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbZEQRG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 13:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbZEQRG1
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 13:06:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60832 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753116AbZEQRG0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 May 2009 13:06:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4HH6QcA013146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 17 May 2009 10:06:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4HH6QvK025147;
	Sun, 17 May 2009 10:06:26 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090517152335.GC11543@zakalwe.fi>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.464 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119402>



On Sun, 17 May 2009, Heikki Orsila wrote:
>
> There was an interesting discussion at
> 
> http://realworldtech.com/forums/index.cfm?action=detail&id=98909&threadid=98430&roomid=2
> 
> that involves DAGs and decompression in Git. The problem is achieving 
> parallelism. The following comment was made:
> 
> "And is it possible to store the block pointers from one object to 
> another in uncompressed form?"

For the biggest form of this, we actually already do.

The single biggest win of compression is the delta-compression: the 
regular zlib compression is generally about a factor-of-two for unpacked 
and "base" delta entries, but much less for already delta-compressed 
entries. In comparison, the delta-compression is likely about a factor of 
10 or more.

And the delta compression already has the SHA1 pointer to the delta base 
entry uncompressed, but the compression is serialized by the fact that we 
need to uncompress the base entry in order to then apply a delta on top of 
it.

Now, there's no question that we could have higher levels of parallelism 
by walking multiple such chains in parallel (we don't always have more 
than one chain to walk, but sometimes we do). But as I point out in that 
thread, we currently don't have any locking for the core object 
datastructures, and adding that locking would likely slow down things more 
than it speeds things up for the normal case.

For 'git fsck', we could speed things up a lot by doing parallel work - 
and we wouldn't need to have anything else uncompressed, we could just 
take advantage of the fact that we could try to uncompress the different 
delta chains in parallel. And yes, fsck is really slow, but on the other 
hand, it's something that most people never do, and I do about once a 
month. The fact that it takes four minutes rather than one is not a big 
deal.

There are other forms of compression where the SHA1 pointers are inside 
the compressed data (the "regular" commit->{commit,tree} relationships and 
tree->{anything} cases).

And yes, we could probably get rid of at least the zlib compression in 
some of that. Much of that data doesn't even compress very well (SHA1's 
are basically uncompressible), and the compression is done largely because 
we have one unified interface for everything (so the basic object code 
doesn't need to care about different object types or different formats: 
it's all just binary data with a magic header to it).

But in that case, we'd probably not want to keep a separate uncompressed 
tree, we'd just decide that "compression is too expensive to be worth it".

That said, on my laptops, CPU time really _never_ is the issue. Every 
single time something is slow, the issue is a slow 4200rpm disk that may 
get 25MB/s off it for linear things in the best case, but seeks take 
milliseconds and any kind of random access will just kill performance.

So in the big picture, I suspect even the wasted CPU-time is worth it. It 
makes some operations slower, but anything that makes the on-disk data 
denser is good. Because the case I end up caring most about is always the 
uncached case.

			Linus
