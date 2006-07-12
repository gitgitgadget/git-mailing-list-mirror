From: Shawn Pearce <spearce@spearce.org>
Subject: Error writing loose object on Cygwin
Date: Tue, 11 Jul 2006 23:57:46 -0400
Message-ID: <20060712035746.GA7863@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 12 05:57:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0VrH-00034o-AL
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 05:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWGLD5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 23:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWGLD5v
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 23:57:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:4590 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932362AbWGLD5u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 23:57:50 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G0Vqy-0003Ka-DE
	for git@vger.kernel.org; Tue, 11 Jul 2006 23:57:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B93E420E43C; Tue, 11 Jul 2006 23:57:46 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23758>

I've got a weird bug that a coworker just found today on Cygwin
running on XP.  He was trying to do `git add foo` in a brand new
repository which was stored on a Solaris server[*1*] and mounted
on his XP desktop by way of samba[*2*].

My coworker received the "unable to write sha1 filename %s:%s"
error in move_temp_to_file during git-add.  After sprinkling some
printfs all over that area of sha1_file.c I concluded that GIT was
receiving back EACCES as the error from the first link attempt in
link_temp_to_file (rather than ENOENT) when the parent directory
didn't exist.

Reproducing it on XP systems was easy, as was working around the
problem:

	mkdir foo
	cd foo
	git init-db
	echo foo>foo
	git add foo # dies with "unable to write sha1 filename"
	mkdir .git/objects/25
	git add foo # now succeeds without error

What's more interesting is Windows 2000 systems accessing the same
Solaris server and the same samba server with the same version of
Cygwin didn't have any problems (the first git add succeeded).

This was Cygwin 1.5.19-4 and 1.4.1.  The tiny patch below fixes
the issue for us, but certainly seems like not the best way to go
about this...  But right now I've got my coworkers running GIT 1.4.1
plus the patch below.

Has anyone else seen this type of behavior before?  Any suggestions
on debugging this issue?

Footnotes:
[*1*] Yes, this Solaris server is the same one that has the old
      compiler and almost no GNU tools, which means GIT, StGIT,
	  cogito and pg's higher level functions are all broken...

[*2*] Yes, Solaris is a real UNIX and the coworker should just use
      GIT there.  The problem is we have some GIT based scripts which
      mirror a version control tool that is only available through
	  a Java applet running in Internet Explorer on a Windows
	  system.  Which means although we can use GIT on Solaris
	  there are some operations that we need to execute on
	  Windows...

-->8--
Assume EACCES means ENOENT when creating sha1 objects.
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8179630..c04d6a5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1344,7 +1344,7 @@ static int link_temp_to_file(const char 
         * else succeeded.
         */
        ret = errno;
-       if (ret == ENOENT) {
+       if (ret == ENOENT || ret == EACCES) {
                char *dir = strrchr(filename, '/');
                if (dir) {
                        *dir = 0;
-- 
1.4.1
