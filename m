From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 09:54:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610160948450.3962@g5.osdl.org>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> <87mz7wp6ek.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 18:54:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZVjZ-0001XS-0b
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 18:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbWJPQyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 12:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422677AbWJPQyW
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 12:54:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26255 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422681AbWJPQyV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 12:54:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9GGsCaX008071
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Oct 2006 09:54:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9GGsAjZ019989;
	Mon, 16 Oct 2006 09:54:11 -0700
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <87mz7wp6ek.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-0.472 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28972>



On Mon, 16 Oct 2006, Jim Meyering wrote:

> Linus Torvalds <torvalds@osdl.org> wrote:
> > On Mon, 16 Oct 2006, Linus Torvalds wrote:
> ...
> > So I think xdiff has chosen too small a hash. Can you try what happens if
> > you change xdl_hashbits() (in xdiff/xutil.c) instead? Try making it return
> > a bigger value (for example, by initializing "bits" to 2 instead of 0),
> > and see if that makes a difference.
> 
> It makes no difference.
> 
> Bear in mind that there are a *lot* of duplicate lines in the files
> being compared: filtering each through "sort -u" removes 40-50k lines.

It can't be due to duplicate lines. If the lines are truly duplicate, then 
they'd get the same 32-bit hash value, and then the first conditional in 
the expression would always be true, and then it wouldn't _matter_ if it's 
a "&&" or a "||".

See?

So as far as I can tell it has to be some kind of collission on the hash 
queue with _different_ hash values being queued on the same hash queue.

Now, it could be that there's a bad hash algorithm somewhere (eg if 
XDL_HASHLONG() just does horribly badly in distributing the hash values 
onto the hash queues, you'd see this _regardless_ of how many bits you 
have, just because it clumps).

Or there could be something else that I'm just missing..

It would probably be nice to just get a sampling of what the hash-queue 
looks like for the bad case? Maybe it would be obvious that certain 
different hash values then get the same XDL_HASHLONG() thing..

		Linus
