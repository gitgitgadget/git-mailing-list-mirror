From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Something weird is happening...
Date: Thu, 29 Jan 2009 15:21:55 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901291512260.3054@localhost.localdomain>
References: <49814BA4.6030705@zytor.com> <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org> <49822944.8000103@zytor.com> <20090129223529.GB1465@elte.hu> <20090129224357.GA18471@elte.hu> <498231EA.3030801@zytor.com> <7vvdrxd8jz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 00:23:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSgEn-0000pc-J1
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 00:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759022AbZA2XWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 18:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758757AbZA2XWe
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 18:22:34 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38708 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758453AbZA2XWc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jan 2009 18:22:32 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0TNLuNi019527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Jan 2009 15:21:57 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0TNLtBZ008057;
	Thu, 29 Jan 2009 15:21:55 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vvdrxd8jz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107751>



On Thu, 29 Jan 2009, Junio C Hamano wrote:
> 
> I am not sure how old this bug is (nor if I can make Linus admit it is
> even a bug---I suspect the code that is involved in this did not change
> that much over time).

I'll happily admit that it's a bug.

I think our "fsck" logic kind of sucks - the default version really skips 
too damn much in the name of being fast and only look at loose objects, 
and --full is _so_ anal that it's silly and overkill for almost 
everything.

We probably should have a middle ground (that should be the default), 
which does at least somewhat proper reachability analysis, checks 
alternates, and make the current "only check local loose objects" be an 
option like "git fsck --loose" (or "--local").

Out current "git fsck --full" is even mis-documented. The built-in help 
says that it means "also consider alternate objects", but that's just a 
small part of what it does. It _also_ verifies the pack-files, and that's 
actually the really expensive part.

So "check_full" turns on _everything_, but some things that it turns on 
should be turned on already by default (the "alternates" directory check), 
while other parts of --full are just too expensive to ever be default (the 
pack-file check).

			Linus
