From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Default "tar" umask..
Date: Fri, 05 Jan 2007 23:30:22 +0100
Message-ID: <459ED17E.2080101@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0612301037570.4473@woody.osdl.org>	<7vfyaxjiaj.fsf@assigned-by-dhcp.cox.net>	<459EB78B.60000@lsrfire.ath.cx> <7vzm8xdw3t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 23:30:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2xa3-0000UE-9H
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 23:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbXAEWa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 17:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbXAEWa2
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 17:30:28 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:44533
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820AbXAEWa1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 17:30:27 -0500
Received: from [10.0.1.3] (p508E67CC.dip.t-dialin.net [80.142.103.204])
	by neapel230.server4you.de (Postfix) with ESMTP id 2624D10005;
	Fri,  5 Jan 2007 23:30:26 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzm8xdw3t.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36032>

[Junio: Sorry for resending, I somehow dropped the CC:'s the first time.]

Junio C Hamano schrieb:
>>> >>> Having said that, I do not see much reason for anybody to want to
>>> >>>  extract any material that is worth to be placed under version
>>> >>> control in a way that is world-writable, so I do not mind having
>>> >>> 002 as the default, but I feel that group-writability should be
>>> >>> kept under control of the umask of end users who know what they
>>> >>> are doing.
>> >> Yes, using 002 is tempting.  But it's got the same "looseness"
>> >> problems as 000, only on a smaller scaler: there are certainly
>> >> situations where a user doesn't want to share write permissions
>> >> with all the members of her current group.  If we change the
>> >> default, let's go all the way to 022.
> > 
> > I don't think the above argument makes much sense -- it does not 
> > explain why you do not go "all the way" to 077.

Well, what I had in mind were free software projects and simple users,
i.e. publicly hosted tar files and users that only download and extract
them, and then don't add confidential changes afterwards.  You're right,
of course: why stop there?  077 would be safest. :->

> > On the other hand, I can explain 002 fairly easily and consistently.
> > This matters only for users who can become root and does not know or
> > care about implied -p, and the group root belongs to had better not
> > contain any suspicious user, so leaving group open does not hurt.
> > 022 actively hurts sane usage (i.e. work always with a sane umask and
> > extract as non root users) while 002 does not.

Hm, right, I was not thinking straight -- I didn't see that the gid of
the extracted files will be set to 0 by tar (as specified in our tar
files).  Err, unless the target system has a group named git, which
would then be used instead.  Come to think of it, having this "git"
group name in there is a bit strange and unnecessary.  How about the
following patch?


In order to make the generated tar files more friendly to users who
extract them as root using GNU tar and its implied -p option, change
the default umask to 002 and change the owner name and group name to
root.  This ensures that a) the extracted files and directories are
not world-writable and b) that they belong to user and group root.

Before they would have been assigned to a user and/or group named
git if it existed.  This also answers the question in the removed
comment: uid=0, gid=0, uname=root, gname=root is exactly what we
want.

Normal users who let tar apply their umask while extracting are
only affected if their umask allowed the world to change their
files (e.g. a umask of zero).  This case is so unlikely and strange
that we don't need to support it.

Credit goes to Junio for finding the ideal default umask of 002
through sheer logic.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

---
 archive-tar.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index af47fdc..7d52a06 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -15,7 +15,7 @@ static char block[BLOCKSIZE];
 static unsigned long offset;
 
 static time_t archive_time;
-static int tar_umask;
+static int tar_umask = 002;
 static int verbose;
 
 /* writes out the whole block, but only if it is full */
@@ -210,11 +210,10 @@ static void write_entry(const unsigned char *sha1, struct strbuf *path,
 	sprintf(header.size, "%011lo", S_ISREG(mode) ? size : 0);
 	sprintf(header.mtime, "%011lo", archive_time);
 
-	/* XXX: should we provide more meaningful info here? */
 	sprintf(header.uid, "%07o", 0);
 	sprintf(header.gid, "%07o", 0);
-	strlcpy(header.uname, "git", sizeof(header.uname));
-	strlcpy(header.gname, "git", sizeof(header.gname));
+	strlcpy(header.uname, "root", sizeof(header.uname));
+	strlcpy(header.gname, "root", sizeof(header.gname));
 	sprintf(header.devmajor, "%07o", 0);
 	sprintf(header.devminor, "%07o", 0);
 
