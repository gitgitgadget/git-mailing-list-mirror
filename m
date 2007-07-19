From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 10:50:37 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707191043430.27353@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160022560.14781@racer.site> <7vejj96igx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707190258550.14781@racer.site>
 <alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org>
 <20070719103436.GA9143@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Olivier Galibert <galibert@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:51:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBa9w-0007Gp-Ss
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 19:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbXGSRvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 13:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765770AbXGSRvZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 13:51:25 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57233 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762521AbXGSRvY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 13:51:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6JHoggr005858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2007 10:50:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6JHobeG014076;
	Thu, 19 Jul 2007 10:50:37 -0700
In-Reply-To: <20070719103436.GA9143@dspnet.fr.eu.org>
X-Spam-Status: No, hits=-3.177 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53013>



On Thu, 19 Jul 2007, Olivier Galibert wrote:

> On Wed, Jul 18, 2007 at 08:28:27PM -0700, Linus Torvalds wrote:
> > And yes, the "search for zero bytes" is not *guaranteed* to find any 
> > beginning at all, if you have lots of short names, *and* lots of zero 
> > bytes in the SHA1's. But while short names may be common, zero bytes in 
> > SHA1's are not so much (since you should expect to see a very even 
> > distribution of bytes, and as such most SHA1's by far should have no zero 
> > bytes at all!)
> 
> The probability of a sha1 to have a zero is approximatively 0.075.
> That's 1 in 13, more or less.

Sure. And since we handle it fine even when it does happen, we don't care.

In fact, since we only need 20 non-zero bytes in between zeroes to know 
that it's ok, and since the ASCII part is already 7 bytes of "mode + 
space" plus <n> bytes of actual name (let's say that names average to be 
about 8 characters - which is low: in the kernel it seems to be about 10.5 
characters), we can say that the ASCII part of a tree tends to be about 15 
characters.

So in order to be unlucky, it's not enough for the previous SHA1 to have a 
NUL character in it, it actually has to be in the last five bytes of the 
SHA1 - so now we're talking something like a 1:50 chance.

And with longer names, it matters even less (to the point where it 
matters not at all if all filenames are >= 14 characters in length).

So we can be unlucky, but it's fairly rare, and when it happens, at worst 
we'll just need to scan to the next entry (and if we're *really* unlucky 
and it keeps happening until we scan until the end, we'll have to do the 
linear search).

The point being that you always get the right answer, and the likelihood 
that you have to do something slow to get that rigth answer is really 
really low.

		Linus
