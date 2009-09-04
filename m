From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 5/8] Allow programs to not depend on remotes having urls
Date: Thu, 3 Sep 2009 22:13:57 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909032213290.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 04:14:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjOJZ-0002pu-Pq
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 04:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbZIDCN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 22:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbZIDCN6
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 22:13:58 -0400
Received: from iabervon.org ([66.92.72.58]:41097 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932338AbZIDCN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 22:13:56 -0400
Received: (qmail 2380 invoked by uid 1000); 4 Sep 2009 02:13:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2009 02:13:57 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127680>

For fetch and ls-remote, which use the first url of a remote, have
transport_get() determine this by passing a remote and passing NULL
for the url. For push, which uses every url of a remote, use each url
in turn if there are any, and use NULL if there are none.

This will allow the transport code to do something different if the
location is not specified with a url.

Also, have the message for a fetch say "foreign" if there is no url.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-fetch.c     |    7 ++++-
 builtin-ls-remote.c |    4 +-
 builtin-push.c      |   67 ++++++++++++++++++++++++++++++++-------------------
 transport.c         |    3 ++
 4 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 817dd6b..63a4ff0 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -309,7 +309,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	if (!fp)
 		return error("cannot open %s: %s\n", filename, strerror(errno));
 
-	url = transport_anonymize_url(raw_url);
+	if (raw_url)
+		url = transport_anonymize_url(raw_url);
+	else
+		url = xstrdup("foreign");
 	for (rm = ref_map; rm; rm = rm->next) {
 		struct ref *ref = NULL;
 
@@ -663,7 +666,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
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
index 67f6d96..8e9b917 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -88,6 +88,34 @@ static void setup_default_push_refspecs(void)
 	}
 }
 
+static int push_with_options(struct transport *transport, int flags)
+{
+	int err;
+	int nonfastforward;
+	if (receivepack)
+		transport_set_option(transport,
+				     TRANS_OPT_RECEIVEPACK, receivepack);
+	if (thin)
+		transport_set_option(transport, TRANS_OPT_THIN, "yes");
+
+	if (flags & TRANSPORT_PUSH_VERBOSE)
+		fprintf(stderr, "Pushing to %s\n", transport->url);
+	err = transport_push(transport, refspec_nr, refspec, flags,
+			     &nonfastforward);
+	err |= transport_disconnect(transport);
+
+	if (!err)
+		return 0;
+
+	if (nonfastforward) {
+		printf("To prevent you from losing history, non-fast-forward updates were rejected.\n"
+		       "Merge the remote changes before pushing again.\n"
+		       "See 'non-fast forward' section of 'git push --help' for details.\n");
+	}
+
+	return 1;
+}
+
 static int do_push(const char *repo, int flags)
 {
 	int i, errs;
@@ -136,33 +164,22 @@ static int do_push(const char *repo, int flags)
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
-		int nonfastforward;
-		if (receivepack)
-			transport_set_option(transport,
-					     TRANS_OPT_RECEIVEPACK, receivepack);
-		if (thin)
-			transport_set_option(transport, TRANS_OPT_THIN, "yes");
-
-		if (flags & TRANSPORT_PUSH_VERBOSE)
-			fprintf(stderr, "Pushing to %s\n", url[i]);
-		err = transport_push(transport, refspec_nr, refspec, flags,
-				     &nonfastforward);
-		err |= transport_disconnect(transport);
-
-		if (!err)
-			continue;
-
-		error("failed to push some refs to '%s'", url[i]);
-		if (nonfastforward) {
-			printf("To prevent you from losing history, non-fast-forward updates were rejected.\n"
-			       "Merge the remote changes before pushing again.\n"
-			       "See 'non-fast forward' section of 'git push --help' for details.\n");
+			transport_get(remote, NULL);
+		if (push_with_options(transport, flags)) {
+			error("failed to push some refs to foreign system");
+			errs++;
 		}
-		errs++;
 	}
 	return !!errs;
 }
diff --git a/transport.c b/transport.c
index 93430fa..684fd6c 100644
--- a/transport.c
+++ b/transport.c
@@ -813,6 +813,9 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
 	ret->remote = remote;
+
+	if (!url && remote && remote->url)
+		url = remote->url[0];
 	ret->url = url;
 
 	if (!prefixcmp(url, "rsync:")) {
-- 
1.6.4.2.419.gc86f8
