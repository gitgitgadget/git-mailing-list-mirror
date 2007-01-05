From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Default "tar" umask..
Date: Fri, 05 Jan 2007 21:39:39 +0100
Message-ID: <459EB78B.60000@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0612301037570.4473@woody.osdl.org> <7vfyaxjiaj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 21:39:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2vqy-0004E5-AQ
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 21:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbXAEUjt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 5 Jan 2007 15:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbXAEUjt
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 15:39:49 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:49625
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750728AbXAEUjs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 15:39:48 -0500
Received: from [10.0.1.3] (p508E67CC.dip.t-dialin.net [80.142.103.204])
	by neapel230.server4you.de (Postfix) with ESMTP id B6A4C1D007;
	Fri,  5 Jan 2007 21:39:46 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyaxjiaj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36019>

Junio C Hamano schrieb:
> Linus Torvalds <torvalds@osdl.org> writes:
>=20
>> We just had a posting on the kernel security list where a person
>> was upset that the 2.6.19.1 and .2 tar-files were apparently group
>> and world-writable.
>=20
> I had an impression that this is only an issue when you untar as=20
> root, and running 'tar xf' as root _is_ a more serious security issue
> than whatever permission the tar archive itself records.

While I agree, I also detect a theory-practice-mismatch.  Users,
operating as root, can (and apparently often do) download a tar file
released by a free software project and untar it with the implied -p
option *without* getting hurt.  Most of the time they simply trust
the file contents (who checks all source files after download?), so
why shouldn't they trust the file permissions, too?

So while it's not the smartest thing to do, it clearly is happening.
And perhaps we should not be the ones trying to educate the users of
software made by _our_ users on the safety of tar by defaulting to loos=
e
permissions.

Let's be "safe by default", even if that particular definition of "safe=
"
means "a bit safer, but only if the untarring is done in a very unsafe
way". ;-)

> Having said that, I do not see much reason for anybody to want to
> extract any material that is worth to be placed under version control
> in a way that is world-writable, so I do not mind having 002 as the
> default, but I feel that group-writability should be kept under
> control of the umask of end users who know what they are doing.

Yes, using 002 is tempting.  But it's got the same "looseness" problems
as 000, only on a smaller scaler: there are certainly situations where =
a
user doesn't want to share write permissions with all the members of he=
r
current group.  If we change the default, let's go all the way to 022.

> Historically we used to have 022 as the default, and IIRC we loosened
> it exactly because some people hated that we created files and
> directories closed to group members.

The situation has changed a bit in that we don't need to find one mask
that fits all users -- we only need to find a default value for the
config option tar.umask now.  If a project is unhappy with that value,
it can easily change it back to zero or to a different value.

Admittedly, that doesn't help users who download from a "022" project,
but really want something looser.  I think it's more important to
avoid violating the expectations of all those who freak out at 0666
permission modes attached to their freshly downloaded files, though.

Trivial patch follows.

Ren=E9


diff --git a/archive-tar.c b/archive-tar.c
index af47fdc..ae84bcb 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -15,7 +15,7 @@ static char block[BLOCKSIZE];
 static unsigned long offset;
=20
 static time_t archive_time;
-static int tar_umask;
+static int tar_umask =3D 0022;
 static int verbose;
=20
 /* writes out the whole block, but only if it is full */
