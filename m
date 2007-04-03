From: "Chris Lee" <clee@kde.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 12:27:05 -0700
Message-ID: <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 21:27:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYoew-00007T-1k
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 21:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbXDCT1K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 15:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbXDCT1J
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 15:27:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:59818 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbXDCT1I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 15:27:08 -0400
Received: by wr-out-0506.google.com with SMTP id 76so2012189wra
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 12:27:06 -0700 (PDT)
Received: by 10.114.56.1 with SMTP id e1mr2359064waa.1175628425185;
        Tue, 03 Apr 2007 12:27:05 -0700 (PDT)
Received: by 10.114.66.10 with HTTP; Tue, 3 Apr 2007 12:27:05 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
Content-Disposition: inline
X-Google-Sender-Auth: bec8b81e1b34e831
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43640>

On 4/3/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> Junio, Nico,
>  I think we need to do something about it.
>
> CLee was complaining about git-index-pack on #irc with the partial KDE
> repo, and while I don't have the KDE repo, I decided to investigate a bit.
>
> Even with just the kernel repo (with a single 170MB pack-file), I can do
>
>         git index-pack --stdin --fix-thin new.pack < .git/objects/pack/pack-*.pack
>
> and it uses 52s of CPU-time, and on my 4GB machine it actually started
> doing IO and swapping, because git-index-pack grew to 4.8GB in size. So
> while I initially thought I'd want a bigger test-case to see the problem,
> I sure as heck don't.

There's another issue here.

I'm running git-index-pack as part of a workflow like so:

$ git-verify-pack -v .git/objects/pack/*.idx > /tmp/all-objects
$ grep 'blob' /tmp/all-objects > /tmp/blob-objects
$ cat /tmp/blob-objects | awk '{print $1;}' | git-pack-objects
--delta-base-offset --all-progress --stdout > blob.pack
$ git-index-pack -v blob.pack

Now, when I run 'git-index-pack' on blob.pack in the current
directory, memory usage is pretty horrific (even with the applied
patch to not leak all everything). Shawn tells me that index-pack
should only be decompressing the object twice - once from the repo and
once from blob.pack - iff I call git-index-pack with --stdin, which I
am not.

If I move the blob.pack into /tmp, and run git-index-pack on it there,
it completes much faster and the memory usage never exceeds 200MB.
(Inside the repo, it takes up over 3G of RES according to top.)

By "much faster", I mean: the entire pack was indexed and completed in
17:42.40, whereas I cancelled the inside-the-repo index because after
56 minutes it was only at 46%.

(And, as far as getting this huge repo published - I have it burned to
a DVD, and I'm going to drop it in the mail to hpa today on my lunch
break, which I should be taking soon.)

-clee
