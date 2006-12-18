X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Protect commits recorded in reflog from pruning.
Date: Mon, 18 Dec 2006 01:42:32 -0800
Message-ID: <7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 09:42:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vodq3a136.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 16 Dec 2006 15:10:53 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34734>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwF12-0008HA-ND for gcvg-git@gmane.org; Mon, 18 Dec
 2006 10:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753649AbWLRJme (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 04:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbWLRJmd
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 04:42:33 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:35941 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753649AbWLRJmd (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 04:42:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061218094232.LVUV4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Mon, 18
 Dec 2006 04:42:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 09ik1W00E1kojtg0000000; Mon, 18 Dec 2006
 04:42:45 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This teaches fsck-objects and prune to protect objects referred
to by reflog entries.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 >>  - now reflog is enabled by default for user repositories, I
 >>    have two worries about its effect, fortunately can be killed
 >>    with a single stone.
 >> 
 >>    * the reflog grows unbounded;
 >> 
 >>    * revisions recorded in the reflog can be pruned out,
 >>      rendering some entries in reflog useless.
 >> 
 >>    I am thinking about teaching fsck-objects and prune to keep
 >>    revisions recorded in the reflog; we would need an end-user
 >>    way to prune older reflog entries and I would appreciate
 >>    somebody codes it up, but even without it, people can always
 >>    use "vi" or "ed" on reflog files ;-).

 Rewinding would not lose any objects from the object database
 with this; somebody needs to code up a garbage collector and/or
 expiration mechanism for reflogs.

 builtin-prune.c |   16 ++++++++++++++++
 fsck-objects.c  |   22 ++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 8591d28..00a53b3 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -181,12 +181,28 @@ static void walk_commit_list(struct rev_info *revs)
 	}
 }
 
+static int add_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1, char *datail, void *cb_data)
+{
+	struct object *object;
+
+	object = parse_object(osha1);
+	if (object)
+		add_pending_object(&revs, object, "");
+	object = parse_object(nsha1);
+	if (object)
+		add_pending_object(&revs, object, "");
+	return 0;
+}
+
 static int add_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *object = parse_object(sha1);
 	if (!object)
 		die("bad object ref: %s:%s", path, sha1_to_hex(sha1));
 	add_pending_object(&revs, object, "");
+
+	for_each_reflog_ent(path, add_one_reflog_ent, NULL);
+
 	return 0;
 }
 
diff --git a/fsck-objects.c b/fsck-objects.c
index 46b628c..e3746e8 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -402,6 +402,25 @@ static void fsck_dir(int i, char *path)
 
 static int default_refs;
 
+static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1, char *datail, void *cb_data)
+{
+	struct object *obj;
+
+	if (!is_null_sha1(osha1)) {
+		obj = lookup_object(osha1);
+		if (obj) {
+			obj->used = 1;
+			mark_reachable(obj, REACHABLE);
+		}
+	}
+	obj = lookup_object(nsha1);
+	if (obj) {
+		obj->used = 1;
+		mark_reachable(obj, REACHABLE);
+	}
+	return 0;
+}
+
 static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *obj;
@@ -419,6 +438,9 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 	default_refs++;
 	obj->used = 1;
 	mark_reachable(obj, REACHABLE);
+
+	for_each_reflog_ent(refname, fsck_handle_reflog_ent, NULL);
+
 	return 0;
 }
 
-- 
1.4.4.2.gc30f

