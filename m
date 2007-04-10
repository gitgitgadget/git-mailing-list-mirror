From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/6] Avoid overflowing name buffer in deep directory structures
Date: Mon, 9 Apr 2007 21:13:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704092113320.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 09:01:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb7k8-0006WV-Dh
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 06:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040AbXDJEOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 00:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933058AbXDJEOF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 00:14:05 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42932 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933040AbXDJEOC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 00:14:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3A4DxPD025560
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Apr 2007 21:13:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3A4DwXO031010;
	Mon, 9 Apr 2007 21:13:59 -0700
In-Reply-To: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.953 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44108>


This just makes sure that when we do a read_directory(), we check
that the filename fits in the buffer we allocated (with a bit of
slop)

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 dir.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index 7426fde..4f5a224 100644
--- a/dir.c
+++ b/dir.c
@@ -353,6 +353,9 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			     !strcmp(de->d_name + 1, "git")))
 				continue;
 			len = strlen(de->d_name);
+			/* Ignore overly long pathnames! */
+			if (len + baselen + 8 > sizeof(fullname))
+				continue;
 			memcpy(fullname + baselen, de->d_name, len+1);
 			if (simplify_away(fullname, baselen + len, simplify))
 				continue;
-- 
1.5.1.110.g1e4c
