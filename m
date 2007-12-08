From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: Something is broken in repack
Date: Fri, 07 Dec 2007 19:44:16 -0800
Message-ID: <1197085456.22471.42.camel@brick>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 04:44:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0qcJ-0000oY-Gs
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 04:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbXLHDoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 22:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbXLHDoS
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 22:44:18 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:41675 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbXLHDoR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 22:44:17 -0500
Received: by rv-out-0910.google.com with SMTP id k20so929243rvb
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 19:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=H1DcuePKLiGILkJpTL4y3FH0mdM8GCWTuJP6cbZ4tR8=;
        b=G5dkjGwYdL8J8j68PUGdi3qbpkQhgOOlc0kuTEenVFPYyfb5f3Ne5v18Wx/XTZzRozDHU5tyEcKr5nRfwRTMVd+oBAU2vHVm0vvYzBO1KdvkxMBs2psTRnlue7uQ/bkzvtKHJGkqy6CeykSH+PIXIMbniwvhFCJfW5vSGxUVHl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Cl6I2Fzp3LgezmslXynyAbMJwc6KXFoFaO6FcuM8Pf7z5vJ/4OSogj4M1hjhrXuUUY9ZlFiUQbsYh9Dn/HleQycyb5vBa/FXtfXflc37Fcld9Ecuh008jifiWZAb5YloXtEUKhQ17DQhd22t/2mAw4kAW71UrEKfByRp708IdtY=
Received: by 10.141.198.8 with SMTP id a8mr401471rvq.1197085457033;
        Fri, 07 Dec 2007 19:44:17 -0800 (PST)
Received: from ?192.168.1.124? ( [216.19.190.48])
        by mx.google.com with ESMTPS id f42sm893849rvb.2007.12.07.19.44.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Dec 2007 19:44:16 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67504>


On Fri, 2007-12-07 at 20:46 -0500, Nicolas Pitre wrote:
> On Fri, 7 Dec 2007, Jon Smirl wrote:
> > And the 330MB gcc pack for input
> >  git repack -a -d -f  --depth=250 --window=250
> > 
> > complete seconds RAM
> > 10%  47 1GB
> > 20%  29 1Gb
> > 30%  24 1Gb
> > 40%  18 1GB
> > 50%  110 1.2GB
> > 60%  85 1.4GB
> > 70%  195 1.5GB
> > 80%  186 2.5GB
> > 90%  489 3.8GB
> > 95%  800 4.8GB
> > I killed it because it started swapping
> > 
> > The mmaps are only about 400MB in this case.
> > At the end the git process had 4.4GB of physical RAM allocated.
> > Starting with a 2GB pack of the same data my process size only grew to
> > 3GB with 2GB of mmaps.
> 
> Which is quite reasonable, even if the same issue might still be there.
> 
> So the problem seems to be related to the pack access code and not the 
> repack code.  And it must have something to do with the number of deltas 
> being replayed.  And because the repack is attempting delta compression 
> roughly from newest to oldest, and because old objects are typically in 
> a deeper delta chain, then this might explain the logarithmic slowdown.
> 
> So something must be wrong with the delta cache in sha1_file.c somehow.

All I have is a qualitative observation, but during the process of
creating the pack, there was a _huge_ slowdown between 10-15%
(hundreds/dozens per second to single object per second and a
corresponding increase in process size).  Didn't keep any numbers
at the time, but it was noticable.

I wonder if there are a bunch of huge objects somewhere in gcc's
history?

Harvey
