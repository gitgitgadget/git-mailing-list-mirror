From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] commit-tree: do not pay attention to commit.gpgsign
Date: Mon, 02 May 2016 14:59:49 -0700
Message-ID: <xmqqk2jcqfxm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 00:00:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axLsj-0004Cn-0B
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 23:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbcEBV7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 17:59:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754411AbcEBV7w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 17:59:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E7E018B1B;
	Mon,  2 May 2016 17:59:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=/
	DjFODId4rNjJ0OUixMDu68ciS0=; b=MCZHetULxxfrMK/iaWP1NDWyuVx6JJ6V5
	GQcKRQhIshOZaTuBjoBdVxIemIbcYkgIraM8ymoEBMj3xKcCgIkGI2GD5+SpZkli
	CAUK9gVJ/HK9qYQxInYMtCDzqD+U6zvt07EGB7YWhpDrAY9GgxWslTNZ+gcmMMoj
	SbN4c2YMSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=cGm
	DU8VCBDi0foAs+y6SXziTy4ij04dSMQFTvHL2CScC3JU/Vy3dNo2U+epguCxd7Ap
	kN8iV5QAHzqJj0LD0aOtDEGvtXtY65Wt2QWj0Q7z6gOMNsfpqU8XoEGA+bCedwKW
	6hYZsMfy+VB9u+tVnaPjpdm4D+Mlx3j22M28QoEU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 55BA218B1A;
	Mon,  2 May 2016 17:59:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A35CF18B18;
	Mon,  2 May 2016 17:59:50 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 317BDF2E-10B1-11E6-8664-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293293>

ba3c69a9 (commit: teach --gpg-sign option, 2011-10-05) introduced a
"signed commit" by teaching --[no-gpg-sign option and commit.gpgsign
configuration variable to various commands that create commits.

Teaching these to "git commit" and "git merge", both of which are
end-user facing Porcelain commands, was perfectly fine.  Allowing
the plumbing "git commit-tree" to suddenly change the behaviour to
surprise the scripts by paying attention to commit.gpgsign was not.

Among the in-tree scripts, filter-branch, quiltimport, rebase and
stash are the commands that run "commit-tree".  If any of these
wants to allow users to always sign every single commit, they should
offer their own configuration (e.g. "filterBranch..gpgsign") with an
option to disable (e.g. "git filter-branch --no-gpgsign").

Ignoring commit.gpgsign option _obviously_ breaks the backward
compatibility, and I seriously doubt anybody sane is depending on
this misfeature that commit-tree blindly follows commit.gpgsign in
any third-party script that calls it, but following the "be careful
when removing (mis)features" tradition, let's give these scripts an
escape hatch.  Passing the new --use-commit-gpgsign-config option to
makes it pay attention to the commit.gpgsign configuration again.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin/commit-tree.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 3feeffe..b023a6b 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -10,9 +10,10 @@
 #include "utf8.h"
 #include "gpg-interface.h"
 
-static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1>";
+static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [--use-commit-gpgsign-config] [-m <message>] [-F <file>] <sha1>";
 
 static const char *sign_commit;
+static const char *config_sign_commit;
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
@@ -34,7 +35,7 @@ static int commit_tree_config(const char *var, const char *value, void *cb)
 	if (status)
 		return status;
 	if (!strcmp(var, "commit.gpgsign")) {
-		sign_commit = git_config_bool(var, value) ? "" : NULL;
+		config_sign_commit = git_config_bool(var, value) ? "" : NULL;
 		return 0;
 	}
 	return git_default_config(var, value, cb);
@@ -42,7 +43,7 @@ static int commit_tree_config(const char *var, const char *value, void *cb)
 
 int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
-	int i, got_tree = 0;
+	int i, got_tree = 0, use_commit_gpgsign_config = 0;
 	struct commit_list *parents = NULL;
 	unsigned char tree_sha1[20];
 	unsigned char commit_sha1[20];
@@ -84,6 +85,11 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		if (!strcmp(arg, "--use-commit-gpgsign-config")) {
+			use_commit_gpgsign_config = 1;
+			continue;
+		}
+
 		if (!strcmp(arg, "-F")) {
 			int fd;
 
@@ -121,6 +127,9 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			die_errno("git commit-tree: failed to read");
 	}
 
+	if (!sign_commit && use_commit_gpgsign_config)
+		sign_commit = config_sign_commit;
+
 	if (commit_tree(buffer.buf, buffer.len, tree_sha1, parents,
 			commit_sha1, NULL, sign_commit)) {
 		strbuf_release(&buffer);
