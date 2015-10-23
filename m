From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2 jk/war-on-sprintf] compat/mingw.c: remove printf format warning
Date: Fri, 23 Oct 2015 08:02:52 +0200
Message-ID: <28a610a30ab9d4f742be2f3225db341ea40c8a51.1445579874.git.j6t@kdbg.org>
References: <2c89c60e470def8f85941933c9fafe4db314628a.1445579874.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, git-for-windows@googlegroups.com,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 23 08:03:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpVS0-00051A-MN
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 08:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbbJWGDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 02:03:14 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:10411 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbbJWGDM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 02:03:12 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nhw3314tcz5tlL;
	Fri, 23 Oct 2015 08:03:11 +0200 (CEST)
Received: from dx.site (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id C57AE531A;
	Fri, 23 Oct 2015 08:03:10 +0200 (CEST)
X-Mailer: git-send-email 2.3.2.245.gb5bf9d3
In-Reply-To: <2c89c60e470def8f85941933c9fafe4db314628a.1445579874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280084>

5096d490 (convert trivial sprintf / strcpy calls to xsnprintf) converted
two sprintf calls. Now GCC warns that "format '%u' expects argument of
type 'unsigned int', but argument 4 has type 'long unsigned int'".
Instead of changing the format string, use a variable of type unsigned
in place of the typedef-ed type DWORD, which hides that it is actually an
unsigned long.

There is no correctness issue with the old code because unsigned long and
unsigned are always of the same size on Windows, even in 64-bit builds.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
I do not know why there are no warnings with the old code. Apparently, the
system provided sprintf declaration does not have format-printf
annotation.

 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index a168800..90bdb1e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2131,7 +2131,7 @@ void mingw_startup()
 
 int uname(struct utsname *buf)
 {
-	DWORD v = GetVersion();
+	unsigned v = (unsigned)GetVersion();
 	memset(buf, 0, sizeof(*buf));
 	xsnprintf(buf->sysname, sizeof(buf->sysname), "Windows");
 	xsnprintf(buf->release, sizeof(buf->release),
-- 
2.3.2.245.gb5bf9d3
