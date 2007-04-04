From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] Added use of xmalloc() on diff-delta.c
Date: Wed, 4 Apr 2007 15:31:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704041525220.6730@woody.linux-foundation.org>
References: <11757126093105-git-send-email-ribas@c3sl.ufpr.br>
 <7vejn02bcv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bruno Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 00:32:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZE1l-0005iH-73
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 00:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbXDDWbw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 18:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbXDDWbw
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 18:31:52 -0400
Received: from smtp.osdl.org ([65.172.181.24]:58387 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbXDDWbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 18:31:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l34MVMPD001354
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 4 Apr 2007 15:31:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l34MVLgd000647;
	Wed, 4 Apr 2007 15:31:21 -0700
In-Reply-To: <7vejn02bcv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.955 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43783>



On Wed, 4 Apr 2007, Junio C Hamano wrote:
> 
> These patches take that nice property away, making libification
> more difficult, which is the downside.  Is there an upside?

Well, we could just make the libification rule very simple:

 - the library does *not* include "xmalloc()", and you have to handle 
   out-of-memory situations yourself inside the xmalloc() that *you* as a 
   libification user provide!.

Then, we just make our xmalloc() be non-inlined (which we should do 
*anyway* - it's long since grown so big that it shouldn't be inlined in 
the first place), and we make it part of a non-library git object file.

Other libgit uses might end up doing something like

		..
		if (sigsetjump(buffer, 1)) {
			show_oom_message();
		..

	void *xmalloc(size_t size)
	{
		void *ret = malloc(size ? size : 1);
		if (!ret)
			siglongjmp(buffer);
		return ret;
	}

or, if they use C++ exception handling, they'd just make their own 
xmalloc() raise an exception, and have the callers catch it.

The point being that this is what you'd need to do *anyway*, and trying to 
make all the library routines return NULL or some other error case is just 
worse programming practice than just having a xmalloc() that dies by 
default but that can be overridden.

		Linus
