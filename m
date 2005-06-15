From: Jason Wright <jason@thought.net>
Subject: time casts
Date: Wed, 15 Jun 2005 11:30:59 -0400
Message-ID: <20050615153058.GD12393@thought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 15 17:27:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiZnF-0005Cq-Au
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 17:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVFOPbv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 11:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVFOPbv
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 11:31:51 -0400
Received: from anything.thought.net ([192.148.252.38]:4755 "EHLO
	anything.thought.net") by vger.kernel.org with ESMTP
	id S261171AbVFOPbj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 11:31:39 -0400
Received: from anything.thought.net (jason@localhost.thought.net [127.0.0.1])
	by anything.thought.net (8.13.4/8.13.0) with ESMTP id j5FFUxmk025646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 15 Jun 2005 11:30:59 -0400 (EDT)
Received: (from jason@localhost)
	by anything.thought.net (8.13.4/8.13.0/Submit) id j5FFUxgM014987
	for git@vger.kernel.org; Wed, 15 Jun 2005 11:30:59 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In porting cogito/git 0.11.3 to OpenBSD, I ran into casts of time_t
warnings for the printfs below.  I think the warnings are harmless, but
the patch below fixes 'em.

--Jason L. Wright

--- date.c.orig	Wed Jun 15 11:21:00 2005
+++ date.c	Wed Jun 15 11:21:30 2005
@@ -438,7 +438,8 @@ void parse_date(char *date, char *result
 		sign = '-';
 	}
 
-	snprintf(result, maxlen, "%lu %c%02d%02d", then, sign, offset/60, offset % 60);
+	snprintf(result, maxlen, "%lu %c%02d%02d", (unsigned long)then,
+	    sign, offset/60, offset % 60);
 }
 
 void datestamp(char *buf, int bufsize)
@@ -451,5 +452,6 @@ void datestamp(char *buf, int bufsize)
 	offset = my_mktime(localtime(&now)) - now;
 	offset /= 60;
 
-	snprintf(buf, bufsize, "%lu %+05d", now, offset/60*100 + offset%60);
+	snprintf(buf, bufsize, "%lu %+05d", (unsigned long)now,
+	    offset/60*100 + offset%60);
 }
--- tar-tree.c.orig	Wed Jun 15 11:24:07 2005
+++ tar-tree.c	Wed Jun 15 11:24:55 2005
@@ -318,7 +318,7 @@ static void write_header(const unsigned 
 	if (S_ISDIR(mode) || S_ISLNK(mode))
 		size = 0;
 	sprintf(&header[124], "%011lo", size);
-	sprintf(&header[136], "%011lo", archive_time);
+	sprintf(&header[136], "%011lo", (unsigned)archive_time);
 
 	header[156] = typeflag;
 
