From: "Chris Lee" <clee@kde.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 12:54:18 -0700
Message-ID: <db69205d0704031254s23460558ycb9715362768be16@mail.gmail.com>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
	 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
	 <alpine.LFD.0.98.0704031540140.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 21:54:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYp5D-00078J-9q
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 21:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbXDCTyU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 15:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933104AbXDCTyU
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 15:54:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:11658 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933094AbXDCTyT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 15:54:19 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1919862wxd
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 12:54:19 -0700 (PDT)
Received: by 10.114.179.1 with SMTP id b1mr2411394waf.1175630058504;
        Tue, 03 Apr 2007 12:54:18 -0700 (PDT)
Received: by 10.114.66.10 with HTTP; Tue, 3 Apr 2007 12:54:18 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704031540140.28181@xanadu.home>
Content-Disposition: inline
X-Google-Sender-Auth: a19ce20ef68b1d82
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43648>

On 4/3/07, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 3 Apr 2007, Chris Lee wrote:
>
> > There's another issue here.
> >
> > I'm running git-index-pack as part of a workflow like so:
> >
> > $ git-verify-pack -v .git/objects/pack/*.idx > /tmp/all-objects
> > $ grep 'blob' /tmp/all-objects > /tmp/blob-objects
> > $ cat /tmp/blob-objects | awk '{print $1;}' | git-pack-objects
> > --delta-base-offset --all-progress --stdout > blob.pack
> > $ git-index-pack -v blob.pack
>
> Instead of using --stdout with git-pack-object, you should provide it
> with a suitable base name for the resulting pack and the index will be
> created automatically along side the pack for you.  No need to use
> index-pack for that.

Right. But then I wouldn't have discovered how much git-index-pack sucks. :)

> > Now, when I run 'git-index-pack' on blob.pack in the current
> > directory, memory usage is pretty horrific (even with the applied
> > patch to not leak all everything). Shawn tells me that index-pack
> > should only be decompressing the object twice - once from the repo and
> > once from blob.pack - iff I call git-index-pack with --stdin, which I
> > am not.
> >
> > If I move the blob.pack into /tmp, and run git-index-pack on it there,
> > it completes much faster and the memory usage never exceeds 200MB.
> > (Inside the repo, it takes up over 3G of RES according to top.)
>
> The 3G should definitely be fixed with the added free().

Not really. This packfile is 2.6GB in size, and apparently it gets mmap'd.

(Yesterday, my machine ran out of memory trying to do index-pack when
the memleak still existed; I have 4G of RAM and, normally, 4G of swap,
but I upped it to 32G of swap and it still ran out of memory.)

> The CPU usage is explained by the fact that you're running index-pack on
> objects that are all already found in your repo so the collision check
> is triggered.  This is more or like the same issue as if you tried to
> run unpack-objects on the same pack where none of your objects will
> actually be unpacked.

Right, and if I was using --stdin, I would expect that. But I'm not.
And, according to Shawn anyway, the current behaviour is not what was
intended.

-clee
