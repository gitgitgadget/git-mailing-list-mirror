From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/4] remote: add a new 'origin' variable to the struct
Date: Wed, 12 Nov 2008 18:11:01 +0100
Message-ID: <95e56b46e30b41af31da86789625c93511f1faef.1226508805.git.vmiklos@frugalware.org>
References: <cover.1226508805.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:12:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0JFr-00065i-6g
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbYKLRKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbYKLRKH
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:10:07 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:49995 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbYKLRKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:10:05 -0500
Received: from vmobile.example.net (dsl5401C37A.pool.t-online.hu [84.1.195.122])
	by yugo.frugalware.org (Postfix) with ESMTPA id 4C797446CCE;
	Wed, 12 Nov 2008 18:10:03 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 73DF919DB13; Wed, 12 Nov 2008 18:11:04 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <cover.1226508805.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1226508805.git.vmiklos@frugalware.org>
References: <cover.1226508805.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100774>

This allows one to track where was the remote's original source, so that
it's possible to decide if it makes sense to migrate it to the config
format or not.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 remote.c |    3 +++
 remote.h |    7 +++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index e530a21..cbb3e48 100644
--- a/remote.c
+++ b/remote.c
@@ -201,6 +201,7 @@ static void read_remotes_file(struct remote *remote)
 
 	if (!f)
 		return;
+	remote->origin = REMOTE_REMOTES;
 	while (fgets(buffer, BUF_SIZE, f)) {
 		int value_list;
 		char *s, *p;
@@ -261,6 +262,7 @@ static void read_branches_file(struct remote *remote)
 		s++;
 	if (!*s)
 		return;
+	remote->origin = REMOTE_BRANCHES;
 	p = s + strlen(s);
 	while (isspace(p[-1]))
 		*--p = 0;
@@ -350,6 +352,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 	if (!subkey)
 		return error("Config with no key for remote %s", name);
 	remote = make_remote(name, subkey - name);
+	remote->origin = REMOTE_CONFIG;
 	if (!strcmp(subkey, ".mirror"))
 		remote->mirror = git_config_bool(key, value);
 	else if (!strcmp(subkey, ".skipdefaultupdate"))
diff --git a/remote.h b/remote.h
index d2e170c..a46a5be 100644
--- a/remote.h
+++ b/remote.h
@@ -1,8 +1,15 @@
 #ifndef REMOTE_H
 #define REMOTE_H
 
+enum {
+	REMOTE_CONFIG,
+	REMOTE_REMOTES,
+	REMOTE_BRANCHES
+};
+
 struct remote {
 	const char *name;
+	int origin;
 
 	const char **url;
 	int url_nr;
-- 
1.6.0.2
