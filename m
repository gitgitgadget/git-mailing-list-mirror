From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Wed, 24 Jan 2007 11:21:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701241108370.3606@woody.linux-foundation.org>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <eovccc$usc$1@sea.gmane.org>
 <Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17846.20498.635623.173653@lisa.zopyra.com>
 <Pine.LNX.4.64.0701231157430.32200@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mark Nudelman <markn@greenwoodsoftware.com>,
	Bill Lear <rael@zopyra.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 24 20:22:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9nhv-0000GI-JZ
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 20:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbXAXTWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 14:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbXAXTWw
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 14:22:52 -0500
Received: from smtp.osdl.org ([65.172.181.24]:52518 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbXAXTWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 14:22:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0OJLCpa021907
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 Jan 2007 11:21:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0OJLAtj025465;
	Wed, 24 Jan 2007 11:21:11 -0800
In-Reply-To: <Pine.LNX.4.64.0701231157430.32200@woody.linux-foundation.org>
X-Spam-Status: No, hits=-4.133 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.171 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37666>



On Tue, 23 Jan 2007, Linus Torvalds wrote:
> 
> I think "less" is actually seriously buggy with -F.
> 
> There are two bugs:
> 
>  - it will always screw up the screen and move to the end. It does this 
>    even if you use -FX which should disable any init sequences, so it's 
>    not about that problem.
> 
>  - if you resize the terminal while less is waiting for input, less
>    will exit entirely without even showing the output. This is very
>    noticeable if you do something like "git diff" on a big and cold-cache 
>    tree and git takes a few seconds to think, and then you resize the 
>    window while it's preparing. Boom. No output AT ALL.

Heh. This extremely hacky patch works around the second bug.

It does so by simply adding a "select()" on the input before even starting 
"less", which will mean that by the time less starts, it always has 
something to read, and that in turn hides the bug with resizing the 
terminal window while less is waiting for input.

I'm sure there's still a window for the bug to trigger, but I can no 
longer trivially reproduce the problem any more.

(The way to reproduce the problem is to do some pager operation that takes 
a while in git, and resizing the window while git is thinking about the 
output. I use

	git diff --stat v2.6.12..

in the kernel tree to do something where it takes a while for git to start 
outputting information)

Without this patch, I can easily just resize the window while git is 
thinking, and the end result is that "less" will exit early and indeed 
leave the tty in a broken state with no echo etc. With this patch, less 
doesn't get confused.

NOTE! To see this problem, you must use the LESS environment that git 
provides by default (LESS=FRSX) and not have your own environment set that 
overrides the git ones (or if you do, it must have -F set).

Is it ugly? Yes. Does it work? Yes. Do we want to apply it? You decide.

		Linus

---
diff --git a/pager.c b/pager.c
index 4587fbb..5f280ab 100644
--- a/pager.c
+++ b/pager.c
@@ -1,5 +1,7 @@
 #include "cache.h"
 
+#include <sys/select.h>
+
 /*
  * This is split up from the rest of git so that we might do
  * something different on Windows, for example.
@@ -7,6 +9,16 @@
 
 static void run_pager(const char *pager)
 {
+	/*
+	 * Work around bug in "less" by not starting it until we
+	 * have real input
+	 */
+	fd_set in;
+
+	FD_ZERO(&in);
+	FD_SET(0, &in);
+	select(1, &in, NULL, &in, NULL);
+
 	execlp(pager, pager, NULL);
 	execl("/bin/sh", "sh", "-c", pager, NULL);
 }
