From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] commit-tree: do not pay attention to commit.gpgsign
Date: Mon, 02 May 2016 14:58:45 -0700
Message-ID: <xmqqlh3sqfze.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 23:58:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axLrh-0003mP-Ny
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 23:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbcEBV6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 17:58:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754411AbcEBV6t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 17:58:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 01CBC19376;
	Mon,  2 May 2016 17:58:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=K
	APorVuoqHneEnUoOWZTiwlG5rU=; b=FWe6MYWQAAOnh+NebPAyQflZ6SDeRP+GY
	x6MCdVnbP2dxE5R1DBt9RltG/cRDtjgjqMKinJ/ItK4dNNxvGJZ1N4v2wCpfNAYZ
	SBMsCy8io9vdY1iOkfZTnIR2tXQvU354dLgsgkDhAlVdwio96u9sDJLNql3Vo3sY
	PCsiulBKj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=hdJ
	NRi/QNuadsif2QkgO32zaKqy0mSRWS9wFuqArChsiuFYNCEXoBEx6T+2S0RDrgPp
	FcGpaCfCq06iM9HLUkfWmwKTepbzCh86qvg6N9Hft/JEHwTDZbR+f0Xl2HTy42eh
	fKRIXKdIPtGtfINrQmX8OdYPsjOr56tfVTvCyWt4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE9F319375;
	Mon,  2 May 2016 17:58:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E6AB19374;
	Mon,  2 May 2016 17:58:47 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0BC3706C-10B1-11E6-B03D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293292>

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
compatibility, but I seriously doubt anybody sane is depending on
this misfeature that commit-tree blindly follows commit.gpgsign in
any third-party script that calls it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is an simpler alternative that forces commit-tree callers
   that want to honor commit.gpgsign to do so themselves.

 builtin/commit-tree.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 3feeffe..e4ba0d8 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -8,7 +8,6 @@
 #include "tree.h"
 #include "builtin.h"
 #include "utf8.h"
-#include "gpg-interface.h"
 
 static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1>";
 
@@ -28,18 +27,6 @@ static void new_parent(struct commit *parent, struct commit_list **parents_p)
 	commit_list_insert(parent, parents_p);
 }
 
-static int commit_tree_config(const char *var, const char *value, void *cb)
-{
-	int status = git_gpg_config(var, value, NULL);
-	if (status)
-		return status;
-	if (!strcmp(var, "commit.gpgsign")) {
-		sign_commit = git_config_bool(var, value) ? "" : NULL;
-		return 0;
-	}
-	return git_default_config(var, value, cb);
-}
-
 int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
 	int i, got_tree = 0;
@@ -48,7 +35,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	unsigned char commit_sha1[20];
 	struct strbuf buffer = STRBUF_INIT;
 
-	git_config(commit_tree_config, NULL);
+	git_config(git_default_config, NULL);
 
 	if (argc < 2 || !strcmp(argv[1], "-h"))
 		usage(commit_tree_usage);
