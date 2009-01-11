From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC PATCH 3/3] Support fetching from foreign VCSes
Date: Sun, 11 Jan 2009 15:12:10 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901110335520.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 21:13:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6gz-0008Ht-0e
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbZAKUM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbZAKUM1
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:12:27 -0500
Received: from iabervon.org ([66.92.72.58]:48386 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754762AbZAKUML (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:12:11 -0500
Received: (qmail 30925 invoked by uid 1000); 11 Jan 2009 20:12:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jan 2009 20:12:10 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105214>

This supports a useful subset of the usual fetch logic, mostly in the
config file.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-fetch.c |  135 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 7b46f8f..14e037e 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -614,6 +614,136 @@ static void set_option(const char *name, const char *value)
 			name, transport->url);
 }
 
+static struct ref *list_foreign(struct remote *remote)
+{
+	struct child_process importer;
+	struct ref *ret = NULL;
+	struct ref **end = &ret;
+	struct strbuf buf;
+	memset(&importer, 0, sizeof(importer));
+	importer.in = 0;
+	importer.no_stdin = 1;
+	importer.out = -1;
+	importer.err = 0;
+	importer.argv = xcalloc(5, sizeof(*importer.argv));
+	strbuf_init(&buf, 80);
+	strbuf_addf(&buf, "vcs-%s", remote->foreign_vcs);
+	importer.argv[0] = buf.buf;
+	importer.argv[1] = "list";
+	importer.argv[2] = remote->name;
+	importer.git_cmd = 1;
+	start_command(&importer);
+
+	strbuf_reset(&buf);
+	while (1) {
+		char *eol, *eon;
+		if (strbuf_read(&buf, importer.out, 80) <= 0)
+			break;
+		while (1) {
+			eol = strchr(buf.buf, '\n');
+			if (!eol)
+				break;
+			*eol = '\0';
+			eon = strchr(buf.buf, ' ');
+			if (eon)
+				*eon = '\0';
+			*end = alloc_ref(buf.buf);
+			end = &((*end)->next);
+			strbuf_remove(&buf, 0, eol - buf.buf + 1);
+		}
+	}
+
+	finish_command(&importer);
+	strbuf_release(&buf);
+	return ret;
+}
+
+static int import_foreign(struct remote *remote, struct ref *refs)
+{
+	struct child_process importer;
+	struct child_process fastimport;
+	struct ref *posn;
+	int count = 0;
+	struct strbuf buf;
+
+	for (posn = refs; posn; posn = posn->next)
+		count++;
+
+	memset(&importer, 0, sizeof(importer));
+	importer.in = 0;
+	importer.no_stdin = 1;
+	importer.out = -1;
+	importer.err = 0;
+	importer.argv = xcalloc(5 + count, sizeof(*importer.argv));
+	strbuf_init(&buf, 80);
+	strbuf_addf(&buf, "vcs-%s", remote->foreign_vcs);
+	importer.argv[0] = buf.buf;
+	importer.argv[1] = "import";
+	importer.argv[2] = remote->name;
+	count = 0;
+	for (posn = refs; posn; posn = posn->next) {
+		importer.argv[3 + count] = posn->name;
+		count++;
+	}
+	importer.git_cmd = 1;
+	start_command(&importer);
+
+	memset(&fastimport, 0, sizeof(fastimport));
+	fastimport.in = importer.out;
+	fastimport.argv = xcalloc(2, sizeof(*fastimport.argv));
+	fastimport.argv[0] = "fast-import";
+	fastimport.argv[1] = "--quiet";
+	fastimport.git_cmd = 1;
+	start_command(&fastimport);
+
+	finish_command(&importer);
+	finish_command(&fastimport);
+	strbuf_release(&buf);
+	return 0;
+}
+
+static int fetch_foreign(struct remote *remote)
+{
+	struct ref *remote_refs = list_foreign(remote);
+	struct ref *ref_map = NULL;
+	struct ref *rm;
+	struct ref **tail = &ref_map;
+	struct branch *branch;
+	int i;
+
+	int exit_code = import_foreign(remote, remote_refs);
+	if (exit_code)
+		return exit_code;
+
+	/* if not appending, truncate FETCH_HEAD */
+	if (!append) {
+		char *filename = git_path("FETCH_HEAD");
+		FILE *fp = fopen(filename, "w");
+		if (!fp)
+			return error("cannot open %s: %s\n", filename, strerror(errno));
+		fclose(fp);
+	}
+
+	for (rm = remote_refs; rm; rm = rm->next)
+		read_ref(rm->name, rm->old_sha1);
+
+	branch = branch_get(NULL);
+
+	for (i = 0; i < remote->fetch_refspec_nr; i++) {
+		get_fetch_map(remote_refs, &remote->fetch[i], &tail, 0);
+		if (!strcmp(branch->remote_name, remote->name))
+			add_merge_config(&ref_map, remote_refs, branch, &tail);
+	}
+
+	for (rm = ref_map; rm; rm = rm->next)
+		if (rm->peer_ref)
+			read_ref(rm->peer_ref->name, rm->peer_ref->old_sha1);
+
+	store_updated_refs("foreign", remote->name, ref_map);
+
+	return exit_code;
+}
+
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	struct remote *remote;
@@ -635,9 +765,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	else
 		remote = remote_get(argv[0]);
 
-	if (remote->foreign_vcs) {
-		die("Using foreign VCSes for fetch is not yet supported.");
-	}
+	if (remote->foreign_vcs)
+		return fetch_foreign(remote);
 
 	transport = transport_get(remote, remote->url[0]);
 	if (verbosity >= 2)
-- 
1.6.0.6
