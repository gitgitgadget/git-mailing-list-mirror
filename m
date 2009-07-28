From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/3 v2] Add support for external programs for handling native
 fetches
Date: Tue, 28 Jul 2009 02:08:49 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907280155390.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Mariano Ortega <mgo1977@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 08:09:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVfs1-0004gk-AT
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 08:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbZG1GI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 02:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbZG1GI5
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 02:08:57 -0400
Received: from iabervon.org ([66.92.72.58]:58961 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716AbZG1GIw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 02:08:52 -0400
Received: (qmail 4137 invoked by uid 1000); 28 Jul 2009 06:08:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Jul 2009 06:08:49 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124213>

transport_get() can call transport_shim_init() to have list and
fetch-ref operations handled by running a separate program as:

 git shim-<something> <remote> [<url>]

This program then accepts, on its stdin, "list" and "fetch <hex>
<name>" commands; the former prints out a list of available refs and
either their hashes or what they are symrefs to, while the latter
fetches them into the local object database and prints a newline when done.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
This version uses the more traditional ordering for listing refs and fixes 
a memory leak.

 Documentation/git-shim.txt |   37 +++++++++++
 Makefile                   |    1 +
 transport-shim.c           |  142 ++++++++++++++++++++++++++++++++++++++++++++
 transport.h                |    3 +
 4 files changed, 183 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-shim.txt
 create mode 100644 transport-shim.c

diff --git a/Documentation/git-shim.txt b/Documentation/git-shim.txt
new file mode 100644
index 0000000..dd80c6d
--- /dev/null
+++ b/Documentation/git-shim.txt
@@ -0,0 +1,37 @@
+git-shim(1)
+============
+
+NAME
+----
+git-shim - Helper programs for interoperation with remote git
+
+SYNOPSIS
+--------
+'git shim-<transport>' <remote>
+
+DESCRIPTION
+-----------
+
+These programs are normally not used directly by end users, but are
+invoked by various git programs that interact with remote repositories
+when the repository they would operate on will be accessed using
+transport code not linked into the main git binary.
+
+COMMANDS
+--------
+
+Commands are given by the caller on the helper's standard input, one per line.
+
+'list'::
+	Lists the refs, one per line, if the format "<value>
+	<name>". The value is either a hex sha1 hash or "@<dest>" for
+	symrefs. After the complete list, outputs a blank line.
+
+'fetch' ref::
+	Fetches the given ref, writing the necessary objects to the
+	database. Outputs a blank line when the fetch is complete.
++
+If a fatal error occurs, the program writes the error message to
+stderr and exits. The caller should expect that a suitable error
+message has been printed if the child closes the connection without
+completing a valid response for the current command.
diff --git a/Makefile b/Makefile
index bde27ed..01efc73 100644
--- a/Makefile
+++ b/Makefile
@@ -549,6 +549,7 @@ LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
 LIB_OBJS += transport.o
+LIB_OBJS += transport-shim.o
 LIB_OBJS += tree-diff.o
 LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
diff --git a/transport-shim.c b/transport-shim.c
new file mode 100644
index 0000000..2518aba
--- /dev/null
+++ b/transport-shim.c
@@ -0,0 +1,142 @@
+#include "cache.h"
+#include "transport.h"
+
+#include "run-command.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+
+struct shim_data
+{
+	const char *name;
+	struct child_process *shim;
+};
+
+static struct child_process *get_shim(struct transport *transport)
+{
+	struct shim_data *data = transport->data;
+	if (!data->shim) {
+		struct strbuf buf = STRBUF_INIT;
+		struct child_process *shim = xcalloc(1, sizeof(*shim));
+		shim->in = -1;
+		shim->out = -1;
+		shim->err = 0;
+		shim->argv = xcalloc(4, sizeof(*shim->argv));
+		strbuf_addf(&buf, "shim-%s", data->name);
+		shim->argv[0] = buf.buf;
+		shim->argv[1] = transport->remote->name;
+		shim->argv[2] = transport->url;
+		shim->git_cmd = 1;
+		start_command(shim);
+		data->shim = shim;
+	}
+	return data->shim;
+}
+
+static int disconnect_shim(struct transport *transport)
+{
+	struct shim_data *data = transport->data;
+	if (data->shim) {
+		write(data->shim->in, "\n", 1);
+		close(data->shim->in);
+		finish_command(data->shim);
+		free(data->shim->argv);
+		free(data->shim);
+		transport->data = NULL;
+	}
+	return 0;
+}
+
+static int fetch_refs_via_shim(struct transport *transport,
+			       int nr_heads, const struct ref **to_fetch)
+{
+	struct child_process *shim;
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
+	if (count) {
+		shim = get_shim(transport);
+		for (i = 0; i < nr_heads; i++) {
+			posn = to_fetch[i];
+			if (posn->status & REF_STATUS_UPTODATE)
+				continue;
+			write(shim->in, "fetch ", 6);
+			write(shim->in, sha1_to_hex(posn->old_sha1), 40);
+			write(shim->in, " ", 1);
+			write(shim->in, posn->name, strlen(posn->name));
+			write(shim->in, "\n", 1);
+		}
+		file = fdopen(shim->out, "r");
+		while (count) {
+			if (strbuf_getline(&buf, file, '\n') == EOF)
+				exit(128); /* child died, message supplied already */
+
+			count--;
+		}
+	}
+	return 0;
+}
+
+static struct ref *get_refs_via_shim(struct transport *transport, int for_push)
+{
+	struct child_process *shim;
+	struct ref *ret = NULL;
+	struct ref **end = &ret;
+	struct ref *posn;
+	struct strbuf buf = STRBUF_INIT;
+	FILE *file;
+
+	shim = get_shim(transport);
+	write(shim->in, "list\n", 5);
+
+	file = fdopen(shim->out, "r");
+	while (1) {
+		char *eov;
+		if (strbuf_getline(&buf, file, '\n') == EOF)
+			exit(128); /* child died, message supplied already */
+
+		if (!*buf.buf)
+			break;
+
+		eov = strchr(buf.buf, ' ');
+		if (!eov)
+			die("Malformed response in ref list: %s", buf.buf);
+		*eov = '\0';
+		*end = alloc_ref(eov + 1);
+		if (eov) {
+			if (buf.buf[0] == '@')
+				(*end)->symref = xstrdup(buf.buf + 1);
+			else
+				get_sha1_hex(buf.buf, (*end)->old_sha1);
+		}
+		end = &((*end)->next);
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
+void transport_shim_init(struct transport *transport, const char *name)
+{
+	struct shim_data *data = xmalloc(sizeof(*data));
+	data->shim = NULL;
+	data->name = name;
+	transport->data = data;
+	transport->get_refs_list = get_refs_via_shim;
+	transport->fetch = fetch_refs_via_shim;
+	transport->disconnect = disconnect_shim;
+}
diff --git a/transport.h b/transport.h
index 51b5397..01f650d 100644
--- a/transport.h
+++ b/transport.h
@@ -77,4 +77,7 @@ void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
 
+/* Transport methods defined outside transport.c */
+void transport_shim_init(struct transport *transport, const char *name);
+
 #endif
-- 
1.6.4.rc2.13.ga9762.dirty
