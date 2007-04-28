From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/5] Add remote functions
Date: Sat, 28 Apr 2007 13:05:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704281303570.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 19:05:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhqMe-0001A2-SI
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 19:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422AbXD1RFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 13:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756420AbXD1RFg
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 13:05:36 -0400
Received: from iabervon.org ([66.92.72.58]:4833 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161874AbXD1RFL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 13:05:11 -0400
Received: (qmail 7645 invoked by uid 1000); 28 Apr 2007 17:05:09 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Apr 2007 17:05:09 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45782>

Make a struct and a set of functions to handle the parsing of remote
configurations (branches files, remotes files, and config sections),
and do some simple operations on lists of refspecs in the struct.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile |    4 +-
 remote.c |  241 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h |   25 +++++++
 3 files changed, 268 insertions(+), 2 deletions(-)
 create mode 100644 remote.c
 create mode 100644 remote.h

diff --git a/Makefile b/Makefile
index 60c41fd..98916f7 100644
--- a/Makefile
+++ b/Makefile
@@ -288,7 +288,7 @@ LIB_H = \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
-	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h
+	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h remote.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -310,7 +310,7 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o attr.o decorate.o progress.o
+	convert.o attr.o decorate.o progress.o remote.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/remote.c b/remote.c
new file mode 100644
index 0000000..58e6a96
--- /dev/null
+++ b/remote.c
@@ -0,0 +1,241 @@
+#include "cache.h"
+#include "remote.h"
+
+#define MAX_REMOTES 16
+
+static struct remote *remotes[MAX_REMOTES];
+
+#define BUF_SIZE (2084)
+static char buffer[BUF_SIZE];
+
+static void add_push_refspec(struct remote *remote, const char *ref)
+{
+	int nr = remote->push_refspec_nr + 1;
+	remote->push_refspec =
+		xrealloc(remote->push_refspec, nr * sizeof(char *));
+	remote->push_refspec[nr-1] = ref;
+	remote->push_refspec_nr = nr;
+}
+
+static void add_fetch_refspec(struct remote *remote, const char *ref)
+{
+	int nr = remote->fetch_refspec_nr + 1;
+	remote->fetch_refspec =
+		xrealloc(remote->fetch_refspec, nr * sizeof(char *));
+	remote->fetch_refspec[nr-1] = ref;
+	remote->fetch_refspec_nr = nr;
+}
+
+static void add_uri(struct remote *remote, const char *uri)
+{
+	int i;
+	for (i = 0; i < MAX_REMOTE_URI; i++) {
+		if (!remote->uri[i]) {
+			remote->uri[i] = uri;
+			return;
+		}
+	}
+	error("ignoring excess uri");
+}
+
+static struct remote *make_remote(const char *name, int len)
+{
+	int i, empty = -1;
+
+	for (i = 0; i < MAX_REMOTES; i++) {
+		if (!remotes[i]) {
+			if (empty < 0)
+				empty = i;
+		} else {
+			if (len ? !strncmp(name, remotes[i]->name, len) :
+			    !strcmp(name, remotes[i]->name))
+				return remotes[i];
+		}
+	}
+
+	if (empty < 0)
+		die("Too many remotes");
+	remotes[empty] = xcalloc(1, sizeof(struct remote));
+	if (len)
+		remotes[empty]->name = xstrndup(name, len);
+	else
+		remotes[empty]->name = xstrdup(name);
+	return remotes[empty];
+}
+
+static void read_remotes_file(struct remote *remote)
+{
+	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
+
+	if (!f)
+		return;
+	while (fgets(buffer, BUF_SIZE, f)) {
+		int is_refspec;
+		char *s, *p;
+
+		if (!prefixcmp(buffer, "URL:")) {
+			is_refspec = 0;
+			s = buffer + 4;
+		} else if (!prefixcmp(buffer, "Push:")) {
+			is_refspec = 1;
+			s = buffer + 5;
+		} else if (!prefixcmp(buffer, "Pull:")) {
+			is_refspec = 2;
+			s = buffer + 5;
+		} else
+			continue;
+
+		while (isspace(*s))
+			s++;
+		if (!*s)
+			continue;
+
+		p = s + strlen(s);
+		while (isspace(p[-1]))
+			*--p = 0;
+
+		switch (is_refspec) {
+		case 0:
+			add_uri(remote, xstrdup(s));
+			break;
+		case 1:
+			add_push_refspec(remote, xstrdup(s));
+			break;
+		case 2:
+			add_fetch_refspec(remote, xstrdup(s));
+			break;
+		}
+	}
+}
+
+static void read_branches_file(struct remote *remote)
+{
+	const char *slash = strchr(remote->name, '/');
+	int n = slash ? slash - remote->name : 1000;
+	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
+	char *s, *p;
+	int len;
+
+	if (!f)
+		return;
+	s = fgets(buffer, BUF_SIZE, f);
+	fclose(f);
+	if (!s)
+		return;
+	while (isspace(*s))
+		s++;
+	if (!*s)
+		return;
+	p = s + strlen(s);
+	while (isspace(p[-1]))
+		*--p = 0;
+	len = p - s;
+	if (slash)
+		len += strlen(slash);
+	p = xmalloc(len + 1);
+	strcpy(p, s);
+	if (slash)
+		strcat(p, slash);
+	remote->uri[0] = p;
+}
+
+static const char *default_remote_name = NULL;
+static const char *current_branch = NULL;
+static int current_branch_len = 0;
+
+static int handle_config(const char *key, const char *value)
+{
+	const char *name;
+	const char *subkey;
+	struct remote *remote;
+	if (!prefixcmp(key, "branch.") && current_branch &&
+	    !strncmp(key + 7, current_branch, current_branch_len) &&
+	    !strcmp(key + 7 + current_branch_len, ".remote")) {
+		default_remote_name = xstrdup(value);
+	}
+	if (prefixcmp(key,  "remote."))
+		return 0;
+	name = key + 7;
+	subkey = strchr(name, '.');
+	if (!subkey)
+		return error("Config with no key for remote %s", name);
+	remote = make_remote(name, subkey - name);
+	if (!strcmp(subkey, ".url")) {
+		add_uri(remote, xstrdup(value));
+	} else if (!strcmp(subkey, ".push")) {
+		add_push_refspec(remote, xstrdup(value));
+	} else if (!strcmp(subkey, ".fetch")) {
+		add_fetch_refspec(remote, xstrdup(value));
+	} else if (!strcmp(subkey, ".receivepack")) {
+		if (!remote->receivepack)
+			remote->receivepack = xstrdup(value);
+		else
+			error("more than one receivepack given, using the first");
+	}
+	return 0;
+}
+
+static void read_config(void)
+{
+	if (default_remote_name) // did this already
+		return;
+	default_remote_name = xstrdup("origin");
+	current_branch = NULL;
+	git_config(handle_config);
+}
+
+struct remote *remote_get(const char *name)
+{
+	struct remote *ret;
+
+	read_config();
+	if (!name)
+		name = default_remote_name;
+	ret = make_remote(name, 0);
+	if (*name == '/')
+		ret->uri[0] = name;
+	if (!ret->uri[0])
+		read_remotes_file(ret);
+	if (!ret->uri[0])
+		read_branches_file(ret);
+	if (!ret->uri[0])
+		return NULL;
+	return ret;
+}
+
+int remote_has_uri(struct remote *remote, const char *uri)
+{
+	int i;
+	for (i = 0; i < MAX_REMOTE_URI; i++) {
+		if (remote->uri[i] && !strcmp(remote->uri[i], uri))
+			return 1;
+	}
+	return 0;
+}
+
+char *remote_fetch_to(struct remote *remote, const char *ref)
+{
+	int i;
+	for (i = 0; i < remote->fetch_refspec_nr; i++) {
+		const char *refspec = remote->fetch_refspec[i];
+		const char *cons = strchr(refspec, ':');
+		const char *glob = strchr(refspec, '*');
+		if (*refspec == '+')
+			refspec++;
+		if (glob) {
+			if (!strncmp(ref, refspec, glob - refspec)) {
+				const char *cons_glob = strchr(cons, '*');
+				char *ret =
+					xmalloc(cons_glob - cons + strlen(ref) - (glob - refspec));
+				memcpy(ret, cons + 1, cons_glob - cons - 1);
+				memcpy(ret + (cons_glob - cons) - 1,
+				       ref + (glob - refspec),
+				       strlen(ref) - (glob - refspec) + 1);
+				return ret;
+			}
+		} else if (!strncmp(ref, refspec, cons - refspec)) {
+			return xstrdup(cons + 1);
+		}
+	}
+	return NULL;
+}
diff --git a/remote.h b/remote.h
new file mode 100644
index 0000000..7e881f7
--- /dev/null
+++ b/remote.h
@@ -0,0 +1,25 @@
+#ifndef _REMOTE_H
+#define _REMOTE_H
+
+#define MAX_REMOTE_URI 16
+
+struct remote {
+	const char *name;
+	const char *uri[MAX_REMOTE_URI];
+
+	const char **push_refspec;
+	int push_refspec_nr;
+
+	const char **fetch_refspec;
+	int fetch_refspec_nr;
+
+	const char *receivepack;
+};
+
+struct remote *remote_get(const char *name);
+
+int remote_has_uri(struct remote *remote, const char *uri);
+
+char *remote_fetch_to(struct remote *remote, const char *ref);
+
+#endif
-- 
1.5.1.2.255.g6ead4-dirty
