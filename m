From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Tue, 24 Jul 2007 16:19:47 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707241608240.3607@woody.linux-foundation.org>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net>
 <200707241134.31950.robin.rosenberg.lists@dewire.com>
 <alpine.LFD.0.999.0707241144490.3607@woody.linux-foundation.org>
 <200707250056.20880.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 01:20:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDTgR-0000z9-Ad
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 01:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756388AbXGXXUs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 19:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756660AbXGXXUs
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 19:20:48 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38623 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756341AbXGXXUr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 19:20:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6ONJrMm026544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jul 2007 16:19:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6ONJluw006087;
	Tue, 24 Jul 2007 16:19:47 -0700
In-Reply-To: <200707250056.20880.robin.rosenberg.lists@dewire.com>
X-Spam-Status: No, hits=-4.729 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.14__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53659>



On Wed, 25 Jul 2007, Robin Rosenberg wrote:
> 
> Having our mind enlightened, I propose this or nothing as a workaround. Since
> cvsexportcommit is really a CVS workaround we might work around some bugs
> in CVS itself while we're at it.

Side note: I think the reason it came up now is that with CONFIG_NO_HZ the 
Linux filesystem clock will easily be off by half a second even for local 
filesystems.

With CONFIG_NO_HZ, we don't update the time as religiously, and as a 
result, people who look at the low-resolution time (like filesystems) will 
get a noticeable skew.

Quite frankly, that's a Linux kernel bug, and we'll fix it. But it doesn't 
really invalidate the argument: applications really shouldn't depend on 
the "filesystem time" being in sync with the "CPU time", and it may be 
that the kernel bug was the one that ended up exposing this mis-feature of 
CVS.

Normally, Linux (and probably most other systems) will keep the local 
filesystems synchronized to within at least one clock-tick of the 
real-time clock, so the clock skew between filesystems and CPU is at most 
in the "few millisecond" range.

That's also the kind of range that NTP will largely guarantee, so 
generally, in most circumstances, while you cannot (and shouldn't) expect 
filesystem times to be "accurate", in most good situations you'll never 
see skews over a few milliseconds.

(But on the other hand, search for "kerberos" and "time skew" on google, 
and you see discussions about allowing five *minutes* of skew etc, so 
clearly the model of "everybody runs NTP" isn't exactly all of it ;)

So I suspect that the CVS code is (a) buggy and (b) hard to show the bug 
actually triggering on a well-maintained machine, and that it may well be 
the case that the only reason it shows up as a bug now is that Jason is 
running a recent kernel with CONFIG_NO_HZ. I have no idea what the default 
Fedora 7 kernel does.

		Linus
