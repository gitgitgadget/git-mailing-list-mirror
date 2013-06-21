From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH 3/3] remote: don't prune when detecting overlapping refspecs
Date: Fri, 21 Jun 2013 12:04:11 +0200
Message-ID: <1371809051-29988-4-git-send-email-dennis@kaarsemaker.net>
References: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 12:04:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpyCl-0005mf-SY
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 12:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049Ab3FUKEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 06:04:21 -0400
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:58346 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750725Ab3FUKET (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jun 2013 06:04:19 -0400
Received: from cpsps-ews27.kpnxchange.com ([10.94.84.193]) by cpsmtpb-ews03.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 12:04:18 +0200
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews27.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 12:04:18 +0200
Received: from kaarsemaker.net ([82.168.11.8]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 12:04:17 +0200
Received: by kaarsemaker.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 12:04:16 +0200
X-Mailer: git-send-email 1.8.3.1-619-gbec0aa7
In-Reply-To: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
In-Reply-To: <1371763424.17896.32.camel@localhost>
References: <1371763424.17896.32.camel@localhost>
X-OriginalArrivalTime: 21 Jun 2013 10:04:17.0134 (UTC) FILETIME=[B0BED8E0:01CE6E66]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228589>

When cloning a repo with --mirror, and adding more remotes later,
get_stale_heads for origin would mark all refs from other repos as
stale. There's no "good" way to solve, this so the best thing we can do
is refusing to prune if we detect this and warning the user.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 remote.c          | 23 +++++++++++++++++++++++
 t/t5505-remote.sh |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index e71f66d..39a9405 100644
--- a/remote.c
+++ b/remote.c
@@ -1912,11 +1912,34 @@ static int get_stale_heads_cb(const char *refname,
 	return 0;
 }
 
+static int check_overlapping_remotes(struct remote *first, void *priv) {
+	struct remote *second = priv;
+	int i, j;
+	if(!second)
+		return for_each_remote(check_overlapping_remotes, first);
+	if(first == second)
+		return 0;
+	for (i = 0; i < first->fetch_refspec_nr; i++) {
+		for (j = 0; j < second->fetch_refspec_nr; j++) {
+			if(strcmp(first->fetch[i].dst, second->fetch[j].dst) &&
+			   (!fnmatch(first->fetch[i].dst, second->fetch[j].dst, 0) ||
+			    !fnmatch(second->fetch[j].dst, first->fetch[i].dst, 0))) {
+				warning(_("Overlapping refspecs detected: '%s' and '%s', not pruning."),
+					first->fetch[i].dst, second->fetch[j].dst);
+				return 1;
+			}
+		}
+	}
+	return 0;
+}
+
 struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fetch_map)
 {
 	struct ref *ref, *stale_refs = NULL;
 	struct string_list ref_names = STRING_LIST_INIT_NODUP;
 	struct stale_heads_info info;
+	if(for_each_remote(check_overlapping_remotes, NULL))
+		return NULL;
 	info.ref_names = &ref_names;
 	info.stale_refs_tail = &stale_refs;
 	info.refs = refs;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 439e996..d4ac6ce 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -428,7 +428,7 @@ test_expect_success 'add alt && prune' '
 	 git rev-parse --verify refs/remotes/origin/side2)
 '
 
-test_expect_failure 'prune and overlapping refspecs' '
+test_expect_success 'prune and overlapping refspecs' '
 	(git clone --mirror one prunetst &&
 	 cd prunetst &&
 	 git remote add two ../two &&
-- 
1.8.3.1-619-gbec0aa7
