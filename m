From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [REROLL PATCH v2 7/8] Support remote archive from all smart transports
Date: Wed,  9 Dec 2009 17:26:33 +0200
Message-ID: <1260372394-16427-8-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1260372394-16427-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 16:27:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIORh-0002on-8M
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 16:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567AbZLIP0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 10:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755539AbZLIP0m
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 10:26:42 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:48682 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496AbZLIP0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 10:26:39 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id BC1E88C7EC
	for <git@vger.kernel.org>; Wed,  9 Dec 2009 17:26:45 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A06E42B8F84; Wed, 09 Dec 2009 17:26:45 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 95C3F1C638D
	for <git@vger.kernel.org>; Wed,  9 Dec 2009 17:26:44 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
In-Reply-To: <1260372394-16427-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134982>

Previously, remote archive required internal (non remote-helper)
smart transport. Extend the remote archive to also support smart
transports implemented by remote helpers.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 216af87..2ce4ef5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -469,6 +469,24 @@ static int process_connect(struct transport *transport,
 	return process_connect_service(transport, name, exec);
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
+	if (!process_connect_service(transport, name, exec))
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
@@ -713,6 +731,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->fetch = fetch;
 	transport->push_refs = push_refs;
 	transport->disconnect = release_helper;
+	transport->connect = connect_helper;
 	transport->smart_options = &(data->transport_options);
 	return 0;
 }
diff --git a/transport.c b/transport.c
index ad25b98..a7d67eb 100644
--- a/transport.c
+++ b/transport.c
@@ -756,6 +756,17 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	return ret;
 }
 
+static int connect_git(struct transport *transport, const char *name,
+		       const char *executable, int fd[2])
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
@@ -901,6 +912,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->get_refs_list = get_refs_via_connect;
 		ret->fetch = fetch_refs_via_pack;
 		ret->push_refs = git_transport_push;
+		ret->connect = connect_git;
 		ret->disconnect = disconnect_git;
 		ret->smart_options = &(data->options);
 
@@ -1061,6 +1073,15 @@ void transport_unlock_pack(struct transport *transport)
 	}
 }
 
+int transport_connect(struct transport *transport, const char *name,
+		      const char *exec, int fd[2])
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
index 781db2e..97ba251 100644
--- a/transport.h
+++ b/transport.h
@@ -64,6 +64,8 @@ struct transport {
 	 **/
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
+	int (*connect)(struct transport *connection, const char *name,
+		       const char *executable, int fd[2]);
 
 	/** get_refs_list(), fetch(), and push_refs() can keep
 	 * resources (such as a connection) reserved for futher
@@ -133,6 +135,9 @@ char *transport_anonymize_url(const char *url);
 void transport_take_over(struct transport *transport,
 			 struct child_process *child);
 
+int transport_connect(struct transport *transport, const char *name,
+		      const char *exec, int fd[2]);
+
 /* Transport methods defined outside transport.c */
 int transport_helper_init(struct transport *transport, const char *name);
 
-- 
1.6.6.rc1.300.gfbc27
