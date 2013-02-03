From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/3] combine-diff: suppress a clang warning
Date: Sun, 3 Feb 2013 20:31:50 +0000
Message-ID: <20130203203150.GU1342@serenity.lan>
References: <cover.1359901732.git.john@keeping.me.uk>
 <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
 <7vwqup890o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 21:32:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U26Ef-0004mn-9K
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 21:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab3BCUb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 15:31:59 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:33993 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab3BCUb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 15:31:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id C59D86064E2;
	Sun,  3 Feb 2013 20:31:57 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MRYOSnU3VlKZ; Sun,  3 Feb 2013 20:31:57 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 260B06064D4;
	Sun,  3 Feb 2013 20:31:52 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vwqup890o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215332>

On Sun, Feb 03, 2013 at 11:58:15AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > When compiling combine-diff.c, clang 3.2 says:
> >
> >     combine-diff.c:1006:19: warning: adding 'int' to a string does not
> > 	    append to the string [-Wstring-plus-int]
> > 		prefix = COLONS + offset;
> > 			 ~~~~~~~^~~~~~~~
> >     combine-diff.c:1006:19: note: use array indexing to silence this warning
> > 		prefix = COLONS + offset;
> > 				^
> > 			 &      [       ]
> >
> > Suppress this by making the suggested change.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> 
> This was not lost in the noise.
> 
> I thought that this wasn't a serious patch, but your attempt to
> demonstrate to others why patches trying to squelch clang warnings
> are not necessarily a good thing to do.
>
> Who is that compiler trying to help with such a warning message?
> After all, we are writing in C, and clang is supposed to be a C
> compiler.  And adding integer to a pointer to (const) char is a
> straight-forward way to look at the trailing part of a given string.

A quick search turned up the original thread where this feature was
added to Clang [1].  It seems that it does find genuine bugs where
people try to log values by doing:

    log("failed to handle error: " + errno);

[1] http://thread.gmane.org/gmane.comp.compilers.clang.scm/47203

> > -		prefix = COLONS + offset;
> > +		prefix = &COLONS[offset];
> 
> In other words, both are perfectly valid C.  Why should we make it
> less readable to avoid a stupid compiler warning?

Are you happy to change COLONS to a const char[] instead of a #define?
That also suppresses the warning.

Since Git is warning-free on GCC and so close to being warning-free on
recent Clang I think it is worthwhile to fix the remaining two issues
which do seem to be intentional diagnostics rather than Clang bugs.


John
