From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Mon, 17 Dec 2007 16:05:49 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712171558350.21557@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com> <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712111146200.25032@woody.linux-foundation.org> <20071212075725.GA7676@coredump.intra.peff.net> <20071217232450.GA13012@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Dec 18 01:07:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Pz7-00022W-86
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 01:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757658AbXLRAGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 19:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758638AbXLRAGe
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 19:06:34 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42439 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757985AbXLRAGd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 19:06:33 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBI05oL2008860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Dec 2007 16:05:51 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBI05nY1009285;
	Mon, 17 Dec 2007 16:05:49 -0800
In-Reply-To: <20071217232450.GA13012@efreet.light.src>
X-Spam-Status: No, hits=-2.714 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68667>



On Tue, 18 Dec 2007, Jan Hudec wrote:
> On Tue, Dec 11, 2007 at 11:50:08AM -0800, Linus Torvalds wrote:
> > And, btw: the diff is totally different from the xdelta we have, so even 
> > if we have an already prepared nice xdelta between the two versions, we'll 
> > end up re-generating the files in full, and then do a diff on the end 
> > result.
> 
> The problem is whether git does not end-up re-generating the same file
> multiple times. When it needs to construct the diff between two versions of
> a file and one is delta-base (even indirect) of the other, does it know to
> create the first, remember it, continue to the other and calculate the diff?

Yes.

Actually, it doesn't "know" anything at all - what happens is that git 
internally has a simple "delta-cache", which just caches the latest 
objects we've generated from deltas, and which automatically handles this 
common case (and others).

So when we tend to work with multiple versions of the same file (which is 
obviously very common with diff, and even more so with something like 
"annotate"), those multiple versions will obviously also tend to be deltas 
against each other and/or against some shared base object, and when we see 
a delta, we'll look the base object up in the delta cache, and if it has 
been generated earlier we'll be able to short-circuit the whole delta 
chain and just use the whole object we already cached.

So if you compare two objects that each have a very deep delta chain, you 
will obviously have to walk the whole delta chain _once_ (to generate 
whichever version of the file you happen to look up first), but you won't 
need to do it twice, because the second time you'll end up hitting in the 
delta cache.

			Linus
