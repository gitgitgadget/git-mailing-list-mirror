From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 3/6] Move setup of curl remote helper from transport.c to
 transport-helper.c
Date: Tue, 11 Aug 2009 12:10:23 +0200
Message-ID: <1249985426-13726-4-git-send-email-johan@herland.net>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com, benji@silverinsanity.com,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:12:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mar9B-0008GJ-1h
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbZHKNLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbZHKNLW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:11:22 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33911 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752498AbZHKNLD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 09:11:03 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO7006YTIYCRBA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:11:00 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO7008QYIY6Z330@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:11:00 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.11.95426
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125552>

Since the curl transport is now launched by the transport-helper mechanism,
it makes sense to move the remaining curl-related code (i.e.
curl_transport_push()) from transport.c into transport-helper.c.

The patch also consolidates the two transport_helper_init() call sites
("foreign" helper and curl helper).

Signed-off-by: Johan Herland <johan@herland.net>
---
 transport-helper.c |   39 +++++++++++++++++++++++++++++++++++++++
 transport.c        |   48 ++++++------------------------------------------
 2 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index a901630..d3ce984 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -249,6 +249,34 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 	return ret;
 }
 
+#ifndef NO_CURL
+static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags)
+{
+	const char **argv;
+	int argc;
+
+	if (flags & TRANSPORT_PUSH_MIRROR)
+		return error("http transport does not support mirror mode");
+
+	argv = xmalloc((refspec_nr + 12) * sizeof(char *));
+	argv[0] = "http-push";
+	argc = 1;
+	if (flags & TRANSPORT_PUSH_ALL)
+		argv[argc++] = "--all";
+	if (flags & TRANSPORT_PUSH_FORCE)
+		argv[argc++] = "--force";
+	if (flags & TRANSPORT_PUSH_DRY_RUN)
+		argv[argc++] = "--dry-run";
+	if (flags & TRANSPORT_PUSH_VERBOSE)
+		argv[argc++] = "--verbose";
+	argv[argc++] = transport->url;
+	while (refspec_nr--)
+		argv[argc++] = *refspec++;
+	argv[argc] = NULL;
+	return !!run_command_v_opt(argv, RUN_GIT_CMD);
+}
+#endif
+
 int transport_helper_init(struct transport *transport)
 {
 	struct helper_data *data = xcalloc(sizeof(*data), 1);
@@ -269,5 +297,16 @@ int transport_helper_init(struct transport *transport)
 	transport->get_refs_list = get_refs_list;
 	transport->fetch = fetch;
 	transport->disconnect = disconnect_helper;
+
+	if (!strcmp(data->name, "http")
+	 || !strcmp(data->name, "https")
+	 || !strcmp(data->name, "ftp")) {
+#ifdef NO_CURL
+		error("git was compiled without libcurl support.");
+#else
+		transport->push = curl_transport_push;
+#endif
+	}
+
 	return 0;
 }
diff --git a/transport.c b/transport.c
index 26d9999..81a28bc 100644
--- a/transport.c
+++ b/transport.c
@@ -349,35 +349,6 @@ static int rsync_transport_push(struct transport *transport,
 	return result;
 }
 
-#ifndef NO_CURL
-static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags)
-{
-	const char **argv;
-	int argc;
-
-	if (flags & TRANSPORT_PUSH_MIRROR)
-		return error("http transport does not support mirror mode");
-
-	argv = xmalloc((refspec_nr + 12) * sizeof(char *));
-	argv[0] = "http-push";
-	argc = 1;
-	if (flags & TRANSPORT_PUSH_ALL)
-		argv[argc++] = "--all";
-	if (flags & TRANSPORT_PUSH_FORCE)
-		argv[argc++] = "--force";
-	if (flags & TRANSPORT_PUSH_DRY_RUN)
-		argv[argc++] = "--dry-run";
-	if (flags & TRANSPORT_PUSH_VERBOSE)
-		argv[argc++] = "--verbose";
-	argv[argc++] = transport->url;
-	while (refspec_nr--)
-		argv[argc++] = *refspec++;
-	argv[argc] = NULL;
-	return !!run_command_v_opt(argv, RUN_GIT_CMD);
-}
-
-#endif
-
 struct bundle_transport_data {
 	int fd;
 	struct bundle_header header;
@@ -815,26 +786,19 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		url = remote->url[0];
 	ret->url = url;
 
-	if (remote && remote->foreign_vcs) {
-		transport_helper_init(ret);
-		return ret;
-	}
+	if (remote && remote->foreign_vcs)
+		url = NULL;
 
 	if (url && !prefixcmp(url, "rsync:")) {
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
 
-	} else if (url
-	        && (!prefixcmp(url, "http://")
-	         || !prefixcmp(url, "https://")
-	         || !prefixcmp(url, "ftp://"))) {
+	} else if (!url
+	        || !prefixcmp(url, "http://")
+	        || !prefixcmp(url, "https://")
+	        || !prefixcmp(url, "ftp://")) {
 		transport_helper_init(ret);
-#ifdef NO_CURL
-		error("git was compiled without libcurl support.");
-#else
-		ret->push = curl_transport_push;
-#endif
 
 	} else if (url && is_local(url) && is_file(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
-- 
1.6.4.rc3.138.ga6b98.dirty
