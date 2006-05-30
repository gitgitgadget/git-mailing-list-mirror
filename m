From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] git-fetch - repack in the background after fetching
Date: Tue, 30 May 2006 17:14:08 +1200
Message-ID: <46a038f90605292214l241a86b8l31edfab010a38c5f@mail.gmail.com>
References: <11489641631558-git-send-email-martin@catalyst.net.nz>
	 <Pine.LNX.4.64.0605292147010.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 07:14:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkwYb-00027A-OB
	for gcvg-git@gmane.org; Tue, 30 May 2006 07:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWE3FOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 01:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWE3FOK
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 01:14:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:503 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932079AbWE3FOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 01:14:09 -0400
Received: by wr-out-0506.google.com with SMTP id i7so1027359wra
        for <git@vger.kernel.org>; Mon, 29 May 2006 22:14:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pCFJ4MgMMfJnyTnr6w1JRgDgfdtZppnzGUF2aqeCpI3uGTGZJ5dbf2P+1A+o2fS7ClC6Dex2t2uuobvmHo5fhOQDG/jfk+jnvQo8rEviOr/pkPOG9JI3/NCcv79KODnAuPd8QaV6qTEzG5+gvKRQGaNS2T8j4NpllMgUKoQbe2A=
Received: by 10.54.96.2 with SMTP id t2mr2824142wrb;
        Mon, 29 May 2006 22:14:09 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Mon, 29 May 2006 22:14:08 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605292147010.5623@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21014>

On 5/30/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Repacking is, but "-d" is not necessarily.

Ok -- strawman knocked down. Next try...

> Some long-running (in git terms) git programs will look up the pack-files
> when they start, and if you repack after that, they won't see the new
> pack-file, but they _will_ notice that the unpacked files are no longer
> there, and will be very unhappy indeed.
>
> So the "-d" part really isn't necessarily safe.
>
> Of course, in -practice- you won't likely see this, and the archive itself
> is never corrupted, but concurrent git ops can fail due to it in theory,
> and quite frankly, that's not the kind of SCM I like to use.

Would it be safe to repack -a && sleep 180 && git prune-packed ?

> So either just do "git repack -a", or do things synchronously.

Which I take to mean 'prune synchronously'. So what about...

+
+if test $(git rev-list --unpacked --all | wc -l) -gt 1000
+then
+       echo "Repacking in the background"
+       git prune-packed
+       nice git repack -a -q &
+fi

this would mean that at any given time there's a bit of overlap
between packed and unpacked, but will be resolved over repeated
commands.




martin
