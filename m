From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Shrink the git binary a bit by avoiding unnecessary inline
 functions
Date: Sun, 22 Jun 2008 15:40:30 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806221532560.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806221159140.2926@woody.linux-foundation.org> <vpqej6p9ko2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 23 00:42:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAYGg-0002c7-Th
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 00:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbYFVWlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 18:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbYFVWlO
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 18:41:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59501 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753733AbYFVWlN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jun 2008 18:41:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5MMeVQO010283
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jun 2008 15:40:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5MMeUJ7031368;
	Sun, 22 Jun 2008 15:40:31 -0700
In-Reply-To: <vpqej6p9ko2.fsf@bauges.imag.fr>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.346 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85812>



On Mon, 23 Jun 2008, Matthieu Moy wrote:
> 
> Wouldn't it be better to split that kind of function into two parts:
> 
> - inline the short common case
> - put the special case apart

It's almost certainly not worth it. These things really aren't big 
optimization wins, and the *big* wins from doing inlines are if it allows 
the call-site to do more optimizations (eg conditionals or calculations 
that just go away if inlined with constant arguments, for example), or if 
the lack of any function call at all allows the caller to do better 
register allocation around it.

Since these inlines contain a real call regardless, the second case never 
happens.

The first case can happen with things like "strlen()" being optimized away 
for constant-sized arguments, but for the one user where that was 
(xstrdup()) it really wasn't an issue. And while a constant size argument 
to "xmalloc()" is not unlikely, and would allow the compiler to optimize 
the

	if (!ret && !size)
		ret = malloc(1);

away statically as an inline, it's really not a big win.

		Linus
