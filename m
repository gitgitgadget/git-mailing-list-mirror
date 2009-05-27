From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/7] Allow programs to not depend on remotes having urls
Date: Wed, 27 May 2009 14:15:42 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905271408380.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 20:16:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Nfl-0001Hm-Fu
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 20:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933130AbZE0SPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 14:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933066AbZE0SPs
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 14:15:48 -0400
Received: from iabervon.org ([66.92.72.58]:46859 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932754AbZE0SPm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 14:15:42 -0400
Received: (qmail 18410 invoked by uid 1000); 27 May 2009 18:15:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 May 2009 18:15:42 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120089>

For fetch and ls-remote, which use the first url of a remote, have
transport_get() determine this by passing a remote and passing NULL
for the url. For push, which uses every url of a remote, use each url
in turn if there are any, and use NULL if there are none.

This will allow the transport code to do something different if the
location is not specified with a url.

Also, have the message for a fetch say "foreign" if there is no url.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-fetch.c     |   19 +++++++++++------
 builtin-ls-remote.c |    4 +-
 builtin-push.c      |   54 +++++++++++++++++++++++++++++++++-----------------
 transport.c         |    3 ++
 4 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 77acabf..bb1534a 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -341,12 +341,17 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
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
@@ -645,7 +650,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
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
index 2eabcd3..49b5086 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -113,6 +113,26 @@ static void setup_default_push_refspecs(void)
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
@@ -152,26 +172,22 @@ static int do_push(const char *repo, int flags)
 			setup_default_push_refspecs();
 	}
 	errs = 0;
-	for (i = 0; i < remote->url_nr; i++) {
+	if (remote->url_nr) {
+		for (i = 0; i < remote->url_nr; i++) {
+			struct transport *transport =
+				transport_get(remote, remote->url[i]);
+			if (push_with_options(transport, flags)) {
+				error("failed to push some refs to '%s'", remote->url[i]);
+				errs++;
+			}
+		}
+	} else {
 		struct transport *transport =
-			transport_get(remote, remote->url[i]);
-		int err;
-		if (receivepack)
-			transport_set_option(transport,
-					     TRANS_OPT_RECEIVEPACK, receivepack);
-		if (thin)
-			transport_set_option(transport, TRANS_OPT_THIN, "yes");
-
-		if (flags & TRANSPORT_PUSH_VERBOSE)
-			fprintf(stderr, "Pushing to %s\n", remote->url[i]);
-		err = transport_push(transport, refspec_nr, refspec, flags);
-		err |= transport_disconnect(transport);
-
-		if (!err)
-			continue;
-
-		error("failed to push some refs to '%s'", remote->url[i]);
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
index 28cd26e..b9f1f6e 100644
--- a/transport.c
+++ b/transport.c
@@ -937,6 +937,9 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
 	ret->remote = remote;
+
+	if (!url && remote)
+		url = remote->url[0];
 	ret->url = url;
 
 	if (!prefixcmp(url, "rsync:")) {
-- 
1.6.0.6
