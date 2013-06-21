From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH 1/3] remote: Add warnings about mixin --mirror and other remotes
Date: Fri, 21 Jun 2013 12:04:09 +0200
Message-ID: <1371809051-29988-2-git-send-email-dennis@kaarsemaker.net>
References: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 12:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpyCk-0005mf-Re
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 12:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913Ab3FUKES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 06:04:18 -0400
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:58853 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820Ab3FUKEQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jun 2013 06:04:16 -0400
Received: from cpsps-ews09.kpnxchange.com ([10.94.84.176]) by cpsmtpb-ews01.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 12:04:15 +0200
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews09.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 12:04:15 +0200
Received: from kaarsemaker.net ([82.168.11.8]) by CPSMTPM-TLF104.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 12:04:13 +0200
Received: by kaarsemaker.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 12:04:14 +0200
X-Mailer: git-send-email 1.8.3.1-619-gbec0aa7
In-Reply-To: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
In-Reply-To: <1371763424.17896.32.camel@localhost>
References: <1371763424.17896.32.camel@localhost>
X-OriginalArrivalTime: 21 Jun 2013 10:04:14.0011 (UTC) FILETIME=[AEE250B0:01CE6E66]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228590>

When cloning a repo with --mirror, and adding more remotes later,
get_stale_heads for origin will mark all refs from other repos as stale.
Add a warning to the documentation, and warn the user when we detect
such things during git remote add.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 Documentation/git-remote.txt |  6 +++++-
 builtin/remote.c             | 17 +++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 581bb4c..d7457df 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -71,7 +71,11 @@ When a fetch mirror is created with `--mirror=fetch`, the refs will not
 be stored in the 'refs/remotes/' namespace, but rather everything in
 'refs/' on the remote will be directly mirrored into 'refs/' in the
 local repository. This option only makes sense in bare repositories,
-because a fetch would overwrite any local commits.
+because a fetch would overwrite any local commits. If you want to add extra
+remotes to a repository created with `--mirror=fetch`, you will need to change
+the configuration of the mirrored remote to fetch only `refs/heads/*`,
+otherwise `git remote prune <remote>` will remove all branches for the extra
+remotes.
 +
 When a push mirror is created with `--mirror=push`, then `git push`
 will always behave as if `--mirror` was passed.
diff --git a/builtin/remote.c b/builtin/remote.c
index 5e54d36..a4f9cb8 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -112,6 +112,21 @@ enum {
 #define MIRROR_PUSH 2
 #define MIRROR_BOTH (MIRROR_FETCH|MIRROR_PUSH)
 
+static int check_overlapping_refspec(struct remote *remote, void *priv)
+{
+	char *refspec = priv;
+	int i;
+	for (i = 0; i < remote->fetch_refspec_nr; i++) {
+		if(strcmp(refspec, remote->fetch[i].dst) &&
+		   (!fnmatch(refspec, remote->fetch[i].dst, 0) ||
+		    !fnmatch(remote->fetch[i].dst, refspec, 0))) {
+			warning(_("Overlapping refspecs detected: '%s' and '%s'"),
+			        refspec, remote->fetch[i].dst);
+		}
+	}
+	return 0;
+}
+
 static int add_branch(const char *key, const char *branchname,
 		const char *remotename, int mirror, struct strbuf *tmp)
 {
@@ -123,6 +138,8 @@ static int add_branch(const char *key, const char *branchname,
 	else
 		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
 				branchname, remotename, branchname);
+
+	for_each_remote(check_overlapping_refspec, strchr((const char*)tmp->buf, ':') + 1);
 	return git_config_set_multivar(key, tmp->buf, "^$", 0);
 }
 
-- 
1.8.3.1-619-gbec0aa7
