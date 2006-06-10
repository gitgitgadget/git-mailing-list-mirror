From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 10:53:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606101041490.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org> <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
 <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
 <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
 <9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com>
 <87y7w5lowc.wl%cworth@cworth.org> <Pine.LNX.4.64.0606092001590.5498@g5.osdl.org>
 <448A847C.20105@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 19:53:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fp7e9-0001I7-I2
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 19:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbWFJRxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 13:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbWFJRxP
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 13:53:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57264 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030474AbWFJRxO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jun 2006 13:53:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5AHrAgt018157
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Jun 2006 10:53:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5AHr9lV028038;
	Sat, 10 Jun 2006 10:53:10 -0700
To: Rogan Dawes <lists@dawes.za.net>
In-Reply-To: <448A847C.20105@dawes.za.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21612>



On Sat, 10 Jun 2006, Rogan Dawes wrote:
>
> Here's an idea. How about separating trees and commits from the actual blobs
> (e.g. in separate packs)? My reasoning is that the commits and trees should
> only be a small portion of the overall repository size, and should not be that
> expensive to transfer. (Of course, this is only a guess, and needs some
> numbers to back it up.)

The trees in particular are actually a pretty big part of the history. 

More importantly, the blobs compress horribly badly in the absense of 
history - a _lot_ of the compression in git packing comes very much from 
the fact that we do a good job at delta-compression.

So if you get all of the commit/tree history, but none of the blob 
history, you're actually not going to win that much space. As already 
discussed, the _whole_ history packed with git is usually not insanely 
bigger than just the whole unpacked tree (with no history at all).

So you'd think that getting just the top version of the tree would be a 
much bigger space-saving that it actually is. If you _also_ get all the 
tree and commit objects, the space saving is even less.

I actually suspect that the most realistic way to handle this is to use 
the "fetch.c" logic (ie the incremental fetcher used by http), and add 
some mode to the git daemon where you fetch literally one object at a time 
(ie this would be totally _separate_ from the pack-file thing: you'd not 
ask for "git-upload-pack", you'd ask for something like 
"git-serve-objects" instead).

The fetch.c logic really does allow for on-demand object fetching, and is 
thus much more suitable for incomplete repositories.

HOWEVER. The fetch.c logic - by necessity - works on a object-by-object 
level. That means that you'd get no delta compression AT ALL, and I 
suspect that the downside of that would be a factor of ten expansion or 
more, which means that it would really not work that well in practice.

It might be worth testing, though. It would work fine for the "after I 
have the initial cauterized tree, fetch small incremental updates" case. 
The operative word here being "small" and "incremental", because I'm 
pretty sure it really would suck for the case of a big fetch.

But it would be _simple_, which is why it's worth trying out. It also has 
the advantage that it would solve the "I had data corruption on my disk, 
and lost 100 objects, but all the the rest is fine" issue. Again, that's 
not something that the efficient packing protocol handles, exactly because 
it assumes full history, and uses that to do all its optimizations.

		Linus
