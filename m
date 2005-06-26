From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Sun, 26 Jun 2005 14:40:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506261359370.19755@ppc970.osdl.org>
References: <20050624.212009.92584730.davem@davemloft.net>
 <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
 <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org> <200506261652.59373.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Jun 26 23:34:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmele-00034V-CE
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 23:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVFZVjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 17:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVFZVjQ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 17:39:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261424AbVFZVjG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 17:39:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5QLcsjA019957
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Jun 2005 14:38:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5QLcrqp021583;
	Sun, 26 Jun 2005 14:38:53 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200506261652.59373.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 26 Jun 2005, Chris Mason wrote:
> 
> Without having read the code, the big thing that hurt performance in my early 
> packed file work was compressing the whole packed file instead of individual 
> sub-objects.  It takes more room to compress each object, but when I 
> compressed the whole thing read performance was quite bad.

Since I wanted random-access, compressing the whole thing just wasn't an 
option.

Besides, the big space savings come from finding deltas, which is 
obviously also a compression, just at a higher level. The biggest problem 
there is to find a guess of objects to try to delta against, and right now 
that part is pretty stupid and could possibly be improved (it just sorts 
objects by size and tries to delta against "close" objects).

To generate a better sort _would_ actually be pretty close to doing a 
global compression (it really does boil down to the same thing: finding 
big sub-sequences, except it's in a "fragmented" space), but one issue is 
that I don't want to read in the whole data set in one go, so it would 
have to be based on some rolling hash or something. Davide pointed to 
rzip, and a variation of that (which knows about object boundaries) might 
work.

(You can also sort by filename, if you want to try. I don't track
filenames at all there and it's actually non-trivial to do, so that would
require some new and pretty nasty code, but it's possible in _theory_ at
least.)

Anyway, that's all potential improvement for generating better packing,
and it should certainly be possible without changing the format - just
generate a better initial sort, in otder to find more deltas (or rather,
find them faster by using a smaller window size).

So the stupid sort I have now does actually work, but exactly because it's
so stupid it wants a big window for best packing (because there might be a
lot of objects that aren't interesting), which in turn is quite expensive.
So a better sort would make a smaller window more effective.

[ Some numbers: a window of 10 objects is the default, and packs the
  current kernel down to 77MB in 2m21s. A window of 20 objects improves
  that packing to 71MB, but makes the packing time go up to 3m36s for me.  
  And a window of 100 gets us down to 62M but takes 11m54s.

  A window of 200 (with a delta depth of 200 too - likely _way_ too deep
  for normal use) gives you a 59M pack, but takes 20m59s, so there's
  definitely a point of diminishing returns.

  This is all for the current HEAD, which takes up 264M the "traditional" 
  git way and takes 141M without any deltas, just packed tightly with no 
  filesystem blocking.

  Now, as you can notice that's actually a slightly sub-linear increase in
  time, because as we find a delta, we will only accept smaller deltas in
  the future, so we can often stop comparing even before we've reached the
  maximum window size, and so effort is slightly less than linear because 
  there's effectively a constant component to part of it.

  Also, the good news is that you probably don't want to generate one 
  humungous pack archive anyway, but you're likely better off doing a new 
  incremental pack every few months. So we'll never have the situation 
  that creating a pack gets increasingly more costly, since at some point 
  you just say "ok, I created a perfect pack for the first 4 months of
  development, I'll now do subsequent packs on top of that instead".

  The other good news is that a pack is also a natural boundary for fsck 
  (as in "ok, I found that object in a pack, so I won't bother going
  deeper in the reachability chain"), so if you start packing your
  repository, fsck will only have to worry about the objects that are
  unpacked. That makes them work really naturally for archiving, ie this 
  all means that you can avoid a lot of overhead by packing your history
  every once in a while, with it all being entirely transparent.

  In other words, if you just pack every month, you can basically 
  guarantee that fsck costs etc never really go up, and your diskspace 
  also goes up only very slowly. The packed format is quite efficient in 
  many ways, but it is totally immutable (ie you can't add anything to an 
  archive - a pack stays the way it always was, and if you want to pack 
  more you have to either re-do the pack or just create a new one) ]

		Linus
