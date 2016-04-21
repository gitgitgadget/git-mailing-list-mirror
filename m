From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] merge: introduce merge.allowUnrelatedhistories configuration option
Date: Thu, 21 Apr 2016 12:25:00 -0700
Message-ID: <20160421192500.23563-5-gitster@pobox.com>
References: <20160421192500.23563-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 21:31:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atKJo-0008Ly-Fe
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 21:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbcDUTbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 15:31:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751707AbcDUTbK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 15:31:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A6E111319B;
	Thu, 21 Apr 2016 15:25:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=w2ex
	Bc1jpFLE0o8eBsJqLQUrBeM=; b=inqOmvfuJF44QajZBzGTq42HZvH1d/z+Zcft
	XnJJztUxWwVwK5Q5SVqa+me8KNOUQlfDaxCdLSbSHgn659BrxQ5dePedKN/6gX7P
	Eq7eOxtkwdsBne7Afc5kee+nb1+7tR8vZiUcV8rJzDznvYVQMDZsuNSmXcwrkfsM
	vuN+xn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=eDA7Ad
	b8tAJxEd9v7K/3RMuWDqDT5b8A9ZbuyXGYXe3rHKJmk1TF0MdQHQVxdRXJYyCOSe
	2Rcgm05AcKMRQg8bkjqBdWQ7G46c/f143y9/QBcD4MSiCwVcXctjVDNiPBJqzNSp
	Foj+zC1XkFsUDjAjhAIbUVju2Bt8HxhJoARjU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F13E1319A;
	Thu, 21 Apr 2016 15:25:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05AF713199;
	Thu, 21 Apr 2016 15:25:09 -0400 (EDT)
X-Mailer: git-send-email 2.8.1-422-g6d9b748
In-Reply-To: <20160421192500.23563-1-gitster@pobox.com>
X-Pobox-Relay-ID: C33E36A0-07F6-11E6-B4FD-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292146>

It was rumored that in an unspecified workflow it is common to
create what Kernel folks call "crazy" and "insane" merges of two
unrelated histories, and having to give --allow-unrelated-histories
option every time is cumbersome.

Just in case the rumor will substanticated with a proper rationale
in the future, prepare a change to allow disabling the safety by
default.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt          |  4 ++++
 Documentation/merge-config.txt |  7 +++++++
 builtin/merge.c                |  3 +++
 t/t3033-merge-toplevel.sh      | 29 +++++++++++++++++++++++++++++
 t/t5521-pull-options.sh        |  9 ++++++++-
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5c9380d..f2edac1 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1140,6 +1140,10 @@ of clones and fetches.
 
 'GIT_MERGE_ALLOW_UNRELATED_HISTORIES'::
 	Allow "git merge" to merge unrelated histories by default.
+	It is recommended that a script that regularly wants to
+	create such a merge to set and export this environment
+	variable upfront, instead of forcing its users to set
+	merge.allowunrelatedhistories configuration variable.
 
 
 Discussion[[Discussion]]
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 002ca58..8b3d14b 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -47,6 +47,13 @@ merge.stat::
 	Whether to print the diffstat between ORIG_HEAD and the merge result
 	at the end of the merge.  True by default.
 
+merge.allowUnrelatedhistories::
+	Setting this option to true (false) makes `git merge` and `git
+	pull` to pretend as if the `--allow-unrelated-histories`
+	(`--no-allow-unrelated-histories`) option was given from the
+	command line.  The configuration is ignored when one of these
+	options is explicitly given from the command line.
+
 merge.tool::
 	Controls which merge tool is used by linkgit:git-mergetool[1].
 	The list below shows the valid built-in values.
diff --git a/builtin/merge.c b/builtin/merge.c
index 4e8b1a1..e979c68 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -583,6 +583,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	} else if (!strcmp(k, "commit.gpgsign")) {
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
+	} else if (!strcmp(k, "merge.allowunrelatedhistories")) {
+		allow_unrelated_histories = git_config_bool(k, v);
+		return 0;
 	}
 
 	status = fmt_merge_msg_config(k, v, cb);
diff --git a/t/t3033-merge-toplevel.sh b/t/t3033-merge-toplevel.sh
index d314599..583b837 100755
--- a/t/t3033-merge-toplevel.sh
+++ b/t/t3033-merge-toplevel.sh
@@ -149,4 +149,33 @@ test_expect_success 'two-project merge with --allow-unrelated-histories' '
 	git diff --exit-code five
 '
 
+test_expect_success 'two-project merge with merge.allowunrelatedhistories' '
+	t3033_reset &&
+
+	# make sure configuration parser works
+	git reset --hard four &&
+	test_config merge.allowunrelatedhistories notabool &&
+	test_must_fail git merge . HEAD &&
+
+	# disabled explicitly and redundantly by configuration
+	git reset --hard four &&
+	test_config merge.allowunrelatedhistories false &&
+	test_must_fail git merge five &&
+
+	# disabled explicitly by configuration, overridden by command line
+	git reset --hard four &&
+	test_config merge.allowunrelatedhistories false &&
+	git merge --allow-unrelated-histories five &&
+
+	# enabled by configuration but explicitly disabled
+	git reset --hard four &&
+	test_config merge.allowunrelatedhistories true &&
+	test_must_fail git merge --no-allow-unrelated-histories five &&
+
+	# enabled by configuration
+	git reset --hard four &&
+	test_config merge.allowunrelatedhistories true &&
+	git merge five
+'
+
 test_done
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index ded8f98..50f0887 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -161,7 +161,14 @@ test_expect_success 'git pull --allow-unrelated-histories' '
 	(
 		cd dst &&
 		test_must_fail git pull ../src side &&
-		git pull --allow-unrelated-histories ../src side
+		git pull --allow-unrelated-histories ../src side &&
+
+		git reset --hard one &&
+		git config merge.allowunrelatedhistories no &&
+		test_must_fail git pull ../src side &&
+		git config merge.allowunrelatedhistories yes &&
+		test_must_fail git pull --no-allow-unrelated-histories ../src side &&
+		git pull ../src side
 	)
 '
 
-- 
2.8.1-422-g6d9b748
