From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] faster inexact rename handling
Date: Tue, 30 Oct 2007 08:38:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710300818390.30120@woody.linux-foundation.org>
References: <20071030042118.GA14729@sigill.intra.peff.net>
 <alpine.LFD.0.999.0710292156580.30120@woody.linux-foundation.org>
 <20071030134355.GA21342@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Andy C <andychup@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 16:44:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImtGl-00053T-1m
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 16:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742AbXJ3Poc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 11:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753639AbXJ3Poc
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 11:44:32 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57236 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756538AbXJ3Pob (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 11:44:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UFcPu5019349
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Oct 2007 08:38:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UFcPZ9014442;
	Tue, 30 Oct 2007 08:38:25 -0700
In-Reply-To: <20071030134355.GA21342@coredump.intra.peff.net>
X-Spam-Status: No, hits=-3.233 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 30 Oct 2007, Jeff King wrote:
>
> On Mon, Oct 29, 2007 at 10:06:11PM -0700, Linus Torvalds wrote:
> 
> > Have you compared the results? IOW, does it find the *same* renames?
> 
> From my limited testing, it generally finds the same pairs. However,
> there are a number of renames that it _doesn't_ find, because they are
> composed of "uninteresting" lines, dropping them below the minimum
> score. Try (in git.git):
> 
>   git-show --raw -M -l0 :/'Big tool rename'
> 
> with the old and new code. Pairs like Documentation/git-add-script.txt
> -> Documentation/git-add.txt are not found, because the file is composed
> almost entirely of boilerplate.

Ok, that does imply to me that we cannot just drop boilerplate text, 
because the fact is, lots of files contain boilerplate, but people still 
think they are "similar".

We do actually depend on the similarity analysis being "good" - because it 
matters a lot for things like merging. The old code was actually very 
careful indeed, and while it didn't care about things like the exact 
*ordering* of lines (ie moving functions around in the same file resulted 
in the *exact* same fingerprint for the file!) it cared about everything 
else.

> Moving the size normalization into the similarity engine should probably
> fix that, and will let us compare old and new results more accurately.
> I'll try to work on that.

Hmm. I hope that is sufficient. But I suspect it may well not be. 
Especially since you ignore boiler-plate lines for *some* files but not 
others (ie it depends on which file you happen to find it in first).

			Linus
