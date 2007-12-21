From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 2.6.24-rc6
Date: Thu, 20 Dec 2007 20:40:54 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712202026040.21557@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0712201731010.21557@woody.linux-foundation.org> <20071221024805.GB8535@fattire.cabal.ca> <20071221030152.GC8535@fattire.cabal.ca> <alpine.LFD.0.9999.0712201937470.21557@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712202009290.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Raphael Assenat <raph@8d.com>,
	Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 05:41:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Zhs-0004NF-Gm
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 05:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbXLUElb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 23:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbXLUElb
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 23:41:31 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53969 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751190AbXLUEla (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2007 23:41:30 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBL4evvf006983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Dec 2007 20:40:58 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBL4esxR029900;
	Thu, 20 Dec 2007 20:40:54 -0800
In-Reply-To: <alpine.LFD.0.9999.0712202009290.21557@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.712 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69039>



On Thu, 20 Dec 2007, Linus Torvalds wrote:
> 
> It only happened for a few files that had lots of repeated lines - so that 
> the diff could literally be done multiple different ways - and in fact, 
> the file that caused the problems really had a bogus commit that 
> duplicated *way* too much data, and caused lots of #define's to exist 
> twice.

Here's the example of this kind of behaviour: in the 2.6.26-rc5 tree the 
file drivers/video/mbx/reg_bits.h has the #defines for 

	/* DINTRS - Display Interrupt Status Register */
	/* DINTRE - Display Interrupt Enable Register */

duplicated twice due to commit ba282daa919f89c871780f344a71e5403a70b634 
("mbxfb: Improvements and new features") by Raphael Assenat mistakenly 
adding another copy of the same old set of defines that we already got 
added once before by commit fb137d5b7f2301f2717944322bba38039083c431 
("mbxfb: Add more registers bits access macros").

Now, that was a mistake - and one that probably happened because Rafael or 
more likely Andrew Morton used GNU patch with its insane defaults (which 
is to happily apply the same patch that adds things twice, because it 
doesn't really care if the context matches or not).

But what that kind of thing causes is that when you create a patch of the 
end result, it can show the now new duplicate lines two different (but 
equally valid) ways: it can show it as an addition of the _first_ set of 
lines, or it can show it as an addition of the _second_ set of lines. They 
are the same, after all.

Now, it doesn't really matter which way you choose to show it, although 
because of how "git diff" finds similarities, it tends to prefer to show 
the second set of identical lines as the "new" ones. Which is generally 
reasonable.

However, that interacted really badly with the new git logic that said 
that "if the two files end in the same sequence, just ignore the common 
tail of the file", because the latter copy of the identical lines would 
now show up as _part_ of that common tail, so the lines that the git diff 
machinery would normally like to show up as "new" did in fact end up being 
considered uninteresting, because they were part of an idential tail. 

So now "git diff" would happily pick _earlier_ lines as the new ones, and 
it would still be a conceptually valid diff, but because we had trimmed 
the tail of the file, that conceptually valid diff no longer had the 
expected shared context at the end.

And while it's a bit embarrassing, I'm really rather happy that both GNU 
patch and "git apply" actually refused to apply the patch. It may have 
been "conceptually correct" (ie it did really contain all of the changes!) 
but because it lacked the expected context it really wasn't a good patch. 

That was a rather long-winded explanation of what happened, mainly because 
it was all very unexpected to me, and I had personally mistakenly thought 
the git optimization was perfectly valid and actually had to go through 
the end result to see what was going on.

Anyway, the diff on kernel.org should be all ok now, and mirrored out too.

			Linus
