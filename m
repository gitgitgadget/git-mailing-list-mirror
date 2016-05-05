From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] exec_cmd.c, sideband.c, Makefile: avoid multiple PREFIX definitions
Date: Thu,  5 May 2016 22:28:53 +0100
Message-ID: <1462483733-3496-2-git-send-email-philipoakley@iee.org>
References: <1462483733-3496-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git-for-windows <git-for-windows@googlegroups.com>
To: GitList <git@vger.kernel.org>, Self <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu May 05 23:29:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayQpf-0003FO-3l
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213AbcEEV3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:29:06 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:7085 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965AbcEEV3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:29:04 -0400
Received: from localhost.localdomain ([92.22.61.226])
	by smtp.talktalk.net with SMTP
	id yQpRaUc28eSy4yQpSagc1I; Thu, 05 May 2016 22:29:02 +0100
X-Originating-IP: [92.22.61.226]
X-Spam: 0
X-OAuthority: v=2.2 cv=bsEOPwSi c=1 sm=1 tr=0 a=PhzTUH1fCcwppfJjoMy/AA==:117
 a=PhzTUH1fCcwppfJjoMy/AA==:17 a=xtxXYLxNAAAA:8 a=mH-QBqSHHxjn49LXL0wA:9
 a=xts0dhWdiJbonKbuqhAr:22
X-Mailer: git-send-email 2.8.1.windows.1
In-Reply-To: <1462483733-3496-1-git-send-email-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfI7vgFOllc9dkECLHpUYoHh/OXziKet9Tj9q3TnIS0m/gRs2fhODIu9UB6Chcp7ESsk0GorVWNjHh+tcppi4VCjRi9MhmQuhuXusp6FXZX0HAyUasfOD
 Q7qfQxltSXStJBkobYRDfrP6rrmcZ8tInU4yo5Xv9KT3TdVzXRDCXz4krDOpHrJBNSZV67lHCVGrdISw78Acu1KIpLEHzkHbT4wMMekfNWyAWgGwHIqjRK3F
 mRqOoduTpQz+5GVxIaVEjCTAcbUAZVDdpaZAyRnI2WEd3gtLeyB+i2Ego0dvQE6zFq8fOypcn9A471/BmnOFDH5Amdx4LpJLvNIDA7SKWyw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293681>

The short and sweet PREFIX can be confused when used in many places.

Rename both usages to better describe their purpose.

Noticed when compiling Git for Windows using MSVC/Visual Studio which
reports the conflict beteeen the command line definition and the
definition in sideband.c

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Makefile   | 2 +-
 exec_cmd.c | 4 ++--
 sideband.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 33b0f76..bcdd3ec 100644
--- a/Makefile
+++ b/Makefile
@@ -1973,7 +1973,7 @@ exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
 exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
-	'-DPREFIX="$(prefix_SQ)"'
+	'-DEXEC_PREFIX="$(prefix_SQ)"'
 
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
diff --git a/exec_cmd.c b/exec_cmd.c
index 9d5703a..2a79781 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -12,7 +12,7 @@ char *system_path(const char *path)
 #ifdef RUNTIME_PREFIX
 	static const char *prefix;
 #else
-	static const char *prefix = PREFIX;
+	static const char *prefix = EXEC_PREFIX;
 #endif
 	struct strbuf d = STRBUF_INIT;
 
@@ -27,7 +27,7 @@ char *system_path(const char *path)
 	    !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
 	    !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
 	    !(prefix = strip_path_suffix(argv0_path, "git"))) {
-		prefix = PREFIX;
+		prefix = EXEC_PREFIX;
 		trace_printf("RUNTIME_PREFIX requested, "
 				"but prefix computation failed.  "
 				"Using static fallback '%s'.\n", prefix);
diff --git a/sideband.c b/sideband.c
index fde8adc..d448ba7 100644
--- a/sideband.c
+++ b/sideband.c
@@ -13,7 +13,7 @@
  * the remote died unexpectedly.  A flush() concludes the stream.
  */
 
-#define PREFIX "remote:"
+#define DISPLAY_PREFIX "remote:"
 
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
@@ -22,13 +22,13 @@
 
 int recv_sideband(const char *me, int in_stream, int out)
 {
-	unsigned pf = strlen(PREFIX);
+	unsigned pf = strlen(DISPLAY_PREFIX);
 	unsigned sf;
 	char buf[LARGE_PACKET_MAX + 2*FIX_SIZE];
 	char *suffix, *term;
 	int skip_pf = 0;
 
-	memcpy(buf, PREFIX, pf);
+	memcpy(buf, DISPLAY_PREFIX, pf);
 	term = getenv("TERM");
 	if (isatty(2) && term && strcmp(term, "dumb"))
 		suffix = ANSI_SUFFIX;
-- 
2.8.1.windows.1
