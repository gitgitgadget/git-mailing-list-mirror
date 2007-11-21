From: Jon Jensen <jon@endpoint.com>
Subject: [PATCH] When re-initializing, set shared permissions on all directories.
Date: Tue, 20 Nov 2007 20:48:58 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711202045140.4046@ybpnyubfg.ybpnyqbznva>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 05:24:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuh7z-0007Dv-6Y
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 05:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbXKUEXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 23:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbXKUEXi
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 23:23:38 -0500
Received: from sb3.endpoint.com ([64.34.193.88]:43165 "EHLO mail.endcrypt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616AbXKUEXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 23:23:37 -0500
X-Greylist: delayed 2076 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Nov 2007 23:23:37 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.endcrypt.com (Postfix) with ESMTP id 5FB6729AACB
	for <git@vger.kernel.org>; Wed, 21 Nov 2007 03:49:00 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65591>

Hi.

Below is a small patch to make git-init --shared change permissions not 
just of .git/refs/ but of the other directories too.

Also a documentation patch for git-init, though after reading discussion 
in the list archives from a few weeks ago, I realize people may not be 
interested in documentation that shows explicit UNIX commands that may not 
apply or could be considered pedantic. Let me know if there's a better way 
I can approach this.

Thanks,
Jon


--
From b2895649165d7e6c4bcbe6484d66c84ea7124bd9 Mon Sep 17 00:00:00 2001
From: Jon Jensen <jon@endpoint.com>
Date: Tue, 20 Nov 2007 20:01:14 -0700
Subject: [PATCH] When re-initializing, set shared permissions on all directories.

Before this patch, when re-initializing an existing repository e.g.
as --shared=group, only .git/refs/ was set chmod g+ws. Now the
other directories get that too.

This is probably only helpful when not much has been done with the
repository yet, since it doesn't include subdirectories and files,
so add an example to the documentation to point the way for people
to finish the job.
---
  Documentation/git-init.txt |   13 +++++++++++++
  builtin-init-db.c          |    8 +++++++-
  2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 07484a4..c4a4757 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -101,6 +101,19 @@ $ git-add .     <2>
  <2> add all existing file to the index


+Adjust an existing git repository to work as if it had been created with git init --shared::
++
+----------------
+$ GIT_DIR=/path/to/my/.git git-init --shared  <1>
+$ chgrp -R mygroup /path/to/my/.git  <2>
+$ find /path/to/my/.git -type d -exec chmod g+ws {} \;  <3>
+----------------
++
+<1> adjust configuration for shared repository
+<2> correct group ownership of any existing directories and files; needed if group shared by users is different than the group ownership of repository files
+<3> make all directories set group ownership of newly created files correctly in the future
+
+
  Author
  ------
  Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 763fa55..d16efa5 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -24,7 +24,13 @@ static void safe_create_dir(const char *dir, int share)
  			exit(1);
  		}
  	}
-	else if (share && adjust_shared_perm(dir))
+
+    /*
+     * If the directory already existed, we may still need
+     * to adjust permissions if this is a reinitialization
+     * for a shared repository.
+     */
+	if (share && adjust_shared_perm(dir))
  		die("Could not make %s writable by group\n", dir);
  }

-- 
1.5.3.6.737.gb2895
