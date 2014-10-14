From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] checkout: report upstream correctly even with loosely defined branch.*.merge
Date: Tue, 14 Oct 2014 15:14:28 -0700
Message-ID: <xmqqbnpexprv.fsf@gitster.dls.corp.google.com>
References: <xmqqa9e67atv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 00:14:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeAMU-0002eW-Ql
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 00:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755712AbaJNWOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 18:14:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753413AbaJNWOa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 18:14:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA5AF1549D;
	Tue, 14 Oct 2014 18:14:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Kui0DpNds3oLriZlyDnjUa4IAuY=; b=rIEw2V2wP/GmJEnbchD4
	DtNk483+OUu+PG8F+f0zl7Jl3mqt/CHaL6YiwRXjUDzodrQ3twx0rxOL6OoljpUl
	1U50AMg+yOZGetCcYr2cPw3mI0Jhe3Bbm88XO2uhNw+xoXomBZ3UBthbjI9G3F4E
	isDbJ9WmDoEJwRsZFDr3tds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=YBNgVYW3dTBPdfaOb/sCyUGvNXVsLI/87eh+KdBVCGqFobsUuctQrLx5
	VXSt4MdwafG02eDP4HMFwWQn9PfrmTDIr9OtmEKsrxoBReBSmCfkF8oFfyZLf+Nc
	3ESoSfzhnO79fJ+RcA7Z+QW/ETq3ajxzg1TDe4W1Yeb5GzyZ0aE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D20E41549C;
	Tue, 14 Oct 2014 18:14:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 641421549B;
	Tue, 14 Oct 2014 18:14:29 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7771799C-53EF-11E4-A6F8-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When checking out a branch that is set to build on top of another
branch (often, a remote-tracking branch), "git checkout" reports how
your work relates to the other branch, e.g.

    Your branch is behind 'origin/master', and can be fast-forwarded.

Back when this feature was introduced, this was only done for
branches that build on remote-tracking branches, but 5e6e2b48 (Make
local branches behave like remote branches when --tracked,
2009-04-01) added support to give the same report for branches that
build on other local branches (i.e. branches whose branch.*.remote
variables are set to '.').  Unlike the support for the branches
building on remote-tracking branches, however, this did not take
into account the fact that branch.*.merge configuration is allowed
to record a shortened branch name.

When branch.*.merge is set to 'master' (not 'refs/heads/master'),
i.e. "my branch builds on the local 'master' branch", this caused
"git checkout" to report:

    Your branch is based on 'master', but the upstream is gone.

The upstream is our repository and is definitely not gone, so this
output is nonsense.

The fix is fairly obvious; just like the branch name is DWIMed when
"git pull" merges from the 'master' branch without complaint on such
a branch, the name of the branch the current branch builds upon
needs to be DWIMed the same way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c                 | 34 +++++++++++++++++++++++-----------
 t/t2024-checkout-dwim.sh | 18 ++++++++++++++++++
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/remote.c b/remote.c
index 0e9459c..ecbe363 100644
--- a/remote.c
+++ b/remote.c
@@ -1611,6 +1611,27 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	}
 }
 
+static void set_merge(struct branch *ret)
+{
+	char *ref;
+	unsigned char sha1[20];
+	int i;
+
+	ret->merge = xcalloc(ret->merge_nr, sizeof(*ret->merge));
+	for (i = 0; i < ret->merge_nr; i++) {
+		ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
+		ret->merge[i]->src = xstrdup(ret->merge_name[i]);
+		if (!remote_find_tracking(ret->remote, ret->merge[i]) ||
+		    strcmp(ret->remote_name, "."))
+			continue;
+		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
+			     sha1, &ref) == 1)
+			ret->merge[i]->dst = ref;
+		else
+			ret->merge[i]->dst = xstrdup(ret->merge_name[i]);
+	}
+}
+
 struct branch *branch_get(const char *name)
 {
 	struct branch *ret;
@@ -1622,17 +1643,8 @@ struct branch *branch_get(const char *name)
 		ret = make_branch(name, 0);
 	if (ret && ret->remote_name) {
 		ret->remote = remote_get(ret->remote_name);
-		if (ret->merge_nr) {
-			int i;
-			ret->merge = xcalloc(ret->merge_nr, sizeof(*ret->merge));
-			for (i = 0; i < ret->merge_nr; i++) {
-				ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
-				ret->merge[i]->src = xstrdup(ret->merge_name[i]);
-				if (remote_find_tracking(ret->remote, ret->merge[i])
-				    && !strcmp(ret->remote_name, "."))
-					ret->merge[i]->dst = xstrdup(ret->merge_name[i]);
-			}
-		}
+		if (ret->merge_nr)
+			set_merge(ret);
 	}
 	return ret;
 }
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 6ecb559..468a000 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -185,4 +185,22 @@ test_expect_success 'checkout <branch> -- succeeds, even if a file with the same
 	test_branch_upstream spam repo_c spam
 '
 
+test_expect_success 'loosely defined local base branch is reported correctly' '
+
+	git checkout master &&
+	git branch strict &&
+	git branch loose &&
+	git commit --allow-empty -m "a bit more" &&
+
+	test_config branch.strict.remote . &&
+	test_config branch.loose.remote . &&
+	test_config branch.strict.merge refs/heads/master &&
+	test_config branch.loose.merge master &&
+
+	git checkout strict | sed -e "s/strict/BRANCHNAME/g" >expect &&
+	git checkout loose | sed -e "s/loose/BRANCHNAME/g" >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
2.1.2-492-gf8d07d7
