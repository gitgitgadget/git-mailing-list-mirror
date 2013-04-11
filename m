From: Jeff King <peff@peff.net>
Subject: Re: trouble on windows network share
Date: Thu, 11 Apr 2013 00:56:46 -0400
Message-ID: <20130411045646.GB27795@sigill.intra.peff.net>
References: <871B6C10EBEFE342A772D1159D1320853F63D205@umechphj.easf.csd.disa.mil>
 <20130404155112.GA11622@sigill.intra.peff.net>
 <871B6C10EBEFE342A772D1159D1320853F63DA3D@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Thu Apr 11 06:56:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ9ZC-0007gS-TO
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 06:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493Ab3DKE4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 00:56:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39705 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759Ab3DKE4x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 00:56:53 -0400
Received: (qmail 11730 invoked by uid 107); 11 Apr 2013 04:58:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 00:58:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 00:56:46 -0400
Content-Disposition: inline
In-Reply-To: <871B6C10EBEFE342A772D1159D1320853F63DA3D@umechphj.easf.csd.disa.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220819>

On Fri, Apr 05, 2013 at 12:44:48PM +0000, Pyeron, Jason J CTR (US) wrote:

> [strace attachment has been removed, email being resent]

I had trouble finding anything interesting in either this, or in the
full strace you sent me off-list, mostly because the syscalls are
foreign to me (I had hoped to see an strace of the actual Unix-level
syscalls, but I guess that is not how cygwin's strace works).

What I really wanted to see was the result of the open, fstat, and mmap
calls. The patch below adds some debugging statements that might help.

> It looks like there is a race condition going on, especially since the
> location and message changes.

If it's a race condition between the write and the subsequent read in
the same process, then it would be solved by looking at the object
later. Does "git cat-file -p 6838761d549cf76033d2e9faf5954e62839eb25d"
work, or is the object forever inaccessible?

---
diff --git a/sha1_file.c b/sha1_file.c
index 0ed2398..d40dd9f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1331,6 +1331,9 @@ void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 	int fd;
 
 	fd = open_sha1_file(sha1);
+	if (fd < 0)
+		error("unable to open sha1 file for %s: %s",
+		      sha1_to_hex(sha1), strerror(errno));
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
@@ -1343,7 +1346,13 @@ void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 				return NULL;
 			}
 			map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
+			if (!map)
+				error("unable to mmap %s: %s",
+				      sha1_to_hex(sha1), strerror(errno));
 		}
+		else
+			error("unable to fstat %s: %s", sha1_to_hex(sha1),
+			      strerror(errno));
 		close(fd);
 	}
 	return map;
