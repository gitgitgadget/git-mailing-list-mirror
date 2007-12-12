From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 18:10:19 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111806320.25032@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com> <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org> <7vprxcdhis.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0712111523210.25032@woody.linux-foundation.org> <alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>
 <Pine.LNX.4.64.0712111611570.1671@alien.or.mcafeemobile.com> <alpine.LFD.0.9999.0712111648180.25032@woody.linux-foundation.org> <Pine.LNX.4.64.0712111653520.1671@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 03:11:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2H4D-0003UO-Jh
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 03:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854AbXLLCK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 21:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbXLLCK7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 21:10:59 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42718 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752173AbXLLCK6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 21:10:58 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBC2AKQd011077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 18:10:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBC2AJJ3020330;
	Tue, 11 Dec 2007 18:10:19 -0800
In-Reply-To: <Pine.LNX.4.64.0712111653520.1671@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67983>



On Tue, 11 Dec 2007, Davide Libenzi wrote:
>
> > That's not the problem. The problem with xdl_trim_ends() is that it 
> > happens *after* you have done all the hashing, so as an optimization it's 
> > fairly useless, because it still leaves the real cost (the per-line 
> > hashing) on the table.
> 
> Careful. The real cost of diffing, is not the O(1) pass of the prepare 
> phase. It's the potentially O(N*M) worst case of the cross-record compare. 
> So that optimization is far from useless. That optimization is indeed 
> mainly targeted to avoid such worst case.

I'm not saying it's useless. I'm saying it's ineffective.

My simple patch that you saw, speeded up a real-life case by A FACTOR OF 
THREE. We're not talking small potatoes here.

> Also, you'd need some code at the end that hands you back at least the N 
> lines you want for context.

Sure. The special case I added it to specifically wanted a context of zero 
in the caller, so I could just ignore that.

But doing this in general and handing back the context is a simple matter 
of

	while (size < orig && context_lines) {
		if (src->buffer[size++] == '\n')
			context_lines--;
	}

which will usually hit in a really short time (ie three lines by default, 
just a few tens of bytes).
			
		Linus
