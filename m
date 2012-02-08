From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] column: Fix some compiler and sparse warnings
Date: Wed, 08 Feb 2012 19:13:12 +0000
Message-ID: <4F32C948.3030700@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 20:36:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvDJO-0002cU-SM
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 20:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756926Ab2BHTgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 14:36:10 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:47326 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755922Ab2BHTgI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2012 14:36:08 -0500
X-Greylist: delayed 1012 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Feb 2012 14:36:08 EST
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1RvD2w-0007G9-ha; Wed, 08 Feb 2012 19:19:15 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190250>


Some versions of gcc complain as follows:

        CC column.o
    column.c: In function `git_config_column':
    column.c:313: warning: 'set' might be used uninitialized in \
        this function

The 'set' variable is not in fact used uninitialised, but in order to
suppress the warning, we rework the code slightly to ensure gcc does
not mis-diagnose the variable usage.

Also, sparse complains as follows:

        SP pager.c
    pager.c:134:5: warning: symbol 'term_columns' was not declared. \
        Should it be static?

In order to fix the warning, we add an include of the column.h header,
which contains an appropriate extern declaration of term_columns().

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Nguyen,

If you need to re-roll your "nd/columns" branch, could you please squash
this patch (or some variant) into it. Thanks!

[I haven't checked, but I'm guessing that the pager.c change would be
squashed into commit cb0850f (Save terminal width before setting up pager,
04-02-2012), whereas the column.c change would be squashed into commit
ac21f2b (Add git-column and column mode parsing, 04-02-2012)]

ATB,
Ramsay Jones

 column.c |    6 +++---
 pager.c  |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/column.c b/column.c
index f001021..98328cf 100644
--- a/column.c
+++ b/column.c
@@ -310,16 +310,16 @@ static int parse_option(const char *arg, int len,
 		{ OPTION, "color",  COL_ANSI },
 		{ OPTION, "dense",  COL_DENSE },
 	};
-	int i, set, name_len;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(opts); i++) {
+		int set = 1, name_len;
+
 		if (opts[i].type == OPTION) {
 			if (len > 2 && !strncmp(arg, "no", 2)) {
 				arg += 2;
 				len -= 2;
 				set = 0;
-			} else {
-				set = 1;
 			}
 		}
 
diff --git a/pager.c b/pager.c
index 37d554d..fe203a7 100644
--- a/pager.c
+++ b/pager.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "column.h"
 
 #ifndef DEFAULT_PAGER
 #define DEFAULT_PAGER "less"
-- 
1.7.9
