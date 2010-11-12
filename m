From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH 2/2] [WIP] Allow running git init on a remote repository
 specification.
Date: Fri, 12 Nov 2010 12:30:48 +0100
Message-ID: <ba28273f7efb0fa3e403a8a9d7b923b61bb62ce3.1289561504.git.peter@softwolves.pp.se>
References: <cover.1289561504.git.peter@softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 12 12:40:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGrzf-0000Ge-OP
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 12:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757002Ab0KLLkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 06:40:13 -0500
Received: from smtp.getmail.no ([84.208.15.66]:59461 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465Ab0KLLkK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 06:40:10 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBR0058NSEYZU10@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 12 Nov 2010 12:40:10 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 35EA91EA54DF_CDD279AB	for <git@vger.kernel.org>; Fri,
 12 Nov 2010 11:40:10 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 1925C1EA2CD5_CDD279AF	for <git@vger.kernel.org>; Fri,
 12 Nov 2010 11:40:10 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBR008XQSEYJT00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 12 Nov 2010 12:40:10 +0100 (MET)
Received: by perkele (Postfix, from userid 501)	id D0F372FC06; Fri,
 12 Nov 2010 12:40:07 +0100 (CET)
In-reply-to: <cover.1289561504.git.peter@softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161337>

If we pass a remote repository specification to git init, we should try
connecting to the remote and run git init there. Not all transports
can support this, so fall back to reporting an error message for those
that cannot.
---
 builtin/init-db.c |    9 +++++++++
 remote.c          |   11 +++++++++++
 remote.h          |    1 +
 3 files changed, 21 insertions(+), 0 deletions(-)

This one doesn't work. I am not sure getting this to work is even possible.

  $ ~/proj/git/git-init remote.server:/home/peter/foobartest.git
  bash: git-init: command not found
  error: cannot run ssh: No such file or directory

(it is the remote side that complains about not finding "git-init")

diff --git a/builtin/init-db.c b/builtin/init-db.c
index f80ff08..e7baf4a 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -7,6 +7,8 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "remote.h"
+#include "transport.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -439,6 +441,13 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 				/*
 				 * We were passed a remote repository specification.
 				 */
+				struct remote *remote = remote_get_unconfigured(argv[0]);
+				struct transport *transport = transport_get(remote, argv[0]);
+				int fd[2];
+				fd[0] = 0;
+				fd[1] = 1;
+				if (0 == transport_connect(transport, argv[0], "git-init", fd))
+					return transport_disconnect(transport);
 				die("Cannot initialize remote repository '%s'", argv[0]);
 			} else if (!mkdir_tried) {
 				int saved;
diff --git a/remote.c b/remote.c
index 9143ec7..fa57689 100644
--- a/remote.c
+++ b/remote.c
@@ -722,6 +722,17 @@ struct remote *remote_get(const char *name)
 	return ret;
 }
 
+struct remote *remote_get_unconfigured(const char *remotespec)
+{
+	struct remote *ret = xcalloc(1, sizeof(struct remote));
+	if (!ret)
+		return NULL;
+	add_url_alias(ret, remotespec);
+	if (!valid_remote(ret))
+		return NULL;
+	return ret;
+}
+
 int remote_is_configured(const char *name)
 {
 	int i;
diff --git a/remote.h b/remote.h
index 888d7c1..eafa578 100644
--- a/remote.h
+++ b/remote.h
@@ -51,6 +51,7 @@ struct remote {
 };
 
 struct remote *remote_get(const char *name);
+struct remote *remote_get_unconfigured(const char *remotespec);
 int remote_is_configured(const char *name);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
-- 
1.7.3
