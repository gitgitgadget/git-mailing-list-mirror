From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3] Don't crash during repack of a reflog with pruned commits.
Date: Thu, 21 Dec 2006 19:49:06 -0500
Message-ID: <20061222004906.GC14789@spearce.org>
References: <be6b1443171482e1930bd7744a0218db0c03d611.1166748450.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 01:49:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYb4-00032N-7L
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 01:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423165AbWLVAtK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 19:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423167AbWLVAtK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 19:49:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57691 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423165AbWLVAtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 19:49:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GxYan-0005Qq-PQ; Thu, 21 Dec 2006 19:48:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5474F20FB65; Thu, 21 Dec 2006 19:49:06 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <be6b1443171482e1930bd7744a0218db0c03d611.1166748450.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35102>

If the user has been using reflog for a long time (e.g. since its
introduction) then it is very likely that an existing branch's
reflog may still mention commits which have long since been pruned
out of the repository.

Rather than aborting with a very useless error message during
git-repack, pack as many valid commits as we can get from the
reflog and let the user know that the branch's reflog contains
already pruned commits.  A future 'git reflog expire' (or whatever
it finally winds up being called) can then be performed to expunge
those reflog entries.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 revision.c |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index de2cbd8..52330cc 100644
--- a/revision.c
+++ b/revision.c
@@ -466,6 +466,7 @@ static void limit_list(struct rev_info *revs)
 
 struct all_refs_cb {
 	int all_flags;
+	int warned_bad_reflog;
 	struct rev_info *all_revs;
 	const char *name_for_errormsg;
 };
@@ -487,25 +488,33 @@ static void handle_all(struct rev_info *revs, unsigned flags)
 	for_each_ref(handle_one_ref, &cb);
 }
 
-static int handle_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1, char *detail, void *cb_data)
+static int handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
-	struct object *object;
-
-	if (!is_null_sha1(osha1)) {
-		object = get_reference(cb->all_revs, cb->name_for_errormsg,
-				       osha1, cb->all_flags);
-		add_pending_object(cb->all_revs, object, "");
+	if (!is_null_sha1(sha1)) {
+		struct object *o = parse_object(sha1);
+		if (o) {
+			o->flags |= cb->all_flags;
+			add_pending_object(cb->all_revs, o, "");
+		} else if (!cb->warned_bad_reflog) {
+			warn("reflog of '%s' references pruned commits",
+				cb->name_for_errormsg);
+			cb->warned_bad_reflog = 1;
+		}
 	}
-	object = get_reference(cb->all_revs, cb->name_for_errormsg,
-			       nsha1, cb->all_flags);
-	add_pending_object(cb->all_revs, object, "");
+}
+
+static int handle_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1, char *detail, void *cb_data)
+{
+	handle_one_reflog_commit(osha1, cb_data);
+	handle_one_reflog_commit(nsha1, cb_data);
 	return 0;
 }
 
 static int handle_one_reflog(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
+	cb->warned_bad_reflog = 0;
 	cb->name_for_errormsg = path;
 	for_each_reflog_ent(path, handle_one_reflog_ent, cb_data);
 	return 0;
-- 
1.4.4.3.ga78a1
