From: Arnout Engelen <arnouten@bzzt.net>
Subject: Re: [PATCH] Improved error messages when temporary file creation
	fails
Date: Tue, 7 Dec 2010 22:20:41 +0100
Message-ID: <20101207212041.GG25767@bzzt.net>
References: <20101207181633.GF25767@bzzt.net> <7v62v5paj2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 22:20:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4xx-0005og-55
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 22:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317Ab0LGVUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 16:20:47 -0500
Received: from smtp-1.concepts.nl ([213.197.30.124]:57643 "EHLO
	smtp-1.concepts.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab0LGVUq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 16:20:46 -0500
Received: from 5ee5397b.ftth.concepts.nl
	([94.229.57.123] helo=mail.bzzt.net ident=Debian-exim)
	by smtp-1.concepts.nl with esmtp (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1PQ4xl-0007Ln-Aw; Tue, 07 Dec 2010 22:20:41 +0100
Received: from arnouten by localhost with local (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1PQ4xm-0006do-05; Tue, 07 Dec 2010 22:20:42 +0100
Content-Disposition: inline
In-Reply-To: <7v62v5paj2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: arnouten@bzzt.net
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-Concepts-MailScanner-Information: Please contact abuse@concepts.nl for more information
X-Concepts-MailScanner-ID: 1PQ4xl-0007Ln-Aw
X-Concepts-MailScanner: Found to be clean
X-Concepts-MailScanner-SpamCheck: 
X-Concepts-MailScanner-From: arnouten@bzzt.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163138>

Thanks to you and Jonathan again for the feedback.

On Tue, Dec 07, 2010 at 12:56:17PM -0800, Junio C Hamano wrote:
> > +	char origtemplate[255];
> > +	strlcpy(origtemplate, template, 255);
> 
> Why "255"?

Random - 'i had to choose something'.

> It may happen to be sufficiently large for the current callers, but what
> provisions if any are made to help the compiler or the runtime protect us
> from new and broken callers?  Use of strlcpy() there hides the issue from
> the runtime by avoiding segfault, but it actively harms us by making the
> code silently behave incorrectly without segfaulting, no?

Only in a small way: when a bigger template is encountered and the mkstemp 
call succeeds, there is no problem. Only when xmkstemp fails *and* clears the
template, the diagnostic error message shows a truncated version of the 
original.

I *could* dynamically allocate space for the original template string, but that
would mean I'd need to do a malloc() instead of putting the buffer on the stack
like this, and free() it afterwards. I'm not too concerned about the 
performance hit here (presumably the I/O that comes with creating and using 
the temporary file here is orders of magnitude slower than that malloc() 
anyway), but it would also make the code a bit less easy to read.

What do you think would be preferable here, a simple fixed-length buffer on the
stack that might cause a truncated error message or a dynamically-allocated 
one that makes the code somewhat more complicated?

> > +++ b/wrapper.h
> 
> Somewhat questionable...

Agreed, this whole file is unneeded and, well, wrong anyway. 

I'll remove wrapper.h and apply Jonathan's improvements some time this week, 
unless of course someone beats me to it :). 


Kind regards,

Arnout
