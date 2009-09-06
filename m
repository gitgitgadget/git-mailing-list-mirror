From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] push: make non-fast-forward help message configurable
Date: Sun, 6 Sep 2009 02:48:16 -0400
Message-ID: <20090906064816.GC28941@coredump.intra.peff.net>
References: <20090906064454.GA1643@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 08:48:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkBY3-0006hG-EL
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 08:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbZIFGsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 02:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754556AbZIFGsS
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 02:48:18 -0400
Received: from peff.net ([208.65.91.99]:57243 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbZIFGsS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 02:48:18 -0400
Received: (qmail 9438 invoked by uid 107); 6 Sep 2009 06:48:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Sep 2009 02:48:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Sep 2009 02:48:16 -0400
Content-Disposition: inline
In-Reply-To: <20090906064454.GA1643@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127838>

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
Probably "messages" is too vague a term to use in the code and config.
Maybe "advice.*"?

 Documentation/config.txt |   16 ++++++++++++++++
 Makefile                 |    2 ++
 builtin-push.c           |    3 ++-
 cache.h                  |    1 +
 config.c                 |    3 +++
 messages.c               |   28 ++++++++++++++++++++++++++++
 messages.h               |   15 +++++++++++++++
 7 files changed, 67 insertions(+), 1 deletions(-)
 create mode 100644 messages.c
 create mode 100644 messages.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5256c7f..ec308a6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1201,6 +1201,22 @@ mergetool.keepTemporaries::
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
 
+message.all::
+	When set to 'true', display all optional help messages. When set
+	to 'false', do not display any. Defaults vary with individual
+	messages (see message.* below).
+
+message.*::
+	When set to 'true', display the given optional help message.
+	When set to 'false', do not display. The configuration variables
+	are:
++
+--
+	pushNonFastForward::
+		Help message shown when linkgit:git-push[1] refuses
+		non-fast-forward refs. Default: true.
+--
+
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
diff --git a/Makefile b/Makefile
index a614347..0785977 100644
--- a/Makefile
+++ b/Makefile
@@ -424,6 +424,7 @@ LIB_H += ll-merge.h
 LIB_H += log-tree.h
 LIB_H += mailmap.h
 LIB_H += merge-recursive.h
+LIB_H += messages.h
 LIB_H += object.h
 LIB_H += pack.h
 LIB_H += pack-refs.h
@@ -506,6 +507,7 @@ LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
 LIB_OBJS += merge-recursive.o
+LIB_OBJS += messages.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-check.o
diff --git a/builtin-push.c b/builtin-push.c
index 787011f..dceac9f 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -157,7 +157,8 @@ static int do_push(const char *repo, int flags)
 			continue;
 
 		error("failed to push some refs to '%s'", url[i]);
-		if (nonfastforward) {
+		if (nonfastforward &&
+		    messages[MESSAGE_PUSH_NONFASTFORWARD].preference) {
 			printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
 			       "Merge the remote changes before pushing again.  See the 'non-fast forward'\n"
 			       "section of 'git push --help' for details.\n");
diff --git a/cache.h b/cache.h
index 5fad24c..32d1a27 100644
--- a/cache.h
+++ b/cache.h
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "hash.h"
+#include "messages.h"
 
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
diff --git a/config.c b/config.c
index e87edea..aed1547 100644
--- a/config.c
+++ b/config.c
@@ -627,6 +627,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	if (!prefixcmp(var, "mailmap."))
 		return git_default_mailmap_config(var, value);
 
+	if (!prefixcmp(var, "message."))
+		return git_default_message_config(var, value);
+
 	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
 		pager_use_color = git_config_bool(var,value);
 		return 0;
diff --git a/messages.c b/messages.c
new file mode 100644
index 0000000..00fc196
--- /dev/null
+++ b/messages.c
@@ -0,0 +1,28 @@
+#include "cache.h"
+#include "messages.h"
+
+struct message_preference messages[] = {
+	{ "pushnonfastforward", 1 },
+};
+
+int git_default_message_config(const char *var, const char *value)
+{
+	const char *k = skip_prefix(var, "message.");
+	int i;
+
+	if (!strcmp(k, "all")) {
+		int v = git_config_bool(var, value);
+		for (i = 0; i < ARRAY_SIZE(messages); i++)
+			messages[i].preference = v;
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(messages); i++) {
+		if (strcmp(k, messages[i].name))
+			continue;
+		messages[i].preference = git_config_bool(var, value);
+		return 0;
+	}
+
+	return 0;
+}
diff --git a/messages.h b/messages.h
new file mode 100644
index 0000000..f175747
--- /dev/null
+++ b/messages.h
@@ -0,0 +1,15 @@
+#ifndef MESSAGE_H
+#define MESSAGE_H
+
+#define MESSAGE_PUSH_NONFASTFORWARD 0
+
+struct message_preference {
+	const char *name;
+	int preference;
+};
+
+extern struct message_preference messages[];
+
+int git_default_message_config(const char *var, const char *value);
+
+#endif /* MESSAGE_H */
-- 
1.6.4.2.266.g981efc.dirty
