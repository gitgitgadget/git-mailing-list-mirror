From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Push code for transport library
Date: Sun, 8 Jul 2007 16:09:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707081608100.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jul 08 22:09:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7d49-00064F-1h
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 22:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121AbXGHUJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 16:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbXGHUJF
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 16:09:05 -0400
Received: from iabervon.org ([66.92.72.58]:1472 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755455AbXGHUJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 16:09:03 -0400
Received: (qmail 22491 invoked by uid 1000); 8 Jul 2007 20:09:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Jul 2007 20:09:00 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51913>

This moves the code to call push backends into a library that can be
extended to make matching fetch and push decisions based on the URL it
gets, and which could be changed to have built-in implementations
instead of calling external programs.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile       |    3 +-
 builtin-push.c |   92 ++++++++++--------------------
 transport.c    |  177 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 transport.h    |   55 +++++++++++++++++
 4 files changed, 264 insertions(+), 63 deletions(-)
 create mode 100644 transport.c
 create mode 100644 transport.h

diff --git a/Makefile b/Makefile
index 4ea5e45..b8f9af1 100644
--- a/Makefile
+++ b/Makefile
@@ -321,7 +321,8 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o
+	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
+	transport.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/builtin-push.c b/builtin-push.c
index 2612f07..ac8cfa2 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -6,10 +6,11 @@
 #include "run-command.h"
 #include "builtin.h"
 #include "remote.h"
+#include "transport.h"
 
 static const char push_usage[] = "git-push [--all] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
 
-static int all, force, thin = 1, verbose;
+static int all, thin = 1, verbose;
 static const char *receivepack;
 
 static const char **refspec;
@@ -43,80 +44,46 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
-static int do_push(const char *repo)
+static int do_push(const char *repo, int flags)
 {
 	int i, errs;
-	int common_argc;
-	const char **argv;
-	int argc;
 	struct remote *remote = remote_get(repo);
 
 	if (!remote)
 		die("bad repository '%s'", repo);
 
-	if (remote->receivepack) {
-		char *rp = xmalloc(strlen(remote->receivepack) + 16);
-		sprintf(rp, "--receive-pack=%s", remote->receivepack);
-		receivepack = rp;
-	}
 	if (!refspec && !all && remote->push_refspec_nr) {
 		refspec = remote->push_refspec;
 		refspec_nr = remote->push_refspec_nr;
 	}
-
-	argv = xmalloc((refspec_nr + 10) * sizeof(char *));
-	argv[0] = "dummy-send-pack";
-	argc = 1;
-	if (all)
-		argv[argc++] = "--all";
-	if (force)
-		argv[argc++] = "--force";
-	if (receivepack)
-		argv[argc++] = receivepack;
-	common_argc = argc;
-
 	errs = 0;
 	for (i = 0; i < remote->uri_nr; i++) {
-		int err;
-		int dest_argc = common_argc;
-		int dest_refspec_nr = refspec_nr;
-		const char **dest_refspec = refspec;
-		const char *dest = remote->uri[i];
-		const char *sender = "send-pack";
-		if (!prefixcmp(dest, "http://") ||
-		    !prefixcmp(dest, "https://"))
-			sender = "http-push";
-		else {
-			char *rem = xmalloc(strlen(remote->name) + 10);
-			sprintf(rem, "--remote=%s", remote->name);
-			argv[dest_argc++] = rem;
-			if (thin)
-				argv[dest_argc++] = "--thin";
+		struct transport *transport =
+			transport_get(remote, remote->uri[i]);
+		int err = 1;
+		if (receivepack)
+			transport_set_option(transport,
+					     TRANS_OPT_RECEIVEPACK, receivepack);
+		if (thin)
+			transport_set_option(transport, TRANS_OPT_THIN, "yes");
+
+		if (transport->ops->push) {
+			err = 0;
+			if (transport->ops->connect_for_send)
+				err = transport->ops->connect_for_send(transport);
+			if (!err) {
+				if (verbose)
+					fprintf(stderr, "Pushing to %s\n", remote->uri[i]);
+				err = transport->ops->push(transport, refspec_nr, refspec, flags);
+			}
+			if (transport->ops->disconnect)
+				err |= transport->ops->disconnect(transport);
 		}
-		argv[0] = sender;
-		argv[dest_argc++] = dest;
-		while (dest_refspec_nr--)
-			argv[dest_argc++] = *dest_refspec++;
-		argv[dest_argc] = NULL;
-		if (verbose)
-			fprintf(stderr, "Pushing to %s\n", dest);
-		err = run_command_v_opt(argv, RUN_GIT_CMD);
+
 		if (!err)
 			continue;
 
 		error("failed to push to '%s'", remote->uri[i]);
-		switch (err) {
-		case -ERR_RUN_COMMAND_FORK:
-			error("unable to fork for %s", sender);
-		case -ERR_RUN_COMMAND_EXEC:
-			error("unable to exec %s", sender);
-			break;
-		case -ERR_RUN_COMMAND_WAITPID:
-		case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
-		case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
-		case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
-			error("%s died with strange error", sender);
-		}
 		errs++;
 	}
 	return !!errs;
@@ -125,6 +92,7 @@ static int do_push(const char *repo)
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int i;
+	int flags = 0;
 	const char *repo = NULL;	/* default repository */
 
 	for (i = 1; i < argc; i++) {
@@ -144,7 +112,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, "--all")) {
-			all = 1;
+			flags |= TRANSPORT_PUSH_ALL;
 			continue;
 		}
 		if (!strcmp(arg, "--tags")) {
@@ -152,7 +120,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, "--force") || !strcmp(arg, "-f")) {
-			force = 1;
+			flags |= TRANSPORT_PUSH_FORCE;
 			continue;
 		}
 		if (!strcmp(arg, "--thin")) {
@@ -164,11 +132,11 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!prefixcmp(arg, "--receive-pack=")) {
-			receivepack = arg;
+			receivepack = arg + 15;
 			continue;
 		}
 		if (!prefixcmp(arg, "--exec=")) {
-			receivepack = arg;
+			receivepack = arg + 7;
 			continue;
 		}
 		usage(push_usage);
@@ -177,5 +145,5 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (all && refspec)
 		usage(push_usage);
 
-	return do_push(repo);
+	return do_push(repo, flags);
 }
diff --git a/transport.c b/transport.c
new file mode 100644
index 0000000..3b84983
--- /dev/null
+++ b/transport.c
@@ -0,0 +1,177 @@
+#include "cache.h"
+#include "transport.h"
+#include "run-command.h"
+
+static const struct transport_ops rsync_transport = {
+};
+
+static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags) {
+	const char **argv;
+	int argc;
+	int err;
+
+	argv = xmalloc((refspec_nr + 11) * sizeof(char *));
+	argv[0] = "http-push";
+	argc = 1;
+	if (flags & TRANSPORT_PUSH_ALL)
+		argv[argc++] = "--all";
+	if (flags & TRANSPORT_PUSH_FORCE)
+		argv[argc++] = "--force";
+	argv[argc++] = transport->url;
+	while (refspec_nr--)
+		argv[argc++] = *refspec++;
+	argv[argc] = NULL;
+	err = run_command_v_opt(argv, RUN_GIT_CMD);
+	switch (err) {
+	case -ERR_RUN_COMMAND_FORK:
+		error("unable to fork for %s", argv[0]);
+	case -ERR_RUN_COMMAND_EXEC:
+		error("unable to exec %s", argv[0]);
+		break;
+	case -ERR_RUN_COMMAND_WAITPID:
+	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
+	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
+	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
+		error("%s died with strange error", argv[0]);
+	}
+	return !!err;
+}
+
+static const struct transport_ops curl_transport = {
+	.push = curl_transport_push,
+};
+
+static const struct transport_ops bundle_transport = {
+};
+
+struct git_transport_data {
+	unsigned thin : 1;
+
+	const char *receivepack;
+};
+
+static int set_git_option(struct transport *connection,
+			  const char *name, const char *value)
+{
+	struct git_transport_data *data = connection->data;
+	if (!strcmp(name, TRANS_OPT_RECEIVEPACK)) {
+		data->receivepack = value;
+		return 0;
+	} else if (!strcmp(name, TRANS_OPT_THIN)) {
+		data->thin = !!value;
+		return 0;
+	}
+	return 1;
+}
+
+static int git_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags) {
+	struct git_transport_data *data = transport->data;
+	const char **argv;
+	char *rem;
+	int argc;
+	int err;
+
+	argv = xmalloc((refspec_nr + 11) * sizeof(char *));
+	argv[0] = "send-pack";
+	argc = 1;
+	if (flags & TRANSPORT_PUSH_ALL)
+		argv[argc++] = "--all";
+	if (flags & TRANSPORT_PUSH_FORCE)
+		argv[argc++] = "--force";
+	if (data->receivepack) {
+		char *rp = xmalloc(strlen(data->receivepack) + 16);
+		sprintf(rp, "--receive-pack=%s", data->receivepack);
+		argv[argc++] = rp;
+	}
+	if (data->thin)
+		argv[argc++] = "--thin";
+	rem = xmalloc(strlen(transport->remote->name) + 10);
+	sprintf(rem, "--remote=%s", transport->remote->name);
+	argv[argc++] = rem;
+	argv[argc++] = transport->url;
+	while (refspec_nr--)
+		argv[argc++] = *refspec++;
+	argv[argc] = NULL;
+	err = run_command_v_opt(argv, RUN_GIT_CMD);
+	switch (err) {
+	case -ERR_RUN_COMMAND_FORK:
+		error("unable to fork for %s", argv[0]);
+	case -ERR_RUN_COMMAND_EXEC:
+		error("unable to exec %s", argv[0]);
+		break;
+	case -ERR_RUN_COMMAND_WAITPID:
+	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
+	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
+	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
+		error("%s died with strange error", argv[0]);
+	}
+	return !!err;
+}
+
+static const struct transport_ops git_transport = {
+	.set_option = set_git_option,
+	.push = git_transport_push
+};
+
+static int is_local(const char *url)
+{
+	const char *colon = strchr(url, ':');
+	const char *slash = strchr(url, '/');
+	return !colon || (slash && slash < colon);
+}
+
+static int is_file(const char *url)
+{
+	struct stat buf;
+	if (stat(url, &buf))
+		return 0;
+	return S_ISREG(buf.st_mode);
+}
+
+struct transport *transport_get(struct remote *remote, const char *url)
+{
+	struct transport *ret = NULL;
+	if (!prefixcmp(url, "rsync://")) {
+		ret = xmalloc(sizeof(*ret));
+		ret->data = NULL;
+		ret->ops = &rsync_transport;
+	} else if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://") ||
+		   !prefixcmp(url, "ftp://")) {
+		ret = xmalloc(sizeof(*ret));
+		ret->data = NULL;
+		ret->ops = &curl_transport;
+	} else if (is_local(url) && is_file(url)) {
+		ret = xmalloc(sizeof(*ret));
+		ret->data = NULL;
+		ret->ops = &bundle_transport;
+	} else {
+		struct git_transport_data *data = xcalloc(1, sizeof(*data));
+		ret = xcalloc(1, sizeof(*ret));
+		ret->data = data;
+		data->thin = 1;
+		data->receivepack = "git-receive-pack";
+		if (remote->receivepack)
+			data->receivepack = remote->receivepack;
+		ret->ops = &git_transport;
+	}
+	if (ret) {
+		ret->remote = remote;
+		ret->url = url;
+	}
+	return ret;
+}
+
+int transport_set_option(struct transport *transport,
+			 const char *name, const char *value)
+{
+	int ret = 1;
+	if (transport->ops->set_option)
+		ret = transport->ops->set_option(transport, name, value);
+	if (ret < 0)
+		fprintf(stderr, "For '%s' option %s cannot be set to '%s'\n",
+			transport->url, name, value);
+	if (ret > 0)
+		fprintf(stderr, "For '%s' option %s is ignored\n",
+			transport->url, name);
+	return ret;
+}
diff --git a/transport.h b/transport.h
new file mode 100644
index 0000000..bff265a
--- /dev/null
+++ b/transport.h
@@ -0,0 +1,55 @@
+#ifndef TRANSPORT_H
+#define TRANSPORT_H
+
+#include "cache.h"
+#include "remote.h"
+
+struct transport {
+	unsigned verbose : 1;
+	unsigned connected : 1;
+	struct remote *remote;
+	const char *url;
+
+	void *data;
+
+	const struct transport_ops *ops;
+};
+
+#define TRANSPORT_PUSH_ALL 1
+#define TRANSPORT_PUSH_FORCE 2
+
+struct transport_ops {
+	/**
+	 * Returns 0 if successful, positive if the option is not
+	 * recognized or is inapplicable, and negative if the option
+	 * is applicable but the value is invalid.
+	 **/
+	int (*set_option)(struct transport *connection, const char *name,
+			  const char *value);
+
+	int (*connect_for_send)(struct transport *connection);
+
+	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
+
+	int (*disconnect)(struct transport *connection);
+};
+
+/* Returns a transport suitable for the url */
+struct transport *transport_get(struct remote *remote, const char *url);
+
+/* Transport options which apply to git:// and scp-style URLs */
+
+/* The program to use on the remote side to receive a pack */
+#define TRANS_OPT_RECEIVEPACK "receivepack"
+
+/* Transfer the data as a thin pack if not null */
+#define TRANS_OPT_THIN "thin"
+
+/**
+ * Returns 0 if the option was used, non-zero otherwise. Prints a
+ * message to stderr if the option is not used.
+ **/
+int transport_set_option(struct transport *transport, const char *name,
+			 const char *value);
+
+#endif
-- 
1.5.2.2.1399.g097d5-dirty
