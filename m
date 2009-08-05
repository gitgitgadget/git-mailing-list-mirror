From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 10/13] Allow helpers to request marks for fast-import
Date: Wed, 5 Aug 2009 01:02:17 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908050056050.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 07:04:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYYeA-0007Gg-Lp
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 07:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316AbZHEFCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 01:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755011AbZHEFCS
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 01:02:18 -0400
Received: from iabervon.org ([66.92.72.58]:37021 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755328AbZHEFCR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 01:02:17 -0400
Received: (qmail 18321 invoked by uid 1000); 5 Aug 2009 05:02:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 05:02:17 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124861>

From: Johan Herland <johan@herland.net>

The 'marks' capability is reported by the remote helper if it requires
the fast-import marks database to loaded/saved by any git-fast-import
process that is provided by the transport machinery. The feature is
advertised along with exactly one argument: the location of the file
containing the marks database.

Signed-off-by: Johan Herland <johan@herland.net>
Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/git-remote-helpers.txt |    8 ++++++++
 transport-helper.c                   |   15 +++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 2c5130f..9a3c5bc 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -67,6 +67,14 @@ CAPABILITIES
 'import'::
 	This helper supports the 'import' command.
 
+'marks' filename::
+	Helper requires the marks from a git-fast-import run to be
+	loaded from, and saved to, the given filename. When this
+	"feature" is advertised, each git-fast-import run must load
+	and save the internal marks database (see the --import-marks
+	and --export-marks option to git-fast-import for more details)
+	located at the given filename.
+
 REF LIST ATTRIBUTES
 -------------------
 
diff --git a/transport-helper.c b/transport-helper.c
index 956cece..cc8707f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -10,6 +10,8 @@ struct helper_data
 {
 	const char *name;
 	struct child_process *helper;
+
+	char *marks_filename;
 	unsigned fetch : 1;
 	unsigned import : 1;
 };
@@ -50,6 +52,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->fetch = 1;
 		if (!strcmp(buf.buf, "import"))
 			data->import = 1;
+		if (!prefixcmp(buf.buf, "marks "))
+			data->marks_filename = xstrdup(buf.buf + 6);
 	}
 	return data->helper;
 }
@@ -101,6 +105,15 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
 	fastimport->argv[0] = "fast-import";
 	fastimport->argv[1] = "--quiet";
+	if (data->marks_filename) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "--export-marks=%s", data->marks_filename);
+		fastimport->argv[2] = strbuf_detach(&buf, 0);
+		if (!access(data->marks_filename, R_OK)) {
+			strbuf_addf(&buf, "--import-marks=%s", data->marks_filename);
+			fastimport->argv[3] = strbuf_detach(&buf, 0);
+		}
+	}
 
 	fastimport->git_cmd = 1;
 	return start_command(fastimport);
@@ -127,6 +140,8 @@ static int fetch_with_import(struct transport *transport,
 	}
 	disconnect_helper(transport);
 	finish_command(&fastimport);
+	free((char *) fastimport.argv[2]);
+	free((char *) fastimport.argv[3]);
 
 	for (i = 0; i < nr_heads; i++) {
 		posn = to_fetch[i];
-- 
1.6.4.rc3.27.g95032.dirty
