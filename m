From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH] builtin-apply.c: Skip filenames without enough components
Date: Sun, 17 Jan 2010 03:05:10 +0100
Organization: SUSE Labs
Message-ID: <201001170305.10793.agruen@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 03:05:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWKW4-0000MM-Vx
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 03:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259Ab0AQCFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 21:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753202Ab0AQCFS
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 21:05:18 -0500
Received: from cantor.suse.de ([195.135.220.2]:42945 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224Ab0AQCFO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 21:05:14 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 222045362F
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 03:05:13 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.1; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137268>

find_name() wrongly returned the whole filename for filenames without
enough leading pathname components (e.g., when applying a patch to a
top-level file with -p2).

Include the -p value used in the error message when no filenames can be
found.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 builtin-apply.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 541493e..b99db0b 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -404,6 +404,9 @@ static char *squash_slash(char *name)
 {
 	int i = 0, j = 0;
 
+	if (!name)
+		return NULL;
+
 	while (name[i]) {
 		if ((name[j++] = name[i++]) == '/')
 			while (name[i] == '/')
@@ -416,7 +419,10 @@ static char *squash_slash(char *name)
 static char *find_name(const char *line, char *def, int p_value, int terminate)
 {
 	int len;
-	const char *start = line;
+	const char *start = NULL;
+
+	if (p_value == 0)
+		start = line;
 
 	if (*line == '"') {
 		struct strbuf name = STRBUF_INIT;
@@ -1199,7 +1205,8 @@ static int find_header(char *line, unsigned long size, int *hdrsize, 
struct patc
 				continue;
 			if (!patch->old_name && !patch->new_name) {
 				if (!patch->def_name)
-					die("git diff header lacks filename information (line %d)", linenr);
+					die("git diff header lacks filename information when removing "
+					    "%d leading pathname components (line %d)" , p_value, linenr);
 				patch->old_name = patch->new_name = patch->def_name;
 			}
 			patch->is_toplevel_relative = 1;
-- 
1.6.6.197.g9c4a28
