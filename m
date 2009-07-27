From: Johan Herland <johan@herland.net>
Subject: [RFC 03/11] Allow programs to not depend on remotes having urls
Date: Mon, 27 Jul 2009 03:04:11 +0200
Message-ID: <1248656659-21415-4-git-send-email-johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>, gitster@pobox.com,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 03:05:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVEev-000498-HF
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 03:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbZG0BFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 21:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755345AbZG0BFi
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 21:05:38 -0400
Received: from mx.getmail.no ([84.208.15.66]:43091 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755117AbZG0BFh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 21:05:37 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF007851PCZF40@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:36 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF004SX1O2UG30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:36 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.27.4819
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1248656659-21415-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124144>

From: Daniel Barkalow <barkalow@iabervon.org>

For fetch and ls-remote, which use the first url of a remote, have
transport_get() determine this by passing a remote and passing NULL
for the url. For push, which uses every url of a remote, use each url
in turn if there are any, and use NULL if there are none.

This will allow the transport code to do something different if the
location is not specified with a url.

Also, have the message for a fetch say "foreign" if there is no url.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-fetch.c     |   19 +++++++++++------
 builtin-ls-remote.c |    4 +-
 builtin-push.c      |   54 +++++++++++++++++++++++++++++++++-----------------
 transport.c         |    3 ++
 4 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 817dd6b..3f32db6 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -346,12 +346,17 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			what = rm->name;
 		}
 
-		url_len = strlen(url);
-		for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
-			;
-		url_len = i + 1;
-		if (4 < i && !strncmp(".git", url + i - 3, 4))
-			url_len = i - 3;
+		if (url) {
+			url_len = strlen(url);
+			for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
+				;
+			url_len = i + 1;
+			if (4 < i && !strncmp(".git", url + i - 3, 4))
+				url_len = i - 3;
+		} else {
+			url = "foriegn";
+			url_len = strlen(url);
+		}
 
 		note_len = 0;
 		if (*what) {
@@ -663,7 +668,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (!remote)
 		die("Where do you want to fetch from today?");
 
-	transport = transport_get(remote, remote->url[0]);
+	transport = transport_get(remote, NULL);
 	if (verbosity >= 2)
 		transport->verbose = 1;
 	if (verbosity < 0)
diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 78a88f7..4c6fc58 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -87,9 +87,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		}
 	}
 	remote = nongit ? NULL : remote_get(dest);
-	if (remote && !remote->url_nr)
+	if (!nongit && !remote)
 		die("remote %s has no configured URL", dest);
-	transport = transport_get(remote, remote ? remote->url[0] : dest);
+	transport = transport_get(remote, remote ? NULL : dest);
 	if (uploadpack != NULL)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 
diff --git a/builtin-push.c b/builtin-push.c
index 1d92e22..ae63521 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -88,6 +88,26 @@ static void setup_default_push_refspecs(void)
 	}
 }
 
+static int push_with_options(struct transport *transport, int flags)
+{
+	int err;
+	if (receivepack)
+		transport_set_option(transport,
+				     TRANS_OPT_RECEIVEPACK, receivepack);
+	if (thin)
+		transport_set_option(transport, TRANS_OPT_THIN, "yes");
+
+	if (flags & TRANSPORT_PUSH_VERBOSE)
+		fprintf(stderr, "Pushing to %s\n", transport->url);
+	err = transport_push(transport, refspec_nr, refspec, flags);
+	err |= transport_disconnect(transport);
+
+	if (!err)
+		return 0;
+
+	return 1;
+}
+
 static int do_push(const char *repo, int flags)
 {
 	int i, errs;
@@ -136,26 +156,22 @@ static int do_push(const char *repo, int flags)
 		url = remote->url;
 		url_nr = remote->url_nr;
 	}
-	for (i = 0; i < url_nr; i++) {
+	if (url_nr) {
+		for (i = 0; i < url_nr; i++) {
+			struct transport *transport =
+				transport_get(remote, url[i]);
+			if (push_with_options(transport, flags)) {
+				error("failed to push some refs to '%s'", url[i]);
+				errs++;
+			}
+		}
+	} else {
 		struct transport *transport =
-			transport_get(remote, url[i]);
-		int err;
-		if (receivepack)
-			transport_set_option(transport,
-					     TRANS_OPT_RECEIVEPACK, receivepack);
-		if (thin)
-			transport_set_option(transport, TRANS_OPT_THIN, "yes");
-
-		if (flags & TRANSPORT_PUSH_VERBOSE)
-			fprintf(stderr, "Pushing to %s\n", url[i]);
-		err = transport_push(transport, refspec_nr, refspec, flags);
-		err |= transport_disconnect(transport);
-
-		if (!err)
-			continue;
-
-		error("failed to push some refs to '%s'", url[i]);
-		errs++;
+			transport_get(remote, NULL);
+		if (push_with_options(transport, flags)) {
+			error("failed to push some refs to foreign system");
+			errs++;
+		}
 	}
 	return !!errs;
 }
diff --git a/transport.c b/transport.c
index 13fbca4..2864f40 100644
--- a/transport.c
+++ b/transport.c
@@ -793,6 +793,9 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
 	ret->remote = remote;
+
+	if (!url && remote && remote->url)
+		url = remote->url[0];
 	ret->url = url;
 
 	if (remote && remote->foreign_vcs) {
-- 
1.6.4.rc3.138.ga6b98.dirty
