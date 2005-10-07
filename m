From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] close clobbers mmap's errno in read_cache
Date: Fri, 7 Oct 2005 23:45:51 +0200
Message-ID: <20051007214551.GA8893@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 23:47:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO02g-0001vp-6z
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 23:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbVJGVp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 17:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbVJGVp6
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 17:45:58 -0400
Received: from devrace.com ([198.63.210.113]:60943 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932584AbVJGVp6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 17:45:58 -0400
Received: from tigra.home (p54A0E11D.dip.t-dialin.net [84.160.225.29])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j97LwIW3080796;
	Fri, 7 Oct 2005 16:58:19 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EO02K-0005r8-00; Fri, 07 Oct 2005 23:45:52 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EO02J-0002Jk-VS; Fri, 07 Oct 2005 23:45:51 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=0.4 required=4.5 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9819>

Save errno before close(fd) for strerror in die().

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

--- a/read-cache.c	2005-10-03 09:16:31.000000000 +0200
+++ b/read-cache.c	2005-10-07 23:23:40.000000000 +0200
@@ -482,9 +482,10 @@ int read_cache(void)
 		if (size >= sizeof(struct cache_header) + 20)
 			map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	}
+	i = errno;
 	close(fd);
 	if (map == MAP_FAILED)
-		die("index file mmap failed (%s)", strerror(errno));
+		die("index file mmap failed (%s)", strerror(i));
 
 	hdr = map;
 	if (verify_hdr(hdr, size) < 0)
