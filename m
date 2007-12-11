From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git blame with valgrind massif
Date: Tue, 11 Dec 2007 13:22:53 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111315060.25032@woody.linux-foundation.org>
References: <9e4733910712111257h20a4a916gd4747e816e4706ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 22:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2CZz-00045v-2z
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXLKVX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbXLKVX3
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:23:29 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38252 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750912AbXLKVX2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 16:23:28 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBLMsZr029231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 13:22:55 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBLMse1009537;
	Tue, 11 Dec 2007 13:22:54 -0800
In-Reply-To: <9e4733910712111257h20a4a916gd4747e816e4706ff@mail.gmail.com>
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67947>



On Tue, 11 Dec 2007, Jon Smirl wrote:
> 
> How do you interpret the massif output?

Not very easy, since massif will tell you what *allocated* it, but then 
trying to see who was supposed to free it is another issue altogether.

I also find the textual output to be very confusing. But what massif is 
really good at is to look at the memory usage over time in the postscript 
file it generates, and that gives you a much better feel for what 
particular allocation is a problem.

In this case, it's patch_delta that generates all the memory usage (well, 
98% of it ;^), but that's not that helpful unless you know git internals, 
and realize that with deep delta chains, that only means that the memory 
is kept around just for random object data. The question is why that 
object data stays around and isn't free'd.

There's two answers to that:
 - the non-buggy use of the object data in the delta base cache (limited 
   by the delta_base_cache_limit, which defaults to 16MB, although you can 
   tweak it with core.deltabasecachelimit)
 - the (possibly buggy) callers that keep the data.

See my previous email with a patch to "git blame" to make it release the 
object data. That should fix it, I think.

		Linus
