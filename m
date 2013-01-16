From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 1/2] fix clang -Wconstant-conversion with bit fields
Date: Wed, 16 Jan 2013 23:47:22 +0100
Message-ID: <1358376443-7404-1-git-send-email-apelisse@gmail.com>
References: <20130116182449.GA4881@sigill.intra.peff.net>
Cc: git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: John Keeping <john@keeping.me.uk>, Max Horn <max@quendi.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 23:48:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvbmb-00081i-13
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 23:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758022Ab3APWsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 17:48:10 -0500
Received: from mail-wg0-f51.google.com ([74.125.82.51]:43197 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757690Ab3APWsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 17:48:08 -0500
Received: by mail-wg0-f51.google.com with SMTP id gg4so1255120wgb.30
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 14:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=sfzNNX7XrFKRdH/LXyNzmtC4taj4mo7YOQV01ov06cI=;
        b=Bf6ybB4XdLOjfOq9MVN8FQ1G5Qy5UlBpwBE/8B8SHbLrukVeJK8A849r4Jea5kTGX2
         kzo6K7EC1aZ8585d3yw9UE9oW75tPvRe0cNe9aF5qM8w5BU9XWMwyTTs3F/gvM30etNa
         dPive0zExx4gggn3Dtt42BMZU3pLiIjD4RJ31xmG7NObxjdOzpyR/Jeu5dnimBFbvdVU
         lBqoWZQ8sTcaOwynfAZSeHTLmVYQ7CDct850KrBQ4+9AigBmU9S+jrpCoouWAgy2HXC0
         x4N35rpq6WIkkzsuzG+XnzMph9cLCa9z/JlPb+3vJfoZIQZoht4vhgH7RfYuWFJZQuIC
         lePQ==
X-Received: by 10.180.97.68 with SMTP id dy4mr4886129wib.7.1358376486888;
        Wed, 16 Jan 2013 14:48:06 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id hu8sm10435375wib.6.2013.01.16.14.48.05
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jan 2013 14:48:06 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.435.g20d29be.dirty
In-Reply-To: <20130116182449.GA4881@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213818>

clang incorrectly reports a constant conversion warning (implicit
truncation to bit field) when using the "flag &= ~FLAG" form, because
~FLAG needs to be truncated.

Convert this form to "flag = flag & ~FLAG" fixes the issue as
the right operand now fits into the bit field.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
I'm sorry about this fix, it really seems bad, yet it's one step closer
to warning-free clang compilation.

It seems quite clear to me that it's a bug in clang.

 bisect.c           | 2 +-
 builtin/checkout.c | 2 +-
 builtin/reflog.c   | 4 ++--
 commit.c           | 4 ++--
 revision.c         | 8 ++++----
 upload-pack.c      | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/bisect.c b/bisect.c
index bd1b7b5..34ac01d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -63,7 +63,7 @@ static void clear_distance(struct commit_list *list)
 {
 	while (list) {
 		struct commit *commit = list->item;
-		commit->object.flags &= ~COUNTED;
+		commit->object.flags = commit->object.flags & ~COUNTED;
 		list = list->next;
 	}
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a..2c83234 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -717,7 +717,7 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	init_revisions(&revs, NULL);
 	setup_revisions(0, NULL, &revs, NULL);

-	object->flags &= ~UNINTERESTING;
+	object->flags = object->flags & ~UNINTERESTING;
 	add_pending_object(&revs, object, sha1_to_hex(object->sha1));

 	for_each_ref(add_pending_uninteresting_ref, &revs);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index b3c9e27..3079c81 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -170,7 +170,7 @@ static int commit_is_complete(struct commit *commit)
 	}
 	/* clear flags from the objects we traversed */
 	for (i = 0; i < found.nr; i++)
-		found.objects[i].item->flags &= ~STUDYING;
+		found.objects[i].item->flags = found.objects[i].item->flags&  ~STUDYING;
 	if (is_incomplete)
 		commit->object.flags |= INCOMPLETE;
 	else {
@@ -229,7 +229,7 @@ static void mark_reachable(struct expire_reflog_cb *cb)
 	struct commit_list *leftover = NULL;

 	for (pending = cb->mark_list; pending; pending = pending->next)
-		pending->item->object.flags &= ~REACHABLE;
+		pending->item->object.flags = pending->item->object.flags & ~REACHABLE;

 	pending = cb->mark_list;
 	while (pending) {
diff --git a/commit.c b/commit.c
index e8eb0ae..800779d 100644
--- a/commit.c
+++ b/commit.c
@@ -883,7 +883,7 @@ struct commit_list *reduce_heads(struct commit_list *heads)

 	/* Uniquify */
 	for (p = heads; p; p = p->next)
-		p->item->object.flags &= ~STALE;
+		p->item->object.flags = p->item->object.flags & ~STALE;
 	for (p = heads, num_head = 0; p; p = p->next) {
 		if (p->item->object.flags & STALE)
 			continue;
@@ -894,7 +894,7 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	for (p = heads, i = 0; p; p = p->next) {
 		if (p->item->object.flags & STALE) {
 			array[i++] = p->item;
-			p->item->object.flags &= ~STALE;
+			p->item->object.flags = p->item->object.flags & ~STALE;
 		}
 	}
 	num_head = remove_redundant(array, num_head);
diff --git a/revision.c b/revision.c
index d7562ee..ed1c16d 100644
--- a/revision.c
+++ b/revision.c
@@ -787,9 +787,9 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li

 	/* We are done with the TMP_MARK */
 	for (p = list; p; p = p->next)
-		p->item->object.flags &= ~TMP_MARK;
+		p->item->object.flags = p->item->object.flags & ~TMP_MARK;
 	for (p = bottom; p; p = p->next)
-		p->item->object.flags &= ~TMP_MARK;
+		p->item->object.flags = p->item->object.flags & ~TMP_MARK;
 	free_commit_list(rlist);
 }

@@ -1948,7 +1948,7 @@ static int remove_duplicate_parents(struct commit *commit)
 	/* count them while clearing the temporary mark */
 	surviving_parents = 0;
 	for (p = commit->parents; p; p = p->next) {
-		p->item->object.flags &= ~TMP_MARK;
+		p->item->object.flags = p->item->object.flags & ~TMP_MARK;
 		surviving_parents++;
 	}
 	return surviving_parents;
@@ -2378,7 +2378,7 @@ static struct commit *get_revision_1(struct rev_info *revs)

 		if (revs->reflog_info) {
 			fake_reflog_parent(revs->reflog_info, commit);
-			commit->object.flags &= ~(ADDED | SEEN | SHOWN);
+			commit->object.flags = commit->object.flags & ~(ADDED | SEEN | SHOWN);
 		}

 		/*
diff --git a/upload-pack.c b/upload-pack.c
index 7c05b15..74d8f0e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -113,7 +113,7 @@ static int do_rev_list(int in, int out, void *user_data)
 	for (i = 0; i < want_obj.nr; i++) {
 		struct object *o = want_obj.objects[i].item;
 		/* why??? */
-		o->flags &= ~UNINTERESTING;
+		o->flags = o->flags & ~UNINTERESTING;
 		add_pending_object(&revs, o, NULL);
 	}
 	for (i = 0; i < have_obj.nr; i++) {
@@ -700,7 +700,7 @@ static void receive_needs(void)
 				struct commit_list *parents;
 				packet_write(1, "unshallow %s",
 					sha1_to_hex(object->sha1));
-				object->flags &= ~CLIENT_SHALLOW;
+				object->flags = object->flags & ~CLIENT_SHALLOW;
 				/* make sure the real parents are parsed */
 				unregister_shallow(object->sha1);
 				object->parsed = 0;
--
1.8.1.1.435.g20d29be.dirty
