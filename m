From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/5] Allow push and fetch urls to be different
Date: Tue,  9 Jun 2009 18:01:34 +0200
Message-ID: <1244563298-15479-2-git-send-email-git@drmicha.warpmail.net>
References: <1244563298-15479-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 18:01:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME3ls-00008m-M1
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 18:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbZFIQBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 12:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754438AbZFIQBm
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 12:01:42 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59601 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752812AbZFIQBk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 12:01:40 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C592B35E6F1;
	Tue,  9 Jun 2009 12:01:42 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 09 Jun 2009 12:01:42 -0400
X-Sasl-enc: q/xrd9zVyuX5Jbjdzm+4cZOuBgcn+A6fK86DqT1KDkfp 1244563301
Received: from localhost (p54859AE3.dip0.t-ipconnect.de [84.133.154.227])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7FC3D2F07F;
	Tue,  9 Jun 2009 12:01:41 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.2.278.gb6431.dirty
In-Reply-To: <1244563298-15479-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121179>

This introduces a config setting remote.$remotename.pushurl which is
used for pushes only. If absent remote.$remotename.url is used for
pushes and fetches as before.
This is useful, for example, in order to do passwordless fetches
(remote update) over the git transport but pushes over ssh.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/config.txt       |    3 +++
 Documentation/urls-remotes.txt |    3 +++
 builtin-push.c                 |   17 +++++++++++++----
 remote.c                       |   14 ++++++++++++++
 remote.h                       |    4 ++++
 5 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3a86d1f..2fecbe3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1319,6 +1319,9 @@ remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
 
+remote.<name>.pushurl::
+	The push URL of a remote repository.  See linkgit:git-push[1].
+
 remote.<name>.proxy::
 	For remotes that require curl (http, https and ftp), the URL to
 	the proxy to use for that remote.  Set to the empty string to
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index 41ec777..2a0e7b8 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -27,10 +27,13 @@ config file would appear like this:
 ------------
 	[remote "<name>"]
 		url = <url>
+		pushurl = <pushurl>
 		push = <refspec>
 		fetch = <refspec>
 ------------
 
+The `<pushurl>` is used for pushes only. It is optional and defaults
+to `<url>`.
 
 Named file in `$GIT_DIR/remotes`
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin-push.c b/builtin-push.c
index c869974..7be1239 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -117,6 +117,8 @@ static int do_push(const char *repo, int flags)
 {
 	int i, errs;
 	struct remote *remote = remote_get(repo);
+	const char **url;
+	int url_nr;
 
 	if (!remote) {
 		if (repo)
@@ -152,9 +154,16 @@ static int do_push(const char *repo, int flags)
 			setup_default_push_refspecs();
 	}
 	errs = 0;
-	for (i = 0; i < remote->url_nr; i++) {
+	if (remote->pushurl_nr) {
+		url = remote->pushurl;
+		url_nr = remote->pushurl_nr;
+	} else {
+		url = remote->url;
+		url_nr = remote->url_nr;
+	}
+	for (i = 0; i < url_nr; i++) {
 		struct transport *transport =
-			transport_get(remote, remote->url[i]);
+			transport_get(remote, url[i]);
 		int err;
 		if (receivepack)
 			transport_set_option(transport,
@@ -163,14 +172,14 @@ static int do_push(const char *repo, int flags)
 			transport_set_option(transport, TRANS_OPT_THIN, "yes");
 
 		if (flags & TRANSPORT_PUSH_VERBOSE)
-			fprintf(stderr, "Pushing to %s\n", remote->url[i]);
+			fprintf(stderr, "Pushing to %s\n", url[i]);
 		err = transport_push(transport, refspec_nr, refspec, flags);
 		err |= transport_disconnect(transport);
 
 		if (!err)
 			continue;
 
-		error("failed to push some refs to '%s'", remote->url[i]);
+		error("failed to push some refs to '%s'", url[i]);
 		errs++;
 	}
 	return !!errs;
diff --git a/remote.c b/remote.c
index 08a5964..9a0397e 100644
--- a/remote.c
+++ b/remote.c
@@ -106,6 +106,12 @@ static void add_url_alias(struct remote *remote, const char *url)
 	add_url(remote, alias_url(url));
 }
 
+static void add_pushurl(struct remote *remote, const char *pushurl)
+{
+	ALLOC_GROW(remote->pushurl, remote->pushurl_nr + 1, remote->pushurl_alloc);
+	remote->pushurl[remote->pushurl_nr++] = pushurl;
+}
+
 static struct remote *make_remote(const char *name, int len)
 {
 	struct remote *ret;
@@ -379,6 +385,11 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_url(remote, v);
+	} else if (!strcmp(subkey, ".pushurl")) {
+		const char *v;
+		if (git_config_string(&v, key, value))
+			return -1;
+		add_pushurl(remote, v);
 	} else if (!strcmp(subkey, ".push")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
@@ -424,6 +435,9 @@ static void alias_all_urls(void)
 		for (j = 0; j < remotes[i]->url_nr; j++) {
 			remotes[i]->url[j] = alias_url(remotes[i]->url[j]);
 		}
+		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
+			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j]);
+		}
 	}
 }
 
diff --git a/remote.h b/remote.h
index 257a555..5db8420 100644
--- a/remote.h
+++ b/remote.h
@@ -15,6 +15,10 @@ struct remote {
 	int url_nr;
 	int url_alloc;
 
+	const char **pushurl;
+	int pushurl_nr;
+	int pushurl_alloc;
+
 	const char **push_refspec;
 	struct refspec *push;
 	int push_refspec_nr;
-- 
1.6.3.2.278.gb6431.dirty
