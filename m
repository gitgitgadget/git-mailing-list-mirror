From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] Add push by "export"
Date: Wed, 5 Aug 2009 01:02:29 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908050056510.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 07:02:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYYeF-0007Gg-78
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 07:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933361AbZHEFCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 01:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933217AbZHEFCj
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 01:02:39 -0400
Received: from iabervon.org ([66.92.72.58]:37036 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933150AbZHEFC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 01:02:29 -0400
Received: (qmail 18347 invoked by uid 1000); 5 Aug 2009 05:02:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 05:02:29 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124862>

---
 Documentation/git-remote-helpers.txt |   33 ++++++++++++++++++
 transport-helper.c                   |   62 ++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 9a3c5bc..dede2e5 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -50,6 +50,17 @@ Supported if the helper has the "fetch" capability.
 +
 Supported if the helper has the "import" capability.
 
+'export' <sha1> [<name>]::
+	Exports the given commit to the given refname. The commit and
+	name (or lack of name) must be suitable for exporting,
+	according to the flags that the helper has reported. Produces
+	a fast-import stream reimporting the exported commits to the
+	imported version of the branch, so that the git view of the
+	history matches what any other import of the history would
+	give.
++
+Supported if the helper has the "export" capability.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
@@ -75,6 +86,10 @@ CAPABILITIES
 	and --export-marks option to git-fast-import for more details)
 	located at the given filename.
 
+'export' [flags]::
+	This helper supports the 'export' command. The flags specify
+	features of the history that may be exported (see below).
+
 REF LIST ATTRIBUTES
 -------------------
 
@@ -82,6 +97,24 @@ REF LIST ATTRIBUTES
 	This ref is unchanged since the last import or fetch, although
 	the helper cannot necessarily determine what value that produced.
 
+EXPORT FLAGS
+------------
+
+Regardless of flags, an exported commit may only have parents which
+have either been exported previously in this session or which were
+produced by fast-import.
+
+'anonymous'::
+	A commit may be exported without it being immediately written
+	to some particular name. This is required in order to use the
+	export command without a name.
+
+'merges'::
+	A commit may have multiple parents.
+
+'branches'::
+	A commit may be exported to a name which did not previously exist.
+
 Documentation
 -------------
 Documentation by Daniel Barkalow.
diff --git a/transport-helper.c b/transport-helper.c
index cc8707f..2b1450e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -14,6 +14,7 @@ struct helper_data
 	char *marks_filename;
 	unsigned fetch : 1;
 	unsigned import : 1;
+	unsigned export : 1;
 };
 
 static struct child_process *get_helper(struct transport *transport)
@@ -52,6 +53,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->fetch = 1;
 		if (!strcmp(buf.buf, "import"))
 			data->import = 1;
+		if (!strcmp(buf.buf, "export"))
+			data->export = 1;
 		if (!prefixcmp(buf.buf, "marks "))
 			data->marks_filename = xstrdup(buf.buf + 6);
 	}
@@ -175,6 +178,64 @@ static int fetch(struct transport *transport,
 	return -1;
 }
 
+static int push_with_export(struct transport *transport, struct ref *remote_refs, int flags) {
+	struct child_process fastimport;
+	struct child_process *helper = get_helper(transport);
+	struct ref *ref, *has;
+	struct rev_info revs;
+	struct commit *commit;
+
+	if (get_importer(transport, &fastimport))
+		die("Couldn't run fast-import");
+
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
+			write_in_full(helper->in, "export ", 7);
+			write_in_full(helper->in, sha1_to_hex(commit->object.sha1), 40);
+			write_in_full(helper->in, " ", 1);
+			write_in_full(helper->in, ref->name, strlen(ref->name));
+			write_in_full(helper->in, "\n", 1);
+		}
+	}
+	disconnect_helper(transport);
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
+static int push(struct transport *transport, struct ref *remote_refs, int flags) {
+	struct helper_data *data = transport->data;
+	if (data->export)
+		return push_with_export(transport, remote_refs, flags);
+
+	return -1;
+}
+
 static struct ref *get_refs_list(struct transport *transport, int for_push)
 {
 	struct child_process *helper;
@@ -241,6 +302,7 @@ int transport_helper_init(struct transport *transport)
 	transport->data = data;
 	transport->get_refs_list = get_refs_list;
 	transport->fetch = fetch;
+	transport->push_refs = push;
 	transport->disconnect = disconnect_helper;
 	return 0;
 }
-- 
1.6.4.rc3.27.g95032.dirty
