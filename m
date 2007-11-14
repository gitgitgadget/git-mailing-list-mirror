From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git 1.5.3.5 error over NFS (pack data corruption)
Date: Wed, 14 Nov 2007 01:02:18 +0100
Message-ID: <20071114000218.GL3268@steel.home>
References: <18228.32091.865519.312011@lisa.zopyra.com> <20071109232106.GA3435@steel.home> <18232.29603.856766.275854@lisa.zopyra.com> <20071112233309.GI2918@steel.home> <18233.47472.890658.729250@lisa.zopyra.com> <20071113214802.GH3268@steel.home> <18234.14781.55429.671459@lisa.zopyra.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:03:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5j7-0001mz-PH
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 01:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758941AbXKNACX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 19:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbXKNACX
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 19:02:23 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:44939 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758749AbXKNACW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 19:02:22 -0500
Received: from tigra.home (Faa9a.f.strato-dslnet.de [195.4.170.154])
	by post.webmailer.de (klopstock mo55) (RZmta 14.0)
	with ESMTP id y047c0jADNtSY1 ; Wed, 14 Nov 2007 01:02:18 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6823A277AE;
	Wed, 14 Nov 2007 01:02:18 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 50ED356D22; Wed, 14 Nov 2007 01:02:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18234.14781.55429.671459@lisa.zopyra.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolA10Q=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64919>

Bill Lear, Wed, Nov 14, 2007 00:56:45 +0100:
> On Tuesday, November 13, 2007 at 22:48:02 (+0100) Alex Riesen writes:
> >...
> >> >I extend the part you quoted. The file is opened here:
> >> >...
> >> >This is strange. The current git should not produce anything like
> >> >this (and does not, here). ...
> >> 
> >> You are absolutely correct.  My comrade ran this with 1.5.0.1 by
> >> mistake.  He reran the strace with 1.5.3.5, and I have replaced
> >> the tarball on my server:
> >> 
> >>     http://www.zopyra.com/~rael/git/git-trace.tar.bz2
> >
> >Still looks like v1.5.0.1:
> >
> >    write(2, "fatal: ", 7)                  = 7
> >    write(2, "cannot pread pack file: No such "..., 49) = 49
> 
> Well, I just grepped for the above string in git-1.5.3.5:
> 
> % grep 'cannot pread pack file' *.c
> index-pack.c:                   die("cannot pread pack file: %s", strerror(errno));

oh, you should be looking for usage.c, the function report (it is
called by default die handler). The old code used to fputs("fatal:"),
the new just vfprintf's everything, so the write should look like:

    write(2, "fatal: cannot pread pack file: No such "...
