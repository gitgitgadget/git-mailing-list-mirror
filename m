From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't fflush(stdout) when it's not helpful
Date: Fri, 29 Jun 2007 09:06:22 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706290851480.8675@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org>
 <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org>
 <alpine.LFD.0.98.0706251607000.8675@woody.linux-foundation.org>
 <20070626171127.GA28810@thunk.org> <alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org>
 <20070628190406.GC29279@thunk.org> <20070628213451.GB22455@coredump.intra.peff.net>
 <20070628235319.GD29279@thunk.org> <20070629010507.GL12721@planck.djpig.de>
 <20070629034838.GF29279@thunk.org> <20070629063819.GA23138@coredump.intra.peff.net>
 <7vmyyjgrxk.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Theodore Tso <tytso@mit.edu>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 18:06:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Izp-0003Eg-8M
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 18:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759437AbXF2QGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 12:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759086AbXF2QGy
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 12:06:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52232 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758756AbXF2QGx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jun 2007 12:06:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5TG6TCw001529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Jun 2007 09:06:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5TG6Mgo010005;
	Fri, 29 Jun 2007 09:06:23 -0700
In-Reply-To: <7vmyyjgrxk.fsf@assigned-by-dhcp.pobox.com>
X-Spam-Status: No, hits=-4.623 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51179>



On Fri, 29 Jun 2007, Junio C Hamano wrote:
> 
> Thanks for bringing it up, as I had the same "Huh?" moment.
> I would probably call that simply "do_not_flush".  Or name the
> variable "flush_stdout" and swap all the logic.

I think that patch looks fine, but I also think that there is a more 
fundamental problem with this approach:

 - all these patches basically break the whole _point_ of Jim's original 
   reason for wanting this!

So remember, we had two different reasons for flushing:

 - interactivity over a pipe. 

   Tools like "gitk" and "git gui blame" all run waiting for input, and we 
   want to give them the commit data as soon as possible.

 - error checking on a filesystem.

   Yes, "ferror()" _after_ the write shows an error happened, but doesn't 
   show what error it was. Doing a fflush() is a lot more likely to 
   actually give the right errors.

So non-files want flushing due to latency issues, and files want flushing 
due to error handling. And the patch under discussion basically broke the 
error handling.

(It turns out that it doesn't break it for the trivial "/dev/full" 
testcase, since that doesn't show up as a file, but it would break it for 
the *real* case of a filesystem that becomes full).

One option is to change the git.c thing to do

	if (fflush(stdout))
		die("write failure on standard output: %s", strerror(errno));
	if (ferror(stdout))
		die("unknown write failure on standard output");
	if (fclose(stdout))
		die("close failure on standard output: %s", strerror(errno));

where the "fflush()" is done first (regardless of ferror), just in the 
(probably futile) hope of getting the right errno.

		Linus
