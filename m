From: Dana How <danahow@gmail.com>
Subject: [PATCH] sha1_file.c:rearrange_packed_git() should consider packs'
 object sizes
Date: Thu, 24 May 2007 15:20:48 -0700
Message-ID: <46560FC0.4020204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 00:20:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrLg1-00009r-TY
	for gcvg-git@gmane.org; Fri, 25 May 2007 00:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbXEXWUx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 18:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbXEXWUx
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 18:20:53 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:5530 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbXEXWUw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 18:20:52 -0400
Received: by wr-out-0506.google.com with SMTP id 76so217814wra
        for <git@vger.kernel.org>; Thu, 24 May 2007 15:20:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Dg5wIFwWPi4TXMhZKliESQBGmHKqJnUja8mzB2h+XuR9X6v6GXAcLV1q6dX0+o/idqjGRObQLay/247hOj2E/5Yr2UTA0xNVtNQNSYt9uLBW+ojf2dmLdWRIESM/W3lGYKWZcpPMa4ZHWREXKQ8X+gpWJZNW2cSELgtmdwlxECE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=PtjCSnuUSfnanIxDmrxHdIK11CI63Pu8VmVTkjsAQZqlfe1KpHwOuvEiaZ5vxHbDyR7j/StirrtyXLohJ4VVZOQhcbTD80hICJHaRbwLLaEbDmMmzYCwx0h6nsve+SwQDb1ARfp2sGOdxMnQIvSJ7IiQ2RH8Ar/OhR+Xej3JEe0=
Received: by 10.115.72.1 with SMTP id z1mr1188450wak.1180045251650;
        Thu, 24 May 2007 15:20:51 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id t1sm1419244poh.2007.05.24.15.20.49;
        Thu, 24 May 2007 15:20:50 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48314>


Shawn O. Pearce wrote:
> We might be able to fix this by altering the sort_pack function
> in sha1_file.c to not only order by mtime, but also by the ratio
> of the size of the .pack to the number of objects stored in it.
> Any packfile with a high size/object ratio is likely to be what
> Dana has been calling a "metadata" pack, holding things like tags,
> commits, trees and small blobs.  Its these packfiles that we want
> to search first, as they are the most likely to be accessed.
>
> By pushing the megablob packs to the end of our packed_git search
> list we won't tend to scan their indexes, as most of our objects
> will be found earlier in the search list.  Hence we will generally
> avoid any costs associated with their indexes.

So change the sort keys in rearrange_packed_git()/sort_pack() to
  local then alternate,
  increasing "deviation",  <== NEW
  decreasing mtime (new then old)

Each packfile has a "rank",  which is the log10 of its average
stored object size.  "Deviation" is the number of standard deviations
this number exceeds its mean,  rounded down and clipped at zero.
Deviation should be 0 in normal use,  and positive for packfiles
with significant populations of huge blobs.

This definition of deviation is intended to override mtime
only when sufficiently significant.  Putting mtime before deviation
in the sort key list would cause deviation to be irrelevant.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 Makefile    |    2 +-
 cache.h     |    1 +
 sha1_file.c |   26 +++++++++++++++++++++++++-
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 29243c6..45f0a52 100644
--- a/Makefile
+++ b/Makefile
@@ -383,7 +383,7 @@ BUILTIN_OBJS = \
 	builtin-pack-refs.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
-EXTLIBS = -lz
+EXTLIBS = -lz -lm
 
 #
 # Platform specific tweaks
diff --git a/cache.h b/cache.h
index cd875bc..630cd89 100644
--- a/cache.h
+++ b/cache.h
@@ -437,6 +437,7 @@ extern struct packed_git {
 	uint32_t num_objects;
 	int index_version;
 	time_t mtime;
+	int deviation;
 	int pack_fd;
 	int pack_local;
 	unsigned char sha1[20];
diff --git a/sha1_file.c b/sha1_file.c
index 12d2ef2..1565d91 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -6,6 +6,7 @@
  * This handles basic git sha1 object files - packing, unpacking,
  * creation etc.
  */
+#include <math.h>
 #include "cache.h"
 #include "delta.h"
 #include "pack.h"
@@ -869,6 +870,14 @@ static int sort_pack(const void *a_, const void *b_)
 		return -st;
 
 	/*
+	 * Packs with large "deviation" should be searched last.
+	 * Such packs have significantly larger blobs.
+	 */
+	st = a->deviation - b->deviation;
+	if (st)
+		return st;
+
+	/*
 	 * Younger packs tend to contain more recent objects,
 	 * and more recent objects tend to get accessed more
 	 * often.
@@ -884,6 +893,7 @@ static void rearrange_packed_git(void)
 {
 	struct packed_git **ary, *p;
 	int i, n;
+	float sum1 = 0, sum2 = 0, mean, sigma;
 
 	for (n = 0, p = packed_git; p; p = p->next)
 		n++;
@@ -892,8 +902,22 @@ static void rearrange_packed_git(void)
 
 	/* prepare an array of packed_git for easier sorting */
 	ary = xcalloc(n, sizeof(struct packed_git *));
-	for (n = 0, p = packed_git; p; p = p->next)
+	for (n = 0, p = packed_git; p; p = p->next) {
+		/* this is the log10 of the average object size (almost) */
+		float rank = log10((p->pack_size + 1.0) / (p->num_objects + 1.0));
+		sum1 += rank;
+		sum2 += rank * rank;
 		ary[n++] = p;
+	}
+	mean = sum1 / n;
+	sigma = sqrt(sum2 / n - mean * mean);
+	for (p = packed_git; p; p = p->next) {
+		float rank = log10((p->pack_size + 1.0) / (p->num_objects + 1.0));
+		int deviation = sigma > 0 ? floor((rank - mean) / sigma) : 0;
+		if ( deviation < 0 )
+			deviation = 0;
+		p->deviation = deviation;
+	}
 
 	qsort(ary, n, sizeof(struct packed_git *), sort_pack);
 
-- 
1.5.2.762.gd8c6-dirty
