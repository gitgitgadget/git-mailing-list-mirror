From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 18:13:13 -0500
Message-ID: <32541b131002141513m29f9a796ma8fb5855a45f91e9@mail.gmail.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> 
	<201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix> 
	<37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com> 
	<20100213223733.GP24809@gibbs.hungrycats.org> <20100214011812.GA2175@dpotapov.dyndns.org> 
	<alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de> <20100214024259.GB9704@dpotapov.dyndns.org> 
	<alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de> <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 00:13:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngnem-0001Sk-Kf
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 00:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab0BNXNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 18:13:34 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:33014 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab0BNXNe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 18:13:34 -0500
Received: by gxk24 with SMTP id 24so4484450gxk.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 15:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=rOH/UStxOIfw4QJAlufKaYQuMULKvBkjsM3nQUKCPxg=;
        b=Q/9KSDokRAIM/cfAxMDAH6mwQbZ0fem7EfYdne/oQTOuiaimvkmIjG0ndNxB2skJLA
         4digJ3JdwS3fQCg88rGcU7R4wZ613LePrTYecwulhTsBCQKBXFv7aJnyyJDJ008lK2Cs
         W1l0gCo6u08KCG4DiRBPLVh9JpdO3wdwaILoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=RIyVBLPdhBlLOxculHNWm9/ZOwbTjUwVdA9wKYOH7ANlINH0A4Yq7kXmdkm16THSJ9
         AHBanHnxIlbNHd53zG3SAqD8h+yMT/ACKGH8/nhZk2A2CC5CcnKaIfD4621A4UXhmYuX
         AU2MXHVJQ8RJUFoxWIYzDPC0Iw9NpuNB6PyqE=
Received: by 10.151.87.1 with SMTP id p1mr5625529ybl.94.1266189213124; Sun, 14 
	Feb 2010 15:13:33 -0800 (PST)
In-Reply-To: <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139949>

On Sun, Feb 14, 2010 at 2:06 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Sun, Feb 14, 2010 at 9:10 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> That's comparing oranges to apples. In one case, the address space runs
>> out, in the other the available memory. The latter is much more likely.
>
> "much more likely" is not a very qualitative characteristic... I would
> prefer to see numbers.

Well, the numbers are rather easy to calculate of course.  On a 32-bit
machine, your (ideal) maximum address space size is 4GB.  On a 64-bit
machine, it's a heck of a lot bigger.  And in either case, a single
process consuming it all doesn't matter since it won't hurt other
processes.  But the available RAM is frequently less than 4GB and that
has to be shared between *all* your processes.

> BTW, probably, it is not difficult to stream a large file in chunks (and
> it may be even much faster, because we work on CPU cache), but I suspect
> it will not resolve all issues with huge files, because eventually we
> need to store them in a pack file. So we need to develop some strategy
> how to deal with them.

It definitely doesn't resolve all the issues.  There are different
ways of looking at this; one is to not bother make git-add work
smoothly with large files, because calculating the deltas will later
cause a disastrous meltdown anyway.  In fact, arguably you should
prevent git-add from adding large files at all, because at least then
you don't get the repository into a hard-to-recover-from state with
huge files.  (This happened at work a few months ago; most people have
no idea what to do in such a situation.)

The other way to look at it is that if we want git to *eventually*
work with huge files, we have to fix each bug one at a time, and we
can't go making things worse.

For my own situation, I think I'm more likely to (and I know people
who are more likely to) try storing huge files in git than I am likely
to modify a file *while* I'm trying to store it in git.

> One way to deal with them is to stream directly into a separate pack.
> Still, it does not resolve all problems, because each pack file should
> be mapped into a memory, and this may be a problem for 32-bit system
> (or even 64-bit systems where a sysadmin set limit on amount virtual
> memory available a single program).
>
> The other way to handle huge files is to split them into chunks.
> http://article.gmane.org/gmane.comp.version-control.git/120112

I have a bit of experience splitting files into chunks:
http://groups.google.com/group/bup-list/browse_thread/thread/812031efd4c5f7e4

It works.  Also note that the speed gain from mmap'ing packs appears
to be much less than the gain from mmap'ing indexes.  You could
probably sacrifice most or all of the former and never really notice.
Caching expanded deltas can be pretty valuable, though.  (bup
presently avoids that whole question by not using deltas.)

I can also confirm that streaming objects directly into packs is a
massive performance increase when dealing with big files.  However,
you then start to run into git's heuristics that often assume (for
example) that if an object is in a pack, it should never (or rarely)
be pruned.  This is normally a fine assumption, because if it was
likely to get pruned, it probably never would have been put into a
pack in the first place.

Have fun,

Avery
