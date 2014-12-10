From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] push: add remote.pushThin to control thin pack generation
Date: Wed, 10 Dec 2014 23:49:49 +0000
Message-ID: <1418255389-133205-1-git-send-email-sandals@crustytoothpaste.net>
References: <20141210233443.GA130424@vauxhall.crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 00:50:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyr15-0000tn-T1
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 00:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933171AbaLJXt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 18:49:56 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55234 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932621AbaLJXtz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 18:49:55 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 759DA2808F
	for <git@vger.kernel.org>; Wed, 10 Dec 2014 23:49:54 +0000 (UTC)
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <20141210233443.GA130424@vauxhall.crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261263>

From: "brian m. carlson" <brian.carlson@cpanel.net>

Thin packs are enabled when pushing by default, but with a large number
of refs and a fast network, git may spend more time trying to find a
good delta than it would spend simply sending data over the network.
Add a per-remote option, pushThin, that controls the default for pushes
on that remote.

Signed-off-by: brian m. carlson <brian.carlson@cpanel.net>
---
 SOURCES/git/Documentation/config.txt | 6 ++++++
 SOURCES/git/builtin/push.c           | 6 ++++--
 SOURCES/git/remote.c                 | 3 +++
 SOURCES/git/remote.h                 | 1 +
 SOURCES/git/transport.c              | 2 ++
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/SOURCES/git/Documentation/config.txt b/SOURCES/git/Documentation/config.txt
index 9220725..7fededd 100644
--- a/SOURCES/git/Documentation/config.txt
+++ b/SOURCES/git/Documentation/config.txt
@@ -2178,6 +2178,12 @@ remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
 
+remote.<name>.pushThin::
+	If true (the default), pass the \--thin option to
+	linkgit:git-pack-objects[1] during push.  This results in a smaller
+	pack being sent and can improve push time over slow networks.  Over
+	fast networks, setting this value to false may improve performance.
+
 remote.<name>.mirror::
 	If true, pushing to this remote will automatically behave
 	as if the `--mirror` option was given on the command line.
diff --git a/SOURCES/git/builtin/push.c b/SOURCES/git/builtin/push.c
index a076b19..ae39677 100644
--- a/SOURCES/git/builtin/push.c
+++ b/SOURCES/git/builtin/push.c
@@ -15,7 +15,7 @@ static const char * const push_usage[] = {
 	NULL,
 };
 
-static int thin = 1;
+static int thin = -1;
 static int deleterefs;
 static const char *receivepack;
 static int verbosity;
@@ -347,7 +347,9 @@ static int push_with_options(struct transport *transport, int flags)
 	if (receivepack)
 		transport_set_option(transport,
 				     TRANS_OPT_RECEIVEPACK, receivepack);
-	transport_set_option(transport, TRANS_OPT_THIN, thin ? "yes" : NULL);
+
+	if (thin != -1)
+		transport_set_option(transport, TRANS_OPT_THIN, thin ? "yes" : NULL);
 
 	if (!is_empty_cas(&cas)) {
 		if (!transport->smart_options)
diff --git a/SOURCES/git/remote.c b/SOURCES/git/remote.c
index f624217..54777cb 100644
--- a/SOURCES/git/remote.c
+++ b/SOURCES/git/remote.c
@@ -175,6 +175,7 @@ static struct remote *make_remote(const char *name, int len)
 
 	ret = xcalloc(1, sizeof(struct remote));
 	ret->prune = -1;  /* unspecified */
+	ret->push_thin = 1; /* default on */
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] = ret;
 	ret->name = xstrndup(name, len);
@@ -445,6 +446,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_push_refspec(remote, v);
+	} else if (!strcmp(subkey, ".pushthin")) {
+		remote->push_thin = git_config_bool(key, value);
 	} else if (!strcmp(subkey, ".fetch")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
diff --git a/SOURCES/git/remote.h b/SOURCES/git/remote.h
index 8b62efd..badf266 100644
--- a/SOURCES/git/remote.h
+++ b/SOURCES/git/remote.h
@@ -46,6 +46,7 @@ struct remote {
 	int skip_default_update;
 	int mirror;
 	int prune;
+	int push_thin;
 
 	const char *receivepack;
 	const char *uploadpack;
diff --git a/SOURCES/git/transport.c b/SOURCES/git/transport.c
index 70d38e4..2f495fa 100644
--- a/SOURCES/git/transport.c
+++ b/SOURCES/git/transport.c
@@ -987,6 +987,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 			ret->smart_options->receivepack = remote->receivepack;
 	}
 
+	transport_set_option(ret, TRANS_OPT_THIN, remote->push_thin ? "yes" : NULL);
+
 	return ret;
 }
 
-- 
2.2.0
