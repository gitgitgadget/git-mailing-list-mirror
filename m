From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/3 v3] Add support for external programs for handling native
 fetches
Date: Fri, 31 Jul 2009 01:26:38 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907310109130.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 07:26:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWkdh-0001ud-4S
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 07:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbZGaF0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 01:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbZGaF0l
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 01:26:41 -0400
Received: from iabervon.org ([66.92.72.58]:54992 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165AbZGaF0j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 01:26:39 -0400
Received: (qmail 5897 invoked by uid 1000); 31 Jul 2009 05:26:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jul 2009 05:26:38 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124502>

transport_get() can call transport_native_helper_init() to have list and
fetch-ref operations handled by running a separate program as:

 git remote-<something> <remote> [<url>]

This program then accepts, on its stdin, "list" and "fetch <hex>
<name>" commands; the former prints out a list of available refs and
either their hashes or what they are symreefs to, while the latter
fetches them into the local object database and prints a newline when done.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
dscho: it turned out that disconnect...() is a method defined to return 
int.

 Documentation/git-remote-helpers.txt |   72 +++++++++++++++
 Makefile                             |    1 +
 transport-helper.c                   |  168 ++++++++++++++++++++++++++++++++++
 transport.h                          |    3 +
 4 files changed, 244 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-helpers.txt
 create mode 100644 transport-helper.c

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
new file mode 100644
index 0000000..86a9c3f
--- /dev/null
+++ b/Documentation/git-remote-helpers.txt
@@ -0,0 +1,72 @@
+git-remote-helpers(1)
+=====================
+
+NAME
+----
+git-remote-helpers - Helper programs for interoperation with remote git
+
+SYNOPSIS
+--------
+'git remote-<transport>' <remote>
+
+DESCRIPTION
+-----------
+
+These programs are normally not used directly by end users, but are
+invoked by various git programs that interact with remote repositories
+when the repository they would operate on will be accessed using
+transport code not linked into the main git binary. Various particular
+helper programs will behave as documented here.
+
+COMMANDS
+--------
+
+Commands are given by the caller on the helper's standard input, one per line.
+
+'capabilities'::
+	Lists the capabilities of the helper, one per line, ending
+	with a blank line.
+
+'list'::
+	Lists the refs, one per line, in the format "<value> <name>
+	[<attr> ...]". The value may be a hex sha1 hash, "@<dest>" for
+	a symref, or "?" to indicate that the helper could not get the
+	value of the ref. A space-separated list of attributes follows
+	the name; unrecognized attributes are ignored. After the
+	complete list, outputs a blank line.
+
+'fetch' <sha1> <name>::
+	Fetches the given object, writing the necessary objects to the
+	database. Outputs a blank line when the fetch is
+	complete. Only objects which were reported in the ref list
+	with a sha1 may be fetched this way.
++
+Supported if the helper has the "fetch" capability.
+
+If a fatal error occurs, the program writes the error message to
+stderr and exits. The caller should expect that a suitable error
+message has been printed if the child closes the connection without
+completing a valid response for the current command.
+
+Additional commands may be supported, as may be determined from
+capabilities reported by the helper.
+
+CAPABILITIES
+------------
+
+'fetch'::
+	This helper supports the 'fetch' command, with the object
+	specified using a sha1 or ref name as specified.
+
+REF LIST ATTRIBUTES
+-------------------
+
+None are defined yet, but the caller must accept any which are supplied.
+
+Documentation
+-------------
+Documentation by Daniel Barkalow.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index daf4296..504646a 100644
--- a/Makefile
+++ b/Makefile
@@ -549,6 +549,7 @@ LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
 LIB_OBJS += transport.o
+LIB_OBJS += transport-helper.o
 LIB_OBJS += tree-diff.o
 LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
diff --git a/transport-helper.c b/transport-helper.c
new file mode 100644
index 0000000..a879bc6
--- /dev/null
+++ b/transport-helper.c
@@ -0,0 +1,168 @@
+#include "cache.h"
+#include "transport.h"
+
+#include "run-command.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+
+struct helper_data
+{
+	const char *name;
+	struct child_process *helper;
+	unsigned fetch : 1;
+};
+
+static struct child_process *get_helper(struct transport *transport)
+{
+	struct helper_data *data = transport->data;
+	struct strbuf buf = STRBUF_INIT;
+	struct child_process *helper;
+	FILE *file;
+
+	if (data->helper)
+		return data->helper;
+
+	helper = xcalloc(1, sizeof(*helper));
+	helper->in = -1;
+	helper->out = -1;
+	helper->err = 0;
+	helper->argv = xcalloc(4, sizeof(*helper->argv));
+	strbuf_addf(&buf, "remote-%s", data->name);
+	helper->argv[0] = strbuf_detach(&buf, NULL);
+	helper->argv[1] = transport->remote->name;
+	helper->argv[2] = transport->url;
+	helper->git_cmd = 1;
+	if (start_command(helper))
+		die("Unable to run helper: git %s", helper->argv[0]);
+	data->helper = helper;
+
+	write_in_full(data->helper->in, "capabilities\n", 13);
+	file = xfdopen(helper->out, "r");
+	while (1) {
+		if (strbuf_getline(&buf, file, '\n') == EOF)
+			exit(128); /* child died, message supplied already */
+
+		if (!*buf.buf)
+			break;
+		if (!strcmp(buf.buf, "fetch"))
+			data->fetch = 1;
+	}
+	return data->helper;
+}
+
+static int disconnect_helper(struct transport *transport)
+{
+	struct helper_data *data = transport->data;
+	if (data->helper) {
+		write_in_full(data->helper->in, "\n", 1);
+		close(data->helper->in);
+		finish_command(data->helper);
+		free((char *)data->helper->argv[0]);
+		free(data->helper->argv);
+		free(data->helper);
+		data->helper = NULL;
+	}
+	return 0;
+}
+
+static int fetch(struct transport *transport,
+		 int nr_heads, const struct ref **to_fetch)
+{
+	struct helper_data *data = transport->data;
+	struct child_process *helper;
+	const struct ref *posn;
+	struct strbuf buf = STRBUF_INIT;
+	int i, count;
+	FILE *file;
+
+	count = 0;
+	for (i = 0; i < nr_heads; i++) {
+		posn = to_fetch[i];
+		if (posn->status & REF_STATUS_UPTODATE)
+			continue;
+		count++;
+	}
+
+	if (!count)
+		return 0;
+
+	helper = get_helper(transport);
+
+	if (!data->fetch)
+		return -1;
+
+	file = xfdopen(helper->out, "r");
+	for (i = 0; i < nr_heads; i++) {
+		posn = to_fetch[i];
+		if (posn->status & REF_STATUS_UPTODATE)
+			continue;
+		write_in_full(helper->in, "fetch ", 6);
+		write_in_full(helper->in, sha1_to_hex(posn->old_sha1), 40);
+		write_in_full(helper->in, " ", 1);
+		write_in_full(helper->in, posn->name, strlen(posn->name));
+		write_in_full(helper->in, "\n", 1);
+		if (strbuf_getline(&buf, file, '\n') == EOF)
+			exit(128); /* child died, message supplied already */
+	}
+	return 0;
+}
+
+static struct ref *get_refs_list(struct transport *transport, int for_push)
+{
+	struct child_process *helper;
+	struct ref *ret = NULL;
+	struct ref **tail = &ret;
+	struct ref *posn;
+	struct strbuf buf = STRBUF_INIT;
+	FILE *file;
+
+	helper = get_helper(transport);
+	write_in_full(helper->in, "list\n", 5);
+
+	file = xfdopen(helper->out, "r");
+	while (1) {
+		char *eov, *eon;
+		if (strbuf_getline(&buf, file, '\n') == EOF)
+			exit(128); /* child died, message supplied already */
+
+		if (!*buf.buf)
+			break;
+
+		eov = strchr(buf.buf, ' ');
+		if (!eov)
+			die("Malformed response in ref list: %s", buf.buf);
+                eon = strchr(eov + 1, ' ');
+		*eov = '\0';
+                if (eon)
+                        *eon = '\0';
+		*tail = alloc_ref(eov + 1);
+		if (buf.buf[0] == '@')
+			(*tail)->symref = xstrdup(buf.buf + 1);
+		else if (buf.buf[0] != '?')
+			get_sha1_hex(buf.buf, (*tail)->old_sha1);
+		tail = &((*tail)->next);
+		strbuf_reset(&buf);
+	}
+	strbuf_release(&buf);
+
+	for (posn = ret; posn; posn = posn->next)
+		resolve_remote_symref(posn, ret);
+
+	return ret;
+}
+
+int transport_native_helper_init(struct transport *transport)
+{
+	struct helper_data *data = xmalloc(sizeof(*data));
+	char *eom = strchr(transport->url, ':');
+	if (!eom)
+		return -1;
+	data->helper = NULL;
+	data->name = xstrndup(transport->url, eom - transport->url);
+	transport->data = data;
+	transport->get_refs_list = get_refs_list;
+	transport->fetch = fetch;
+	transport->disconnect = disconnect_helper;
+	return 0;
+}
diff --git a/transport.h b/transport.h
index 51b5397..fff9d8c 100644
--- a/transport.h
+++ b/transport.h
@@ -77,4 +77,7 @@ void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
 
+/* Transport methods defined outside transport.c */
+int transport_native_helper_init(struct transport *transport);
+
 #endif
-- 
1.6.4.rc3.25.gd5eff.dirty
