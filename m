From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/4] remote.c: introduce remote.pushdefault
Date: Mon, 18 Mar 2013 18:46:14 +0530
Message-ID: <1363612575-7340-4-git-send-email-artagnon@gmail.com>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 14:15:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHZum-00042U-Ru
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 14:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab3CRNPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 09:15:19 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:42082 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab3CRNPO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 09:15:14 -0400
Received: by mail-pb0-f53.google.com with SMTP id un1so6370735pbc.26
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 06:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=hUzDcnfPtUfjKP0UhKbwaeX+4HUR7kTMdIFAgbWSQ54=;
        b=gHYZ1sjzVvLBqaMQq/dV5UKJnA9kjxA2IjkUdJRYcwbq+dtW1TxLuTGCuvJbSTaVFL
         RViTBymGjHulboamgKcet/SGWtyYhOjnL6crzg0O+RBQD8jK55cjEKMU3GSi1HWadey7
         XoQmee5boNmbyBc3DgLeBoGB7QO3TCk20Q6qqv+psfxK0PwVXQmcFKwdCx03m7LFk7jg
         qmwkZdfuVabm8tKLSQ0aGrqh7OWajSL4xqO8QbhPsPCxXs+h/3hXkdON9KjDGJcyGgqG
         vfrEypWs3zGA5jRmM2sT0wbfcj6dT6EWtwga7zwLPoV5CIzYdwdzPCjbVbEfsPjFv7x5
         IeKw==
X-Received: by 10.66.81.2 with SMTP id v2mr10318910pax.204.1363612513928;
        Mon, 18 Mar 2013 06:15:13 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id y1sm20178280pbg.10.2013.03.18.06.15.11
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 06:15:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218412>

This new configuration variable defines the default remote to push to,
and overrides `branch.<name>.remote` for all branches.  It is useful
in the typical triangular-workflow setup, where the remote you're
fetching from is different from the remote you're pushing to.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt | 13 ++++++++++---
 remote.c                 |  4 ++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bbba728..8ddd0fd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -723,9 +723,12 @@ branch.autosetuprebase::
 	This option defaults to never.
 
 branch.<name>.remote::
-	When in branch <name>, it tells 'git fetch' and 'git push' which
-	remote to fetch from/push to.  It defaults to `origin` if no remote is
-	configured. `origin` is also used if you are not on any branch.
+	When on branch <name>, it tells 'git fetch' and 'git push'
+	which remote to fetch from/push to.  The remote to push to
+	may be overriden with `remote.pushdefault` (for all branches).
+	If no remote is configured, or if you are not on any branch,
+	it defaults to `origin` for fetching and `remote.pushdefault`
+	for pushing.
 
 branch.<name>.merge::
 	Defines, together with branch.<name>.remote, the upstream branch
@@ -1894,6 +1897,10 @@ receive.updateserverinfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
 
+remote.pushdefault::
+	The remote to push to by default.  Overrides
+	`branch.<name>.remote` for all branches.
+
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
diff --git a/remote.c b/remote.c
index 4704404..987edc4 100644
--- a/remote.c
+++ b/remote.c
@@ -350,6 +350,10 @@ static int handle_config(const char *key, const char *value, void *cb)
 	const char *subkey;
 	struct remote *remote;
 	struct branch *branch;
+	if (!prefixcmp(key, "remote.")) {
+		if (!strcmp(key + 7, "pushdefault"))
+			git_config_string(&pushremote_name, key, value);
+	}
 	if (!prefixcmp(key, "branch.")) {
 		name = key + 7;
 		subkey = strrchr(name, '.');
-- 
1.8.2
