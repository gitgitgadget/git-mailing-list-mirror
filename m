From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 8/9] sparse: Fix some "symbol not declared" warnings
Date: Thu, 07 Apr 2011 19:49:33 +0100
Message-ID: <4D9E073D.5090006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:53:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7uL1-0005FA-PR
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 20:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab1DGSxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 14:53:46 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:48602 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756564Ab1DGSxq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 14:53:46 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1Q7uKu-0001Tm-mf; Thu, 07 Apr 2011 18:53:45 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171074>


In particular, sparse issues the "symbol 'a_symbol' was not declared.
Should it be static?" warnings for the following symbols:

    attr.c:468:12: 'git_etc_gitattributes'
    attr.c:476:5:  'git_attr_system'
    vcs-svn/svndump.c:282:6: 'svndump_read'
    vcs-svn/svndump.c:417:5: 'svndump_init'
    vcs-svn/svndump.c:432:6: 'svndump_deinit'
    vcs-svn/svndump.c:445:6: 'svndump_reset'

The symbols in attr.c only require file scope, so we add the static
modifier to their declaration.

The symbols in vcs-svn/svndump.c are external symbols, and they
already have extern declarations in the "svndump.h" header file,
so we simply include the header in svndump.c.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 attr.c            |    4 ++--
 vcs-svn/svndump.c |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 0e28ba8..f6b3f7e 100644
--- a/attr.c
+++ b/attr.c
@@ -465,7 +465,7 @@ static void drop_attr_stack(void)
 	}
 }
 
-const char *git_etc_gitattributes(void)
+static const char *git_etc_gitattributes(void)
 {
 	static const char *system_wide;
 	if (!system_wide)
@@ -473,7 +473,7 @@ const char *git_etc_gitattributes(void)
 	return system_wide;
 }
 
-int git_attr_system(void)
+static int git_attr_system(void)
 {
 	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
 }
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 572a995..bc79222 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -13,6 +13,7 @@
 #include "line_buffer.h"
 #include "string_pool.h"
 #include "strbuf.h"
+#include "svndump.h"
 
 /*
  * Compare start of string to literal of equal length;
-- 
1.7.4
