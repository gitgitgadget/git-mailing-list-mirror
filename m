From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 09/13] drop objects larger than --blob-limit if specified
Date: Fri, 6 Apr 2007 08:49:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704060845120.6730@woody.linux-foundation.org>
References: <56b7f5510704051536s7de9638fs8cd811d580f6a7dc@mail.gmail.com>
 <alpine.LFD.0.98.0704052103410.28181@xanadu.home>
 <56b7f5510704051919v7daac590m6ac52c4fcabd5321@mail.gmail.com>
 <alpine.LFD.0.98.0704052257200.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 18:36:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZqhH-0001fP-IG
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 17:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbXDFPtt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 11:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932975AbXDFPtt
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 11:49:49 -0400
Received: from smtp.osdl.org ([65.172.181.24]:54091 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932969AbXDFPts (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 11:49:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l36FnNPD008840
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 Apr 2007 08:49:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l36FnMT6012480;
	Fri, 6 Apr 2007 08:49:22 -0700
In-Reply-To: <alpine.LFD.0.98.0704052257200.28181@xanadu.home>
X-Spam-Status: No, hits=-0.954 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43914>



On Thu, 5 Apr 2007, Nicolas Pitre wrote:
> 
> > (2) Pack the object any way and let the packfile size exceed
> >     my specification.  Ignoring a clear preference from the user
> >     doesn't seem good.
> 
> It is not indeed.

Well, I think there is an easy solution.

Just go back and say that when the user limits the size, it limits the 
offset at which objects can *start*.

Not only is that the only thing that the index file itself cares about, it 
also means that

 - you don't ever need to undo anything at all (because you know the 
   starting offset) when you begin packing a new object.

   This should simplify your patch a lot.

 - the object size issue just goes away. Sure, the pack-file limit looks a 
   bit strange (it's no longer a hard limit on the *size* of the 
   pack-file, just on the object offsets), but let's face it, we really 
   really don't care.

And in practice, by setting the pack-file limit to 2GB (or even 1GB), you 
never ever have to worry about the 32-bit filesystem limits any more, 
unless your repository is fundamentally so screwed that you simply 
*cannot* reporesent it well on something like FATFS (ie any object that is 
2GB in size will probably have a blob that is even bigger, and FATFS 
already has problems with it).

So in practice, just limiting the index offsets is what you really want 
anyway.

		Linus
