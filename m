From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 7/8] Add support for "import" helper command
Date: Thu, 3 Sep 2009 22:14:01 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909032213330.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 04:14:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjOJb-0002pu-A9
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 04:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbZIDCOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 22:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbZIDCOB
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 22:14:01 -0400
Received: from iabervon.org ([66.92.72.58]:41101 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932338AbZIDCN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 22:13:59 -0400
Received: (qmail 2408 invoked by uid 1000); 4 Sep 2009 02:14:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2009 02:14:01 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127681>

This command, supported if the "import" capability is advertized,
allows a helper to support fetching by outputting a git-fast-import
stream.

If both "fetch" and "import" are advertized, git itself will use
"fetch" (although other users may use "import" in this case).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/git-remote-helpers.txt |   10 ++++++
 transport-helper.c                   |   53 ++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 173ee23..e9aa67e 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -43,6 +43,13 @@ Commands are given by the caller on the helper's standard input, one per line.
 +
 Supported if the helper has the "fetch" capability.
 
+'import' <name>::
+	Produces a fast-import stream which imports the current value
+	of the named ref. It may additionally import other refs as
+	needed to construct the history efficiently.
++
+Supported if the helper has the "import" capability.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
@@ -57,6 +64,9 @@ CAPABILITIES
 'fetch'::
 	This helper supports the 'fetch' command.
 
+'import'::
+	This helper supports the 'import' command.
+
 REF LIST ATTRIBUTES
 -------------------
 
diff --git a/transport-helper.c b/transport-helper.c
index e2b5270..3825441 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -11,6 +11,7 @@ struct helper_data
 	const char *name;
 	struct child_process *helper;
 	unsigned fetch : 1;
+	unsigned import : 1;
 };
 
 static struct child_process *get_helper(struct transport *transport)
@@ -50,6 +51,8 @@ static struct child_process *get_helper(struct transport *transport)
 			break;
 		if (!strcmp(buf.buf, "fetch"))
 			data->fetch = 1;
+		if (!strcmp(buf.buf, "import"))
+			data->import = 1;
 	}
 	return data->helper;
 }
@@ -93,6 +96,53 @@ static int fetch_with_fetch(struct transport *transport,
 	return 0;
 }
 
+static int get_importer(struct transport *transport, struct child_process *fastimport)
+{
+	struct helper_data *data = transport->data;
+	struct child_process *helper = get_helper(transport);
+	memset(fastimport, 0, sizeof(*fastimport));
+	fastimport->in = helper->out;
+	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
+	fastimport->argv[0] = "fast-import";
+	fastimport->argv[1] = "--quiet";
+
+	fastimport->git_cmd = 1;
+	return start_command(fastimport);
+}
+
+static int fetch_with_import(struct transport *transport,
+			     int nr_heads, struct ref **to_fetch)
+{
+	struct child_process fastimport;
+	struct child_process *helper = get_helper(transport);
+	int i;
+	struct ref *posn;
+	struct strbuf buf = STRBUF_INIT;
+
+	if (get_importer(transport, &fastimport))
+		die("Couldn't run fast-import");
+
+	for (i = 0; i < nr_heads; i++) {
+		posn = to_fetch[i];
+		if (posn->status & REF_STATUS_UPTODATE)
+			continue;
+
+		strbuf_addf(&buf, "import %s\n", posn->name);
+		write_in_full(helper->in, buf.buf, buf.len);
+		strbuf_reset(&buf);
+	}
+	disconnect_helper(transport);
+	finish_command(&fastimport);
+
+	for (i = 0; i < nr_heads; i++) {
+		posn = to_fetch[i];
+		if (posn->status & REF_STATUS_UPTODATE)
+			continue;
+		read_ref(posn->name, posn->old_sha1);
+	}
+	return 0;
+}
+
 static int fetch(struct transport *transport,
 		 int nr_heads, struct ref **to_fetch)
 {
@@ -110,6 +160,9 @@ static int fetch(struct transport *transport,
 	if (data->fetch)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
+	if (data->import)
+		return fetch_with_import(transport, nr_heads, to_fetch);
+
 	return -1;
 }
 
-- 
1.6.4.2.419.gc86f8
