From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/1] [PROPOSAL] Add a module (repo-log.c) to log repository events.
Date: Thu, 16 Jun 2005 13:59:24 +1000
Message-ID: <20050616035924.31808.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 16 05:55:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DilSz-0001Km-1X
	for gcvg-git@gmane.org; Thu, 16 Jun 2005 05:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVFPD75 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 23:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVFPD75
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 23:59:57 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:22657 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261727AbVFPD72 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 23:59:28 -0400
Received: (qmail 31818 invoked by uid 500); 16 Jun 2005 03:59:24 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch contains a header file that illustrates a proposed
repository event logging module.

The motivations for introducing such a module are documented
in the proposed header. There are probably good reasons for
taking a similar approach to logging cache events, since
to do so would provide a robust undo/redo facility that
is guaranteed to be able to reconstruct the workspace to any
previous state.

This patch is posted to the list to solicit feedback that
I'll try to incorporate as I proceed with the implementation.
---

 repo-log.h |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 135 insertions(+), 0 deletions(-)

diff --git a/repo-log.h b/repo-log.h
new file mode 100644
--- /dev/null
+++ b/repo-log.h
@@ -0,0 +1,135 @@
+#ifndef REPOLOG_H
+#define REPOLOG_H
+/*
+ * Copyright (c) 2005, Jon Seymour
+ * 
+ * This module provides an API for logging significant 
+ * repository events via a logging API.
+ * 
+ * There are several uses for this feature:
+ * 	* identifying new objects to be pushed "somewhere else". Somewhere else
+ *        could be:
+ *             * another repository (via rsync)
+ * 	       * another kind of representation (e.g. an XML extract, 
+ * 		 a patch extract)
+ * 	       * another view (e.g. a GITK instance)
+ *             * another kind of repository database (e.g. MySQL)
+ *             * another kind of SCM (e.g. CVS)
+ *             * another more compact representation (e.g. an deltification 
+ * 		 process)
+ * 	* helping to locate versions of stuff when the workspace
+ *        (user) gets confused.
+ * 
+ * NOTE: this would probably be even more useful for the index 
+ * allowing a provably correct workspace undo/redo implementation, 
+ * however, let's bite-off one piece at a time.
+ */
+
+#define REPO_LOG_STOP  (1u << 1)
+#define REPO_LOG_ERROR (1u << 2)
+#define REPO_LOG_FATAL (1u << 4)
+
+struct repo_log_event_data {
+	/**
+	 * Flags set by handlers to communicate actions to the logging API
+	 *     STOP  - the event has been handled and no further dispatch
+	 *             should be performed. Filtering type handlers should
+	 * 	       set this flag.
+	 *     ERROR - a non-fatal error occured, but the logging API
+	 *             should return.
+	 *     FATAL - a fatal event occurred during logging and the logging
+	 * 	       API should die before returning.
+	 */
+	unsigned int flags;
+	
+	/**
+	 * The type of event being logged. It is either an object type
+	 * such as: blob, commit, tree, delta or tag or it is a label.
+	 */
+	char * objtype;
+	
+	/**
+	 * The timestamp of the event being logged.
+	 */
+	struct tm * timestamp;	
+	
+	/**
+	 * The sha1 associated with a repository object event. 
+	 * Set to NULL for label events.
+	 */
+	unsigned char * sha1;
+	
+	/**
+	 * The label associated with the event.
+	 */
+	char * label;
+};
+
+/**
+ * Describes a repository log event handler.
+ * 
+ * Private data associated with the handler can be placed in the 
+ * later parts of a containing data structure.
+ * 
+ * struct private_handler_data {
+ * 	struct repo_log_event_handler handler;
+ * 	char * some_private_data;
+ * 	...
+ * }
+ * repo_log_register_handler(&private_handler_data.handler);
+ * 
+ */
+struct repo_log_event_handler {
+	/**
+	 * This method is called once for each repo log event that occurs.
+	 */	 
+	void (*method)(struct repo_log_event_handler *, struct repo_log_event_data *);
+	
+	/**
+	 * Initialized by repo_log_register_handler. 
+	 * Private to repo-log.c, should not be used or modified elsewhere.
+	 */
+	struct repo_log_event_handler * next;
+}
+
+/*
+ * Answers true if repository logging is enabled.
+ * 
+ * Repository logging is enabled if repo_log_register_handler
+ * has been called or if GIT_REPO_LOG_PATH is set to a 
+ * writeable name.
+ */
+int repo_log_logging_enabled();
+
+/*
+ * Registers a new repo_log_event handler.
+ * 
+ * The method associated with this handler will be invoked
+ * each time a repository event occurs.
+ */
+void repo_log_register_handler(repo_log_event_handler * handler);
+
+/*
+ * Logs a repository event.
+ * 
+ * Returns false if the logging was not successful.
+ */ 
+int repo_log_event(struct tm * tm, char * objtype, unsigned char * sha1);
+
+/*
+ * Writes a label into the repository event log. 
+ * 
+ * The label is validated to ensure it only contains
+ * graphic ASCII characters in the range 0x21 -> 0x7f.
+ * 
+ * Labels are for informational purposes only and need 
+ * not be unique.
+ */ 
+int repo_log_label(char * label);
+
+/*
+ * Logs a repository event, using the timestamp extracted from the (closed) 
+ * file.
+ */
+int repo_log_event_file(char * filename, char * objtype, unsigned char * sha1);
+#endif /* REPOLOG_H */
------------
