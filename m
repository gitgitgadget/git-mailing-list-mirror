From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] push: also use "upstream" mapping when pushing a single ref
Date: Tue,  3 Dec 2013 16:39:54 -0800
Message-ID: <1386117594-22062-4-git-send-email-gitster@pobox.com>
References: <1386117594-22062-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 01:40:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo0Vq-0005G7-1v
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 01:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573Ab3LDAkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 19:40:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755247Ab3LDAkL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 19:40:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D22358EFE
	for <git@vger.kernel.org>; Tue,  3 Dec 2013 19:40:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=8ex8
	lRy7zf4Hs595PkuEaaBb5Ps=; b=iebTV0sGfkFbBZrSkaseHVseOn4056MrAeU7
	fv8cGylhMKDER6mhDVxIZKFI9FGBFsDZCnHYKep4wKaL4QU7Z+RLEcpy/dU95EBw
	NVgPImKAr4VrHO28CeT8MFgqrcGUdgf5kVYR7UZzw1+AeB35zmlLObqn8AA8raAz
	T2KP5dM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wtSjMO
	OSuXapPiUqZFcGVC20TlvzyKYaGbLbSlWlOv+ImxXH095/eIXsO1nU4e7so3L2Mq
	iEWXojZ8HHTmp3pp4xhzMR4M/vg75wfhtPYbOJ3692rWkqv9iqyItel7VvWWftgc
	4jmZm+Fkbs1oOxFtspyO6dQcgW91NCvolZPws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CF4158EFD
	for <git@vger.kernel.org>; Tue,  3 Dec 2013 19:40:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2E3158EFC
	for <git@vger.kernel.org>; Tue,  3 Dec 2013 19:40:10 -0500 (EST)
X-Mailer: git-send-email 1.8.5.1-400-gbc1da41
In-Reply-To: <1386117594-22062-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A1841D7C-5C7C-11E3-82D0-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238747>

When the user is using the 'upstream' mode, these commands:

    $ git push
    $ git push origin

would find the 'upstream' branch for the current branch, and then
push the current branch to update it.  However, pushing a single
branch explicitly, i.e.

    $ git push origin $(git symbolic-ref --short HEAD)

would not go through the same ref mapping process, and ends up
updating the branch at 'origin' of the same name, which may not
necessarily be the upstream of the branch being pushed.

In the spirit similar to the previous one, map a colon-less refspec
using the upstream mapping logic.

Note that this is deliberately done after the logic to map refspec
via the remote.$name.push configuration did not find any.  This is
because most of those that employ a simple 'upstream' mode do not
have the push refspec, and checking with remote.$name.push refspec
first will allow it to be used as a mechanism to override the usual
'upstream' push mapping (which is primarily useful for centralized
workflow) by those who want to use a triangular workflow.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c        | 11 +++++++++++
 t/t5516-fetch-push.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/builtin/push.c b/builtin/push.c
index bdc1fc1..71c081e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -58,6 +58,17 @@ static const char *map_refspec(const char *ref,
 		}
 	}
 
+	if (push_default == PUSH_DEFAULT_UPSTREAM &&
+	    !prefixcmp(matched->name, "refs/heads/")) {
+		struct branch *branch = branch_get(matched->name + 11);
+		if (branch->merge_nr == 1 && branch->merge[0]->src) {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addf(&buf, "%s:%s",
+				    ref, branch->merge[0]->src);
+			return strbuf_detach(&buf, NULL);
+		}
+	}
+
 	return ref;
 }
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 6d7f102..926e7f6 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1160,6 +1160,7 @@ test_expect_success 'with no remote.$name.push, it is not used as refmap' '
 		git pull ../testrepo master &&
 		git branch next &&
 		git config remote.dst.url ../dst &&
+		git config push.default matching &&
 		git push dst master &&
 		git show-ref refs/heads/master >../dst/expect
 	) &&
@@ -1171,6 +1172,35 @@ test_expect_success 'with no remote.$name.push, it is not used as refmap' '
 	test_cmp dst/expect dst/actual
 '
 
+test_expect_success 'with no remote.$name.push, upstream mapping is used' '
+	mk_test testrepo heads/master &&
+	rm -fr src dst &&
+	git init src &&
+	git init --bare dst &&
+	(
+		cd src &&
+		git pull ../testrepo master &&
+		git branch next &&
+		git config remote.dst.url ../dst &&
+		git config remote.dst.fetch "+refs/heads/*:refs/remotes/dst/*" &&
+		git config push.default upstream &&
+
+		git config branch.master.merge refs/heads/trunk &&
+		git config branch.master.remote dst &&
+
+		git push dst master &&
+		git show-ref refs/heads/master |
+		sed -e "s|refs/heads/master|refs/heads/trunk|" >../dst/expect
+	) &&
+	(
+		cd dst &&
+		test_must_fail git show-ref refs/heads/master &&
+		test_must_fail git show-ref refs/heads/next &&
+		git show-ref refs/heads/trunk >actual
+	) &&
+	test_cmp dst/expect dst/actual
+'
+
 test_expect_success 'push does not follow tags by default' '
 	mk_test testrepo heads/master &&
 	rm -fr src dst &&
-- 
1.8.5.1-400-gbc1da41
