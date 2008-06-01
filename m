From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3 v2] Make "git-remote rm" delete refs acccording to fetch specs
Date: Sun, 1 Jun 2008 00:28:04 -0400
Message-ID: <20080601042804.GA32293@spearce.org>
References: <20080601035901.GC32176@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 06:29:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2fCD-00017v-T0
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 06:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbYFAE2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 00:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbYFAE2J
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 00:28:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49586 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbYFAE2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 00:28:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K2fAs-0007pr-8G; Sun, 01 Jun 2008 00:28:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B31D520FBAE; Sun,  1 Jun 2008 00:28:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080601035901.GC32176@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83429>

A remote may be configured to fetch into tracking branches that
don't match its name.  A user may have created a remote by hand
that will fetch to a different tracking branch namespace:

  [remote "alt"]
    url = git://repo.or.cz/alt-git.git
    fetch = refs/heads/*:refs/remotes/origin/*

When deleting remote alt we should clean up the refs whose names
start with "refs/remotes/origin/", even though the remote itself
was named alt by the user.

To avoid deleting refs used by another remote we only clear refs
that are unique to this remote.  This prevents `git prune rm alt`
from removing the refs used by say origin if alt was just using a
different URL for the same repository.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is a longer, but better version of this patch.  Instead of
 blindly deleting the refs we remove them only if this is the last
 remote that would write to the local tracking ref.

 builtin-remote.c |   68 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index e5cfc88..c49f00f 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -267,27 +267,65 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 	return 0;
 }
 
+struct known_remote {
+	struct known_remote *next;
+	struct remote *remote;
+};
+
+struct known_remotes {
+	struct remote *to_delete;
+	struct known_remote *list;
+};
+
+static int add_known_remote(struct remote *remote, void *cb_data)
+{
+	struct known_remotes *all = cb_data;
+	struct known_remote *r;
+
+	if (!strcmp(all->to_delete->name, remote->name))
+		return 0;
+
+	r = xmalloc(sizeof(*r));
+	r->remote = remote;
+	r->next = all->list;
+	all->list = r;
+	return 0;
+}
+
 struct branches_for_remote {
-	const char *prefix;
+	struct remote *remote;
 	struct path_list *branches;
+	struct known_remotes *keep;
 };
 
 static int add_branch_for_removal(const char *refname,
 	const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct branches_for_remote *branches = cb_data;
+	struct refspec refspec;
+	struct path_list_item *item;
+	struct known_remote *kr;
 
-	if (!prefixcmp(refname, branches->prefix)) {
-		struct path_list_item *item;
+	memset(&refspec, 0, sizeof(refspec));
+	refspec.dst = (char *)refname;
+	if (remote_find_tracking(branches->remote, &refspec))
+		return 0;
+
+	/* don't delete a branch if another remote also uses it */
+	for (kr = branches->keep->list; kr; kr = kr->next) {
+		memset(&refspec, 0, sizeof(refspec));
+		refspec.dst = (char *)refname;
+		if (!remote_find_tracking(kr->remote, &refspec))
+			return 0;
+	}
 
-		/* make sure that symrefs are deleted */
-		if (flags & REF_ISSYMREF)
-			return unlink(git_path(refname));
+	/* make sure that symrefs are deleted */
+	if (flags & REF_ISSYMREF)
+		return unlink(git_path(refname));
 
-		item = path_list_append(refname, branches->branches);
-		item->util = xmalloc(20);
-		hashcpy(item->util, sha1);
-	}
+	item = path_list_append(refname, branches->branches);
+	item->util = xmalloc(20);
+	hashcpy(item->util, sha1);
 
 	return 0;
 }
@@ -313,8 +351,9 @@ static int rm(int argc, const char **argv)
 	};
 	struct remote *remote;
 	struct strbuf buf;
+	struct known_remotes known_remotes = { NULL, NULL };
 	struct path_list branches = { NULL, 0, 0, 1 };
-	struct branches_for_remote cb_data = { NULL, &branches };
+	struct branches_for_remote cb_data = { NULL, &branches, &known_remotes };
 	int i;
 
 	if (argc != 2)
@@ -324,6 +363,9 @@ static int rm(int argc, const char **argv)
 	if (!remote)
 		die("No such remote: %s", argv[1]);
 
+	known_remotes.to_delete = remote;
+	for_each_remote(add_known_remote, &known_remotes);
+
 	strbuf_init(&buf, 0);
 	strbuf_addf(&buf, "remote.%s", remote->name);
 	if (git_config_rename_section(buf.buf, NULL) < 1)
@@ -352,9 +394,7 @@ static int rm(int argc, const char **argv)
 	 * the branches one by one, since for_each_ref() relies on cached
 	 * refs, which are invalidated when deleting a branch.
 	 */
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "refs/remotes/%s/", remote->name);
-	cb_data.prefix = buf.buf;
+	cb_data.remote = remote;
 	i = for_each_ref(add_branch_for_removal, &cb_data);
 	strbuf_release(&buf);
 
-- 
1.5.6.rc0.158.g7c7a1
