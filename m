From: Mike Taht <mike.taht@timesys.com>
Subject: would madvise be a win or a lose on memory pressure?
Date: Fri, 15 Apr 2005 22:05:59 -0700
Message-ID: <42609D37.3030809@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 16 07:03:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMfRy-0005vr-O6
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 07:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVDPFGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 01:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVDPFGI
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 01:06:08 -0400
Received: from mail.timesys.com ([65.117.135.102]:9836 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262635AbVDPFGD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 01:06:03 -0400
Received: from [10.129.129.212] ([67.180.132.225]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 16 Apr 2005 01:01:26 -0400
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-OriginalArrivalTime: 16 Apr 2005 05:01:26.0562 (UTC) FILETIME=[57F09820:01C54241]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Doesn't seem to make sense to use MADV_RANDOM on the cache file, but 
maybe MADV_SEQUENTIAL on the rest...

--- /home/m/src/git-pasky-0.4/update-cache.c    2005-04-15 
12:24:26.000000000 -0700
+++ update-cache.c      2005-04-15 21:53:34.000000000 -0700
@@ -30,7 +30,7 @@
         close(fd);
         if (!out || (int)(long)in == -1)
                 return -1;
-
+       madvise(in,size,MADV_SEQUENTIAL);
         memset(&stream, 0, sizeof(stream));
         deflateInit(&stream, Z_BEST_COMPRESSION);

--- /home/m/src/git-pasky-0.4/read-cache.c      2005-04-15 
12:24:26.000000000 -0700
+++ read-cache.c        2005-04-15 22:01:12.000000000 -0700
@@ -143,6 +143,7 @@
         close(fd);
         if (-1 == (int)(long)map)
                 return NULL;
+       madvise(map,st.st_size,MADV_SEQUENTIAL);
         *size = st.st_size;
         return map;
  }
@@ -254,6 +255,7 @@
         close(fd);
         if (map == MAP_FAILED)
                 return -1;
+       madvise(map,size,MADV_SEQUENTIAL);
         cmp = memcmp(buf, map, size);
         munmap(map, size);
         if (cmp)


-- 

Mike Taht
