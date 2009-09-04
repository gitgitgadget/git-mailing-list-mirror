From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 6/8] Add a config option for remotes to specify a foreign
 vcs
Date: Thu, 3 Sep 2009 22:13:59 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909032213310.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 04:14:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjOJa-0002pu-Ht
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 04:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbZIDCOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 22:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbZIDCOA
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 22:14:00 -0400
Received: from iabervon.org ([66.92.72.58]:41099 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932351AbZIDCN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 22:13:58 -0400
Received: (qmail 2404 invoked by uid 1000); 4 Sep 2009 02:13:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2009 02:13:59 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127679>

If this is set, the url is not required, and the transport always uses
a helper named "git-remote-<value>".

It is a separate configuration option in order to allow a sensible
configuration for foreign systems which either have no meaningful urls
for repositories or which require urls that do not specify the system
used by the repository at that location. However, this only affects
how the name of the helper is determined, not anything about the
interaction with the helper, and the contruction is such that, if the
foreign scm does happen to use a co-named url method, a url with that
method may be used directly.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/config.txt |    4 ++++
 remote.c                 |    4 +++-
 remote.h                 |    2 ++
 transport.c              |    5 +++++
 4 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5256c7f..436ee91 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1380,6 +1380,10 @@ remote.<name>.tagopt::
 	Setting this value to \--no-tags disables automatic tag following when
 	fetching from remote <name>
 
+remote.<name>.vcs::
+	Setting this to a value <vcs> will cause git to interact with
+	the remote with the git-remote-<vcs> helper.
+
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See linkgit:git-remote[1].
diff --git a/remote.c b/remote.c
index fec63fa..e9dbb3b 100644
--- a/remote.c
+++ b/remote.c
@@ -50,7 +50,7 @@ static char buffer[BUF_SIZE];
 
 static int valid_remote(const struct remote *remote)
 {
-	return !!remote->url;
+	return !remote->url != !remote->foreign_vcs;
 }
 
 static const char *alias_url(const char *url)
@@ -427,6 +427,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 	} else if (!strcmp(subkey, ".proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
+	} else if (!strcmp(subkey, ".vcs")) {
+		return git_config_string(&remote->foreign_vcs, key, value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 5db8420..ac0ce2f 100644
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
index 684fd6c..38bebe3 100644
--- a/transport.c
+++ b/transport.c
@@ -818,6 +818,11 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		url = remote->url[0];
 	ret->url = url;
 
+	if (remote && remote->foreign_vcs) {
+		transport_helper_init(ret, remote->foreign_vcs);
+		return ret;
+	}
+
 	if (!prefixcmp(url, "rsync:")) {
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
-- 
1.6.4.2.419.gc86f8
