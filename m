From: "Ben Lynn" <benlynn@gmail.com>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 16:09:23 -0700
Message-ID: <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
	 <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
	 <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>
	 <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 01:10:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6CzK-0006eJ-Vh
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 01:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbYFJXJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 19:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754501AbYFJXJ4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 19:09:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:21614 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbYFJXJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 19:09:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1943244fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 16:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ovCMRLTlusEM//CdL7I5f2GeLIvLcOl8rT0d6oOhDpU=;
        b=IThMhoKrOWvd93yqqEtDwQfNtLa/B5Iane1a0kCIXGbncxl1T8cuJvKJUOaUbkwD6J
         qY+BenwbTWLQLDoEXAe5vGNuUukCDphnhZLz06hqBI48J/jr9l/ZyzNlAUU2R3gynwfO
         Gjscq9hki5E88NKzvbJIAs13xPb355N/O1QKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qQm3TjZpq7P/rv7hL02809C8QdQi6qXGHw1EB0EOaZLY9eJ0a2W9RD6r2qJfs6bV7R
         aAOfhzj0eRG2alojIDMdyoN53lwDUoJ3UzLGUb1A2+Fk3VtBYKD693dbk+lp9aYa6whc
         HgnaUqU4N8ooGTUdCY8aygN8gBQgzZHsCOe7U=
Received: by 10.86.26.1 with SMTP id 1mr6361910fgz.49.1213139369863;
        Tue, 10 Jun 2008 16:09:29 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Tue, 10 Jun 2008 16:09:23 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84561>

>> Nice! I believe I can prove there are no races now.
>
> It's worth pointing out that even in the absense of races, you can
> obviously screw things up if you really work at it, and *want* to. We
> cannot guarantee that we see all file changes from the stat() information,
> and we don't even save the whole stat info (ie we only save the low 32
> bits).

I agree completely. My proof only holds in an abstract setting. It
assumes things such as a strictly nondecreasing system clock is and
that ctime and mtime work in an ideal sense.

> And different systems have different approaches to what happens when a
> file gets modified through a writable mmap(). Exactly what is the mtime
> going to be?

Good point. I confess I've only learned about mmap very recently, from
browsing the git code. All this time, I've been using streams, file
descriptors, etc. mmap is so much better!

What's Linux do in this case? For indexing purposes, so long as the
mtime is updated after the last write before git gets to it, things
should be fine.

> So I think git does a really good job at matching the stat() information,
> and the suggested patch makes it even stricter, but I think we should not
> even try to make it handle "malicious" changes. I bet you can work at
> making it miss some update if you really *really* try.

Definitely. e.g. rig the mtime by 2^32 seconds, or add 2^32 bytes to a
file within a second.

> And I think there is one known race: the index mtime itself is not
> race-free. Remember: it may take more than a second to write the index
> file! So I can imagine that if you can set it up so that you change the
> file as the index is written out, and the index write is delayed
> sufficiently, the racy timestamp logic can fail just because the timestamp
> on the index file ends up being later.

I had thought about this. I hacked some code up where the index looks
at the current system time when updating a cache entry to determine if
the hash is racy. Is doing one time(NULL) call per file reasonable?
I'm guessing it must be cheaper that a stat call.

> This is more easily shown by doing a 'touch' on the index file afterwards,
> of course.

Agreed. Another assumption of my proof is that the index is
trustworthy. If you tamper with it, all bets are off. You can't stop
determined users from hurting themselves.

> And yes, we should have written the timestamp to the file itself, instead
> of reading it from the filesystem.

Interesting. I had hacked a version of the index that did this (before
changing it to use a different solution).

In general, is the format of the index file set in stone? Is that why
it's better to use the size zero trick for the race condition rather
than introduce a new flag for example? Or are these wrinkles too small
to justify a potentially painful upgrade?

-Ben
