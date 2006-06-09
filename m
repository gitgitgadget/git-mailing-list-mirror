From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 08:01:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606090745390.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <9e4733910606082028k37f6d915m26009e0d5011808b@mail.gmail.com>
 <e6b798$td3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 17:02:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoiUu-0003EU-Ui
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 17:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWFIPCA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 11:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWFIPCA
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 11:02:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19382 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030200AbWFIPB7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 11:01:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k59F1vgt011724
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 08:01:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k59F1ut3017303;
	Fri, 9 Jun 2006 08:01:56 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e6b798$td3$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21530>



On Fri, 9 Jun 2006, Jakub Narebski wrote:
> Jon Smirl wrote:
> 
> >> git-repack -a -d but it OOMs on my 2GB+2GBswap machine :(
> > 
> > We are all having problems getting this to run on 32 bit machines with
> > the 3-4GB process size limitations.
> 
> Is that expected (for 10GB repository if I remember correctly), or is there
> some way to avoid this OOM?

Well, to some degree, the VM limitations are inevitable with huge packs.

The original idea for packs was to avoid making one huge pack, partly 
because it was expected to be really really slow to generate (so 
incremental repacking was a much better strategy), but partly simply 
because trying to map one huge pack is really hard to do.

For various reasons, we ended up mostly using a single pack most of the 
time: it's the most efficient model when the project is reasonably sized, 
and it turns out that with the delta re-use, repacking even moderately 
large projects like the kernel doesn't actually take all that long.

But the fact that we ended up mostly using a single pack for the kernel, 
for example, doesn't mean that the fundamental reasons that git supports 
multiple packs would somehow have gone away. At some point, the project 
gets large enough that one single pack simply isn't reasonable.

So a single 2GB pack is already very much pushing it. It's really really 
hard to map in a 2GB file on a 32-bit platform: your VM is usually 
fragmented enough that it simply isn't practical. In fact, I think the 
limit for _practical_ usage of single packs is probably somewhere in the 
half-gig region, unless you just have 64-bit machines.

And yes, I realize that the "single pack" thing actually ends up having 
become a fact for cloning, for example. Originally, cloning would unpack 
on the receiving end, and leave the repacking to happen there, but that 
obviously sucked. So now when we clone, we always get a single pack. That 
can absolutely be a problem.

I don't know what the right solution is. Single packs _are_ very useful, 
especially after a clone. So it's possible that we should just make the 
pack-reading code be able to map partial packs. But the point is that 
there are certainly ways we can fix this - it's not _really_ fundamental.

It's going to complicate it a bit (damn, how I hate 32-bit VM 
limitations), but the good news is that the whole git model of "everything 
is an individual object" means that it's a very _local_ decision: it will 
probably be painful to re-do some of the pack reading code and have a LRU 
of pack _fragments_ instead of a LRU of packs, but it's only going to 
affect a small part of git, and everything else will never even see it.

So large packs are not really a fundamental problem, but right now we have 
some practical issues with them.

(It's not _just_ packs: running out of memory is also because of 
git-rev-list --objects being pretty memory hungry. I've improved the 
memory usage several times by over 50%, but people keep trying larger 
projects. It used to be that I considered the kernel a large history, now 
we're talking about things that have ten times the number of objects).

Martin - do you have some place to make that big mozilla repo available? 
It would be a good test-case.. 

			Linus
