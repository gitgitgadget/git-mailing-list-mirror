From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Error writing loose object on Cygwin
Date: Wed, 12 Jul 2006 01:00:16 -0400
Message-ID: <20060712050016.GA8002@spearce.org>
References: <20060712035746.GA7863@spearce.org> <7vr70r1ms5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607112132540.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 07:00:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Wpo-0001m4-1R
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 07:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWGLFAY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 01:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWGLFAY
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 01:00:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53382 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932213AbWGLFAX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 01:00:23 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G0Wpf-0006m6-1j; Wed, 12 Jul 2006 01:00:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D46C920E43C; Wed, 12 Jul 2006 01:00:16 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607112132540.5623@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23763>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Tue, 11 Jul 2006, Junio C Hamano wrote:
> 
> > Shawn Pearce <spearce@spearce.org> writes:
> > 
> > > Has anyone else seen this type of behavior before?  Any suggestions
> > > on debugging this issue?
> > 
> > I would suggest raising this (politely) to Cygwin people.
> 
> Well, since it apparently works with W2000, and breaks with XP, I suspect 
> it's actually Windows that just returns the wrong error code.
> 
> It's entirely possible that we should just make that whole
> 
> 	if (ret == ENOENT)
> 
> go away. Yes, it's the right error code if a subdirectory is missing, and 
> yes, POSIX requires it, and yes, WXP is probably just a horrible piece of 
> sh*t, but on the other hand, I don't think git really has any serious 
> reason to even care. 
> 
> So we might as well say that if the link() fails for _any_ reason, we'll 
> try to see if doing the mkdir() and re-trying the link helps.


Hmm.  Its a single mkdir call before we give up and tell the user
something is wrong.  The following change appears to work OK here on
a reasonably POSIX compliant system (OK meaning it reports errors reasonably).

Given that this type of error (failed link) shouldn't happen
that often, except for on Coda or FAT (according to a comment in
move_temp_to_file), I guess the change is OK and comes with little
penalty.  But for Coda and FAT users things are going to slow down a
little bit as we try mkdir for every new loose object being created
before we try rename.

Tomorrow when I get access to my Cygwin system again I'll try to
write up a tiny test case which shows the error behavior we are
seeing and send it to the Cygwin mailing list, as this really does
seem to be a Cygwin or Windows issue.  But of course having GIT
handle this case slightly better wouldn't be bad either.  :-)


diff --git a/sha1_file.c b/sha1_file.c
index 8734d50..db4bddc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1336,26 +1336,23 @@ static int link_temp_to_file(const char 
 		return 0;
 
 	/*
-	 * Try to mkdir the last path component if that failed
-	 * with an ENOENT.
+	 * Try to mkdir the last path component if that failed.
 	 *
 	 * Re-try the "link()" regardless of whether the mkdir
 	 * succeeds, since a race might mean that somebody
 	 * else succeeded.
 	 */
 	ret = errno;
-	if (ret == ENOENT) {
-		char *dir = strrchr(filename, '/');
-		if (dir) {
-			*dir = 0;
-			mkdir(filename, 0777);
-			if (adjust_shared_perm(filename))
-				return -2;
-			*dir = '/';
-			if (!link(tmpfile, filename))
-				return 0;
-			ret = errno;
-		}
+	char *dir = strrchr(filename, '/');
+	if (dir) {
+		*dir = 0;
+		mkdir(filename, 0777);
+		if (adjust_shared_perm(filename))
+			return -2;
+		*dir = '/';
+		if (!link(tmpfile, filename))
+			return 0;
+		ret = errno;
 	}
 	return ret;
 }
