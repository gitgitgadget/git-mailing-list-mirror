From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix crash in t0020 (crlf conversion)
Date: Sun, 22 Apr 2007 16:11:54 +0200
Message-ID: <20070422141154.GB2431@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 16:12:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfcna-0006V6-2H
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 16:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030879AbXDVOL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 10:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030881AbXDVOL4
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 10:11:56 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:40759 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030879AbXDVOL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 10:11:56 -0400
Received: from tigra.home (Fcb6c.f.strato-dslnet.de [195.4.203.108])
	by post.webmailer.de (mrclete mo9) (RZmta 5.6)
	with ESMTP id T03635j3ME3lcq ; Sun, 22 Apr 2007 16:11:54 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3F657277BD;
	Sun, 22 Apr 2007 16:11:54 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0DEB4BDDE; Sun, 22 Apr 2007 16:11:53 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsD+I4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45240>

Reallocated wrong size.
Noticed on Ubuntu 7.04 probably because it has some malloc diagnostics in libc:
"git-read-tree --reset -u HEAD" aborted in the test. Valgrind sped up the
debugging greatly: took me 10 minutes.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 attr.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 285e689..a071254 100644
--- a/attr.c
+++ b/attr.c
@@ -300,7 +300,8 @@ static struct attr_stack *read_attr_from_array(const char **list)
 		a = parse_attr_line(line, "[builtin]", ++lineno, 1);
 		if (!a)
 			continue;
-		res->attrs = xrealloc(res->attrs, res->num_matches + 1);
+		res->attrs = xrealloc(res->attrs,
+			sizeof(struct match_attr *) * (res->num_matches + 1));
 		res->attrs[res->num_matches++] = a;
 	}
 	return res;
@@ -324,7 +325,8 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 		a = parse_attr_line(buf, path, ++lineno, macro_ok);
 		if (!a)
 			continue;
-		res->attrs = xrealloc(res->attrs, res->num_matches + 1);
+		res->attrs = xrealloc(res->attrs,
+			sizeof(struct match_attr *) * (res->num_matches + 1));
 		res->attrs[res->num_matches++] = a;
 	}
 	fclose(fp);
-- 
1.5.1.1.946.gdb75a
