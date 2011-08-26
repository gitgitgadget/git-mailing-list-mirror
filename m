From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] revision: keep track of the end-user input from the
 command line
Date: Thu, 25 Aug 2011 18:00:00 -0700
Message-ID: <7vbovdgf73.fsf_-_@alter.siamese.dyndns.org>
References: <20110824213205.GI45292@book.hvoigt.net>
 <438ea0b254ccafb3fc9f3431f8f86007cc03132b.1314290439.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, Heiko Voigt <hvoigt@hvoigt.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 03:00:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwkmc-0007P1-IG
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 03:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab1HZBAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 21:00:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120Ab1HZBAL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 21:00:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B63B4A20;
	Thu, 25 Aug 2011 21:00:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t/db9on4GM1jN3jiK3ITRd5Dddw=; b=kc4N6F
	8fZzHvoXRfrw+aZ1uglRC8tU4pJpVdKxj+SU7hbhQCOKANDA7mePRlD7KRFf220A
	BmM7bj6yeK0xztLFHFhNatevfzf3NdkB+3PSbfXsPJO0uEnBTNm6T3wMXL2h3JfT
	lPCFrCCcjdzd4T1dd7/Z9KGosbe2VRtFhSTSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PfcMW7w63JYyDHrZlDRb/dtzU9kDynuJ
	/ntSnmX9EG52V5eAnETHkDOC+vqGo4+kq5nhj84S6wu/GjVU/G7hK+ta35fsoJCa
	/e8095wAzymlnnUGoDCCbOyRLJyrPjwtDiL+EDwSCG3Jy2RD8fPLsvFxSBtFVacv
	ViRL4cvaZV8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2517E4A1F;
	Thu, 25 Aug 2011 21:00:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 471374A02; Thu, 25 Aug 2011
 21:00:03 -0400 (EDT)
In-Reply-To: <438ea0b254ccafb3fc9f3431f8f86007cc03132b.1314290439.git.brad.king@kitware.com> (Brad King's message of "Thu, 25 Aug 2011 12:49:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB1AC7C8-CF7E-11E0-9438-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180141>

Given a complex set of revision specifiers on the command line, it is too
late to look at the flags of the objects in the initial traversal list at
the beginning of limit_list() in order to determine what the objects the
end-user explicitly listed on the command line were. The process to move
objects from the pending array to the traversal list may have marked
objects that are not mentioned as UNINTERESTING, when handle_commit()
marked the parents of UNINTERESTING commits mentioned on the command line
by calling mark_parents_uninteresting().

This made "rev-list --ancestry-path ^A ..." to mistakenly list commits
that are descendants of A's parents but that are not descendants of A
itself, as ^A from the command line causes A and its parents marked as
UNINTERESTING before coming to limit_list(), and we try to enumerate the
commits that are descendants of these commits that are UNINTERESTING
before we start walking the history.

It actually is too late even if we inspected the pending object array
before calling prepare_revision_walk(), as some of the same objects might
have been mentioned twice, once as positive and another time as negative.
The "rev-list --some-option A --not --all" command may want to notice,
even if the resulting set is empty, that the user showed some interest in
"A" and do something special about it.

Prepare a separate array to keep track of what syntactic element was used
to cause each object to appear in the pending array from the command line,
and populate it as setup_revisions() parses the command line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Should apply cleanly on top of your test case.

 revision.c |   37 +++++++++++++++++++++++++++++++++----
 revision.h |   20 ++++++++++++++++++++
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 96d7fa7..3e87c86 100644
--- a/revision.c
+++ b/revision.c
@@ -797,6 +797,23 @@ static int limit_list(struct rev_info *revs)
 	return 0;
 }
 
+static void add_rev_cmdline(struct rev_info *revs,
+			    struct object *item,
+			    const char *name,
+			    int whence,
+			    unsigned flags)
+{
+	struct rev_cmdline_info *info = &revs->cmdline;
+	int nr = info->nr;
+
+	ALLOC_GROW(info->rev, nr + 1, info->alloc);
+	info->rev[nr].item = item;
+	info->rev[nr].name = name;
+	info->rev[nr].whence = whence;
+	info->rev[nr].flags = flags;
+	info->nr++;
+}
+
 struct all_refs_cb {
 	int all_flags;
 	int warned_bad_reflog;
@@ -809,6 +826,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1, int flag,
 	struct all_refs_cb *cb = cb_data;
 	struct object *object = get_reference(cb->all_revs, path, sha1,
 					      cb->all_flags);
+	add_rev_cmdline(cb->all_revs, object, path, REV_CMD_REF, cb->all_flags);
 	add_pending_object(cb->all_revs, object, path);
 	return 0;
 }
@@ -835,6 +853,7 @@ static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
 		struct object *o = parse_object(sha1);
 		if (o) {
 			o->flags |= cb->all_flags;
+			/* ??? CMDLINEFLAGS ??? */
 			add_pending_object(cb->all_revs, o, "");
 		}
 		else if (!cb->warned_bad_reflog) {
@@ -871,12 +890,13 @@ static void handle_reflog(struct rev_info *revs, unsigned flags)
 	for_each_reflog(handle_one_reflog, &cb);
 }
 
-static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
+static int add_parents_only(struct rev_info *revs, const char *arg_, int flags)
 {
 	unsigned char sha1[20];
 	struct object *it;
 	struct commit *commit;
 	struct commit_list *parents;
+	const char *arg = arg_;
 
 	if (*arg == '^') {
 		flags ^= UNINTERESTING;
@@ -898,6 +918,7 @@ static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
 	for (parents = commit->parents; parents; parents = parents->next) {
 		it = &parents->item->object;
 		it->flags |= flags;
+		add_rev_cmdline(revs, it, arg_, REV_CMD_PARENTS_ONLY, flags);
 		add_pending_object(revs, it, arg);
 	}
 	return 1;
@@ -987,7 +1008,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	revs->limited = 1;
 }
 
-int handle_revision_arg(const char *arg, struct rev_info *revs,
+int handle_revision_arg(const char *arg_, struct rev_info *revs,
 			int flags,
 			int cant_be_filename)
 {
@@ -996,6 +1017,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	struct object *object;
 	unsigned char sha1[20];
 	int local_flags;
+	const char *arg = arg_;
 
 	dotdot = strstr(arg, "..");
 	if (dotdot) {
@@ -1004,6 +1026,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 		const char *this = arg;
 		int symmetric = *next == '.';
 		unsigned int flags_exclude = flags ^ UNINTERESTING;
+		unsigned int a_flags;
 
 		*dotdot = 0;
 		next += symmetric;
@@ -1036,10 +1059,15 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 				add_pending_commit_list(revs, exclude,
 							flags_exclude);
 				free_commit_list(exclude);
-				a->object.flags |= flags | SYMMETRIC_LEFT;
+				a_flags = flags | SYMMETRIC_LEFT;
 			} else
-				a->object.flags |= flags_exclude;
+				a_flags = flags_exclude;
+			a->object.flags |= a_flags;
 			b->object.flags |= flags;
+			add_rev_cmdline(revs, &a->object, this,
+					REV_CMD_LEFT, a_flags);
+			add_rev_cmdline(revs, &b->object, next,
+					REV_CMD_RIGHT, flags);
 			add_pending_object(revs, &a->object, this);
 			add_pending_object(revs, &b->object, next);
 			return 0;
@@ -1070,6 +1098,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, sha1, flags ^ local_flags);
+	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
 	add_pending_object_with_mode(revs, object, arg, mode);
 	return 0;
 }
diff --git a/revision.h b/revision.h
index 855464f..031cc7c 100644
--- a/revision.h
+++ b/revision.h
@@ -23,6 +23,23 @@ struct rev_info;
 struct log_info;
 struct string_list;
 
+struct rev_cmdline_info {
+	unsigned int nr;
+	unsigned int alloc;
+	struct rev_cmdline_entry {
+		struct object *item;
+		const char *name;
+		enum {
+			REV_CMD_REF,
+			REV_CMD_PARENTS_ONLY,
+			REV_CMD_LEFT,
+			REV_CMD_RIGHT,
+			REV_CMD_REV
+		} whence;
+		unsigned flags;
+	} *rev;
+};
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -31,6 +48,9 @@ struct rev_info {
 	/* Parents of shown commits */
 	struct object_array boundary_commits;
 
+	/* The end-points specified by the end user */
+	struct rev_cmdline_info cmdline;
+
 	/* Basic information */
 	const char *prefix;
 	const char *def;
-- 
1.7.6.1.385.gb7fcd0
