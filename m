From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't fflush(stdout) when it's not helpful
Date: Fri, 29 Jun 2007 19:15:35 -0700
Message-ID: <7vlke2dw6w.fsf@assigned-by-dhcp.pobox.com>
References: <20070626171127.GA28810@thunk.org>
	<alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org>
	<20070628190406.GC29279@thunk.org>
	<20070628213451.GB22455@coredump.intra.peff.net>
	<20070628235319.GD29279@thunk.org>
	<20070629010507.GL12721@planck.djpig.de>
	<20070629034838.GF29279@thunk.org>
	<20070629063819.GA23138@coredump.intra.peff.net>
	<7vmyyjgrxk.fsf@assigned-by-dhcp.pobox.com>
	<alpine.LFD.0.98.0706290851480.8675@woody.linux-foundation.org>
	<20070629174046.GC16268@thunk.org>
	<alpine.LFD.0.98.0706291641590.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Jeff King <peff@peff.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jun 30 04:15:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4SUt-0000kX-DA
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 04:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbXF3CPh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 22:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbXF3CPh
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 22:15:37 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:61111 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbXF3CPg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 22:15:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630021535.RDCH1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Jun 2007 22:15:35 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HeFb1X0011kojtg0000000; Fri, 29 Jun 2007 22:15:35 -0400
In-Reply-To: <alpine.LFD.0.98.0706291641590.8675@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 29 Jun 2007 16:43:14 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51187>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 29 Jun 2007, Theodore Tso wrote:
>> 
>> Comments?
>
> Looks ok to me. 
>
> This should probably be paired up with the change to git.c (in "next") to 
> do the "fflush()" before the "ferror()" too, in case the error is pending.

Do you mean this part?

+	/* Somebody closed stdout? */
+	if (fstat(fileno(stdout), &st))
+		return 0;
+	/* Ignore write errors for pipes and sockets.. */
+	if (S_ISFIFO(st.st_mode) || S_ISSOCK(st.st_mode))
+		return 0;
+
+	/* Check for ENOSPC and EIO errors.. */
+	if (ferror(stdout))
+		die("write failure on standard output");
+	if (fflush(stdout) || fclose(stdout))
+		die("write failure on standard output: %s", strerror(errno));
+
+	return 0;
+}

I was planning to push this out to 'master' this weekend.
