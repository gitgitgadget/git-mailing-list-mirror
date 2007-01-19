From: Bart Trojanowski <bart@jukie.net>
Subject: [PATCH] Don't call fstat() on stdin in index-pack.
Date: Thu, 18 Jan 2007 21:44:36 -0500
Message-ID: <20070119024436.GQ8624@jukie.net>
References: <20070118212615.GO8624@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Fri Jan 19 03:44:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7jkH-0008LF-R4
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 03:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbXASCoj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 21:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbXASCoi
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 21:44:38 -0500
Received: from bart.ott.istop.com ([66.11.172.99]:36361 "EHLO jukie.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932856AbXASCoi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jan 2007 21:44:38 -0500
Received: from tau.jukie.net ([10.10.10.211]:34328)
	by jukie.net with esmtp (Exim 4.50)
	id 1H7jk5-0002Gj-5b
	for git@vger.kernel.org; Thu, 18 Jan 2007 21:44:37 -0500
Received: by tau.jukie.net (Postfix, from userid 1000)
	id C084E2DC03A; Thu, 18 Jan 2007 21:44:36 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070118212615.GO8624@jukie.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37148>

* Bart Trojanowski <bart@jukie.net> [070118 16:26]:
>       $ git push origin 
>       updating 'refs/heads/my-ocf+fsm_v2.6.18' 
>         from 0000000000000000000000000000000000000000 
>         to   380541e91358d7a5e2fe37c81c520c92a3094951 
>       Generating pack... 
>       Done counting 727 objects. 
>       Result has 708 objects. 
>       Deltifying 708 objects. 
>        100% (708/708) done 
>       Writing 708 objects. 
>        100% (708/708) done 
>       Total 708 (delta 535), reused 275 (delta 218) 
>       fatal: cannot fstat packfile: Value too large for defined data type 

I had a look at the code in index-pack.c and noticed that this error is
printed input_fd is set to 0 in open_pack_file().

|           if (fstat(input_fd, &st))
|                   die("cannot fstat packfile: %s", strerror(errno));
|           if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
|                   die("pack has junk at the end");

It seems strange to me to call fstat on fd 0 to get st_size info.

Granted, st_mode should tell us that it's not a regular file, but
already know it's not a regular file.

So I removed it.  And now it works (I verified that the git-diff output
on both sides matches).

-Bart

----

>From fcd359655e12a4b6424f989b7c01cbbb8a551287 Mon Sep 17 00:00:00 2001
From: Bart Trojanowski <bart@jukie.net>
Date: Fri, 19 Jan 2007 02:39:27 +0000
Subject: [PATCH] Don't call fstat() on stdin in index-pack.

This fixes a issues with a large git-push with a
32bit git on a 64bit kernel.

Signed-off-by: Bart Trojanowski <bart@jukie.net>
---
 index-pack.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 72e0962..e7870a9 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -455,10 +455,12 @@ static void parse_pack_objects(unsigned char *sha1)
 	use(20);
 
 	/* If input_fd is a file, we should have reached its end now. */
-	if (fstat(input_fd, &st))
-		die("cannot fstat packfile: %s", strerror(errno));
-	if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
-		die("pack has junk at the end");
+        if (input_fd) {
+                if (fstat(input_fd, &st))
+                        die("cannot fstat packfile: %s", strerror(errno));
+                if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
+                        die("pack has junk at the end");
+        }
 
 	if (!nr_deltas)
 		return;
-- 
1.5.0.rc1.gdf1b-dirty
