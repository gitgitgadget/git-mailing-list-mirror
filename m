From: Johan Herland <johan@herland.net>
Subject: [RFCv2 03/12] Add option for using a foreign VCS
Date: Fri, 31 Jul 2009 12:00:23 +0200
Message-ID: <1249034432-31437-4-git-send-email-johan@herland.net>
References: <1249034432-31437-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>, gitster@pobox.com,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 12:03:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWox3-0008BK-Ex
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 12:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbZGaKBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 06:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZGaKBc
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 06:01:32 -0400
Received: from mx.getmail.no ([84.208.15.66]:46085 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751630AbZGaKB3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 06:01:29 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNN00GDD56H0220@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 31 Jul 2009 12:01:29 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNN005FA55FU840@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 31 Jul 2009 12:01:29 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.31.94825
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1249034432-31437-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124524>

From: Daniel Barkalow <barkalow@iabervon.org>

This simply configures the remote to use a transport that doesn't have
any methods at all and is therefore unable to do anything yet.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/config.txt |    4 ++++
 remote.c                 |    2 ++
 remote.h                 |    2 ++
 transport.c              |    3 ++-
 4 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1446007..b4ab67b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1377,6 +1377,10 @@ remote.<name>.tagopt::
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
index c3ada2d..758727c 100644
--- a/remote.c
+++ b/remote.c
@@ -422,6 +422,8 @@ static int handle_config(const char *key, const char *value, void *cb)
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
index 349ccae..f414bd3 100644
--- a/transport.c
+++ b/transport.c
@@ -928,7 +928,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->remote = remote;
 	ret->url = url;
 
-	if (!prefixcmp(url, "rsync:")) {
+	if (remote && remote->foreign_vcs) {
+	} else if (!prefixcmp(url, "rsync:")) {
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
-- 
1.6.4.rc3.138.ga6b98.dirty
