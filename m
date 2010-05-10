From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] hash_object: correction for zero length file
Date: Tue, 11 May 2010 01:38:17 +0400
Message-ID: <20100510213817.GK14069@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 10 23:38:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBagH-0000Vj-4D
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 23:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206Ab0EJViW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 17:38:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:40958 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab0EJViV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 17:38:21 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1812512fga.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 14:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=ip2MlXKv97NDRpoeNGQQMlJGN+MEcCghP52GFuFPKK0=;
        b=cZt4QQP7uBiHFFLHDYEbHegCTthAIs/jIP6z2R0DUCMueqh/T047UqMlMc3ZVvyI6B
         6cUs8v7qxjWmvv2NvOVUlUvEoVUsxjIk3nUynCfmThEulf320H6mbbcxgYmvF+fP21op
         3SIi88guquhZaTal5KyKiVK9zBOQkUQvvzuDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=gQ9TLJRXitnF8yn9TL4swR4NJ3RqCMP4UyjmP/9+KzEWFt74P02/mOB7Uu2Hpe2+Pe
         IQJ//zNq7PtdwaRSzALq06zz6DsZt8DRa71u/ta7xySxe+dCr3q73cIIhTt7bVEFrcuu
         xyQGuvHbU57Gf0tlj6SYsEHXgzQ1oGVXuZtYI=
Received: by 10.86.119.19 with SMTP id r19mr10409169fgc.76.1273527499066;
        Mon, 10 May 2010 14:38:19 -0700 (PDT)
Received: from localhost (ppp85-140-167-246.pppoe.mtu-net.ru [85.140.167.246])
        by mx.google.com with ESMTPS id 19sm10377947fkr.39.2010.05.10.14.38.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 14:38:18 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146857>

The check whether size is zero was done after if size <= SMALL_FILE_SIZE,
as result, zero size case was never triggered. Instead zero length file
was treated as any other small file. This did not caused any problem, but
if we have a special case for size equal to zero, it is better to make it
work and avoid redundant malloc().

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 sha1_file.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 28c056e..2ece9b6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2448,7 +2448,9 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 		else
 			ret = -1;
 		strbuf_release(&sbuf);
-	} else if (size <= SMALL_FILE_SIZE) {
+	} else if (!size)
+		ret = index_mem(sha1, NULL, size, write_object, type, path);
+	else if (size <= SMALL_FILE_SIZE) {
 		char *buf = xmalloc(size);
 		if (size == read_in_full(fd, buf, size))
 			ret = index_mem(sha1, buf, size, write_object, type,
@@ -2456,12 +2458,11 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 		else
 			ret = error("short read %s", strerror(errno));
 		free(buf);
-	} else if (size) {
+	} else {
 		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 		ret = index_mem(sha1, buf, size, write_object, type, path);
 		munmap(buf, size);
-	} else
-		ret = index_mem(sha1, NULL, size, write_object, type, path);
+	}
 	close(fd);
 	return ret;
 }
-- 
1.7.1.83.g11b7c
