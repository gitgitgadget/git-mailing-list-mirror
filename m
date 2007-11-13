From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Strange "beagle" interaction..
Date: Tue, 13 Nov 2007 16:44:33 -0500
Message-ID: <9e4733910711131344t381b939dg47b5e078c52be3b2@mail.gmail.com>
References: <alpine.LFD.0.9999.0711131241050.2786@woody.linux-foundation.org>
	 <20071113210354.GD22590@fieldses.org>
	 <alpine.LFD.0.9999.0711131326310.2786@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:45:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3Z6-0005QG-2W
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762063AbXKMVoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761045AbXKMVoh
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:44:37 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:26753 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759381AbXKMVof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:44:35 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1410109nze
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 13:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VbzdlA5n5fHNe9Rv2NAKUxj8ON4zXcqkpDYc3jdJz6M=;
        b=T0+WTwoK1Y6QjfAGzfI/PT5qVOdEEG5biRE0JAAYCHznzqBfwOQ54po76mRQDXpEDujSOXG/9hbrbxlDwBPdwpznDVR3IQWHogyc7Xys9i9LLF32bNCtn3WLb0S+pOGZpFc89Dlq5/r32ufXxWvXxQ7RYmciy0HeSrdXAM3t2hM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l5X5VZ/Xu4fIEAWllET6uJK12uBM6zbYxRW/xIA2sfrNA7CVX/HK+4BRIN3yiMLskSEjFsMi7YtyyEV16P/vR+r1hLVPP3X+tPdtqaZOKga3rCb0H++SyOIR5jm1jf1MyYaKuSqIeEyVXhR9de/5RWQcvMWR9BENuQUwzEG5SU0=
Received: by 10.114.88.1 with SMTP id l1mr320417wab.1194990273389;
        Tue, 13 Nov 2007 13:44:33 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Tue, 13 Nov 2007 13:44:33 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0711131326310.2786@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64879>

On 11/13/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Tue, 13 Nov 2007, J. Bruce Fields wrote:
> >
> > Last I ran across this, I believe I found it was adding extended
> > attributes to the file.
>
> Yeah, I just straced it and found the same thing. It's saving fingerprints
> and mtimes to files in the extended attributes.

Things like Beagle need a guaranteed log of global inotify events.
That would let them efficiently find changes made since the last time
they updated their index.

Right now every time Beagle starts it hasn't got a clue what has
changed in the file system since it was last run. This forces Beagle
to rescan the entire filesystem every time it is started. The xattrs
are used as cache to reduce this load somewhat.

A better solution would be for the kernel to log inotify events to
disk in a manner that survives reboots. When Beagle starts it would
locate its last checkpoint and then process the logged inotify events
from that time forward. This inotify logging needs to be bullet proof
or it will mess up your Beagle index.

Logged files systems already contain the logged inotify data (in their
own internal form). There's just no universal API for retrieving it in
a file system independent manner.

>
> > Yeah, I just turned off beagle.  It looked to me like it was doing
> > something wrongheaded.
>
> Gaah. The problem is, setting xattrs does actually change ctime. Which
> means that if we want to make git play nice with beagle, I guess we have
> to just remove the comparison of ctime.
>
> Oh, well. Git doesn't *require* it, but I like the notion of checking the
> inode really really carefully. But it looks like it may not be an option,
> because of file indexers hiding stuff behind our backs.
>
> Or we could just tell people not to run beagle on their git trees, but I
> suspect some people will actually *want* to. Even if it flushes their disk
> caches.
>
>                 Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
