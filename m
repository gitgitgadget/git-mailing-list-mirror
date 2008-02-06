From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] allow GIT_CONFIG_ETC to override compile-time setting
Date: Wed, 6 Feb 2008 04:07:36 -0500
Message-ID: <20080206090736.GA3258@coredump.intra.peff.net>
References: <20080206090453.GA6762@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 10:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMgGL-0004SP-Op
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 10:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759661AbYBFJHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 04:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759626AbYBFJHk
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 04:07:40 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2926 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759538AbYBFJHi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 04:07:38 -0500
Received: (qmail 27274 invoked by uid 111); 6 Feb 2008 09:07:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 06 Feb 2008 04:07:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2008 04:07:36 -0500
Content-Disposition: inline
In-Reply-To: <20080206090453.GA6762@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72775>

This is not expected to be used by mere mortals, since the
GIT_CONFIG_LOCAL variable already accomplishes more or less
the same thing. However, to keep the testing environment
clean, it is necessary to be able to suppress the use of
this file (which may have settings that interfere with the
tests).

Signed-off-by: Jeff King <peff@peff.net>
---
Junio, more rationale for the series is available in the first message
of the thread.

 cache.h  |    1 +
 config.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 549f4bb..d8322a1 100644
--- a/cache.h
+++ b/cache.h
@@ -208,6 +208,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_LOCAL_ENVIRONMENT "GIT_CONFIG_LOCAL"
+#define CONFIG_ETC_ENVIRONMENT "GIT_CONFIG_ETC"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
diff --git a/config.c b/config.c
index 498259e..2a0d005 100644
--- a/config.c
+++ b/config.c
@@ -481,7 +481,9 @@ const char *git_etc_gitconfig(void)
 {
 	static const char *system_wide;
 	if (!system_wide) {
-		system_wide = ETC_GITCONFIG;
+		system_wide = getenv(CONFIG_ETC_ENVIRONMENT);
+	        if (!system_wide)
+			system_wide = ETC_GITCONFIG;
 		if (!is_absolute_path(system_wide)) {
 			/* interpret path relative to exec-dir */
 			struct strbuf d = STRBUF_INIT;
-- 
1.5.4.26.g9be9
