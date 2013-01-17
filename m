From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] simplify-merges: drop merge from irrelevant side branch
Date: Thu, 17 Jan 2013 14:23:03 -0800
Message-ID: <7va9s7tpo8.fsf_-_@alter.siamese.dyndns.org>
References: <CABURp0q0nhka+ivrs3+m+3C1N+FfTq2zJ=1rWp34tfGNQ3b30g@mail.gmail.com>
 <7vk3re0zyt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>
To: "git\@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 23:23:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvxrt-0005pp-Ta
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 23:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635Ab3AQWXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 17:23:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034Ab3AQWXH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 17:23:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F81EA8A7;
	Thu, 17 Jan 2013 17:23:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N6rr0335bn2YlBkhcXL8x7+Z4/Q=; b=unLAVl
	wefvroEVgvQcAZSiczQQVpk2qVmoGaWzAaQoynMFV4XjJ+7vWU1v4rBtfW4QHPcV
	Zkh+uutrxdN07MJ2BJ+CebC9aoW/IzePpjc+8sAGP/IpUFU3WB4itP3Vn4WalpXx
	IY3ud7wlV1AiTs3eRy52FGCY8ETxiCtK7Acn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yWPMn6idoatU8G6QtdNS31EEog7bOBnS
	w/emX0AmVzJZGYySxYl8d8RMSWvmICdH5MB04bj22k2aG9P4SJht8ihIpGPOvkJC
	/p5H5RPXcVsTz301sx8dizFDJZ9N6msb3JanacgBt5KkUfGHE04LqEZl72jwXZAL
	yyjuFza991k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14AD4A8A6;
	Thu, 17 Jan 2013 17:23:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62FA5A8A5; Thu, 17 Jan 2013
 17:23:05 -0500 (EST)
In-Reply-To: <7vk3re0zyt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 15 Jan 2013 15:48:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76B0EC6C-60F4-11E2-B58F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213884>

The merge simplification rule stated in 6546b59 (revision traversal:
show full history with merge simplification, 2008-07-31) still
treated merge commits too specially.  Namely, in a history with this
shape:

	---o---o---M
	          /
         x---x---x

where three 'x' were on a history completely unrelated to the main
history 'o' and do not touch any of the paths we are following, we
still said that after simplifying all of the parents of M, 'x'
(which is the leftmost 'x' that rightmost 'x simplifies down to) and
'o' (which would be the last commit on the main history that touches
the paths we are following) are independent from each other, and
both need to be kept.

That is incorrect; when the side branch 'x' never touches the paths,
it should be removed to allow M to simplify down to the last commit
on the main history that touches the paths.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The old test vector had a history ending at I; the updates to it
   adds an unrelated side branch rooted at J, merge of I and J which
   is K, and then an extra commit L on top.

	A---(some merge mess)---I---K---L
                                   /
                                  J

 revision.c                   | 19 +++++++++++++++++++
 t/t6012-rev-list-simplify.sh | 26 +++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index 33cb207..532611b 100644
--- a/revision.c
+++ b/revision.c
@@ -1424,6 +1424,22 @@ static struct merge_simplify_state *locate_simplify_state(struct rev_info *revs,
 	return st;
 }
 
+static void remove_treesame_parents(struct commit *commit)
+{
+	struct commit_list **pp, *p;
+
+	pp = &commit->parents;
+	while ((p = *pp) != NULL) {
+		struct commit *parent = p->item;
+		if (parent->object.flags & TREESAME) {
+			*pp = p->next;
+			free(p);
+			continue;
+		}
+		pp = &p->next;
+	}
+}
+
 static struct commit_list **simplify_one(struct rev_info *revs, struct commit *commit, struct commit_list **tail)
 {
 	struct commit_list *p;
@@ -1469,6 +1485,9 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 		pst = locate_simplify_state(revs, p->item);
 		p->item = pst->simplified;
 	}
+
+	remove_treesame_parents(commit);
+
 	cnt = remove_duplicate_parents(commit);
 
 	/*
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index 510bb96..d6d79c4 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -59,7 +59,23 @@ test_expect_success setup '
 
 	echo "Final change" >file &&
 	test_tick && git commit -a -m "Final change" &&
-	note I
+	note I &&
+
+	git symbolic-ref HEAD refs/heads/unrelated &&
+	git rm -f "*" &&
+	echo "Unrelated branch" >side &&
+	git add side &&
+	test_tick && git commit -m "Side root" &&
+	note J &&
+
+	git checkout master &&
+	test_tick && git merge -m "Coolest" unrelated &&
+	note K &&
+
+	echo "Immaterial" >elif &&
+	git add elif &&
+	test_tick && git commit -m "Last" &&
+	note L
 '
 
 FMT='tformat:%P 	%H | %s'
@@ -82,10 +98,10 @@ check_result () {
 	'
 }
 
-check_result 'I H G F E D C B A' --full-history
-check_result 'I H E C B A' --full-history -- file
-check_result 'I H E C B A' --full-history --topo-order -- file
-check_result 'I H E C B A' --full-history --date-order -- file
+check_result 'L K J I H G F E D C B A' --full-history
+check_result 'K I H E C B A' --full-history -- file
+check_result 'K I H E C B A' --full-history --topo-order -- file
+check_result 'K I H E C B A' --full-history --date-order -- file
 check_result 'I E C B A' --simplify-merges -- file
 check_result 'I B A' -- file
 check_result 'I B A' --topo-order -- file
-- 
1.8.1.1.431.g469ab37
