From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v3 7/8] Support remote archive from external protocol helpers
Date: Sun,  6 Dec 2009 18:28:50 +0200
Message-ID: <1260116931-16549-8-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 17:29:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHJzN-0006Vu-N0
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 17:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933866AbZLFQ3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 11:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932938AbZLFQ3A
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 11:29:00 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:41074 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932975AbZLFQ2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 11:28:55 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id CE4E018CFF2
	for <git@vger.kernel.org>; Sun,  6 Dec 2009 18:29:01 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A011F9CB596; Sun, 06 Dec 2009 18:29:01 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id A82F3402E
	for <git@vger.kernel.org>; Sun,  6 Dec 2009 18:29:00 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
In-Reply-To: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134675>

Helpers which support invoke/connect also should support remote archive
snapshot (or at least there's only one way to attempt it). So support
remote snapshotting for protocol helpers.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 builtin-archive.c  |   17 ++++++++++-------
 transport-helper.c |   19 +++++++++++++++++++
 transport.c        |   21 +++++++++++++++++++++
 transport.h        |    5 +++++
 4 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 12351e9..d34b3fd 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -5,6 +5,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "archive.h"
+#include "transport.h"
 #include "parse-options.h"
 #include "pkt-line.h"
 #include "sideband.h"
@@ -25,12 +26,16 @@ static void create_output_file(const char *output_file)
 static int run_remote_archiver(int argc, const char **argv,
 			       const char *remote, const char *exec)
 {
-	char *url, buf[LARGE_PACKET_MAX];
+	char buf[LARGE_PACKET_MAX];
 	int fd[2], i, len, rv;
-	struct child_process *conn;
+	struct transport *transport;
+	struct remote *_remote;
 
-	url = xstrdup(remote);
-	conn = git_connect(fd, url, exec, 0);
+	_remote = remote_get(remote);
+	if (!_remote->url[0])
+		die("git archive: Remote with no URL");
+	transport = transport_get(_remote, _remote->url[0]);
+	transport_connect(transport, "git-upload-archive", exec, fd);
 
 	for (i = 1; i < argc; i++)
 		packet_write(fd[1], "argument %s\n", argv[i]);
@@ -53,9 +58,7 @@ static int run_remote_archiver(int argc, const char **argv,
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
 	rv = recv_sideband("archive", fd[0], 1);
-	close(fd[0]);
-	close(fd[1]);
-	rv |= finish_connect(conn);
+	rv |= transport_disconnect(transport);
 
 	return !!rv;
 }
diff --git a/transport-helper.c b/transport-helper.c
index e0254bc..a49be55 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -451,6 +451,24 @@ static int process_connect(struct transport* transport,
 	return _process_connect(transport, name, exec);
 }
 
+static int connect_helper(struct transport *transport, const char *name,
+		   const char *exec, int fd[2])
+{
+	struct helper_data *data = transport->data;
+
+	/* Get_helper so connect is inited. */
+	get_helper(transport);
+	if (!data->connect)
+		die("Operation not supported by protocol.");
+
+	if (!_process_connect(transport, name, exec))
+		die("Can't connect to subservice %s.", name);
+
+	fd[0] = data->helper->out;
+	fd[1] = data->helper->in;
+	return 0;
+}
+
 static int fetch(struct transport *transport,
 		 int nr_heads, struct ref **to_fetch)
 {
@@ -694,6 +712,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->fetch = fetch;
 	transport->push_refs = push_refs;
 	transport->disconnect = release_helper;
+	transport->connect = connect_helper;
 	transport->disown = helper_disown;
 	transport->smart_options = &(data->gitoptions);
 	return 0;
diff --git a/transport.c b/transport.c
index e9802e3..b418889 100644
--- a/transport.c
+++ b/transport.c
@@ -756,6 +756,17 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	return ret;
 }
 
+static int connect_git(struct transport *transport, const char* name,
+		       const char* executable, int fd[2])
+{
+	struct git_transport_data *data = transport->data;
+	data->conn = git_connect(data->fd, transport->url,
+				 executable, 0);
+	fd[0] = data->fd[0];
+	fd[1] = data->fd[1];
+	return 0;
+}
+
 static int disconnect_git(struct transport *transport)
 {
 	struct git_transport_data *data = transport->data;
@@ -917,6 +928,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->get_refs_list = get_refs_via_connect;
 		ret->fetch = fetch_refs_via_pack;
 		ret->push_refs = git_transport_push;
+		ret->connect = connect_git;
 		ret->disconnect = disconnect_git;
 		ret->smart_options = &(data->options);
 		ret->disown = NULL;
@@ -1078,6 +1090,15 @@ void transport_unlock_pack(struct transport *transport)
 	}
 }
 
+int transport_connect(struct transport *transport, const char *name,
+		      const char* exec, int fd[2])
+{
+	if (transport->connect)
+		return transport->connect(transport, name, exec, fd);
+	else
+		die("Operation not supported by protocol");
+}
+
 int transport_disconnect(struct transport *transport)
 {
 	int ret = 0;
diff --git a/transport.h b/transport.h
index 499962d..d702e31 100644
--- a/transport.h
+++ b/transport.h
@@ -64,6 +64,8 @@ struct transport {
 	 **/
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
+	int (*connect)(struct transport *connection, const char* name,
+		       const char* executable, int fd[2]);
 
 	/**
 	 * Disown the transport helper. Releases all resources used
@@ -139,6 +141,9 @@ int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
 void transport_take_over(struct transport *transport);
 
+int transport_connect(struct transport *transport, const char *name,
+		      const char* exec, int fd[2]);
+
 /* Transport methods defined outside transport.c */
 int transport_helper_init(struct transport *transport, const char *name);
 
-- 
1.6.6.rc1.300.gfbc27
