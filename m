From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH] Add push --set-upstream
Date: Fri, 15 Jan 2010 18:36:47 +0200
Message-ID: <1263573407-13642-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 17:36:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVpAO-0003VY-5Y
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 17:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab0AOQgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 11:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780Ab0AOQgw
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 11:36:52 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:51229 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab0AOQgv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 11:36:51 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 1A5F48C4BF
	for <git@vger.kernel.org>; Fri, 15 Jan 2010 18:36:50 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A05043160AC; Fri, 15 Jan 2010 18:36:50 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id E978E158A64
	for <git@vger.kernel.org>; Fri, 15 Jan 2010 18:36:48 +0200 (EET)
X-Mailer: git-send-email 1.6.6.102.gd6f8f.dirty
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137081>

Frequent complaint is lack of easy way to set up upstream (tracking)
references for git pull to work as part of push command. So add switch
--set-upstream (-u) to do just that.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
This is built on top of master.

 Documentation/git-push.txt |    8 +++++++-
 builtin-push.c             |    1 +
 transport.c                |   35 +++++++++++++++++++++++++++++++++++
 transport.h                |    1 +
 4 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index e3eb1e8..6c68978 100644
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
@@ -122,6 +122,12 @@ nor in any Push line of the corresponding remotes file---see below).
 	the name "origin" is used. For this latter case, this option
 	can be used to override the name "origin". In other words,
 	the difference between these two commands
+
+-u::
+--set-upstream::
+	For every branch that is up to date or successfully pushed, add
+	upstream (tracking) reference for argument-less git pull.
+
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
 
diff --git a/transport.c b/transport.c
index b5332c0..956d2ed 100644
--- a/transport.c
+++ b/transport.c
@@ -8,6 +8,7 @@
 #include "bundle.h"
 #include "dir.h"
 #include "refs.h"
+#include "branch.h"
 
 /* rsync support */
 
@@ -135,6 +136,33 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 	}
 }
 
+static void set_upstreams(struct transport *trans, struct ref *refs)
+{
+	struct ref *i;
+	for (i = refs; i; i = i->next) {
+		/*
+		 * Check suitability for tracking. Must be successful /
+		 * alreay up-to-date ref create/modify (not delete) and
+		 * both sides must be local branches.
+		 */
+		if (i->status != REF_STATUS_OK &&
+			i->status != REF_STATUS_UPTODATE)
+			continue;
+		if (!i->peer_ref)
+			continue;
+		if (!i->new_sha1 || is_null_sha1(i->new_sha1))
+			continue;
+		if (prefixcmp(i->peer_ref->name, "refs/heads/"))
+			continue;
+		if (prefixcmp(i->name, "refs/heads/"))
+			continue;
+
+		install_branch_config(BRANCH_CONFIG_VERBOSE,
+			i->peer_ref->name + 11, trans->remote->name,
+			i->name);
+	}
+}
+
 static const char *rsync_url(const char *url)
 {
 	return prefixcmp(url, "rsync://") ? skip_prefix(url, "rsync:") : url;
@@ -974,6 +1002,10 @@ int transport_push(struct transport *transport,
 	verify_remote_names(refspec_nr, refspec);
 
 	if (transport->push) {
+		/* Maybe FIXME. But no important transport uses this case. */
+		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
+			die("This transport does not support using --set-upstream");
+
 		return transport->push(transport, refspec_nr, refspec, flags);
 	} else if (transport->push_refs) {
 		struct ref *remote_refs =
@@ -1002,6 +1034,9 @@ int transport_push(struct transport *transport,
 					verbose | porcelain, porcelain,
 					nonfastforward);
 
+		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
+			set_upstreams(transport, remote_refs);
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
