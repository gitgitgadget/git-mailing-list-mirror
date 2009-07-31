From: Johan Herland <johan@herland.net>
Subject: [RFCv2 07/12] Add a transport implementation using git-vcs-* helpers
Date: Fri, 31 Jul 2009 12:00:27 +0200
Message-ID: <1249034432-31437-8-git-send-email-johan@herland.net>
References: <1249034432-31437-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>, gitster@pobox.com,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 12:03:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWox6-0008BK-UM
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 12:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbZGaKBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 06:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbZGaKBi
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 06:01:38 -0400
Received: from mx.getmail.no ([84.208.15.66]:55725 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752039AbZGaKBh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 06:01:37 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNN00EYG56P2D60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 31 Jul 2009 12:01:37 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNN005FA55FU840@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 31 Jul 2009 12:01:36 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.31.94825
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1249034432-31437-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124531>

From: Daniel Barkalow <barkalow@iabervon.org>

This is somewhat careless about pushes (that is, it attempts to make
pushes that the helper can't necessarily handle), but actually works for
fetches and simple pushes.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Makefile            |    1 +
 remote.c            |    2 +-
 transport-foreign.c |  200 +++++++++++++++++++++++++++++++++++++++++++++++++++
 transport.c         |    1 +
 transport.h         |    3 +
 5 files changed, 206 insertions(+), 1 deletions(-)
 create mode 100644 transport-foreign.c

diff --git a/Makefile b/Makefile
index c9003d7..fe62e2b 100644
--- a/Makefile
+++ b/Makefile
@@ -553,6 +553,7 @@ LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
 LIB_OBJS += transport.o
+LIB_OBJS += transport-foreign.o
 LIB_OBJS += tree-diff.o
 LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
diff --git a/remote.c b/remote.c
index 106151f..057ac02 100644
--- a/remote.c
+++ b/remote.c
@@ -50,7 +50,7 @@ static char buffer[BUF_SIZE];
 
 static int valid_remote(const struct remote *remote)
 {
-	return !!remote->url;
+	return remote->url || remote->foreign_vcs;
 }
 
 static const char *alias_url(const char *url)
diff --git a/transport-foreign.c b/transport-foreign.c
new file mode 100644
index 0000000..29aad77
--- /dev/null
+++ b/transport-foreign.c
@@ -0,0 +1,200 @@
+#include "cache.h"
+#include "transport.h"
+
+#include "run-command.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+
+struct foreign_data
+{
+	struct child_process *importer;
+};
+
+static struct child_process *get_importer(struct transport *transport)
+{
+	struct child_process *importer = transport->data;
+	if (!importer) {
+		struct strbuf buf;
+		importer = xcalloc(1, sizeof(*importer));
+		importer->in = -1;
+		importer->out = -1;
+		importer->err = 0;
+		importer->argv = xcalloc(3, sizeof(*importer->argv));
+		strbuf_init(&buf, 80);
+		strbuf_addf(&buf, "vcs-%s", transport->remote->foreign_vcs);
+		importer->argv[0] = buf.buf;
+		importer->argv[1] = transport->remote->name;
+		importer->git_cmd = 1;
+		start_command(importer);
+		transport->data = importer;
+	}
+	return importer;
+}
+
+static int disconnect_foreign(struct transport *transport)
+{
+	struct child_process *importer = transport->data;
+	if (importer) {
+		write(importer->in, "\n", 1);
+		close(importer->in);
+		finish_command(importer);
+		free(importer);
+		transport->data = NULL;
+	}
+	return 0;
+}
+
+static int fetch_refs_via_foreign(struct transport *transport,
+				  int nr_heads, struct ref **to_fetch)
+{
+	struct child_process *importer;
+	struct child_process fastimport;
+	struct ref *posn;
+	int i, count;
+
+	count = 0;
+	for (i = 0; i < nr_heads; i++) {
+		posn = to_fetch[i];
+		if (posn->status & REF_STATUS_UPTODATE)
+			continue;
+		count++;
+	}
+	if (count) {
+		importer = get_importer(transport);
+
+		memset(&fastimport, 0, sizeof(fastimport));
+		fastimport.in = importer->out;
+		fastimport.argv = xcalloc(3, sizeof(*fastimport.argv));
+		fastimport.argv[0] = "fast-import";
+		fastimport.argv[1] = "--quiet";
+		fastimport.git_cmd = 1;
+		start_command(&fastimport);
+
+		for (i = 0; i < nr_heads; i++) {
+			posn = to_fetch[i];
+			if (posn->status & REF_STATUS_UPTODATE)
+				continue;
+			write(importer->in, "import ", 7);
+			write(importer->in, posn->name, strlen(posn->name));
+			write(importer->in, "\n", 1);
+		}
+		disconnect_foreign(transport);
+		finish_command(&fastimport);
+	}
+	for (i = 0; i < nr_heads; i++) {
+		posn = to_fetch[i];
+		if (posn->status & REF_STATUS_UPTODATE)
+			continue;
+		read_ref(posn->name, posn->old_sha1);
+	}
+	return 0;
+}
+
+static struct ref *get_refs_via_foreign(struct transport *transport, int for_push)
+{
+	struct child_process *importer;
+	struct ref *ret = NULL;
+	struct ref **end = &ret;
+	struct strbuf buf;
+	FILE *file;
+
+	importer = get_importer(transport);
+	write(importer->in, "list\n", 5);
+
+	strbuf_init(&buf, 0);
+	file = fdopen(importer->out, "r");
+	while (1) {
+		char *eon;
+		if (strbuf_getline(&buf, file, '\n') == EOF)
+			break;
+
+		if (!*buf.buf)
+			break;
+
+		eon = strchr(buf.buf, ' ');
+		if (eon)
+			*eon = '\0';
+		*end = alloc_ref(buf.buf);
+		if (eon) {
+			if (strstr(eon + 1, "unchanged")) {
+				(*end)->status |= REF_STATUS_UPTODATE;
+				if (read_ref((*end)->name, (*end)->old_sha1))
+					die("Unchanged?");
+				fprintf(stderr, "Old: %p %s\n", *end, sha1_to_hex((*end)->old_sha1));
+			}
+		}
+		end = &((*end)->next);
+		strbuf_reset(&buf);
+	}
+
+	strbuf_release(&buf);
+	return ret;
+}
+
+static int foreign_push(struct transport *transport, struct ref *remote_refs, int flags) {
+	struct ref *ref, *has;
+	struct child_process *importer;
+	struct rev_info revs;
+	struct commit *commit;
+	struct child_process fastimport;
+
+	importer = get_importer(transport);
+
+	memset(&fastimport, 0, sizeof(fastimport));
+	fastimport.in = importer->out;
+	fastimport.argv = xcalloc(3, sizeof(*fastimport.argv));
+	fastimport.argv[0] = "fast-import";
+	fastimport.argv[1] = "--quiet";
+	fastimport.git_cmd = 1;
+	start_command(&fastimport);
+	for (ref = remote_refs; ref; ref = ref->next) {
+		if (!ref->peer_ref) {
+			ref->status = REF_STATUS_NONE;
+			continue;
+		}
+		init_revisions(&revs, NULL);
+		revs.reverse = 1;
+		for (has = remote_refs; has; has = has->next) {
+			commit = lookup_commit(has->old_sha1);
+			commit->object.flags |= UNINTERESTING;
+			add_pending_object(&revs, &commit->object, has->name);
+		}
+		commit = lookup_commit(ref->peer_ref->new_sha1);
+		add_pending_object(&revs, &commit->object, ref->name);
+
+		if (prepare_revision_walk(&revs))
+			die("Something wrong");
+
+		ref->status = REF_STATUS_UPTODATE;
+		while ((commit = get_revision(&revs))) {
+			ref->status = REF_STATUS_EXPECTING_REPORT;
+			fprintf(stderr, "export %s %s\n", sha1_to_hex(commit->object.sha1), ref->name);
+			write(importer->in, "export ", 7);
+			write(importer->in, sha1_to_hex(commit->object.sha1), 40);
+			write(importer->in, " ", 1);
+			write(importer->in, ref->name, strlen(ref->name));
+			write(importer->in, "\n", 1);
+		}
+	}
+
+	disconnect_foreign(transport);
+	finish_command(&fastimport);
+
+	for (ref = remote_refs; ref; ref = ref->next) {
+		read_ref(ref->name, ref->new_sha1);
+		if (ref->status == REF_STATUS_EXPECTING_REPORT)
+			ref->status = REF_STATUS_OK;
+	}
+
+	return 0;
+}
+
+void transport_foreign_init(struct transport *transport)
+{
+	transport->get_refs_list = get_refs_via_foreign;
+	transport->fetch = fetch_refs_via_foreign;
+	transport->push_refs = foreign_push;
+	transport->disconnect = disconnect_foreign;
+	transport->url = transport->remote->foreign_vcs;
+}
diff --git a/transport.c b/transport.c
index 7ba7ea9..643f20e 100644
--- a/transport.c
+++ b/transport.c
@@ -932,6 +932,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->url = url;
 
 	if (remote && remote->foreign_vcs) {
+		transport_foreign_init(ret);
 	} else if (!prefixcmp(url, "rsync:")) {
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
diff --git a/transport.h b/transport.h
index b45e6c5..190490e 100644
--- a/transport.h
+++ b/transport.h
@@ -115,4 +115,7 @@ void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
 
+/* Transport methods defined outside transport.c */
+void transport_foreign_init(struct transport *transport);
+
 #endif
-- 
1.6.4.rc3.138.ga6b98.dirty
