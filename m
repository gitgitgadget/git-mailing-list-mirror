From: Tomas Carnecky <tom@dbservice.com>
Subject: [PATCH 2/6] Allow more than one keepfile in the transport
Date: Sun,  3 Oct 2010 14:21:47 +0200
Message-ID: <1286108511-55876-2-git-send-email-tom@dbservice.com>
References: <4CA86A12.6080905@dbservice.com>
Cc: Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 14:22:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2NaD-0005Mv-7T
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 14:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab0JCMWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 08:22:13 -0400
Received: from gw.ptr-62-65-141-13.customer.ch.netstream.com ([62.65.141.13]:60847
	"EHLO calvin.caurea.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751077Ab0JCMWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 08:22:11 -0400
Received: by calvin.caurea.org (Postfix, from userid 501)
	id DCE55245A74E; Sun,  3 Oct 2010 14:22:09 +0200 (CEST)
X-Mailer: git-send-email 1.7.3.37.gb6088b
In-Reply-To: <4CA86A12.6080905@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157866>

Git itself creates only one packfile per fetch. But other transports may
chose to create more than one (those that use fast-import for example).
Use an array to keep track of the pack lockfiles.

Signed-off-by: Tomas Carnecky <tom@dbservice.com>
---
 transport-helper.c |    5 +----
 transport.c        |   27 ++++++++++++++++++++++-----
 transport.h        |   11 ++++++++++-
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 0fe886e..dcaaa89 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -362,10 +362,7 @@ static int fetch_with_fetch(struct transport *transport,
 
 		if (!prefixcmp(buf.buf, "lock ")) {
 			const char *name = buf.buf + 5;
-			if (transport->pack_lockfile)
-				warning("%s also locked %s", data->name, name);
-			else
-				transport->pack_lockfile = xstrdup(name);
+			transport_keep(transport, name);
 		} else if (!prefixcmp(buf.buf, "map ")) {
 			map_impure_ref(nr_heads, to_fetch, buf.buf + 4);
 		}
diff --git a/transport.c b/transport.c
index 4dba6f8..df2baa7 100644
--- a/transport.c
+++ b/transport.c
@@ -518,6 +518,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct fetch_pack_args args;
 	int i;
 	struct ref *refs_tmp = NULL;
+	char *keepfile = NULL;
 
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->options.uploadpack;
@@ -541,7 +542,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	refs = fetch_pack(&args, data->fd, data->conn,
 			  refs_tmp ? refs_tmp : transport->remote_refs,
-			  dest, nr_heads, heads, &transport->pack_lockfile);
+			  dest, nr_heads, heads, &keepfile);
 	close(data->fd[0]);
 	close(data->fd[1]);
 	if (finish_connect(data->conn))
@@ -556,6 +557,10 @@ static int fetch_refs_via_pack(struct transport *transport,
 	free(origh);
 	free(heads);
 	free(dest);
+
+	if (keepfile)
+		transport_keep(transport, keepfile);
+
 	return (refs ? 0 : -1);
 }
 
@@ -1116,11 +1121,15 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 
 void transport_unlock_pack(struct transport *transport)
 {
-	if (transport->pack_lockfile) {
-		unlink_or_warn(transport->pack_lockfile);
-		free(transport->pack_lockfile);
-		transport->pack_lockfile = NULL;
+	int i;
+
+	for (i = 0; i < transport->keep_nr; ++i) {
+		char *keepfile = (char *) transport->keep[i];
+		unlink_or_warn(keepfile);
+		free(keepfile);
 	}
+
+	transport->keep_nr = 0;
 }
 
 int transport_connect(struct transport *transport, const char *name,
@@ -1137,6 +1146,7 @@ int transport_disconnect(struct transport *transport)
 	int ret = 0;
 	if (transport->disconnect)
 		ret = transport->disconnect(transport);
+	free(transport->keep);
 	free(transport);
 	return ret;
 }
@@ -1188,3 +1198,10 @@ char *transport_anonymize_url(const char *url)
 literal_copy:
 	return xstrdup(url);
 }
+
+void transport_keep(struct transport *transport, const char *keepfile)
+{
+	int nr = transport->keep_nr + 1;
+	ALLOC_GROW(transport->keep, nr, transport->keep_alloc);
+	transport->keep[transport->keep_nr++] = keepfile;
+}
diff --git a/transport.h b/transport.h
index c59d973..6320d28 100644
--- a/transport.h
+++ b/transport.h
@@ -78,7 +78,14 @@ struct transport {
 	 * use. disconnect() releases these resources.
 	 **/
 	int (*disconnect)(struct transport *connection);
-	char *pack_lockfile;
+
+	/** The transport can create zero or more pack files which need to be
+	 * kept until we can update the refs. This array holds the names of the
+	 * keep files which we have to delete once the refs are updated.
+	 **/
+	const char **keep;
+	int keep_nr, keep_alloc;
+
 	signed verbose : 3;
 	/**
 	 * Transports should not set this directly, and should use this
@@ -165,4 +172,6 @@ int transport_refs_pushed(struct ref *ref);
 void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, int *nonfastforward);
 
+void transport_keep(struct transport *transport, const char *keepfile);
+
 #endif
-- 
1.7.3.37.gb6088b
