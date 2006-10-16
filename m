From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 11:51:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610161130090.3962@g5.osdl.org>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> <87mz7wp6ek.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
 <87ejt8p5l9.fsf@rho.meyering.net> <Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610161109430.7697@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jim Meyering <jim@meyering.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 20:52:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZXYy-0006fl-Rv
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 20:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422809AbWJPSvq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 14:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422813AbWJPSvp
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 14:51:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422809AbWJPSvp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 14:51:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9GIpIaX014647
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Oct 2006 11:51:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9GIpIIq023588;
	Mon, 16 Oct 2006 11:51:18 -0700
To: Junio C Hamano <junkio@cox.net>,
	Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0610161109430.7697@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=-3.471 required=5 tests=AWL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28985>


Junio, I think this is worthy to go in before a 1.4.3 release. Possibly 
even back-ported to earlier trees. Anything that causes an almost two 
orders of magnitude slowdown (even if it's just on 64-bit architectures 
and most people won't necessarily compile git that way) is worth fixing 
pronto.

On Mon, 16 Oct 2006, Davide Libenzi wrote:
> 
> Yeah, using an appropriate golden ratio prime for 64 bits fixes it. I 
> think it's the best/minimal fix (use 0x9e37fffffffc0001UL, like the 
> kernel does).

Ok. But then you need something like the appended to avoid warnings..

(This is the only nice portable way to figure out at compile-time whether 
"unsigned long" is more than 32 bits that I can come up with: everything 
that uses actual C expressions ends up warning about integers not fitting 
etc)

Quite frankly, I prefer my previous patch more, it just avoids that whole 
problem, and two shifts and adds (even with a conditional) are often 
faster than a full 64-bit multiply.

		Linus
---
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 4c2fde8..38f8f93 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -23,8 +23,13 @@
 #if !defined(XMACROS_H)
 #define XMACROS_H
 
+#include <limits.h>
 
+#if LONG_MAX > 2147483647ul
+#define GR_PRIME 0x9e37fffffffc0001UL
+#else
 #define GR_PRIME 0x9e370001UL
+#endif
 
 
 #define XDL_MIN(a, b) ((a) < (b) ? (a): (b))
