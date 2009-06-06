From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [WIP/RFC] Allow push and fetch urls to be different
Date: Sat,  6 Jun 2009 16:43:15 +0200
Message-ID: <1244299395-6605-1-git-send-email-git@drmicha.warpmail.net>
References: <7v1vpztsci.fsf@alter.siamese.dyndns.org>
Cc: Nikos Chantziaras <realnc@arcor.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 16:43:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCx7Y-0000K3-2N
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 16:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbZFFOnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 10:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbZFFOnU
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 10:43:20 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51820 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754779AbZFFOnT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 10:43:19 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 854BE357581;
	Sat,  6 Jun 2009 10:43:21 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sat, 06 Jun 2009 10:43:21 -0400
X-Sasl-enc: FSAE/dA3IUqwFOo6pRxqOPGC37OBLV1O7Yfasws31tRj 1244299400
Received: from localhost (p548596E3.dip0.t-ipconnect.de [84.133.150.227])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 914F72E230;
	Sat,  6 Jun 2009 10:43:20 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.2.277.gd10543
In-Reply-To: <7v1vpztsci.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120918>

This introduces a config setting remote.$remotename.pushurl which is
used for pushes only. If absent remote.$remotename.url is used for
pushes and fetches as before.
This is useful, for example, in order to to do passwordless fetches
(remote update) over git: but pushes over ssh.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This is a working prototype, but I'd like to rfc about the approach before
coding further. Do I need to do anything in http-push.c? I don't think so.

Things that would go in a full series:
* documentation (man pages, maybe manual)
* tests
* teach builtin-remote about pushurl

 builtin-push.c |   17 +++++++++++++----
 remote.c       |   14 ++++++++++++++
 remote.h       |    4 ++++
 3 files changed, 31 insertions(+), 4 deletions(-)

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
1.6.3.2.277.gd10543
