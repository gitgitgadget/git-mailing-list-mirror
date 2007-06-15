From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-pack SIGSEGV..
Date: Thu, 14 Jun 2007 23:01:52 -0700
Message-ID: <7vr6od92nj.fsf@assigned-by-dhcp.pobox.com>
References: <alpine.LFD.0.98.0706142124380.14121@woody.linux-foundation.org>
	<7vvedp935y.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 08:02:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz4sg-0007eG-9d
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 08:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbXFOGB5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 02:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbXFOGB4
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 02:01:56 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:35009 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbXFOGB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 02:01:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070615060155.OPBE4247.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 Jun 2007 02:01:55 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Bi1s1X00H1kojtg0000000; Fri, 15 Jun 2007 02:01:53 -0400
In-Reply-To: <7vvedp935y.fsf@assigned-by-dhcp.pobox.com> (Junio C. Hamano's
	message of "Thu, 14 Jun 2007 22:50:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50245>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> I *suspect* it's due to the refspec pattern matching changes Daniel did, 
>> but again - I haven't actually debugged it any deeper.
>
> I am officially recuperating from an operation I had today, so I
> cannot really take a deep look at this.
>
> I think what is going wrong is that struct refspec for pattern
> match that is parsed by parse_ref_spec does not have ->dst
> component filled for "refs/tags/*" refspec, but match_refs()
> does not check if pat->dst is NULL, in which case it should
> reuse pat->src value.
>
> Incidentally I have other remote.c fixes queued in 'next'.  I
> haven't yet checked if I (accidentally) fixed this already.

Completely untested, but this may fix it.

I suspect this has an side effect of allowing

	fetch = refs/heads/*

to mean the same thing as

	fetch = refs/heads/*:refs/heads/*

which is suitable for a bare mirroring repository, but I do not
think of any downside, so it might be Ok.

But that is something from a person who was under anesthesia a
few hours ago, so you should take it with a big grain of salt ;-)

---

 remote.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index ed62a62..356e6bc 100644
--- a/remote.c
+++ b/remote.c
@@ -252,6 +252,8 @@ static struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
 			ep = gp;
 		}
 		rs[i].src = xstrndup(sp, ep - sp);
+		if (rs[i].pattern && !rs[i].dst)
+			rs[i].dst = xstrdup(rs[i].src);
 	}
 	return rs;
 }
