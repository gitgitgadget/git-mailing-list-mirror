From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/5] Add option for using a foreign VCS
Date: Tue, 24 Mar 2009 23:04:12 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903242303330.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 04:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmJRC-00061j-Pr
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 04:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757106AbZCYDET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 23:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756871AbZCYDEQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 23:04:16 -0400
Received: from iabervon.org ([66.92.72.58]:43756 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756498AbZCYDEP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 23:04:15 -0400
Received: (qmail 11074 invoked by uid 1000); 25 Mar 2009 03:04:12 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 03:04:12 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114549>

This simply configures the remote to use a transport that doesn't have
any methods at all and is therefore unable to do anything yet.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/config.txt |    4 ++++
 remote.c                 |    2 ++
 remote.h                 |    2 ++
 transport.c              |    3 ++-
 4 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 089569a..14b0e07 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1305,6 +1305,10 @@ remote.<name>.tagopt::
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
index 2b037f1..be04658 100644
--- a/remote.c
+++ b/remote.c
@@ -411,6 +411,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 	} else if (!strcmp(subkey, ".proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
+	} else if (!strcmp(subkey, ".vcs")) {
+		return git_config_string(&remote->foreign_vcs, key, value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index de3d21b..e77dc1b 100644
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
index 26c578e..8a37db5 100644
--- a/transport.c
+++ b/transport.c
@@ -939,7 +939,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->remote = remote;
 	ret->url = url;
 
-	if (!prefixcmp(url, "rsync:")) {
+	if (remote && remote->foreign_vcs) {
+	} else if (!prefixcmp(url, "rsync:")) {
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
-- 
1.6.2.1.476.g9bf04b
