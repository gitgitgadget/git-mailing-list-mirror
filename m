From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] push: also use "upstream" mapping when pushing a single ref
Date: Wed,  4 Dec 2013 17:27:29 -0800
Message-ID: <1386206849-6503-4-git-send-email-gitster@pobox.com>
References: <1386117594-22062-1-git-send-email-gitster@pobox.com>
 <1386206849-6503-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 02:27:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoNjI-00047c-DK
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 02:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346Ab3LEB1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 20:27:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44753 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756287Ab3LEB1i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 20:27:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5882558745
	for <git@vger.kernel.org>; Wed,  4 Dec 2013 20:27:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RM+A
	bY47AmMiQuxcCOuKy6Y9l90=; b=j5GssxD/jToTJrq9SQQZQ+J5WfAv9Tw8tyH/
	DxDIyQV3UODfVQh4/M6Jpxu6CfSLeb4z3004jY/haPXAAUyd4ovWcx4W47JM/qsB
	+dlN9zpTtB13V6t1CDbt9qw0NqtPjzkwmJ3Fx50DJDN+Fz60aFWoi+7M89aMt4TG
	1Uu+LJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=TrcPP0
	x57O36mcfytSg7uJ8JN/KncIGro8Z0qr3BEKEVxeErpANED0UYM+42kQa0Pr1ZCT
	HvjDDMijfiv5hS2MIZPalhmwJQ0z7sOn6HDdx550okNsAj67fuDHNQu2Twfk6DLI
	rlbT46O0axWtDdtmtqps0urrJqvVAnon1P1ps=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4629C58744
	for <git@vger.kernel.org>; Wed,  4 Dec 2013 20:27:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 907AB58742
	for <git@vger.kernel.org>; Wed,  4 Dec 2013 20:27:37 -0500 (EST)
X-Mailer: git-send-email 1.8.5.1-402-gdd8f092
In-Reply-To: <1386206849-6503-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6CD440B8-5D4C-11E3-A33C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238835>

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

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c        | 11 +++++++++++
 t/t5516-fetch-push.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/builtin/push.c b/builtin/push.c
index 857f76d..9e47c29 100644
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
1.8.5.1-402-gdd8f092
