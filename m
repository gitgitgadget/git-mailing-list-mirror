From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git 1.5.3.5 error over NFS (pack data corruption)
Date: Tue, 13 Nov 2007 22:48:02 +0100
Message-ID: <20071113214802.GH3268@steel.home>
References: <18228.32091.865519.312011@lisa.zopyra.com> <20071109232106.GA3435@steel.home> <18232.29603.856766.275854@lisa.zopyra.com> <20071112233309.GI2918@steel.home> <18233.47472.890658.729250@lisa.zopyra.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:48:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3cP-0006d3-Nq
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756857AbXKMVsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759591AbXKMVsI
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:48:08 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:51571 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756857AbXKMVsG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:48:06 -0500
Received: from tigra.home (Faa9a.f.strato-dslnet.de [195.4.170.154])
	by post.webmailer.de (fruni mo12) (RZmta 14.0)
	with ESMTP id N0216ajADKiIdt ; Tue, 13 Nov 2007 22:48:02 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 599A5277AE;
	Tue, 13 Nov 2007 22:48:02 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 3F96A56D22; Tue, 13 Nov 2007 22:48:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18233.47472.890658.729250@lisa.zopyra.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolA10Q=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64881>

Bill Lear, Tue, Nov 13, 2007 15:49:20 +0100:
> >> >> We have an NFS-mounted filesystem, and git pull is choking on it.
> >> >> 
> >> >> % uname -a
> >> >> Linux uhlr.zopyra.com 2.6.9-42.0.2.ELsmp #1 SMP Wed Aug 23 13:38:27 BST 2006 x86_64 x86_64 x86_64 GNU/Linux
> >
> >It is a really old kernel... Maybe you could try with some of the
> >recent ones?
> 
> I'll see if we can: the machine in question is a high security one,
> and not easy to change.  We haven't seen this sort of problem
> elsewhere on our newer systems as far as I know.

Suspected that :)

> >I extend the part you quoted. The file is opened here:
> >...
> >This is strange. The current git should not produce anything like
> >this (and does not, here). ...
> 
> You are absolutely correct.  My comrade ran this with 1.5.0.1 by
> mistake.  He reran the strace with 1.5.3.5, and I have replaced
> the tarball on my server:
> 
>     http://www.zopyra.com/~rael/git/git-trace.tar.bz2

Still looks like v1.5.0.1:

    write(2, "fatal: ", 7)                  = 7
    write(2, "cannot pread pack file: No such "..., 49) = 49

> With this minor correction (!), here is the last part from
> the last file (strace.out.26001):

I think it got worse:

> write(3, "\360]|\204\205\317|\352\336C\342\316\206\334\326\201\211"..., 4096) = 4096
> write(3, "\20\t\33if (cached_vias.insert(die,\227\17"..., 4096) = 4096

The data in packs is zlib-compressed. I don't think you should be able
to see any readable strings in them (except for "PACK" in the header).
I believe you have a data corruption now.

Does git-fsck --all say anything about that, BTW?

Besides, could you try with a git compiled with NO_PREAD?
