From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 10:48:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603251040190.15714@g5.osdl.org>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
 <118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com>
 <Pine.LNX.4.64.0603250734130.15714@g5.osdl.org> <Pine.LNX.4.64.0603250742340.15714@g5.osdl.org>
 <Pine.LNX.4.64.0603251009500.11968@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 19:49:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNDoa-0005fl-NN
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 19:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWCYSsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 13:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWCYSsL
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 13:48:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28853 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932226AbWCYSsK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 13:48:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2PIm4DZ025024
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Mar 2006 10:48:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2PIm39K008560;
	Sat, 25 Mar 2006 10:48:03 -0800
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0603251009500.11968@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17992>



On Sat, 25 Mar 2006, Davide Libenzi wrote:
>
> I also have to teach libxdiff patch algo to recognize the tag and do the
> right thing during the patch operation.

Btw, git-apply does it, and it's actually quite simple: the code to handle 
the "\ No newline" case is literally just this:

                /*
                 * "plen" is how much of the line we should use for 
                 * the actual patch data. Normally we just remove the
                 * first character on the line, but if the line is
                 * followed by "\ No newline", then we also remove the
                 * last one (which is the newline, of course).
                 */
                plen = len-1;
                if (len < size && patch[len] == '\\')
                        plen--;

if we just remove the last '\n' on a line, if the _next_ line starts with 
a '\\' (so the git-apply code actually depends on knowing that the patch 
text is dense, and that it's also padded out so that you can look one byte 
past the end of the diff and it won't be a '\\').

I don't know how well that fits into xpatch (I never looked at the patch 
side, since I already had my own ;), but my point being that handling this 
special case _can_ be very simple if the data structures are just set up 
for it.

It's also important to realize that (a) you can't actually check the "No 
newline" string, because that depends on your locale and (b) it's not 
necessarily at the _end_ of the patch, because you can have a patch that 
looks like

	-	next-to-last-line
	-	last-line
	\ No newline at end of file
	+	new-end-of-file
	+	new-last-line
	\ No newline at end of file

ie the first "\ No newline" is in the middle, because it relates to the 
last removed line (while the second one obviously relates to the last 
added one).

The xdiff patch I sent out automatically does that when generating these 
things, of course.

			Linus
