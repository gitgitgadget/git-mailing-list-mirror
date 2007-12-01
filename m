From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Some git performance measurements..
Date: Sat, 1 Dec 2007 09:19:26 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712010843520.8458@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org> <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org> <85abou8x5n.fsf@lupus.ig3.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Joachim B Haga <cjhaga@fys.uio.no>
X-From: git-owner@vger.kernel.org Sat Dec 01 18:20:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyW0h-0005Bg-0A
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 18:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbXLARTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 12:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbXLARTu
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 12:19:50 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48061 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751791AbXLARTt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Dec 2007 12:19:49 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB1HJRpN023396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 1 Dec 2007 09:19:32 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB1HJQr7032404;
	Sat, 1 Dec 2007 09:19:27 -0800
In-Reply-To: <85abou8x5n.fsf@lupus.ig3.net>
X-Spam-Status: No, hits=-2.728 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66727>



On Sat, 1 Dec 2007, Joachim B Haga wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > The pack-files (both index and data) are accessed somewhat randomly, but 
> > there is still enough locality that doing read-ahead and clustering really 
> > does help.
> 
> They are dense enough that slurping them in whole is 20% faster, at 
> least here. And much less noisy! These are both cache-cold tests.

With BK, I used to have a "readahead" script to something close to this.

The problem with that approach is that it works wonderfully well for 
people who (a) have tons of memory and (b) really only care about the 
source tree and almost nothing else, but it doesn't work that well at all 
for others.

So yes, for me, forcing a page-in of all the data is actually worth it. I 
commonly do something like

	git grep quieuiueriueirue &

on my main machine when I reboot it for testing - just to bring in the 
working tree into cache, so that subsequent "git diff" and "git grep" 
operations will be faster.

> $ time git read-tree -m -u HEAD HEAD
> 
> real    0m9.255s
> user    0m0.832s
> sys     0m0.196s
> 
> $ time (cat .git/objects/pack/* .git/index >/dev/null; git read-tree -m -u HEAD HEAD)
> 
> real    0m7.141s
> user    0m0.936s
> sys     0m1.912s
> 
> Now, I don't know how useful this is since git doesn't know if the
> data are cached. Is it perhaps possible to give a hint to the
> readahead logic that it should try to read as far as possible?

You have a much faster disk drive than I do on that slow laptop that I 
wanted to optimize for.

I get

	[torvalds@hp linux]$ time git read-tree -m -u HEAD HEAD
	real    0m12.849s
	user    0m0.232s
	sys     0m0.124s

for the cold-cache case, but then for populating the whole thing:

	time cat .git/objects/pack/* .git/index >/dev/null
	real    0m31.350s
	user    0m0.040s
	sys     0m0.468s

whoops. Can you say "pitiful"?

(In contrast, my desktop does the same it in seven seconds - laptop disks 
really are *much* slower than a reasonable desktop one).

		Linus
