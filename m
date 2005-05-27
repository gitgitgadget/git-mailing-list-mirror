From: David Meybohm <dmeybohmlkml@bellsouth.net>
Subject: [PATCH] check_file_directory_conflict path fix
Date: Thu, 26 May 2005 22:59:10 -0400
Message-ID: <20050527025910.GA4836@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 27 04:57:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbV1W-000108-So
	for gcvg-git@gmane.org; Fri, 27 May 2005 04:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVE0C63 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 22:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVE0C63
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 22:58:29 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:41967 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261494AbVE0C6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 22:58:24 -0400
Received: from ibm67aec.bellsouth.net ([65.10.215.177])
          by imf22aec.mail.bellsouth.net
          (InterMail vM.5.01.06.11 201-253-122-130-111-20040605) with ESMTP
          id <20050527025822.INHD2086.imf22aec.mail.bellsouth.net@ibm67aec.bellsouth.net>
          for <git@vger.kernel.org>; Thu, 26 May 2005 22:58:22 -0400
Received: from localhost ([65.10.215.177]) by ibm67aec.bellsouth.net
          (InterMail vG.1.02.00.01 201-2136-104-101-20040929) with ESMTP
          id <20050527025821.XCWZ8829.ibm67aec.bellsouth.net@localhost>
          for <git@vger.kernel.org>; Thu, 26 May 2005 22:58:21 -0400
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

check_file_directory_conflict can give the wrong answers. This is
because the wrong length is passed to cache_name_pos. The length
passed should be the length of the whole path from the root, not
the length of each path subcomponent.

	$ git-init-db
	defaulting to local storage area
	$ mkdir path && touch path/file
	$ git-update-cache --add path/file
	$ rm path/file
	$ mkdir path/file && touch path/file/f
	$ git-update-cache --add path/file/f  <-- Conflict ignored
	$

Signed-off-by: David Meybohm <dmeybohmlkml@bellsouth.net>
---
Index: read-cache.c
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/read-cache.c  (mode:100644)
+++ uncommitted/read-cache.c  (mode:100644)
@@ -172,11 +172,13 @@
 	cp = pathbuf;
 	while (1) {
 		char *ep = strchr(cp, '/');
+		int len;
 		if (!ep)
 			break;
 		*ep = 0;    /* first cut it at slash */
+		len = ep - pathbuf;
 		pos = cache_name_pos(pathbuf,
-				     htons(create_ce_flags(ep-cp, stage)));
+				     htons(create_ce_flags(len, stage)));
 		if (0 <= pos) {
 			/* Our leading path component is registered as a file,
 			 * and we are trying to make it a directory.  This is
