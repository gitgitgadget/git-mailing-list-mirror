From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] pack-refs: use lockfile as everybody else does.
Date: Thu, 5 Oct 2006 07:51:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610050747590.3952@g5.osdl.org>
References: <7v7izhrc2v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610041954480.3952@g5.osdl.org> <7vodsrguej.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 16:55:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVUZN-0001ny-KW
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 16:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWJEOvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 10:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWJEOvZ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 10:51:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751261AbWJEOvY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Oct 2006 10:51:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k95EpJaX024464
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 Oct 2006 07:51:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k95EpJCW021618;
	Thu, 5 Oct 2006 07:51:19 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodsrguej.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.459 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28359>



On Wed, 4 Oct 2006, Junio C Hamano wrote:
> 
> How would one ensure the effect of rename(2) hits the disk
> platter before proceeding to do something else?  We seem to do
> sync(1) in git-repack.sh for similar reasons, and I wonder if we
> should do a sync(2) there.  I doubt it would be worth it though;
> the function can return before the actual writing is done.

sync() is supposed to wait until the data is on the disk, anything else is 
likely to be a bad implementation (even if POSIX may not _guarantee_ it).

Also, most filesystems (for various reasons, not the least of which is 
"speed of fsck") will journal metadata, but not file contents. Which means 
that if a crash happens and one of the loose refs has already been 
removed, then (thanks to journaling) that means that on most filesystems 
the rename would already have been guaranteed to hit the disk - even 
regardless of any sync().

So in practice, it's much more important to guarantee the file contents 
(the fsync) part, because the OS already tends to guarantee metadata 
ordering.

			Linus
