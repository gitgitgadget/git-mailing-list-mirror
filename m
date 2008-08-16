From: "John J. Franey" <jjfraney@gmail.com>
Subject: [JGIT PATCH] On error in DirCache.lock, do not leave the index
	locked.
Date: Sat, 16 Aug 2008 16:29:05 -0400
Message-ID: <1218918545.27000.22.camel@isidore.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 16 22:30:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUSPd-0007fB-U7
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 22:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbYHPU3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 16:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbYHPU3J
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 16:29:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:43578 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbYHPU3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 16:29:08 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1615730wxd.4
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=d8K5hg9frNd5M3UbVqFh/qUe97L9Uz77bntRFT6IcAE=;
        b=BiMSkbVkf8yWzXgicR2NvZxj16oPjerK7/HX9+ANj/lKbF/yw0LsfiR9lQhgpklPKb
         8OU/blo5UwgQT3rFqKErk+NRIvueudrSBYUC2vdkRydMswRGA9JBqagjsHI88waRaaFn
         B/WbqI043S4pdMPXl2IvoLDsmmL7HbLHVkuQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=i4P1PUHu+t7g4WVbai+vA8PzjnZb/xHL0x1MHlBYCNrpDXJ4i7lYQVsRHS6JEnPPIi
         MSe/zjmUX0mw6iuDnztao3H2u3OBOv7pOuCYnyDHJgEUmKUxfy0HZn7xJLvgXBsx/q7R
         3qYICwDyOMNIuqLRnDNN2xYEHFWD/5HG9QiNE=
Received: by 10.70.26.8 with SMTP id 8mr5075718wxz.13.1218918546551;
        Sat, 16 Aug 2008 13:29:06 -0700 (PDT)
Received: from ?192.168.2.101? ( [70.21.159.80])
        by mx.google.com with ESMTPS id h35sm94821wxd.31.2008.08.16.13.29.04
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Aug 2008 13:29:05 -0700 (PDT)
X-Mailer: Evolution 2.22.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92554>


>From 557280ecdcb4729c481ff6f1817bb277f11caec7 Mon Sep 17 00:00:00 2001
From: John J. Franey <jjfraney@gmail.com>
Date: Sat, 16 Aug 2008 15:32:48 -0400
Subject: [PATCH] On error in DirCache.lock, do not leave the index locked.

After using C git on the same repository, the jgit cache read
threw an EOFException, and left the index lock file.
The repository is still valid according to C git, but
unreachable by C git because it honors the lock file
left behind by jgit.

Signed-off-by: John J. Franey <jjfraney@gmail.com>
---
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
