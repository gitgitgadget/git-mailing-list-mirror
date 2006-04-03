From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Mon, 3 Apr 2006 07:33:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
 <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kees-Jan Dijkzeul <k.j.dijkzeul@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 16:34:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQQ80-00072x-JJ
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 16:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWDCOd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 10:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWDCOd5
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 10:33:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751458AbWDCOd5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 10:33:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k33EXpEX028531
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Apr 2006 07:33:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k33EXpHS019416;
	Mon, 3 Apr 2006 07:33:51 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18332>



On Mon, 3 Apr 2006, Johannes Schindelin wrote:
> 
> The problem is not mmap() on cygwin, but that a fork() has to jump through 
> loops to reinstall the open file descriptors on cygwin. If the 
> corresponding file was deleted, that fails. Therefore, we work around that 
> on cygwin by actually reading the file into memory, *not* mmap()ing it.

Well, we could actually do a _real_ mmap on pack-files. The pack-files are 
much better mmap'ed - there we don't _want_ them to be removed while we're 
using them. It was the index file etc that was problematic.

Maybe the cygwin fake mmap should be triggered only for the index (and 
possibly the individual objects - if only because there doing a 
malloc+read may actually be faster).

Using malloc+read on pack-files is pretty wasteful, since we usually only 
use a very small part of them (ie if we have a 1.5GB pack-file, it's sad 
to read all of it, when we'd usually actually access just a small small 
fraction of it).

That said, I think git _does_ have problems with large pack-files. We have 
some 32-bit issues etc, and just virtual address space things. So for now, 
it's probably best to limit pack-files to the few-hundred-meg size, and 
create serveral smaller ones rather than one huge one.

		Linus
