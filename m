From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] fast-import producing very deep tree deltas
Date: Mon, 12 Nov 2007 12:26:45 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711121221040.3062@woody.linux-foundation.org>
References: <20071112110354.GP6212@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:27:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrfsQ-0006jI-4m
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 21:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbXKLU1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 15:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757909AbXKLU1F
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 15:27:05 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50887 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757524AbXKLU1D (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 15:27:03 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lACKQjHx023389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Nov 2007 12:26:46 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lACKQjqr007480;
	Mon, 12 Nov 2007 12:26:45 -0800
In-Reply-To: <20071112110354.GP6212@lavos.net>
X-Spam-Status: No, hits=-3.234 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64699>



On Mon, 12 Nov 2007, Brian Downing wrote:
> 
>     depths: count 135970 total 120567366 min 0 max 6035 mean 886.72 median 3 std_dev 1653.48
> 
> Needless to say the pack that resulted was just about useless.  Trying to
> repack it resulted in the "counting objects" phase running at about five
> objects per second.

Hmm. Quick hack: increase the delta cache window. The reason (I think) why 
performance turns glacial with really deep delta chains is that it turns 
into an O(n^2) thing when you don't hit in the delta cache, and your delta 
depth is so deep that following a *single* delta chain will flush the 
cache.

So I bet that making the delta cache bigger will "fix" it. You probably 
don't have to make it 6000+ entries, but with the *median* being that 
deep, making it 2k entries should improve it for most cases.

Obviously fastimport should be fixed to not do those insanely deep chains 
too, but it might be a good idea to at least make the delta cache a bit 
bigger by default, and perhaps have some config option for setting it.

		Linus
