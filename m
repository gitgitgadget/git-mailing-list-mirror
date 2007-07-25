From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: index-pack died on pread
Date: Wed, 25 Jul 2007 16:44:05 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707251636490.3607@woody.linux-foundation.org>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com>
 <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org>
 <200707260115.13234.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Michal Rokos <michal.rokos@gmail.com>, GIT <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 01:45:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDqXQ-0006JH-4L
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 01:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbXGYXpB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 19:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbXGYXpA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 19:45:00 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33500 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750840AbXGYXpA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jul 2007 19:45:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6PNiDQc008395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Jul 2007 16:44:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6PNi58O001981;
	Wed, 25 Jul 2007 16:44:06 -0700
In-Reply-To: <200707260115.13234.robin.rosenberg.lists@dewire.com>
X-Spam-Status: No, hits=-2.734 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53741>



On Thu, 26 Jul 2007, Robin Rosenberg wrote:
> 
> Does cygwin have the same pread problem then.. ? after make NO_PREAD=1 with 1.5.2.4
> clone works.

Interesting.

It's true that pread() is used much less than normal reads, and maybe the 
cygwin pread() is indeed broken. But it's intriguing how apparently both 
HP-UX and Cygwin are showing the same breakage.

But if git was doing something odd with pread(), then NO_PREAD shouldn't 
work either, because that just enables the exact same code, except we now 
supply a pread emulation library function (which does it using "lseek()": 
not a *good* emulation, but good enough for the very limited use that git 
puts it to).

So yeah, it looks like pread() is broken under cygwin and hpux-11.11.

Googling for "pread" "cygwin" does seem to show that it's been buggy at 
times.  Eg:

	Fixes since 1.5.21-1:

	...

	- Fix pread in case current file offset is non-zero. (Hideki Iwamoto)

but I'm a bit surprised that hp-ux has the bug. pread isn't *that* 
complex.

		Linus
