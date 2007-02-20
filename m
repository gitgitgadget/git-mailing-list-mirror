From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Mon, 19 Feb 2007 16:11:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <20070217233203.GA6014@coredump.intra.peff.net>
 <Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
 <7vodnp68p8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
 <7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:13:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJIda-0000iW-Nw
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965618AbXBTALy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965615AbXBTALQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:11:16 -0500
Received: from smtp.osdl.org ([65.172.181.24]:43621 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965598AbXBTALI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:11:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1K0B3hB017708
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Feb 2007 16:11:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1K0B2eJ025022;
	Mon, 19 Feb 2007 16:11:02 -0800
In-Reply-To: <7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.454 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40168>



On Mon, 19 Feb 2007, Junio C Hamano wrote:
> 
> Hmm.  I am puzzled.  Are you suggesting to change behaviour of
> "git apply" with --index?

Yeah. Or at least _verify_ that the patch is within the subdirectory we 
are in right now. Right now, we do neither, and it will actually change 
files outside that subdirectory, which I think is a bit dangerous.

> git generated patch, or patches on the kernel list that are not
> generated with git are always relative to the top-level, so I
> think the current --index behaviour makes tons of sense.

I agree that it is sensible, but it's sensible only within the context of 
purely self-generated patches, where the patch itself was generated not 
just with git, but with that exact project.

Imagine somebody sending you a patch to a set of files, and they didn't 
use git to generate that patch. What would it look right? Right, it might 
well look like

	diff -u file.c.orig file.c
	--- file.c.orig
	+++ file.c
	@@ -29,6 +29,7 @@
	...

and it happens to be in some subdirectory. What would you do?

I'd use "git apply". And I would be really upset *if* git-apply actually 
applied the patch to some *other* subdirectory than the one I was in.

(Again, "Makefile" is a common case, since you often have it at multiple 
levels - maybe it would try to apply the changes to the top-level 
Makefile, even though I was in the drivers/usb/ subdirectory).

Now, I personally actually always work in the top-level directory, so I 
don't actually much care. I'm so used to editing the patches themselves 
that that is what I always end up doing, but I do believe that I'm odd in 
that. Few enough people have worked with unified diffs for over 15 years, 
and are perfectly happy to edit not just the headers, but the actual 
contents too, and fixing up the line numbers to make it all come out 
right. I do that regularly (not daily, but I probably do it almost once a 
month - I decide that I like somebody's patch and want to apply it, but 
fix up some whitespace issue in the patch where he had the opening brace 
of an "if"-statement on the wrong line etc).

So while I *personally* would probably never be impacted, just because I 
alway work in the top directory anyway, I do that partly exactly because 
I'm the top-level maintainer. Somebody who maintains drivers/usb/ might 
well get patches to a driver that only edits the xyzzy.c and xyzzy.h files 
within that subdirectory, and it really does make sense that he be able to 
do "git apply < patch" in that situation.

		Linus
