From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] fix up strtoul_ui error handling
Date: Thu, 19 Apr 2007 03:08:15 +0100
Message-ID: <37ce3db845caa21ba45c15d4f829ece1@pinky>
References: <871witxicn.fsf@rho.meyering.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 04:18:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeMEL-0001ss-C2
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 04:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993110AbXDSCSi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 22:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993112AbXDSCSi
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 22:18:38 -0400
Received: from 85-210-210-97.dsl.pipex.com ([85.210.210.97]:36643 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2993110AbXDSCSh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 22:18:37 -0400
X-Greylist: delayed 625 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Apr 2007 22:18:37 EDT
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1HeM4F-0001XI-99
	for git@vger.kernel.org; Thu, 19 Apr 2007 03:08:15 +0100
InReply-To: <871witxicn.fsf@rho.meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44976>


Two scanf() calls were converted to strtoul_ui() but the return
values were not updated to match.  scanf() returns the number of
matched "values" which for this usage is 1 on success.  strtoul_ui()
return 0 on success.  Update these call sites to match.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
	Without this patch svnimport fails to add files as
	update-index --cacheinfo fails.
---
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 9205c9f..8f98991 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -627,7 +627,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				if (i+3 >= argc)
 					die("git-update-index: --cacheinfo <mode> <sha1> <path>");
 
-				if ((strtoul_ui(argv[i+1], 8, &mode) != 1) ||
+				if (strtoul_ui(argv[i+1], 8, &mode) ||
 				    get_sha1_hex(argv[i+2], sha1) ||
 				    add_cacheinfo(mode, sha1, argv[i+3], 0))
 					die("git-update-index: --cacheinfo"
diff --git a/convert-objects.c b/convert-objects.c
index cf03bcf..cefbceb 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -88,7 +88,7 @@ static int write_subdirectory(void *buffer, unsigned long size, const char *base
 		unsigned int mode;
 		char *slash, *origpath;
 
-		if (!path || strtoul_ui(buffer, 8, &mode) != 1)
+		if (!path || strtoul_ui(buffer, 8, &mode))
 			die("bad tree conversion");
 		mode = convert_mode(mode);
 		path++;
