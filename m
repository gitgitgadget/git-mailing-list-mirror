From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/3] read-cache.c: Pass 'struct stat' parameters by reference
Date: Tue, 04 Sep 2012 19:52:14 +0100
Message-ID: <50464DDE.2070105@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: t.gummerer@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 04 21:07:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8yTM-0001sL-RQ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647Ab2IDTHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:07:30 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:40967 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932637Ab2IDTH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:07:29 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 60F8E128076;
	Tue,  4 Sep 2012 20:07:28 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 32A8D128075;	Tue,  4 Sep 2012 20:07:25 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Tue,  4 Sep 2012 20:07:23 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204775>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Thomas,

Passing the 'struct stat' parameters by value, while not *wrong*, looks
somewhat odd to my eyes. As I said before, feel free to ignore this one.

ATB,
Ramsay Jones

 read-cache.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 211b971..36f0877 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1199,25 +1199,25 @@ int read_index(struct index_state *istate)
 	return read_index_from(istate, get_index_file());
 }
 
-static int index_changed(struct stat st_old, struct stat st_new)
+static int index_changed(struct stat *st_old, struct stat *st_new)
 {
 	int changed = 0;
 
-	if (st_old.st_mtime != st_new.st_mtime ||
+	if (st_old->st_mtime != st_new->st_mtime ||
 #if !defined(__CYGWIN__)
-	    st_old.st_uid   != st_new.st_uid ||
-	    st_old.st_gid   != st_new.st_gid ||
-	    st_old.st_ino   != st_new.st_ino ||
+	    st_old->st_uid   != st_new->st_uid ||
+	    st_old->st_gid   != st_new->st_gid ||
+	    st_old->st_ino   != st_new->st_ino ||
 #endif
-	    st_old.st_size  != st_new.st_size)
+	    st_old->st_size  != st_new->st_size)
 		changed = 1;
 #ifdef USE_NSEC
-	if (ST_MTIME_NSEC(st_old) != ST_MTIME_NSEC(st_new))
+	if (ST_MTIME_NSEC(*st_old) != ST_MTIME_NSEC(*st_new))
 		changed = 1;
 #endif
 
 #ifdef USE_STDEV
-	if (st_old.st_dev != st_new.st_dev)
+	if (st_old->st_dev != st_new->st_dev)
 		changed = 1;
 #endif
 
@@ -1273,12 +1273,12 @@ int read_index_from(struct index_state *istate, const char *path)
 
 		munmap(mmap, mmap_size);
 
-		if (!index_changed(st_old, st_new) && !err)
+		if (!index_changed(&st_old, &st_new) && !err)
 			return istate->cache_nr;
 
 		usleep(10*1000);
 		i++;
-	} while ((err || index_changed(st_old, st_new)) && i < 50);
+	} while ((err || index_changed(&st_old, &st_new)) && i < 50);
 
 	munmap(mmap, mmap_size);
 	die("index file corrupt");
-- 
1.7.12
