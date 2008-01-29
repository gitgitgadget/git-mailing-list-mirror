From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-revert is a memory hog
Date: Wed, 30 Jan 2008 09:49:44 +1100 (EST)
Message-ID: <alpine.LFD.1.00.0801300945310.3378@www.l.google.com>
References: <20080127172748.GD2558@does.not.exist> <20080128055933.GA13521@coredump.intra.peff.net> <alpine.LFD.1.00.0801300844170.28476@www.l.google.com> <20080129222007.GA3985@coredump.intra.peff.net> <7vfxwgmf87.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Adrian Bunk <bunk@kernel.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:52:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJzIz-0004mg-21
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 23:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776AbYA2WvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 17:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755758AbYA2WvG
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 17:51:06 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56950 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755823AbYA2WvE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2008 17:51:04 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0TMnlJc018679
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jan 2008 14:49:50 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0TMniga008387;
	Tue, 29 Jan 2008 14:49:45 -0800
X-X-Sender: torvalds@www.l.google.com
In-Reply-To: <7vfxwgmf87.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72010>



On Tue, 29 Jan 2008, Junio C Hamano wrote:
> 
> I wonder if the second one for the overflow avoidance should be
> using || instead of &&, though.

No, we want to be able to handle the case where there is (for example) 
just one removed file, but lots of new ones. That's not expensive at all. 
So we don't want to require that *both* the counts for removed and new 
files are low, we really want to check that we don't have too many 
combinations together.

But  the

        if (rename_limit <= 0 || rename_limit > 32767)
                rename_limit = 32767;

which is there purely to avoid overflow in 32-bit multiplication should 
probably be changed to be more reasonable. We'll never want to try to do a 
matrix that is really 32k * 32k in size, even if we can calculate its size 
;)

So maybe we should just make that hard limit more reasonable. 100x100 was 
too small, but a 1000x1000 matrix might be acceptable.

Or, better yet (which was what I was hoping for originally), we'd just 
make the inexact rename detection be linear-size/time rather than O(m*n). 
But those patches never really came together, so we do need to limit it 
more aggressively.

		Linus
