From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/5] Rename remote.uri to remote.url within remote handling internals
Date: Wed, 19 Sep 2007 00:49:27 -0400
Message-ID: <20070919044927.GA17107@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 06:49:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXrVe-00072u-DX
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 06:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbXISEtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 00:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbXISEtc
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 00:49:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38737 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbXISEtb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 00:49:31 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXrV8-0006wz-W9; Wed, 19 Sep 2007 00:49:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EC65920FBAE; Wed, 19 Sep 2007 00:49:27 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58675>

Anyplace we talk about the address of a remote repository we always
refer to it as a URL, especially in the configuration file and
.git/remotes where we call it "remote.$n.url" or start the first
line with "URL:".  Calling this value a uri within the internal C
code just doesn't jive well with our commonly accepted terms.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |    2 +-
 builtin-push.c  |    8 ++++----
 remote.c        |   34 +++++++++++++++++-----------------
 remote.h        |    6 +++---
 send-pack.c     |    2 +-
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index b9722e5..997a8ff 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -530,7 +530,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	else
 		remote = remote_get(argv[i++]);
 
-	transport = transport_get(remote, remote->uri[0]);
+	transport = transport_get(remote, remote->url[0]);
 	if (verbose >= 2)
 		transport->verbose = 1;
 	if (quiet)
diff --git a/builtin-push.c b/builtin-push.c
index 7d7e826..4ee36c2 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -57,9 +57,9 @@ static int do_push(const char *repo, int flags)
 		refspec_nr = remote->push_refspec_nr;
 	}
 	errs = 0;
-	for (i = 0; i < remote->uri_nr; i++) {
+	for (i = 0; i < remote->url_nr; i++) {
 		struct transport *transport =
-			transport_get(remote, remote->uri[i]);
+			transport_get(remote, remote->url[i]);
 		int err;
 		if (receivepack)
 			transport_set_option(transport,
@@ -68,14 +68,14 @@ static int do_push(const char *repo, int flags)
 			transport_set_option(transport, TRANS_OPT_THIN, "yes");
 
 		if (verbose)
-			fprintf(stderr, "Pushing to %s\n", remote->uri[i]);
+			fprintf(stderr, "Pushing to %s\n", remote->url[i]);
 		err = transport_push(transport, refspec_nr, refspec, flags);
 		err |= transport_disconnect(transport);
 
 		if (!err)
 			continue;
 
-		error("failed to push to '%s'", remote->uri[i]);
+		error("failed to push to '%s'", remote->url[i]);
 		errs++;
 	}
 	return !!errs;
diff --git a/remote.c b/remote.c
index 31e2b70..e3c3df5 100644
--- a/remote.c
+++ b/remote.c
@@ -32,13 +32,13 @@ static void add_fetch_refspec(struct remote *remote, const char *ref)
 	remote->fetch_refspec_nr = nr;
 }
 
-static void add_uri(struct remote *remote, const char *uri)
+static void add_url(struct remote *remote, const char *url)
 {
-	int nr = remote->uri_nr + 1;
-	remote->uri =
-		xrealloc(remote->uri, nr * sizeof(char *));
-	remote->uri[nr-1] = uri;
-	remote->uri_nr = nr;
+	int nr = remote->url_nr + 1;
+	remote->url =
+		xrealloc(remote->url, nr * sizeof(char *));
+	remote->url[nr-1] = url;
+	remote->url_nr = nr;
 }
 
 static struct remote *make_remote(const char *name, int len)
@@ -154,7 +154,7 @@ static void read_remotes_file(struct remote *remote)
 
 		switch (value_list) {
 		case 0:
-			add_uri(remote, xstrdup(s));
+			add_url(remote, xstrdup(s));
 			break;
 		case 1:
 			add_push_refspec(remote, xstrdup(s));
@@ -206,7 +206,7 @@ static void read_branches_file(struct remote *remote)
 	} else {
 		branch = "refs/heads/master";
 	}
-	add_uri(remote, p);
+	add_url(remote, p);
 	add_fetch_refspec(remote, branch);
 	remote->fetch_tags = 1; /* always auto-follow */
 }
@@ -260,7 +260,7 @@ static int handle_config(const char *key, const char *value)
 		return 0; /* ignore unknown booleans */
 	}
 	if (!strcmp(subkey, ".url")) {
-		add_uri(remote, xstrdup(value));
+		add_url(remote, xstrdup(value));
 	} else if (!strcmp(subkey, ".push")) {
 		add_push_refspec(remote, xstrdup(value));
 	} else if (!strcmp(subkey, ".fetch")) {
@@ -347,14 +347,14 @@ struct remote *remote_get(const char *name)
 		name = default_remote_name;
 	ret = make_remote(name, 0);
 	if (name[0] != '/') {
-		if (!ret->uri)
+		if (!ret->url)
 			read_remotes_file(ret);
-		if (!ret->uri)
+		if (!ret->url)
 			read_branches_file(ret);
 	}
-	if (!ret->uri)
-		add_uri(ret, name);
-	if (!ret->uri)
+	if (!ret->url)
+		add_url(ret, name);
+	if (!ret->url)
 		return NULL;
 	ret->fetch = parse_ref_spec(ret->fetch_refspec_nr, ret->fetch_refspec);
 	ret->push = parse_ref_spec(ret->push_refspec_nr, ret->push_refspec);
@@ -380,11 +380,11 @@ int for_each_remote(each_remote_fn fn, void *priv)
 	return result;
 }
 
-int remote_has_uri(struct remote *remote, const char *uri)
+int remote_has_url(struct remote *remote, const char *url)
 {
 	int i;
-	for (i = 0; i < remote->uri_nr; i++) {
-		if (!strcmp(remote->uri[i], uri))
+	for (i = 0; i < remote->url_nr; i++) {
+		if (!strcmp(remote->url[i], url))
 			return 1;
 	}
 	return 0;
diff --git a/remote.h b/remote.h
index b5b558f..05add06 100644
--- a/remote.h
+++ b/remote.h
@@ -4,8 +4,8 @@
 struct remote {
 	const char *name;
 
-	const char **uri;
-	int uri_nr;
+	const char **url;
+	int url_nr;
 
 	const char **push_refspec;
 	struct refspec *push;
@@ -32,7 +32,7 @@ struct remote *remote_get(const char *name);
 typedef int each_remote_fn(struct remote *remote, void *priv);
 int for_each_remote(each_remote_fn fn, void *priv);
 
-int remote_has_uri(struct remote *remote, const char *uri);
+int remote_has_url(struct remote *remote, const char *url);
 
 struct refspec {
 	unsigned force : 1;
diff --git a/send-pack.c b/send-pack.c
index f74e66a..4533d1b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -420,7 +420,7 @@ int main(int argc, char **argv)
 
 	if (remote_name) {
 		remote = remote_get(remote_name);
-		if (!remote_has_uri(remote, dest)) {
+		if (!remote_has_url(remote, dest)) {
 			die("Destination %s is not a uri for %s",
 			    dest, remote_name);
 		}
-- 
1.5.3.1.195.gadd6
