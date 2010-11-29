From: Jeremy Huddleston <jeremyhu@apple.com>
Subject: [PATCH updated] Fallback on _NSGetExecutablePath to get the executable
 path if using argv[0] fails
Date: Mon, 29 Nov 2010 13:29:39 -0500
Message-ID: <DD9829B7-8851-41CF-BCC6-2676B6015028@apple.com>
References: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com>
 <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com>
 <20101129171211.GL8037@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 19:29:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN8U4-0004iX-Ib
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 19:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848Ab0K2S3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 13:29:45 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:52845 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab0K2S3o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 13:29:44 -0500
Received: from relay16.apple.com (relay16.apple.com [17.128.113.55])
	by mail-out3.apple.com (Postfix) with ESMTP id E1DBEBB9B115
	for <git@vger.kernel.org>; Mon, 29 Nov 2010 10:29:43 -0800 (PST)
X-AuditID: 11807137-b7bf5ae000001937-fc-4cf3f117e925
Received: from elliott.apple.com (elliott.apple.com [17.151.62.13])
	by relay16.apple.com (Apple SCV relay) with SMTP id 27.E3.06455.711F3FC4; Mon, 29 Nov 2010 10:29:43 -0800 (PST)
Received: from [17.153.103.154] by elliott.apple.com
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPSA id <0LCN005KXSPGF160@elliott.apple.com> for git@vger.kernel.org;
 Mon, 29 Nov 2010 10:29:43 -0800 (PST)
In-reply-to: <20101129171211.GL8037@burratino>
X-Mailer: Apple Mail (2.1082)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162411>


This adds better support for RUNTIME_PREFIX on Mac OS X.  The previous codepath
would only work if argv[0] contained the full path to the executable or $PATH
already contained /path/to/libexec/git-core.  We use _NSGetExecutablePath here
to find the full path (and thus prepend the correct libexec/git-core to $PATH)
in the case where argv[0] does not contain the full path to the executable.

Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
Reviewed-by: Matt Wright <mww@apple.com>
---
 exec_cmd.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index bf22570..182fd3a 100644
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
+#if defined(__APPLE__)
+	} else {
+		char new_argv0[PATH_MAX];
+		uint32_t new_argv0_s = PATH_MAX;
+		if(_NSGetExecutablePath(new_argv0, &new_argv0_s) == 0) {
+			slash = new_argv0 + strlen(new_argv0);
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
