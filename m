From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make Git accept absolute path names for files within
 the work tree
Date: Tue, 4 Dec 2007 14:52:15 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712041444090.13796@woody.linux-foundation.org>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com> <20071204014326.GA21358@coredump.intra.peff.net> <Pine.LNX.4.64.0712040216220.27959@racer.site> <200712040742.24728.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0712041149440.27959@racer.site>
 <alpine.LFD.0.9999.0712040756370.2981@woody.linux-foundation.org> <20071204220840.GA3340@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 04 23:59:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzgjM-0007Jc-7a
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 23:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbXLDW6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 17:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbXLDW6o
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 17:58:44 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43193 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751063AbXLDW6o (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2007 17:58:44 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB4MqGTh007531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Dec 2007 14:52:17 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB4MqFqH009683;
	Tue, 4 Dec 2007 14:52:15 -0800
In-Reply-To: <20071204220840.GA3340@coredump.intra.peff.net>
X-Spam-Status: No, hits=-4.727 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67097>



On Tue, 4 Dec 2007, Jeff King wrote:
> 
> It is more expensive, though we will be doing it once per user-supplied
> pathspec, so I don't know that it will actually have an impact.

Well, I'm more worried about just bugs, actually.

Doing this right is actually rather hard. For example, our current 
"make_absolute_path()" is simply not very good, and it's almost impossible 
to *make* it very good.

Why? It relies on being able to get the current cwd, which isn't always 
even possible on all systems. What about unreadable directories? What 
about just so *deep* directories, that the cwd doesn't fit in the 1kB 
allocated for it? Both do happen (people use executable but non-readable 
directories for security sometimes). I'm also almost certain that you can 
confuse it by renaming directories while that thing is running, etc etc.

IOW, that whole thing is simply a bug waiting to happen. The fact that it 
apparently *always* runs whether needed or not just seems to make it worse 
(ie if we already know our cwd, and the absolute path we have already has 
that as a prefix, just strip it off, don't try to do anything complex, and 
leave the complex and fragile cases for the odd-ball when the simple 
approach doesn't work)

			Linus
