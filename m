From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3] Make "git-remote rm" delete refs acccording to fetch specs
Date: Sat, 31 May 2008 23:59:01 -0400
Message-ID: <20080601035901.GC32176@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 06:00:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2eje-0004oC-P2
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 05:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbYFAD7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 23:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755342AbYFAD7F
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 23:59:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41984 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334AbYFAD7F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 23:59:05 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K2eiY-00059U-UE; Sat, 31 May 2008 23:58:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CBF8C20FBAE; Sat, 31 May 2008 23:59:01 -0400 (EDT)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83428>

A remote may be configured to fetch into tracking branches that
don't match its name.  A user may have created a remote by hand
that will fetch to a different tracking branch namespace:

  [remote "alt"]
    url = git://repo.or.cz/alt-git.git
    fetch = refs/heads/*:refs/remotes/origin/*

When deleting remote alt we should clean up the refs whose names
start with "refs/remotes/origin/", even though the remote itself
was named alt by the user.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I'm not sure this is the right thing to do here.  If another
 remote is still using these tracking refs (such as the example
 in my prior patch of this series) we may not want to remove these
 when we remove the remote.

 builtin-remote.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index e5cfc88..6dbc3d4 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -268,7 +268,7 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 }
 
 struct branches_for_remote {
-	const char *prefix;
+	struct remote *remote;
 	struct path_list *branches;
 };
 
@@ -276,8 +276,11 @@ static int add_branch_for_removal(const char *refname,
 	const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct branches_for_remote *branches = cb_data;
+	struct refspec refspec;
 
-	if (!prefixcmp(refname, branches->prefix)) {
+	memset(&refspec, 0, sizeof(refspec));
+	refspec.dst = (char *)refname;
+	if (!remote_find_tracking(branches->remote, &refspec)) {
 		struct path_list_item *item;
 
 		/* make sure that symrefs are deleted */
@@ -352,9 +355,7 @@ static int rm(int argc, const char **argv)
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
