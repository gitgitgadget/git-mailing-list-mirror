From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] minor: wrong handling of GIT_AUTHOR_DATE
Date: Sat, 16 Aug 2008 21:37:05 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808162128400.3324@nehalem.linux-foundation.org>
References: <20080816205325.GD10729@mrq1.org> <alpine.LFD.1.10.0808161543160.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808161613520.3324@nehalem.linux-foundation.org> <7vr68obbpd.fsf@gitster.siamese.dyndns.org> <7vk5egbaft.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808162054050.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Hermann Gausterer <git-mailinglist@mrq1.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 06:38:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUa1z-0002la-5Y
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 06:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbYHQEhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 00:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbYHQEhP
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 00:37:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57739 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750941AbYHQEhN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2008 00:37:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7H4b6gj018806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 16 Aug 2008 21:37:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7H4b5dM020150;
	Sat, 16 Aug 2008 21:37:06 -0700
In-Reply-To: <alpine.LFD.1.10.0808162054050.3324@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.924 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92572>



On Sat, 16 Aug 2008, Linus Torvalds wrote:
> 
> The rules are:
> 
>  - valid days of month/mday are always single or double digits.
> 
>  - valid years are either two or four digits
> 
>    No, we don't support the year 600 _anyway_, since our encoding is based 
>    on the UNIX epoch, and the day we worry about the year 10,000 is far 
>    away and we can raise the limit to five digits when we get closer.
> 
>  - Other numbers (eg "600 days ago") can have any number of digits, but 
>    they cannot start with a zero. Again, the only exception is for 
>    two-digit numbers, since that is fairly common for dates ("Dec 01" is 
>    not unheard of)
> 
> So that means that any milli- or micro-second would be thrown out just 
> because the number of digits shows that it cannot be an interesting date.

I should explain that nonsensical statement a bit.

A milli- or micro-second can obviously be a perfectly fine number 
according to the rules above, as long as it doesn't start with a '0'. So 
if we have

	12:34:56.123

then that '123' gets parsed as a number, and we remember it. But because 
it's bigger than 31, we'll never use it as such _unless_ there is 
something after it to trigger that use.

So you can say "12:34:56.123.days.ago", and because of the "days", that 
123 will actually be meaninful now.

But the problem with "12.34.56.001" was that we used to remember the "001" 
as a number, and because we could see no other use for it we then assumed 
that it meant the day of the month.

Of course, we *should* do that only if we have seen a month-name too, but 
we don't currently track that, so.. Adding that as a further sanity test 
would be good, but it would require us to have some extra "flags" field. 
Maybe we should have a

	#define SEEN_MONTH	1
	#define SEEN_YEAR	2
	#define SEEN_DAY	4
	#define SEEN_TIME	8
	...

	struct extended_tm {
		unsigned long seen;
		unsigned long number;
		struct tm tm;
	}

and pass *that* around instead of passing "struct tm *" and "unsigned long 
*num" around. That would be good. Then we could do

	if (tm->number && tm->number < 32 &&
	    (tm->seen & SEEN_MONTH) && !(tm->seen & SEEN_DAY))
		tm->tm.tm_mday = tm->number;

there instead, which would protect us from other numbers just being seen 
as days instead.

Anybody? I'm not going to bother.

			Linus
