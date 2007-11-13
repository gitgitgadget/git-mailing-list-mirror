From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Strange "beagle" interaction..
Date: Tue, 13 Nov 2007 16:58:55 -0500
Message-ID: <9e4733910711131358w4a9c5f73yb0411691a3d91beb@mail.gmail.com>
References: <alpine.LFD.0.9999.0711131241050.2786@woody.linux-foundation.org>
	 <20071113210354.GD22590@fieldses.org>
	 <alpine.LFD.0.9999.0711131326310.2786@woody.linux-foundation.org>
	 <9e4733910711131344t381b939dg47b5e078c52be3b2@mail.gmail.com>
	 <20071113215047.GG22590@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 23:00:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3nn-0002So-R8
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 23:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762372AbXKMV7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761734AbXKMV67
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:58:59 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:35864 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761487AbXKMV66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:58:58 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1414052nze
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 13:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0x7g92l+9wV2tiBHz30Pbxc7s1dOMKlI9ujC0cNOZMk=;
        b=rAgeB32Fg59pUwHlq57unHZpsB9FcSHwVCEnkUppCrjxK0MfAygrPgxZWFOOyneOLXKI8+hkGtau46poA3UDZ2icgt/0VfGoGM2M5reLox2d5zV7ZFeBA6TQjjnBzV7wqCiP2nFmGWJXsfGGbK3PaLwpQpT8Mf+mbK4c2XJ1E7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KmNJvrIkwHpQNIJMx58JZWnQlW/DI1NOo+XwSzevzJpPtHbrcRrhivlYPO4UgYVKwpj5fgtqvEswgsiaWjA2/ktGYsvvnhPmdO25psr07lK4MkZI/hTXYk2EyziGHwS557WjnuZP3Z90Y8h6zuZnRnM6dxogsrb8sjJsdsDQJsY=
Received: by 10.114.200.2 with SMTP id x2mr360137waf.1194991135907;
        Tue, 13 Nov 2007 13:58:55 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Tue, 13 Nov 2007 13:58:55 -0800 (PST)
In-Reply-To: <20071113215047.GG22590@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64891>

On 11/13/07, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Tue, Nov 13, 2007 at 04:44:33PM -0500, Jon Smirl wrote:
> > On 11/13/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > >
> > >
> > > On Tue, 13 Nov 2007, J. Bruce Fields wrote:
> > > >
> > > > Last I ran across this, I believe I found it was adding extended
> > > > attributes to the file.
> > >
> > > Yeah, I just straced it and found the same thing. It's saving fingerprints
> > > and mtimes to files in the extended attributes.
> >
> > Things like Beagle need a guaranteed log of global inotify events.
> > That would let them efficiently find changes made since the last time
> > they updated their index.
>
> Wouldn't a simple change-attribute get you most of the way there?  All
> you need is a number that's guaranteed to increase any time a file is
> updated.

You still need to look at every file in the file system. People can
have many millions of files in their file systems (I have two million
in mine and that's small). The inotify log is the most efficient
solution.

I've turned Beagle off simply because it beats on my disk for an hour
after I reboot.

>
> Lacking that, git's current approach (snapshot all the stat data, then
> look closer at any files that appear to have been touched within a
> second of the stat) seems pretty sensible.
>
> --b.
>
> > Right now every time Beagle starts it hasn't got a clue what has
> > changed in the file system since it was last run. This forces Beagle
> > to rescan the entire filesystem every time it is started. The xattrs
> > are used as cache to reduce this load somewhat.
> >
> > A better solution would be for the kernel to log inotify events to
> > disk in a manner that survives reboots. When Beagle starts it would
> > locate its last checkpoint and then process the logged inotify events
> > from that time forward. This inotify logging needs to be bullet proof
> > or it will mess up your Beagle index.
> >
> > Logged files systems already contain the logged inotify data (in their
> > own internal form). There's just no universal API for retrieving it in
> > a file system independent manner.
>


-- 
Jon Smirl
jonsmirl@gmail.com
