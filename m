From: Junio C Hamano <junkio@cox.net>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Sat, 20 Jan 2007 11:24:54 -0800
Message-ID: <7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net>
References: <17842.1385.366750.915767@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 20:25:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Lpq-0008PZ-OM
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 20:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965351AbXATTY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 14:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965357AbXATTY4
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 14:24:56 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64058 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965351AbXATTY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 14:24:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120192455.WWKU29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sat, 20 Jan 2007 14:24:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DXRD1W0071kojtg0000000; Sat, 20 Jan 2007 14:25:13 -0500
To: Bill Lear <rael@zopyra.com>
In-Reply-To: <17842.1385.366750.915767@lisa.zopyra.com> (Bill Lear's message
	of "Sat, 20 Jan 2007 06:04:57 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37282>

Bill Lear <rael@zopyra.com> writes:

> % git push
> updating 'refs/heads/master'
>   from 6b421066e842203e383e1dc466c1cdef10de56b1
>   to   2a8e554ae0c99d44988690c9fce693b3f5f128fa
> Generating pack...
> Done counting 61 objects.
> Result has 32 objects.
> Deltifying 32 objects.
>  100% (32/32) done
> Writing 32 objects.
>  100% (32/32) done
> Total 32, written 32 (delta 18), reused 0 (delta 0)
> Unpacking 32 objects
> fatal: protocol error: bad line length character
>
> The notion of fatality led him to think, quite plausibly, that
> something very bad had happened with his push.  However, we can find
> no evidence that anything bad really did happen.

I've seen this "bad line length character" mentioned in #git and
on this list but nobody seems to have hunted down what this is.

	http://www.gelato.unsw.edu.au/archives/git/0603/17807.html

is another (Google finds some others for the error message on
xcb list but that is about fetch-pack which is totally different
codepath).

Your report and the above one both mention there was no harm,
which is somewhat of consolation but it definitely is not a good
sign.

I've tried to reproduce it, suspecting it could be some
interaction with hook scripts output, without success.

I've committed the following to 'master' so that when it
reproduces we could have a slightly better clue on what we are
getting instead of what we are expecting.

diff --git a/pkt-line.c b/pkt-line.c
index b4cb7e2..369eec9 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -81,13 +81,13 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 {
 	int n;
 	unsigned len;
-	char linelen[4];
+	unsigned char linelen[4];
 
-	safe_read(fd, linelen, 4);
+	safe_read(fd, (char *)linelen, 4);
 
 	len = 0;
 	for (n = 0; n < 4; n++) {
-		unsigned char c = linelen[n];
+		char c = linelen[n];
 		len <<= 4;
 		if (c >= '0' && c <= '9') {
 			len += c - '0';
@@ -101,7 +101,9 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 			len += c - 'A' + 10;
 			continue;
 		}
-		die("protocol error: bad line length character");
+		die("protocol error: bad line length character: "
+		    "%02x %02x %02x %02x",
+		    linelen[0], linelen[1], linelen[2], linelen[3]);
 	}
 	if (!len)
 		return 0;
