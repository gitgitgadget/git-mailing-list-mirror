From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] push: make non-fast-forward help message configurable
Date: Wed, 9 Sep 2009 07:38:58 -0400
Message-ID: <20090909113858.GA31051@coredump.intra.peff.net>
References: <20090909112623.GA30765@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 13:39:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlLW3-0002pl-QP
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 13:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbZIILjC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 07:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbZIILjB
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 07:39:01 -0400
Received: from peff.net ([208.65.91.99]:57492 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbZIILjA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 07:39:00 -0400
Received: (qmail 27970 invoked by uid 107); 9 Sep 2009 11:39:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 09 Sep 2009 07:39:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Sep 2009 07:38:58 -0400
Content-Disposition: inline
In-Reply-To: <20090909112623.GA30765@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128061>

This message is designed to help new users understand what
has happened when refs fail to push. However, it does not
help experienced users at all, and significantly clutters
the output, frequently dwarfing the regular status table and
making it harder to see.

This patch introduces a general configuration mechanism for
optional messages, with this push message as the first
example.

Signed-off-by: Jeff King <peff@peff.net>
---
Changes from the original version:

 - s/message/advice/ in the config and filenames.

 - no more advice.all config option. The point of this is to shut up
   messages that annoy you; It's probably best to let users see a
   message, dislike it, and then turn it off manually after making a
   decision that they don't need or want to see it. But adding a "never
   show me any advice" option means they will never see some of the
   messages, which might otherwise be helpful.

   My thinking here is influenced by the fact that we are usually pretty
   conservative about adding messages in the first place. If we suddenly
   had a period of adding a bunch of "you are clueless, and here is how
   git works" messages, enabled by default, then I might reconsider.

 - I re-worked the code to give each preference its own variable. This
   means we can avoid maintaining a separate list of "#define
   MESSAGE_ONE 1" in addition to the array. It also means that checking
   a preference is a little nicer. Instead of:

     if (advice[ADVICE_PUSH_NONFASTFORWARD].preference)

   you get:

     if (advice_push_nonfastforward)

 Documentation/config.txt |   11 +++++++++++
 Makefile                 |    2 ++
 advice.c                 |   25 +++++++++++++++++++++++++
 advice.h                 |    8 ++++++++
 builtin-push.c           |    2 +-
 cache.h                  |    1 +
 config.c                 |    3 +++
 7 files changed, 51 insertions(+), 1 deletions(-)
 create mode 100644 advice.c
 create mode 100644 advice.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5256c7f..a35b918 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -113,6 +113,17 @@ For command-specific variables, you will find a more detailed description
 in the appropriate manual page. You will find a description of non-core
 porcelain configuration variables in the respective porcelain documentation.
 
+advice.*::
+	When set to 'true', display the given optional help message.
+	When set to 'false', do not display. The configuration variables
+	are:
++
+--
+	pushNonFastForward::
+		Advice shown when linkgit:git-push[1] refuses
+		non-fast-forward refs. Default: true.
+--
+
 core.fileMode::
 	If false, the executable bit differences between the index and
 	the working copy are ignored; useful on broken filesystems like FAT.
diff --git a/Makefile b/Makefile
index a614347..9d9ff45 100644
--- a/Makefile
+++ b/Makefile
@@ -397,6 +397,7 @@ export PERL_PATH
 LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
 
+LIB_H += advice.h
 LIB_H += archive.h
 LIB_H += attr.h
 LIB_H += blob.h
@@ -454,6 +455,7 @@ LIB_H += utf8.h
 LIB_H += wt-status.h
 
 LIB_OBJS += abspath.o
+LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
 LIB_OBJS += archive.o
diff --git a/advice.c b/advice.c
new file mode 100644
index 0000000..b5216a2
--- /dev/null
+++ b/advice.c
@@ -0,0 +1,25 @@
+#include "cache.h"
+
+int advice_push_nonfastforward = 1;
+
+static struct {
+	const char *name;
+	int *preference;
+} advice_config[] = {
+	{ "pushnonfastforward", &advice_push_nonfastforward },
+};
+
+int git_default_advice_config(const char *var, const char *value)
+{
+	const char *k = skip_prefix(var, "advice.");
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(advice_config); i++) {
+		if (strcmp(k, advice_config[i].name))
+			continue;
+		*advice_config[i].preference = git_config_bool(var, value);
+		return 0;
+	}
+
+	return 0;
+}
diff --git a/advice.h b/advice.h
new file mode 100644
index 0000000..862bae3
--- /dev/null
+++ b/advice.h
@@ -0,0 +1,8 @@
+#ifndef ADVICE_H
+#define ADVICE_H
+
+extern int advice_push_nonfastforward;
+
+int git_default_advice_config(const char *var, const char *value);
+
+#endif /* ADVICE_H */
diff --git a/builtin-push.c b/builtin-push.c
index 787011f..6eda372 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -157,7 +157,7 @@ static int do_push(const char *repo, int flags)
 			continue;
 
 		error("failed to push some refs to '%s'", url[i]);
-		if (nonfastforward) {
+		if (nonfastforward && advice_push_nonfastforward) {
 			printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
 			       "Merge the remote changes before pushing again.  See the 'non-fast forward'\n"
 			       "section of 'git push --help' for details.\n");
diff --git a/cache.h b/cache.h
index 5fad24c..e1ab092 100644
--- a/cache.h
+++ b/cache.h
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "hash.h"
+#include "advice.h"
 
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
diff --git a/config.c b/config.c
index e87edea..f21530c 100644
--- a/config.c
+++ b/config.c
@@ -627,6 +627,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	if (!prefixcmp(var, "mailmap."))
 		return git_default_mailmap_config(var, value);
 
+	if (!prefixcmp(var, "advice."))
+		return git_default_advice_config(var, value);
+
 	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
 		pager_use_color = git_config_bool(var,value);
 		return 0;
-- 
1.6.5.rc0.173.g0bfef
