From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] warn use of "git diff A..B"
Date: Wed, 23 Mar 2011 14:45:17 -0700
Message-ID: <7vei5xcxzm.fsf@alter.siamese.dyndns.org>
References: <7voc51cydw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 22:45:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Vrt-0004v2-Ux
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 22:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751Ab1CWVpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 17:45:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab1CWVpX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 17:45:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 33BDF4AD8;
	Wed, 23 Mar 2011 17:47:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ly52myKYV7RFmnuOuijkXKVdwPU=; b=Y+4yWC
	vcKbg41rYa8xBSkrYUty4pxacWxLVUKFnPXpLO184QE5fYmoRMmDTv0rrwMZVQgJ
	A98blvYtkiQaU2ENRaqJcXC9xQ2awHctcokwUnSGrAc7TWXe+mYSAt4dXR57dnv4
	JSimNA47QOlTslvzn3xtIJxAaAP0/ihkod0gI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xb5lrQf5hncAQXorbDqUcW1uo/Ub900F
	E8+OUvX0nHnTmjoJ9XwgFfh169lmkrc5j8qiNr8ruzQSYoxVPYXgXlTtBOVFwbtw
	sV2pPbWAoJI/MZwjGEE0IS77IoTt2hx90RlqKOCtzKEz4iw5MLqGbxdQUczmPcAo
	2FzfS7dXoe8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D19F4AD6;
	Wed, 23 Mar 2011 17:47:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 216BD4AD5; Wed, 23 Mar 2011
 17:46:58 -0400 (EDT)
In-Reply-To: <7voc51cydw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 23 Mar 2011 14:36:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 157F5740-5597-11E0-80B2-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169875>

"git diff" (and "diff-tree") accepts a range notation "A..B" from the
command line to specify the two endpoints to be compared; the right way to
spell this would be "git diff A B".  This is merely a historical accident
that comes from the fact that "git log" family of commands and "git diff"
happens to share some code in their command line parsers.

It was fine for people who are used to seeing "git diff A..B" and silently
translating it to "git diff A B" in their head, but it made things hard
for new people.  It is easy to mistakenly think that "git diff A..B" has
some similarity with "git log A..B" (there isn't).

Indeed, "git log A..B" computes for the range "A..B" a set of commits that
are in B but not in A, and if one misunderstands "git diff" to somehow
magically work with ranges (it doesn't), it is more natural to expect that
"git diff A..B" might show a cumulative changes since B forked from A.

But that is not what the command gives (it gives the difference between
two endpoints and there is no history cosideration such as "B forked from
A").

New people can be trained not to say "git diff A..B" when they mean to
compare two endpoints with "git diff A B", and that would reduce the
confusion greatly.

Warn the use of "git diff A..B" syntax when "git diff A B" equally works
well, is shorter, and is much more clear what the command is comparing
(i.e. two endpoints).

The new code does not issue a warning against "git diff ..B" that is used
as a shorthand for "git diff HEAD B", and "git diff A.." that is used as a
shorthand for "git diff A HEAD", respectively.  These are shorter to type
and are often useful.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Cumulative effect can be had with "git diff $(git merge-base A B) B"
   and there is a short-hand for it "git diff A...B", but this change is
   about the two-dot notation, not three-dots.

 builtin/diff.c |   16 ++++++++++++++++
 revision.c     |    6 ++++--
 revision.h     |    1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 86614d4..6d8028b 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -142,12 +142,28 @@ static int builtin_diff_index(struct rev_info *revs,
 	return run_diff_index(revs, cached);
 }
 
+static void check_useless_use_of_range(struct object_array_entry *ent)
+{
+	if (!(ent[0].item->flags & UNINTERESTING) ||
+	    ent[1].item->flags & UNINTERESTING)
+		return; /* not a range made by "A..B" notation */
+
+	if ((ent[0].name == dotdot_default_HEAD) ||
+	    (ent[1].name == dotdot_default_HEAD))
+		return;	/* "A.." or "..B" */
+
+	warning("Do not write 'git diff A..B' but write 'git diff A B'");
+	warning("diff is about two endpoints!");
+}
+
 static int builtin_diff_tree(struct rev_info *revs,
 			     int argc, const char **argv,
 			     struct object_array_entry *ent)
 {
 	if (argc > 1)
 		usage(builtin_diff_usage);
+
+	check_useless_use_of_range(ent);
 	diff_tree_sha1(ent[0].item->sha1, ent[1].item->sha1, "", &revs->diffopt);
 	log_tree_diff_flush(revs);
 	return 0;
diff --git a/revision.c b/revision.c
index e96c281..48a0a44 100644
--- a/revision.c
+++ b/revision.c
@@ -1008,6 +1008,8 @@ static void prepare_show_merge(struct rev_info *revs)
 	revs->limited = 1;
 }
 
+const char dotdot_default_HEAD[] = "HEAD";
+
 int handle_revision_arg(const char *arg, struct rev_info *revs,
 			int flags,
 			int cant_be_filename)
@@ -1030,9 +1032,9 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 		next += symmetric;
 
 		if (!*next)
-			next = "HEAD";
+			next = dotdot_default_HEAD;
 		if (dotdot == arg)
-			this = "HEAD";
+			this = dotdot_default_HEAD;
 		if (!get_sha1(this, from_sha1) &&
 		    !get_sha1(next, sha1)) {
 			struct commit *a, *b;
diff --git a/revision.h b/revision.h
index ae94860..27a233c 100644
--- a/revision.h
+++ b/revision.h
@@ -151,6 +151,7 @@ struct rev_info {
 /* revision.c */
 typedef void (*show_early_output_fn_t)(struct rev_info *, struct commit_list *);
 extern volatile show_early_output_fn_t show_early_output;
+extern const char dotdot_default_HEAD[];
 
 struct setup_revision_opt {
 	const char *def;
