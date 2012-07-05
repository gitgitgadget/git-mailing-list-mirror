From: marcnarc@xiplink.com
Subject: [PATCH 2/6] Teach remote.c about the remote.default configuration setting.
Date: Thu,  5 Jul 2012 18:11:13 -0400
Message-ID: <1341526277-17055-3-git-send-email-marcnarc@xiplink.com>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com, Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 00:11:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmuGs-00069c-Lm
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 00:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab2GEWL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 18:11:29 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:31283 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756879Ab2GEWL1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2012 18:11:27 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q65MBE0B004223;
	Thu, 5 Jul 2012 18:11:15 -0400
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201066>

From: Marc Branchaud <marcnarc@xiplink.com>

The code now has a default_remote_name and an effective_remote_name:
 - default_remote_name is set by remote.default in the config, or is "origin"
   if remote.default doesn't exist ("origin" was the fallback value before
   this change).
 - effective_remote_name is the name of the remote tracked by the current
   branch, or is default_remote_name if the current branch doesn't have a
   remote.

Also add two new helper functions for other code modules to use:
 - remote_get_default_name() returns default_remote_name.
 - remote_count() returns the number of remotes.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 remote.c | 27 ++++++++++++++++++++++++---
 remote.h |  2 ++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 6f371e0..ccada0d 100644
--- a/remote.c
+++ b/remote.c
@@ -47,6 +47,7 @@ static int branches_alloc;
 static int branches_nr;
 
 static struct branch *current_branch;
+static const char *default_remote_name;
 static const char *effective_remote_name;
 static int explicit_effective_remote_name;
 
@@ -390,6 +391,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 	}
 	if (prefixcmp(key,  "remote."))
 		return 0;
+
 	name = key + 7;
 	if (*name == '/') {
 		warning("Config remote shorthand cannot begin with '/': %s",
@@ -397,8 +399,12 @@ static int handle_config(const char *key, const char *value, void *cb)
 		return 0;
 	}
 	subkey = strrchr(name, '.');
-	if (!subkey)
+	if (!subkey) {
+		/* Look for remote.default */
+		if (!strcmp(name, "default"))
+			default_remote_name = xstrdup(value);
 		return 0;
+	}
 	remote = make_remote(name, subkey - name);
 	remote->origin = REMOTE_CONFIG;
 	if (!strcmp(subkey, ".mirror"))
@@ -481,9 +487,8 @@ static void read_config(void)
 	unsigned char sha1[20];
 	const char *head_ref;
 	int flag;
-	if (effective_remote_name) /* did this already */
+	if (default_remote_name) /* did this already */
 		return;
-	effective_remote_name = xstrdup("origin");
 	current_branch = NULL;
 	head_ref = resolve_ref_unsafe("HEAD", sha1, 0, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
@@ -492,6 +497,10 @@ static void read_config(void)
 			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
 	git_config(handle_config, NULL);
+	if (!default_remote_name)
+		default_remote_name = "origin";
+	if (!effective_remote_name)
+		effective_remote_name = default_remote_name;
 	alias_all_urls();
 }
 
@@ -671,6 +680,18 @@ static int valid_remote_nick(const char *name)
 	return !strchr(name, '/'); /* no slash */
 }
 
+const char *remote_get_default_name()
+{
+	read_config();
+	return default_remote_name;
+}
+
+int remote_count()
+{
+	read_config();
+	return remotes_nr;
+}
+
 struct remote *remote_get(const char *name)
 {
 	struct remote *ret;
diff --git a/remote.h b/remote.h
index 251d8fd..f9aac87 100644
--- a/remote.h
+++ b/remote.h
@@ -52,6 +52,8 @@ struct remote {
 
 struct remote *remote_get(const char *name);
 int remote_is_configured(const char *name);
+const char *remote_get_default_name();
+int remote_count();
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
 int for_each_remote(each_remote_fn fn, void *priv);
-- 
1.7.11.1
