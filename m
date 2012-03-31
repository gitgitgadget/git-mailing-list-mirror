From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Sun, 01 Apr 2012 00:11:01 +0200
Message-ID: <4F7780F5.3060306@lsrfire.ath.cx>
References: <201203291818.49933.mfick@codeaurora.org> <7v7gy2q1kq.fsf@alter.siamese.dyndns.org> <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com> <20120330093207.GA12298@sigill.intra.peff.net> <20120330094052.GB12298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Martin Fick <mfick@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 01 00:11:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE6Vu-0006u7-9F
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 00:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772Ab2CaWLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 18:11:09 -0400
Received: from india601.server4you.de ([85.25.151.105]:33722 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757Ab2CaWLH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 18:11:07 -0400
Received: from [192.168.2.105] (p4FFD98B5.dip.t-dialin.net [79.253.152.181])
	by india601.server4you.de (Postfix) with ESMTPSA id 302982F8038;
	Sun,  1 Apr 2012 00:11:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120330094052.GB12298@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194468>

Speed up prepare_revision_walk() by adding commits without sorting
to the commit_list and at the end sort the list in one go.  Thanks
to mergesort() working behind the scenes, this is a lot faster for
large numbers of commits than the current insert sort.

Also introduce and use commit_list_reverse(), to keep the ordering
of commits sharing the same commit date unchanged.  That's because
commit_list_insert_by_date() sorts commits with descending date,
but adds later entries with the same date entries last, while
commit_list_insert() always inserts entries at the top.  The
following commit_list_sort_by_date() keeps the order of entries
sharing the same date.

Jeff's test case, in a repo with lots of refs, was to run:

  # make a new commit on top of HEAD, but not yet referenced
  sha1=`git commit-tree HEAD^{tree} -p HEAD </dev/null`

  # now do the same "connected" test that receive-pack would do
  git rev-list --objects $sha1 --not --all

With a git.git with a ref for each revision, master needs (best of
five):

	real	0m2.210s
	user	0m2.188s
	sys	0m0.016s

And with this patch:

	real	0m0.480s
	user	0m0.456s
	sys	0m0.020s

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 commit.c   |   15 +++++++++++++++
 commit.h   |    1 +
 revision.c |    4 +++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 0d0c424..5ebbda0 100644
--- a/commit.c
+++ b/commit.c
@@ -361,6 +361,21 @@ struct commit_list *commit_list_insert(struct commit *item, struct commit_list *
 	return new_list;
 }
 
+void commit_list_reverse(struct commit_list **list_p)
+{
+	struct commit_list *prev = NULL, *curr = *list_p, *next;
+
+	if (!list_p)
+		return;
+	while (curr) {
+		next = curr->next;
+		curr->next = prev;
+		prev = curr;
+		curr = next;
+	}
+	*list_p = prev;
+}
+
 unsigned commit_list_count(const struct commit_list *l)
 {
 	unsigned c = 0;
diff --git a/commit.h b/commit.h
index 154c0e3..f8d250d 100644
--- a/commit.h
+++ b/commit.h
@@ -57,6 +57,7 @@ unsigned commit_list_count(const struct commit_list *l);
 struct commit_list *commit_list_insert_by_date(struct commit *item,
 				    struct commit_list **list);
 void commit_list_sort_by_date(struct commit_list **list);
+void commit_list_reverse(struct commit_list **list_p);
 
 void free_commit_list(struct commit_list *list);
 
diff --git a/revision.c b/revision.c
index b3554ed..92095f5 100644
--- a/revision.c
+++ b/revision.c
@@ -2076,11 +2076,13 @@ int prepare_revision_walk(struct rev_info *revs)
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
 				commit->object.flags |= SEEN;
-				commit_list_insert_by_date(commit, &revs->commits);
+				commit_list_insert(commit, &revs->commits);
 			}
 		}
 		e++;
 	}
+	commit_list_reverse(&revs->commits);
+	commit_list_sort_by_date(&revs->commits);
 	if (!revs->leak_pending)
 		free(list);
 
-- 
1.7.9.2
