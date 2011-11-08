From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/12] merge: record tag objects without peeling in
 MERGE_HEAD
Date: Mon,  7 Nov 2011 19:00:43 -0800
Message-ID: <1320721245-13223-11-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320721245-13223-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 04:01:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNbwG-0001XL-1g
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 04:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065Ab1KHDBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 22:01:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44646 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754794Ab1KHDBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 22:01:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D96EA6524;
	Mon,  7 Nov 2011 22:01:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=P7+s
	UM/LRqSsMznI/VLmhmjgzYI=; b=TzgCkL2FzhmQAgRMwAUb1+8ZUYmc5OCbcr4i
	Etm8V3IxrCddBqUyq5yIouzCAZFtDlo4CEHKjyPcwfQ6kjbkDw+65HYvngODD8DH
	l8XkciPwIbeS1HzbLKuj2A48C0erOXlr8XZqP1Zgrf/CVuIPXJkvyBLhqNybgdyi
	T9fNwzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	rZf2w47czeeoQKSqBvymvNzSZjL2Y2WnpCgjFhM3E6esElNpRDI7ewq8DII/2aes
	y+0qsON90DjUK8oZp4ru5439kyKzAAiaVc/TxsS7WBMnSXfPldxUJg3GF9PQGf8X
	o7V9KiCSo1kHg6lHu+rfjfpvVQlOGU3g1gCZ+31f9So=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1AC96522;
	Mon,  7 Nov 2011 22:01:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63A186521; Mon,  7 Nov 2011
 22:01:08 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.g90e080
In-Reply-To: <1320721245-13223-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E804A508-09B5-11E1-81E6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185060>

Otherwise, "git commit" wouldn't have a way to tell that we were in the
middle of merging an annotated or signed tag, not a plain commit, after
"git merge" stops to ask the user to resolve conflicts.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c  |   13 ++++++++++---
 t/t7600-merge.sh |    6 +++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 8d4eb4e..7158e8e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1045,9 +1045,16 @@ static void write_merge_state(void)
 	struct commit_list *j;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (j = remoteheads; j; j = j->next)
-		strbuf_addf(&buf, "%s\n",
-			sha1_to_hex(j->item->object.sha1));
+	for (j = remoteheads; j; j = j->next) {
+		unsigned const char *sha1;
+		struct commit *c = j->item;
+		if (c->util && merge_remote_util(c)->obj) {
+			sha1 = merge_remote_util(c)->obj->sha1;
+		} else {
+			sha1 = c->object.sha1;
+		}
+		strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
+	}
 	fd = open(git_path("MERGE_HEAD"), O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"),
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index b91d022..5d8c428 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -96,7 +96,11 @@ verify_parents () {
 
 verify_mergeheads () {
 	printf '%s\n' "$@" >mergehead.expected &&
-	test_cmp mergehead.expected .git/MERGE_HEAD
+	while read sha1 rest
+	do
+		git rev-parse $sha1
+	done <.git/MERGE_HEAD >mergehead.actual &&
+	test_cmp mergehead.expected mergehead.actual
 }
 
 verify_no_mergehead () {
-- 
1.7.8.rc0.128.g31aa4
