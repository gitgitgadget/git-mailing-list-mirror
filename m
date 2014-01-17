From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] setup_pager: set MORE=R
Date: Thu, 16 Jan 2014 23:21:53 -0500
Message-ID: <20140117042153.GB23443@sigill.intra.peff.net>
References: <20140117041430.GB19551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Yuri <yuri@rawbw.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 05:22:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W40wS-0000GM-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 05:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbaAQEV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 23:21:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:33986 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751298AbaAQEVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 23:21:55 -0500
Received: (qmail 15206 invoked by uid 102); 17 Jan 2014 04:21:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 22:21:55 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 23:21:53 -0500
Content-Disposition: inline
In-Reply-To: <20140117041430.GB19551@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240572>

When we run the pager, we always set "LESS=R" to tell the
pager to pass through ANSI colors. On modern versions of
FreeBSD, the system "more" can do the same trick.

Unlike "less", we may be dealing with various versions of
"more" that do not understand the "R" option, but do know
how to read options from MORE (Debian's "more" is an
example). For this reason, we make the setting a
compile-time option (but turn it on by default on FreeBSD).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile         | 7 +++++++
 config.mak.uname | 1 +
 pager.c          | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/Makefile b/Makefile
index b4af1e2..6cd7a2a 100644
--- a/Makefile
+++ b/Makefile
@@ -312,6 +312,9 @@ all::
 # you want to use something different.  The value will be interpreted by the
 # shell at runtime when it is used.
 #
+# Define PAGER_MORE_UNDERSTANDS_R if your system's "more" pager
+# can pass-through ANSI colors using the "R" option.
+#
 # Define DEFAULT_EDITOR to a sensible editor command (defaults to "vi") if you
 # want to use something different.  The value will be interpreted by the shell
 # if necessary when it is used.  Examples:
@@ -1608,6 +1611,10 @@ DEFAULT_PAGER_CQ_SQ = $(subst ','\'',$(DEFAULT_PAGER_CQ))
 BASIC_CFLAGS += -DDEFAULT_PAGER='$(DEFAULT_PAGER_CQ_SQ)'
 endif
 
+ifdef PAGER_MORE_UNDERSTANDS_R
+BASIC_CFLAGS += -DPAGER_MORE_UNDERSTANDS_R
+endif
+
 ifdef SHELL_PATH
 SHELL_PATH_CQ = "$(subst ",\",$(subst \,\\,$(SHELL_PATH)))"
 SHELL_PATH_CQ_SQ = $(subst ','\'',$(SHELL_PATH_CQ))
diff --git a/config.mak.uname b/config.mak.uname
index 7d31fad..d63babc 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -188,6 +188,7 @@ ifeq ($(uname_S),FreeBSD)
 	endif
 	PYTHON_PATH = /usr/local/bin/python
 	HAVE_PATHS_H = YesPlease
+	PAGER_MORE_UNDERSTANDS_R = YesPlease
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
diff --git a/pager.c b/pager.c
index 90d237e..2303164 100644
--- a/pager.c
+++ b/pager.c
@@ -87,6 +87,10 @@ void setup_pager(void)
 		argv_array_push(&env, "LESS=FRSX");
 	if (!getenv("LV"))
 		argv_array_push(&env, "LV=-c");
+#ifdef PAGER_MORE_UNDERSTANDS_R
+	if (!getenv("MORE"))
+		argv_array_push(&env, "MORE=R");
+#endif
 	pager_process.env = argv_array_detach(&env, NULL);
 
 	if (start_command(&pager_process))
-- 
1.8.5.2.500.g8060133
