From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 13:06:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603251256330.15714@g5.osdl.org>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
 <118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com>
 <Pine.LNX.4.64.0603250734130.15714@g5.osdl.org> <Pine.LNX.4.64.0603250742340.15714@g5.osdl.org>
 <7vslp6uvn1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 22:07:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNFyY-00069k-Gw
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 22:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWCYVGv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 16:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWCYVGv
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 16:06:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751474AbWCYVGt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 16:06:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2PL6jDZ030404
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Mar 2006 13:06:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2PL6iRn012208;
	Sat, 25 Mar 2006 13:06:44 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslp6uvn1.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17999>



On Sat, 25 Mar 2006, Junio C Hamano wrote:
> 
> This is a replacement for my previous one, which reduces the
> changes to the testsuite.

Btw, your comment about the GNU diff @@-line simplification made me look 
at that again.

git-apply used to believe that a simplified line (ie with a single value) 
meant "x,x". While it seems that it really means "x,1".

Now, at worst, this would probably mean that some patches would get 
rejected (rather than mis-applied), so I think we've just never hit it. 
Also, with the default 3-line context I think that it simply _cannot_ be 
hit (since the only way that the result or source would have only one line 
in the resulting is it was the first line).

But if the "x" shorthand really means "x,1" (and I think you're right - 
using "-U 1" I can get that kind of shorthand) then apply.c should be 
fixed as follows (actual patch: removal of two characters).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/apply.c b/apply.c
index 2da225a..e80cd15 100644
--- a/apply.c
+++ b/apply.c
@@ -693,7 +693,7 @@ static int parse_range(const char *line,
 	line += digits;
 	len -= digits;
 
-	*p2 = *p1;
+	*p2 = 1;
 	if (*line == ',') {
 		digits = parse_num(line+1, p2);
 		if (!digits)
