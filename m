From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/7] cleanups: Fix resource leak and buffer overrun in daemon.c
Date: Mon, 17 Apr 2006 14:42:45 -0700
Message-ID: <7vu08rkhey.fsf@assigned-by-dhcp.cox.net>
References: <20060417145148.2F3CB19C90D@sergelap.hallyn.com>
	<20060417151447.D4FE619B90E@sergelap.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 23:42:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVbUg-0004R2-G0
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 23:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWDQVmr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 17:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWDQVmr
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 17:42:47 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:54240 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751327AbWDQVmr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 17:42:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060417214245.NQIS8660.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Apr 2006 17:42:45 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18839>

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Address two reports from an automatic code analyzer:
>
> 1. In logreport, it is possible to write \0 one
> character past the end of buf[].

I am perhaps slower than I usually am today, but it seems to me
that the code caps msglen to (maxlen-1) and then adds that to
buflen.

Now, maxlen is (sizeof(buf)-buflen-1), so that means after
the "buflen += msglen" happens, buflen is at most:

	buflen + (sizeof(buf)-buflen-1) - 1
        = sizeof(buf) - 2

And then "buf[buflen++] = '\n'; buf[buflen] = '\0'" happens.
'\n' is written at sizeof(buf)-2 (or lower index than that) and
'\0' is written at sizeof(buf)-1 (or lower).  I am unsure how it
steps beyond the end...

> 2. In socksetup, socklist can be leaked when returning
> if set_reuse_addr().  Note: dunno why this case returns...

I am not sure why this part returns either.  It appears to me
that it should just keep going just like the cases where
bind/listen fails.
