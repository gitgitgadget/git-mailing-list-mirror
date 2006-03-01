From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git doesn't like big files when pushing
Date: Wed, 1 Mar 2006 15:00:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603011448230.22647@g5.osdl.org>
References: <20060301220802.GA18250@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 00:01:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEaJX-0003rI-TW
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 00:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWCAXA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 18:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbWCAXA4
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 18:00:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751937AbWCAXA4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 18:00:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k21N0sDZ000880
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Mar 2006 15:00:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k21N0o7Z024753;
	Wed, 1 Mar 2006 15:00:52 -0800
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060301220802.GA18250@kroah.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17025>



On Wed, 1 Mar 2006, Greg KH wrote:
> 
> That worked fine, but when I went to push the stuff to my server, I got
> the following errors:
> 
> $ git push origin
> updating 'refs/heads/master'
>   from 490badd9bec9ada3a21be275c97fb2a3a390f49e
>   to   16be8985abc8a9c89ad2cc8f46a0d8e9786e832f
> Generating pack...
> Done counting 8 objects.
> Deltifying 8 objects.
> fatal: Out of memory, malloc failed
> fatal: early EOF

Gaah. We probably have a memory leak somewhere, and it just normally 
doesn't much matter.

Git does want to keep the "window" of the objects it packs in memory while 
packing (it would be really costly to read them in one at a time, over and 
over again), but it should hopefully not really not need tons more memory 
than that. Since the window is normally 10, and you only have 8 objects, 
it really wants to have all eight in memory, but it shouldn't need a whole 
lot more.

But maybe it's really the case that you can't fit those 8 objects in 
memory. One option (which might also solve some of the performance issues) 
is to make the window be based on object _size_ rather than just be a 
fixed number (ie with an 80MB object, you'd only try a couple of objects 
around it, not the full window).

		Linus
