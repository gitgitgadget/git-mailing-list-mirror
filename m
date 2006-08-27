From: Junio C Hamano <junkio@cox.net>
Subject: Re: Relative timestamps in git log
Date: Sat, 26 Aug 2006 18:22:44 -0700
Message-ID: <7vodu7yntn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0608261537120.11811@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 03:22:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH9MG-0000zv-OX
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 03:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWH0BWX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 21:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWH0BWX
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 21:22:23 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:449 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750805AbWH0BWW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 21:22:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827012221.OTNO21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sat, 26 Aug 2006 21:22:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id EpNJ1V00K4Noztg0000000
	Sat, 26 Aug 2006 21:22:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608261537120.11811@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 26 Aug 2006 15:45:26 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26078>

Linus Torvalds <torvalds@osdl.org> writes:

> The exact cut-off points when it switches from days to weeks etc are 
> totally arbitrary, but are picked somewhat to avoid the "1 weeks ago" 
> thing (by making it show "10 days ago" rather than "1 week", or "70 
> minutes ago" rather than "1 hour ago").

It might be arbitrary but I agree they make sense.  

The code was quite confusing in that after you turn it into days
you stop converting to larger scale and I was going to nitpick
that 365 weeks do not make much sense.  I think you meant to do
a "Turn it into weeks" conversion before comparing diff with 53
and then changed your mind, got confused yourself that diff is
still in days and decided to say "months" for the past year.

IOW, I think there is a bug around weeks/months code ;-).  On
top of your patch how about the attached?

Personally I have mixed feeling about "months" scale.  On one
hand, I think it could extend to 30 months or so without losing
readability when one is interested in "how long ago did this
happen".  On the other hand, it would take more time for me if I
see "this happened 5 months ago" than "this happened in March
this year" to recollect what the context of the particular
change was ("ah I needed that feature when I was preparing the
committer/author graph for OLS paper deadline").

P.S. welcome back to the list.

diff --git a/date.c b/date.c
index 92e3f6e..914fd82 100644
--- a/date.c
+++ b/date.c
@@ -87,17 +87,19 @@ const char *show_date(unsigned long time
 			snprintf(timebuf, sizeof(timebuf), "%lu hours ago", diff);
 			return timebuf;
 		}
-		/* Turn it into days */
+		/* Turn it into days; from here on we deal with days */
 		diff = (diff + 12) / 24;
 		if (diff < 14) {
 			snprintf(timebuf, sizeof(timebuf), "%lu days ago", diff);
 			return timebuf;
 		}
-		if (diff < 53) {
+		/* Say weeks for the past 6 months or so */
+		if (diff < 180) {
 			snprintf(timebuf, sizeof(timebuf), "%lu weeks ago", (diff + 3) / 7);
 			return timebuf;
 		}
-		if (diff < 365) {
+		/* Say months for the past 30 months or so */
+		if (diff < 912) {
 			snprintf(timebuf, sizeof(timebuf), "%lu months ago", (diff + 15) / 30);
 			return timebuf;
 		}
