From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH 1/7] cleanups: Fix resource leak and buffer overrun in daemon.c
Date: Tue, 18 Apr 2006 08:11:06 -0500
Message-ID: <20060418131106.GD7562@sergelap.austin.ibm.com>
References: <20060417145148.2F3CB19C90D@sergelap.hallyn.com> <20060417151447.D4FE619B90E@sergelap.hallyn.com> <7vu08rkhey.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 15:11:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVpz9-0008Je-Hn
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 15:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWDRNLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 09:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWDRNLJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 09:11:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:65252 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750863AbWDRNLH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 09:11:07 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3IDB7nS017702
	for <git@vger.kernel.org>; Tue, 18 Apr 2006 09:11:07 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3ID7TMS261494
	for <git@vger.kernel.org>; Tue, 18 Apr 2006 07:07:29 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3IDB7DQ012683
	for <git@vger.kernel.org>; Tue, 18 Apr 2006 07:11:07 -0600
Received: from sergelap.hallyn.com (sig-9-76-29-193.mts.ibm.com [9.76.29.193])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k3IDB6Fc012630;
	Tue, 18 Apr 2006 07:11:06 -0600
Received: by sergelap.hallyn.com (Postfix, from userid 1007)
	id 3B18C19B910; Tue, 18 Apr 2006 08:11:06 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu08rkhey.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18852>

Quoting Junio C Hamano (junkio@cox.net):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > Address two reports from an automatic code analyzer:
> >
> > 1. In logreport, it is possible to write \0 one
> > character past the end of buf[].
> 
> I am perhaps slower than I usually am today, but it seems to me
> that the code caps msglen to (maxlen-1) and then adds that to
> buflen.
> 
> Now, maxlen is (sizeof(buf)-buflen-1), so that means after
> the "buflen += msglen" happens, buflen is at most:
> 
> 	buflen + (sizeof(buf)-buflen-1) - 1
>         = sizeof(buf) - 2
> 
> And then "buf[buflen++] = '\n'; buf[buflen] = '\0'" happens.
> '\n' is written at sizeof(buf)-2 (or lower index than that) and
> '\0' is written at sizeof(buf)-1 (or lower).  I am unsure how it
> steps beyond the end...

Argh, I had to pull out a sheet of paper, but you are right.  I
misread, and the warning must be about the case where the
snprint "[%ld] " prints out 1023 characters.

> > 2. In socksetup, socklist can be leaked when returning
> > if set_reuse_addr().  Note: dunno why this case returns...
> 
> I am not sure why this part returns either.  It appears to me
> that it should just keep going just like the cases where
> bind/listen fails.

Then perhaps the following is more appropriate.

thanks,
-serge

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH] socksetup: don't return on set_reuse_addr() error

The set_reuse_addr() error case was the only error case in
socklist() where we returned rather than continued.  Not sure
why.  Either we must free the socklist, or continue.  This patch
continues on error.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 daemon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

b589029e3187eed51c3fe6a2715f51bea2159786
diff --git a/daemon.c b/daemon.c
index a1ccda3..776749e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -535,7 +535,7 @@ static int socksetup(int port, int **soc
 
 		if (set_reuse_addr(sockfd)) {
 			close(sockfd);
-			return 0;	/* not fatal */
+			continue;
 		}
 
 		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
-- 
1.2.5
