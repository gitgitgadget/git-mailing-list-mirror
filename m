From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH v3] Add push --set-upstream
Date: Sat, 16 Jan 2010 11:23:47 +0200
Message-ID: <1263633827-23720-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 10:24:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW4tH-0004v9-29
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 10:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab0APJX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 04:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604Ab0APJXy
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 04:23:54 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:46385 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab0APJXv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 04:23:51 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 7110EC7E4B
	for <git@vger.kernel.org>; Sat, 16 Jan 2010 11:23:49 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0631C6E162; Sat, 16 Jan 2010 11:23:49 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 421E827D84
	for <git@vger.kernel.org>; Sat, 16 Jan 2010 11:23:48 +0200 (EET)
X-Mailer: git-send-email 1.6.6.102.gd6f8f.dirty
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137212>

Frequent complaint is lack of easy way to set up upstream (tracking)
references for git pull to work as part of push command. So add switch
--set-upstream (-u) to do just that.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
Differences from v2:
- Only pretend to set up tracking in case of --dry-run.

 Documentation/git-push.txt |    9 +++++-
 builtin-push.c             |    1 +
 t/t5523-push-upstream.sh   |   69 ++++++++++++++++++++++++++++++++++++++++++++
 transport.c                |   56 +++++++++++++++++++++++++++++++++++
 transport.h                |    1 +
 5 files changed, 135 insertions(+), 1 deletions(-)
 create mode 100755 t/t5523-push-upstream.sh

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index e3eb1e8..2a5394b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git push' [--all | --mirror | --tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
-	   [--repo=<repository>] [-f | --force] [-v | --verbose]
+	   [--repo=<repository>] [-f | --force] [-v | --verbose] [-u | --set-upstream]
 	   [<repository> <refspec>...]
 
 DESCRIPTION
@@ -122,6 +122,13 @@ nor in any Push line of the corresponding remotes file---see below).
 	the name "origin" is used. For this latter case, this option
 	can be used to override the name "origin". In other words,
 	the difference between these two commands
+
+-u::
+--set-upstream::
+	For every branch that is up to date or successfully pushed, add
+	upstream (tracking) reference, used by argument-less
+	linkgit:git-pull[1] and other commands. For more information,
+	see 'branch.<name>.merge' in linkgit:git-config[1].
 +
 --------------------------
 git push public         #1
diff --git a/builtin-push.c b/builtin-push.c
index 28a26e7..75ddaf4 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -218,6 +218,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
+		OPT_BIT('u', "set-upstream", &flags, "Set upstream for git pull", TRANSPORT_PUSH_SET_UPSTREAM),
 		OPT_END()
 	};
 
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
new file mode 100755
index 0000000..00da707
--- /dev/null
+++ b/t/t5523-push-upstream.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='push with --set-upstream'
+. ./test-lib.sh
+
+test_expect_success 'setup bare parent' '
+	git init --bare parent &&
+	git remote add upstream parent
+'
+
+test_expect_success 'setup local commit' '
+	echo content >file &&
+	git add file &&
+	git commit -m one
+'
+
+check_config() {
+	(echo $2; echo $3) >expect.$1
+	(git config branch.$1.remote
+	 git config branch.$1.merge) >actual.$1
+	test_cmp expect.$1 actual.$1
+}
+
+test_expect_success 'push -u master:master' '
+	git push -u upstream master:master &&
+	check_config master upstream refs/heads/master
+'
+
+test_expect_success 'push -u master:other' '
+	git push -u upstream master:other &&
+	check_config master upstream refs/heads/other
+'
+
+test_expect_success 'push -u --dry-run master:otherX' '
+	git push -u --dry-run upstream master:otherX &&
+	check_config master upstream refs/heads/other
+'
+
+test_expect_success 'push -u master2:master2' '
+	git branch master2 &&
+	git push -u upstream master2:master2 &&
+	check_config master2 upstream refs/heads/master2
+'
+
+test_expect_success 'push -u master2:other2' '
+	git push -u upstream master2:other2 &&
+	check_config master2 upstream refs/heads/other2
+'
+
+test_expect_success 'push -u :master2' '
+	git push -u upstream :master2 &&
+	check_config master2 upstream refs/heads/other2
+'
+
+test_expect_success 'push -u --all' '
+	git branch all1 &&
+	git branch all2 &&
+	git push -u --all &&
+	check_config all1 upstream refs/heads/all1 &&
+	check_config all2 upstream refs/heads/all2
+'
+
+test_expect_success 'push -u HEAD' '
+	git checkout -b headbranch &&
+	git push -u upstream HEAD &&
+	check_config headbranch upstream refs/heads/headbranch
+'
+
+test_done
diff --git a/transport.c b/transport.c
index b5332c0..12b3d69 100644
--- a/transport.c
+++ b/transport.c
@@ -8,6 +8,7 @@
 #include "bundle.h"
 #include "dir.h"
 #include "refs.h"
+#include "branch.h"
 
 /* rsync support */
 
@@ -135,6 +136,53 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 	}
 }
 
+static void set_upstreams(struct transport *trans, struct ref *refs,
+	int pretend)
+{
+	struct ref *i;
+	for (i = refs; i; i = i->next) {
+		const char *localname;
+		const char *tmp;
+		const char *remotename;
+		unsigned char sha[20];
+		int flag = 0;
+		/*
+		 * Check suitability for tracking. Must be successful /
+		 * alreay up-to-date ref create/modify (not delete).
+		 */
+		if (i->status != REF_STATUS_OK &&
+			i->status != REF_STATUS_UPTODATE)
+			continue;
+		if (!i->peer_ref)
+			continue;
+		if (!i->new_sha1 || is_null_sha1(i->new_sha1))
+			continue;
+
+		/* Chase symbolic refs (mainly for HEAD). */
+		localname = i->peer_ref->name;
+		remotename = i->name;
+		tmp = resolve_ref(localname, sha, 1, &flag);
+		if (tmp && flag & REF_ISSYMREF &&
+			!prefixcmp(tmp, "refs/heads/"))
+			localname = tmp;
+
+		/* Both source and destination must be local branches. */
+		if (!localname || prefixcmp(localname, "refs/heads/"))
+			continue;
+		if (!remotename || prefixcmp(remotename, "refs/heads/"))
+			continue;
+
+		if (!pretend)
+			install_branch_config(BRANCH_CONFIG_VERBOSE,
+				localname + 11, trans->remote->name,
+				remotename);
+		else
+			printf("Would set upstream '%s' -> '%s' of '%s'\n",
+				localname + 11, remotename + 11,
+				trans->remote->name);
+	}
+}
+
 static const char *rsync_url(const char *url)
 {
 	return prefixcmp(url, "rsync://") ? skip_prefix(url, "rsync:") : url;
@@ -974,6 +1022,10 @@ int transport_push(struct transport *transport,
 	verify_remote_names(refspec_nr, refspec);
 
 	if (transport->push) {
+		/* Maybe FIXME. But no important transport uses this case. */
+		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
+			die("This transport does not support using --set-upstream");
+
 		return transport->push(transport, refspec_nr, refspec, flags);
 	} else if (transport->push_refs) {
 		struct ref *remote_refs =
@@ -983,6 +1035,7 @@ int transport_push(struct transport *transport,
 		int verbose = flags & TRANSPORT_PUSH_VERBOSE;
 		int quiet = flags & TRANSPORT_PUSH_QUIET;
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
+		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int ret;
 
 		if (flags & TRANSPORT_PUSH_ALL)
@@ -1002,6 +1055,9 @@ int transport_push(struct transport *transport,
 					verbose | porcelain, porcelain,
 					nonfastforward);
 
+		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
+			set_upstreams(transport, remote_refs, pretend);
+
 		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
 			struct ref *ref;
 			for (ref = remote_refs; ref; ref = ref->next)
diff --git a/transport.h b/transport.h
index 97ba251..c4314dd 100644
--- a/transport.h
+++ b/transport.h
@@ -91,6 +91,7 @@ struct transport {
 #define TRANSPORT_PUSH_VERBOSE 16
 #define TRANSPORT_PUSH_PORCELAIN 32
 #define TRANSPORT_PUSH_QUIET 64
+#define TRANSPORT_PUSH_SET_UPSTREAM 128
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
1.6.6.102.gd6f8f.dirty
