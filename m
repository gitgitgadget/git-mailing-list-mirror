From: Jeremy Huddleston <jeremyhu@apple.com>
Subject: [PATCH] Fallback on _NSGetExecutablePath to get the executable path if using argv[0] fails
Date: Mon, 29 Nov 2010 11:57:02 -0500
Message-ID: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 18:06:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN7B8-0006n6-6N
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 18:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626Ab0K2RGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 12:06:08 -0500
Received: from mail-out.apple.com ([17.254.13.23]:58501 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab0K2RGH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 12:06:07 -0500
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2010 12:06:07 EST
Received: from relay16.apple.com (relay16.apple.com [17.128.113.55])
	by mail-out4.apple.com (Postfix) with ESMTP id 3BF42C09BEA2
	for <git@vger.kernel.org>; Mon, 29 Nov 2010 08:57:04 -0800 (PST)
X-AuditID: 11807137-b7bf5ae000001937-75-4cf3db5f4071
Received: from [17.153.103.154] (Unknown_Domain [17.153.103.154])
	by relay16.apple.com (Apple SCV relay) with SMTP id 34.38.06455.F5BD3FC4; Mon, 29 Nov 2010 08:57:04 -0800 (PST)
X-Mailer: Apple Mail (2.1082)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162403>


Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
Reviewed-by: Matt Wright <mww@apple.com>
---
 exec_cmd.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index bf22570..1e24a8f 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -3,6 +3,10 @@
 #include "quote.h"
 #define MAX_ARGS	32
 
+#if defined(__APPLE__) && defined(RUNTIME_PREFIX)
+#include <mach-o/dyld.h>
+#endif
+
 extern char **environ;
 static const char *argv_exec_path;
 static const char *argv0_path;
@@ -53,6 +57,19 @@ const char *git_extract_argv0_path(const char *argv0)
 	if (slash >= argv0) {
 		argv0_path = xstrndup(argv0, slash - argv0);
 		return slash + 1;
+#ifdef __APPLE__
+	} else {
+		char new_argv0[PATH_MAX];
+		uint32_t new_argv0_s = PATH_MAX;
+		if(_NSGetExecutablePath(new_argv0, &new_argv0_s) == 0) {
+			slash = new_argv0 + new_argv0_s;
+			while (new_argv0 <= slash && !is_dir_sep(*slash))
+		                slash--;
+
+			if (slash >= new_argv0)
+				argv0_path = xstrndup(new_argv0, slash - new_argv0);
+		}
+#endif
 	}
 
 	return argv0;
-- 
1.7.3.2
