From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 5/7] Add a config option for remotes to specify a foreign
 vcs
Date: Wed, 27 May 2009 14:15:45 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905271409040.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 20:16:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Nfo-0001Hm-58
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 20:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933157AbZE0SQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 14:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933149AbZE0SP6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 14:15:58 -0400
Received: from iabervon.org ([66.92.72.58]:46863 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932592AbZE0SPq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 14:15:46 -0400
Received: (qmail 18417 invoked by uid 1000); 27 May 2009 18:15:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 May 2009 18:15:45 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120087>

This can be used instead of a url in a valid remote configuration, but
the resulting transport cannot do anything.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/config.txt |    4 ++++
 remote.c                 |    4 +++-
 remote.h                 |    2 ++
 transport.c              |    4 ++++
 4 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2c03162..d6c6c9c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1347,6 +1347,10 @@ remote.<name>.tagopt::
 	Setting this value to \--no-tags disables automatic tag following when
 	fetching from remote <name>
 
+remote.<name>.vcs::
+	Setting this to a value <vcs> will cause git to interact with
+	the remote with the git-vcs-<vcs> helper.
+
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See linkgit:git-remote[1].
diff --git a/remote.c b/remote.c
index 5552ce7..168b0ce 100644
--- a/remote.c
+++ b/remote.c
@@ -50,7 +50,7 @@ static char buffer[BUF_SIZE];
 
 static int valid_remote(const struct remote *remote)
 {
-	return !!remote->url;
+	return remote->url || remote->foreign_vcs;
 }
 
 static const char *alias_url(const char *url)
@@ -416,6 +416,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 	} else if (!strcmp(subkey, ".proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
+	} else if (!strcmp(subkey, ".vcs")) {
+		return git_config_string(&remote->foreign_vcs, key, value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 99706a8..a234b37 100644
--- a/remote.h
+++ b/remote.h
@@ -11,6 +11,8 @@ struct remote {
 	const char *name;
 	int origin;
 
+	const char *foreign_vcs;
+
 	const char **url;
 	int url_nr;
 	int url_alloc;
diff --git a/transport.c b/transport.c
index b9f1f6e..011a8dc 100644
--- a/transport.c
+++ b/transport.c
@@ -938,6 +938,10 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 	ret->remote = remote;
 
+	if (remote && remote->foreign_vcs) {
+		return ret;
+	}
+
 	if (!url && remote)
 		url = remote->url[0];
 	ret->url = url;
-- 
1.6.0.6
