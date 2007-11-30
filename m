From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Some git performance measurements..
Date: Thu, 29 Nov 2007 22:03:00 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711292145110.8458@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org> <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org> <alpine.LFD.0.99999.0711282244190.9605@xanadu.home> <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
 <alpine.LFD.0.99999.0711291208060.9605@xanadu.home> <alpine.LFD.0.9999.0711290945060.8458@woody.linux-foundation.org> <7v3auos4yi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 07:04:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxyzP-0001ky-Uk
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 07:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbXK3GEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 01:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754287AbXK3GEU
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 01:04:20 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39879 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753844AbXK3GET (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2007 01:04:19 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAU6302V032122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2007 22:03:02 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAU630KJ026032;
	Thu, 29 Nov 2007 22:03:00 -0800
In-Reply-To: <7v3auos4yi.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.728 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66616>



On Thu, 29 Nov 2007, Junio C Hamano wrote:
> 
> I am hoping that "probably 10s of those 17s" can actually be measured
> with the patch I sent out last night.  Has anybody took a look at it?

Sorry, I missed it. But I just did timings.

Your patch helps

	git read-tree -m -u --exclude-per-directory=.gitignore HEAD HEAD

timings enormously, and it's now down to 3s for me (which is the same 
speed as it is without any per-directory-excludes). That's a big 
improvement from the ~10s I see without your patch (I've repacked my 
tree, I have to admit that I don't even know if it's the new or the old 
older, but I can state that 7s for me was just those .gitignore files).

Sadly, the full "git checkout" itself is not actually improved, due to the

	git update-index --refresh

there, which will end up populating the whole directory cache anyway.

I wonder why I didn't see that as the expensive operation when I timed 
"git checkout". Probably because I narrowed down on the "git read-tree" as 
the operation that actually accesses the pack-file and the object 
directory, while the "git update-index" never touches the actual objects.

Anyway, I think your patch is great. It just doesn't help the full case of 
a "git checkout", only the read-tree portion of it ;(

As to partitioning the data according to types:

> When I do archaeology, I think I often run blame first to see which
> change made the block of text into the current shape first, and then run
> a path limited "git log -p" either starting or ending at that revision.
> In that workflow, the initial blame may get slower with the new layout,
> but I suspect it would help by speeding up the latter "git log -p" step.

I really cannot convince myself one way or the other. I have a suspicion 
that sometimes it helps to have objects (regardless of type) close to each 
other, and sometimes it helps to have the trees packed densely. A lot of 
operations *do* work on both blobs and trees (a *raw* diff doesn't, but 
they are fairly rare), so this is not at all clear-cut like the commit 
case.

So sorting the commits together is a no-brainer, since a lot of really 
important ops only look at them. But blobs and trees? The numbers 
certainly go both ways, and I suspect we are probably better off not 
messing with the sort order unless we have some unambiguous real results.

Oh, well. I was hoping that I'd have a number of cases that showed good 
improvements, with perhaps the bulk of it not showing much difference at 
all. But while I saw the good improvements, the very first try at "git 
blame" also showed quite worse numbers, so I think we should consider it 
an interesting idea, but probably shelve it.

			Linus
