From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] minor: wrong handling of GIT_AUTHOR_DATE
Date: Sat, 16 Aug 2008 20:50:45 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808162040160.3324@nehalem.linux-foundation.org>
References: <20080816205325.GD10729@mrq1.org> <alpine.LFD.1.10.0808161543160.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808161613520.3324@nehalem.linux-foundation.org> <7vr68obbpd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Hermann Gausterer <git-mailinglist@mrq1.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 05:52:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUZJa-0003zG-Py
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 05:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbYHQDvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 23:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbYHQDvX
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 23:51:23 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37963 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445AbYHQDvX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Aug 2008 23:51:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7H3okRr016667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 16 Aug 2008 20:50:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7H3ojbh018656;
	Sat, 16 Aug 2008 20:50:46 -0700
In-Reply-To: <7vr68obbpd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.924 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92567>



On Sat, 16 Aug 2008, Junio C Hamano wrote:
> 
> People who followed that advice would have gotten used to this already, e.g.
> 
>    $ git reflog delete master@{07.04.2005.15:15:00.-0700}
> 
> should not be broken.

Hmm. Fair enough. In that case, just the "nodate()" approach is probably 
fine on its own. HOWEVER:

> I think your first hunk needs to distinguish between "very-long-precision
> posint" (in which case we ignore because it is likely to be nanoseconds
> fraction) and others.

Well, that ignores nanosecond resolution seconds, but not microseconds, 
for example. Now, microseconds normally don't matter (because they won't 
trigger the 'seconds-since-epoch' case), but they _can_ trigger some other 
cases.

For example, let's assume that we have microseconds in the date specifier. 
Then try this one:

	./test-date "12:12:12.000001"

Notice what happens? Oops.

With my patch, you get

	12:12:12.0000001 -> Sat Aug 16 12:12:12 2008

and with your, you get

	12:12:12.000001 -> Fri Aug  1 12:12:12 2008

and yeah, it's odd, but I can explain it.

But you are definitely right about the case of doing

	"15:15:00.-0700"

and yes, my patch was crap too. 

			Linus
