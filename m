From: "John J. Franey" <jjfraney@gmail.com>
Subject: [JGIT PATCH] On error in DirCache.lock, do not leave the index
	locked.
Date: Sat, 16 Aug 2008 17:36:27 -0400
Message-ID: <1218922587.30527.2.camel@isidore.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 16 23:37:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUTSm-0003xV-98
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 23:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbYHPVg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 17:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbYHPVg3
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 17:36:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:49092 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbYHPVg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 17:36:28 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1577331wri.5
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=LYaiSDwmvO2A5PVc/SFug8oHcayFhdYQ8v73jSxVjic=;
        b=a3A8u2LrK9yafAtdPQieflZEJUYTGYLC47WA64UlyxajUiz9uqR19nUQ2HnL0qqRFc
         UYHkLmCYYUVqvUFjSLyLpD1E0w6l5StoKvfS0vnS4OZfx1bz1mJmZzsHcFYJKkXBrK2i
         MH9l0PMk/zbKBqrOIvtXUsWd4atcRONuiYnHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=LGFVEcrVPVfQ4xCX8YFFUt2BsemXEaM68J82LiOsbcPTJ8WOFOBNiS/4262dyfygBO
         +moeyHLXqhByOUfc1kVsMaiE8P96SxTMkAzeExnkHMUVQRYynfL2/OmRsPSN0pbC8Pml
         poBBJB2gKuGXN9kZxv2I4aO0H3qY47KWmDg28=
Received: by 10.90.80.19 with SMTP id d19mr5771140agb.73.1218922587876;
        Sat, 16 Aug 2008 14:36:27 -0700 (PDT)
Received: from ?192.168.2.101? ( [70.21.159.80])
        by mx.google.com with ESMTPS id 36sm1870049aga.10.2008.08.16.14.36.26
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Aug 2008 14:36:26 -0700 (PDT)
X-Mailer: Evolution 2.22.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92558>

After using C git on the same repository, the jgit cache read
threw an EOFException, and left the index lock file.
The repository is still valid according to C git, but
unreachable by C git because it honors the lock file
left behind by jgit.

Signed-off-by: John J. Franey <jjfraney@gmail.com>
---
 retry: My first email for this had mail header in mail body - sorry.

 Hi, hope this helps.

 The reason for the EOFException is beyond me right now.  It
 reported "Short read of block."  However, I'm pretty sure
 leaving the lock file in place is an error.

 Regards,
 John

 .../src/org/spearce/jgit/dircache/DirCache.java    |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index 280149a..c52d98b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -158,7 +158,8 @@ public static DirCache read(final Repository db)
 	 * <p>
 	 * The new index will be locked and then read before it is returned to the
 	 * caller. Read failures are reported as exceptions and therefore prevent
-	 * the method from returning a partially populated index.
+	 * the method from returning a partially populated index.  On read failure,
+	 * the lock is released.
 	 *
 	 * @param indexLocation
 	 *            location of the index file on disk.
@@ -176,7 +177,20 @@ public static DirCache lock(final File indexLocation)
 		final DirCache c = new DirCache(indexLocation);
 		if (!c.lock())
 			throw new IOException("Cannot lock " + indexLocation);
-		c.read();
+		
+		try {
+			c.read();
+		} catch(IOException e) {
+			c.unlock();
+			throw e;
+		} catch(RuntimeException e) {
+			c.unlock();
+			throw e;
+		} catch(Error e) {
+			c.unlock();
+			throw e;
+		}
+		
 		return c;
 	}
 
-- 
1.6.0.rc1.71.gfba5
