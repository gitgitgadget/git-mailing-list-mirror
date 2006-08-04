From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 12:53:28 -0400
Message-ID: <9e4733910608040953p171e4a62p9670f614b33f93b2@mail.gmail.com>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
	 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
	 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
	 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
	 <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
	 <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
	 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>
	 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
	 <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
	 <44D37845.5010009@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 18:53:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G92vW-0003qe-9p
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 18:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161297AbWHDQxb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 12:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161299AbWHDQxa
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 12:53:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:15854 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161297AbWHDQxa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 12:53:30 -0400
Received: by nf-out-0910.google.com with SMTP id q29so6892nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 09:53:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LR/aW6e7fTCWlJ+G3+1skAx04Z9mXA41WzccCoduAAhAgyjOnTfd0ldlTes+Jx4fE7Y51idcMul8RthNm+Ldz1HzpXAqunyhDkyy/I5fhDlOnEtZBTt4nFwaquA8Yz2EHF2Q+3cOYUvx4rgD91fT3c5e62ABzXWRN+oYsEoDsCs=
Received: by 10.78.147.3 with SMTP id u3mr1614634hud;
        Fri, 04 Aug 2006 09:53:28 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Fri, 4 Aug 2006 09:53:28 -0700 (PDT)
To: "Rogan Dawes" <discard@dawes.za.net>
In-Reply-To: <44D37845.5010009@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24808>

On 8/4/06, Rogan Dawes <discard@dawes.za.net> wrote:
> Jon Smirl wrote:
> > On 8/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >> I'd suggest against it, but you can (and should) just repack often enough
> >> that you shouldn't ever have gigabytes of objects "in flight". I'd have
> >> expected that with a repack every few ten thousand files, and most files
> >> being on the order of a few kB, you'd have been more than ok, but
> >> especially if you have large files, you may want to make things "every
> >> <n>
> >> bytes" rather than "every <n> files".
> >
> > How about forking off a pack-objects and handing it one file name at a
> > time over a pipe. When I hand it the next file name I delete the first
> > file. Does pack-objects make multiple passes over the files? This
> > model would let me hand it all 1M files.
> >
>
> I'd imagine that this would not necessarily save you a lot, if you have
> to write it to disk, and then read it back again. Your only chance here
> is if you stay in the buffer, and avoid actually writing to disk at all.

If I keep creating files, reading them and then deleting them then it
is likely that the same blocks are being used over and over. Since the
blocks are reused it will stop the cache thrashing. Some disk writes
will still happen but that is way better than doing 12GB of unique
writes followed by 12GB of reads. The 24GB of IO is all reads on small
files so it is seek time limited since repack does writes in the
middle of the reads.

> Of course, using a ramdisk/tmpfs for your object directories might be
> enough to save you. Just use a symlink to tmpfs for the objects
> directory, and leave the pack files on persistent storage.

The unpacked set of objects is way to big to fit into RAM. Any scheme
using the unpacked objects will spill to disk.

> That doesn't answer your question about how many passes pack-objects
> does. Nicholas Pitre should be able to answer that.
>
> Rogan
>


-- 
Jon Smirl
jonsmirl@gmail.com
