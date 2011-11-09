From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/17] merge: record tag objects without peeling in
 MERGE_HEAD
Date: Tue,  8 Nov 2011 17:01:56 -0800
Message-ID: <1320800523-5407-11-git-send-email-gitster@pobox.com>
References: <1320800523-5407-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:02:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNwZ0-0003z8-Um
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 02:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab1KIBCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 20:02:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865Ab1KIBC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 20:02:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2B005B85
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=sY6C
	uFgDQZ6XzFhesaPbIb7wG2c=; b=xHaAMsjAF/6nDG1sLZOOEI6PYeu2+ufoI9Db
	glQt77dwqPPt4VWnhbmAN8QyjNBJdgsZJKs8qsbGkA9fd9PV9MetB81dJKJSYMfH
	Q7xHpP47kBEj7EN5+GjtV+XGRH43uohbgxWWMm8uG49sq/BBTYAsP/Obr2SWGysj
	Bg8Wo1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=a269Od
	EO12qt9RL9AR5DQ/bLg4XTU8Oq4P0lbURXS9cT+TKja8t+yLs1cBXa2rtZyb9Eu0
	HNDuRKs1uOAZnLGht0ewJhiIBq5UHb2XdHr4RMQGHQzo3lv7eWg1DxfJSC+ZWH91
	8r1IHzd7O2wv/ETfqPazV21wUOrxNjGZ0VFQU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9ED95B84
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BBB95B82 for
 <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:28 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320800523-5407-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7E8FAE1A-0A6E-11E1-85B4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185131>

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
1.7.8.rc1.82.g90e080
