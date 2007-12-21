From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 2.6.24-rc6
Date: Thu, 20 Dec 2007 21:21:40 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712202110350.21557@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0712201731010.21557@woody.linux-foundation.org> <20071221024805.GB8535@fattire.cabal.ca> <20071221030152.GC8535@fattire.cabal.ca> <alpine.LFD.0.9999.0712201937470.21557@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712202009290.21557@woody.linux-foundation.org> <alpine.LFD.0.9999.0712202054350.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 06:22:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5aKz-0003mm-Rn
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 06:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbXLUFVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 00:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbXLUFVt
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 00:21:49 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53560 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750942AbXLUFVs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2007 00:21:48 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBL5LfrD008092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Dec 2007 21:21:42 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBL5Leda031278;
	Thu, 20 Dec 2007 21:21:40 -0800
In-Reply-To: <alpine.LFD.0.9999.0712202054350.21557@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.712 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69042>



On Thu, 20 Dec 2007, Linus Torvalds wrote:
> 
> Not that it matters in real life, since nobody uses -U0, and "git blame" 
> won't care. But let's get it right anyway ;)

.. and here's a test-case to see the *impact* of this whole issue:

	yes | head -1000 > a
	yes | head -2000 > b
	git diff -U0 a b | grep @@
	diff -U0 a b | grep @@

and notice the differences.

Both will add a thousand lines of "y", but the "git diff" will add it at a 
different point, ie git says:

	@@ -488,0 +489,1000 @@ y

while a non-tail-optimizing diff will say

	@@ -1000,0 +1001,1000 @@

which may be a bit more obvious.

Both answers are *correct*, though. The particular choice of "insert at 
line 489, after line 488" is a bit odd, but is because we don't actually 
search to exactly the beginning of where the differences started, we 
search in blocks of 1kB and then we go forward to the next newline.

(We could also go to exactly where the differences started, and if the 
previous character was a newline or the beginning of the file, we'd not 
move forward at all, and then we'd get a more "logical" diff of inserting 
at the beginning).

Considering that the answer is correct, and this only happens for insane 
cases anyway, I don't really think anybody cares, but it's an interesting 
case nonetheless.

			Linus
