From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 7/7] mingw: ensure sockets are initialized before calling gethostname
Date: Sat, 15 Oct 2011 15:05:20 +0100
Message-ID: <1318687520-19522-8-git-send-email-patthoyts@users.sourceforge.net>
References: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 15 16:05:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF4rw-0003yR-VZ
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 16:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115Ab1JOOFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 10:05:40 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:41531 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752982Ab1JOOFc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 10:05:32 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.3])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015140531.WPYJ13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 15:05:31 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1RF4rj-0002GJ-2i; Sat, 15 Oct 2011 15:05:31 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id B2351207A7; Sat, 15 Oct 2011 15:05:30 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=TfjBYBlSESQA:10 a=FP58Ms26AAAA:8 a=UD-kLrrJ6qfRlAyR1vwA:9 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183660>

If the Windows sockets subsystem has not been initialized yet then an
attempt to get the hostname returns an error and prints a warning to the
console. This solves this issue for msysGit as seen with 'git fetch'.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 compat/mingw.c |    7 +++++++
 compat/mingw.h |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8947418..efdc703 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1321,6 +1321,13 @@ static void ensure_socket_initialization(void)
 	initialized = 1;
 }
 
+#undef gethostname
+int mingw_gethostname(char *name, int namelen)
+{
+    ensure_socket_initialization();
+    return gethostname(name, namelen);
+}
+
 #undef gethostbyname
 struct hostent *mingw_gethostbyname(const char *host)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index ce9dd98..fecf0d0 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -190,6 +190,9 @@ char *mingw_getcwd(char *pointer, int len);
 char *mingw_getenv(const char *name);
 #define getenv mingw_getenv
 
+int mingw_gethostname(char *host, int namelen);
+#define gethostname mingw_gethostname
+
 struct hostent *mingw_gethostbyname(const char *host);
 #define gethostbyname mingw_gethostbyname
 
-- 
1.7.7.1.gbba15
