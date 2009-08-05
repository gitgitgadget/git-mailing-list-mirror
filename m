From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 06/13] Allow programs to not depend on remotes having urls
Date: Wed, 5 Aug 2009 01:02:07 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908050055440.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 07:04:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYYe7-0007Gg-Fq
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 07:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbZHEFCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 01:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755141AbZHEFCL
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 01:02:11 -0400
Received: from iabervon.org ([66.92.72.58]:37009 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754137AbZHEFCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 01:02:07 -0400
Received: (qmail 18294 invoked by uid 1000); 5 Aug 2009 05:02:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 05:02:07 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 817dd6b..b51a019 100644
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
+			url = "foreign";
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
index b99d934..983d183 100644
--- a/transport.c
+++ b/transport.c
@@ -808,6 +808,9 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
 	ret->remote = remote;
+
+	if (!url && remote && remote->url)
+		url = remote->url[0];
 	ret->url = url;
 
 	if (!prefixcmp(url, "rsync:")) {
-- 
1.6.4.rc3.27.g95032.dirty
