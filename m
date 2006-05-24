From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Clean up sha1 file writing
Date: Wed, 24 May 2006 11:52:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605241145490.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org> <E1Fixs4-0005pD-10@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 24 20:52:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiyTD-0003rl-BT
	for gcvg-git@gmane.org; Wed, 24 May 2006 20:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWEXSwc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 14:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWEXSwc
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 14:52:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932219AbWEXSwb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 14:52:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4OIqOtH018134
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 May 2006 11:52:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4OIqMFX027271;
	Wed, 24 May 2006 11:52:23 -0700
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1Fixs4-0005pD-10@moooo.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20699>



On Wed, 24 May 2006, Matthias Lederhofer wrote:

> > checking for partial writes
>
> Just out of interest: is this to be safe on any OS or should this
> be checked always?

Any POSIX-conformant OS/filesystem should always do a full write for a 
regular file, unless a serious error happens.

HOWEVER. 

In practice, you can get partial writes at least over NFS (hey, it may not 
be posix, but it's _common_) when the filesystem has been mounted soft 
(and/or interruptible). And obviously if your file descriptor isn't a 
regular file, you can easily get partial writes.

Doing the loop is always safe, so it's worth doing it that way.

> > +		size = write(fd, buf, len);
> > +		if (!size)
> > +			return error("file write: disk full");
>
> Shouldn't write to a full disk return -1 with ENOSPC?

In that case, the "size < 0" check will catch it. The "return zero for 
full" case is an alternate error return (it happens for block device files 
at the end, it could happen for other things too). So the "returns zero 
means full" is the portable/safe thing to do.

		Linus
