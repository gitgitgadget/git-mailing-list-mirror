From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Date parsing
Date: Sat, 21 Jun 2008 15:28:56 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806211507370.2926@woody.linux-foundation.org>
References: <bd6139dc0806100758xb41d08dh18e3051088b707e5@mail.gmail.com> <Zx2uvEYSssjj9E0HrmUL8wYASyWX9L9w8LkR-gGRAmnD9isjoEeyKg@cipher.nrlssc.navy.mil> <bd6139dc0806100831y7a00a0f4sbc8dee9df7a8c16a@mail.gmail.com> <alpine.LFD.1.10.0806100942500.3101@woody.linux-foundation.org>
 <20080621215240.GD15111@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jun 22 00:30:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KABbR-0007Z1-Km
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 00:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbYFUW3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 18:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbYFUW3m
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 18:29:42 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52673 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751097AbYFUW3m (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jun 2008 18:29:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5LMSvph003752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jun 2008 15:28:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5LMSu9S014416;
	Sat, 21 Jun 2008 15:28:56 -0700
In-Reply-To: <20080621215240.GD15111@leksak.fem-net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.346 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85735>



On Sat, 21 Jun 2008, Stephan Beyer wrote:
> 
> Today I've been playing around with approxidate(), too, and I think I
> found some bug in date parsing. I let copy&paste speak...
> 
> Correct:
> 
> $ ./test-date "2008-07-01 23:59:59 +0200"
> 2008-07-01 23:59:59 +0200 -> 1214949599 +0200 -> Tue Jul  1 23:59:59 2008
> 2008-07-01 23:59:59 +0200 -> Tue Jul  1 23:59:59 2008
> 
> And even:
> 
> $ ./test-date "2008-07-01 24:00:00 +0200"
> 2008-07-01 24:00:00 +0200 -> 1214949600 +0200 -> Wed Jul  2 00:00:00 2008
> 2008-07-01 24:00:00 +0200 -> Wed Jul  2 00:00:00 2008
> 
> But then there's a jump in time:
> 
> $ ./test-date "2008-07-02 00:00:00 +0200"
> 2008-07-02 00:00:00 +0200 -> 1202335200 +0200 -> Wed Feb  6 23:00:00 2008
> 2008-07-02 00:00:00 +0200 -> Wed Feb  6 23:00:00 2008

Heh.

What you're seeing is that approxidate() does not like dates in the 
future. You're hitting this case:

                /* Be it commit time or author time, it does not make
                 * sense to specify timestamp way into the future.  Make
                 * sure it is not later than ten days from now...
                 */
                if (now + 10*24*3600 < specified)
                        return 0;

so approxidate() refuses to think that "2008-07-02" is a valid date in 
July, because it is more than ten days in the future. So it decides that 
if somebody tried to feed it a date like that, it must be the seventh of 
February instead of July.

So the refusal to look at future dates is part of trying to disambiguate 
the "dd.mm" form from the "mm.dd" form, where it will decide that if it's 
far in the future (where "far" is 10 days), it cannot be right.

Remember: the git date handling was _not_ meant to be a generic date 
library. It is very much meant to be a *git* date library. This is why you 
can say things like "7 days ago", and it will return something sane, but 
if you say "7 days from now", it will still think you're talking about 
seven days ago - it simply doesn't have the concept of "future date".

That said, I think that in this case the thing just doesn't make sense. 
For the specific case of iso time format, we perhaps shouldn't even try to 
refuse future dates. Does anybody use the insane yyyy-dd-mm format? 

To avoid the future check, you could try something like the appended.

Of course, the whole parser was really designed to parse email dates from 
the beginning, and rfc2822 actually ends up being totally unambiguous and 
also won't ever hit the "refuse future" case.

So I was wrong. Rather than using the European ISO format (yyyy-mm-dd), 
the really safest format is the "English month name spelled out" format, 
ie

	./test-date "12 Jul 2010"

parses correctly, but

	./test-date 2010-07-12

does not, because the latter is found suspect due to being in the future.

		Linus

---
 date.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/date.c b/date.c
index 1a4eb87..870419a 100644
--- a/date.c
+++ b/date.c
@@ -374,7 +374,7 @@ static int match_multi_number(unsigned long num, char c, const char *date, char
 
 		if (num > 70) {
 			/* yyyy-mm-dd? */
-			if (is_date(num, num2, num3, refuse_future, now, tm))
+			if (is_date(num, num2, num3, NULL, now, tm))
 				break;
 			/* yyyy-dd-mm? */
 			if (is_date(num, num3, num2, refuse_future, now, tm))
