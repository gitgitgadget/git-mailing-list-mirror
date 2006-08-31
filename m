From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Trace into open fd and refactor tracing code.
Date: Thu, 31 Aug 2006 14:49:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608311444200.27779@g5.osdl.org>
References: <20060831084211.28d38764.chriscool@tuxfamily.org>
 <Pine.LNX.4.64.0608311409470.27779@g5.osdl.org> <7vsljc8udx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 23:51:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIuRB-0005XU-QB
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 23:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWHaVu6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 17:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWHaVu6
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 17:50:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932455AbWHaVu5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 17:50:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7VLnmnW004108
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 31 Aug 2006 14:49:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7VLnipf025361;
	Thu, 31 Aug 2006 14:49:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsljc8udx.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.435 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26278>



On Thu, 31 Aug 2006, Junio C Hamano wrote:
> 
> Actually it was me who suggested the use of fd directly, along
> with trying to do one message in a single write (i.e. not doing
> stdio as much as possible).

I definitely agree with the "one message in a single write" thing.

That's in fact required to make sure that O_APPEND works properly (ie that 
you don't have potentially different processes mixing output)

> I somehow felt there would be less interference between writes
> issued by process A and process B, but probably I am mistaken.

The atomicity guarantees are the same regardless of whether you do a 
separate open(), the only thing that matters is that you do want to try to 
do messages with a single "write()" call, and that you use O_APPEND. That 
should guarantee that you get good behaviour.

Without O_APPEND, you would obviously have to share one single file 
descriptor, because otherwise people will just be writing all over each 
other.

			Linus
