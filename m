From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 5/6] Let transport_helper_init() decide if a remote helper
 program can be used
Date: Tue, 11 Aug 2009 12:10:25 +0200
Message-ID: <1249985426-13726-6-git-send-email-johan@herland.net>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com, benji@silverinsanity.com,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:12:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mar99-0008GJ-H4
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbZHKNLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbZHKNLJ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:11:09 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33911 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751670AbZHKNLE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 09:11:04 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO7006Z7IYFRBA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:11:03 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO7008QYIY6Z330@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:11:03 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.11.95426
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125548>

Teach the transport-helper mechanism to verify that the remote helper
program is available, before finalizing the transport setup.
If the remote helper is NOT available, transport_helper_init() returns -1,
and transport_get() falls back to trying a native transport.

This patch introduces a subtle, but important change in the handling of
remotes and their URLs:

Before this patch, we only invoke transport_helper_init() _after_ we find
that the transport-helper mechanism is appropriate for this remote
(i.e. the remote is "foreign", or is handled by the curl helper).

This patch moves the decision point into transport_helper_init(): If the
remote is not obviously using a native transport (URL starts with "file:",
"git:" or "ssh:"), then we first call transport_helper_init(), and only if
it returns error (meaning that no appropriate remote helper program was
found) do we fall back to native transport handling.

Signed-off-by: Johan Herland <johan@herland.net>
---
 transport-helper.c |   22 ++++++++++++++++++++--
 transport.c        |   11 ++++++-----
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index d3ce984..de30727 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -5,6 +5,7 @@
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
+#include "help.h"
 
 struct helper_data
 {
@@ -279,11 +280,18 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 
 int transport_helper_init(struct transport *transport)
 {
-	struct helper_data *data = xcalloc(sizeof(*data), 1);
+	struct helper_data *data;
+	struct strbuf buf = STRBUF_INIT;
+	char *cmd;
+
+	if (!transport->remote)
+		return -1;
 
+	data = xcalloc(sizeof(*data), 1);
 	if (transport->remote->foreign_vcs) {
 		data->name = xstrdup(transport->remote->foreign_vcs);
-		transport->url = transport->remote->foreign_vcs;
+		if (!transport->url)
+			transport->url = transport->remote->foreign_vcs;
 	} else {
 		char *eom = strchr(transport->url, ':');
 		if (!eom) {
@@ -293,6 +301,16 @@ int transport_helper_init(struct transport *transport)
 		data->name = xstrndup(transport->url, eom - transport->url);
 	}
 
+	strbuf_addf(&buf, "remote-%s", data->name);
+	cmd = strbuf_detach(&buf, NULL);
+	if (!is_git_command_or_alias(cmd)) {
+		warning("Could not find remote helper command \"git %s\". Assuming native remote.", cmd);
+		free(cmd);
+		free(data->name);
+		free(data);
+		return -1;
+	}
+
 	transport->data = data;
 	transport->get_refs_list = get_refs_list;
 	transport->fetch = fetch;
diff --git a/transport.c b/transport.c
index 81a28bc..b7033eb 100644
--- a/transport.c
+++ b/transport.c
@@ -794,11 +794,12 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
 
-	} else if (!url
-	        || !prefixcmp(url, "http://")
-	        || !prefixcmp(url, "https://")
-	        || !prefixcmp(url, "ftp://")) {
-		transport_helper_init(ret);
+	} else if ((!url
+	         || (prefixcmp(url, "git:")
+	          && prefixcmp(url, "ssh:")
+	          && prefixcmp(url, "file:")))
+	        && !transport_helper_init(ret)) {
+		/* no-op, ret is initialized by transport_helper_init() */
 
 	} else if (url && is_local(url) && is_file(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
-- 
1.6.4.rc3.138.ga6b98.dirty
