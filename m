From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] merge: merge with the default upstream with no argument
Date: Thu, 24 Mar 2011 00:39:44 -0700
Message-ID: <7vd3lharwf.fsf_-_@alter.siamese.dyndns.org>
References: <7v62r9csqr.fsf@alter.siamese.dyndns.org>
 <7vpqphasbr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 08:39:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2f9D-0005Z5-7J
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 08:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933509Ab1CXHjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 03:39:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933338Ab1CXHjw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 03:39:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A2D583D01;
	Thu, 24 Mar 2011 03:41:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LqK4rGorXAmQaWf6PEfPIDFXx7c=; b=IrSVVa
	LLJ61gaXy7o2xBoz8J4fk3+/DOXX0f+9HHnKrqXLQcX5MucgFEmysaGFoZCERX2K
	d8fGEjw+PTHtgm7TnNy5B4V/1lo4BdLY8Deqy3ytdk+NGReSP4ro7VKDSY4jMcRr
	Y3pD6o3lTFl07IR2Z85TY9HDK/ztyPobziKvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FBRAYDx1FGh8k1qqEGVA8DmwgpFR+vAo
	zY5rzv2Nhyw9OMq0nhWIsPg7rPYMzsFNejtrWUYBgIfna4PmGlAs67h69cyLKdry
	P585XcL7d/E3bpaFy+zKkPEkilozsUdCGhBRVOrCWvzfj3axamj7Jsn4HHciwRto
	wMu9LM/SU0I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7F2133D00;
	Thu, 24 Mar 2011 03:41:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 321623CFF; Thu, 24 Mar 2011
 03:41:26 -0400 (EDT)
In-Reply-To: <7vpqphasbr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 24 Mar 2011 00:30:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2220F8FC-55EA-11E0-85E6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169899>

"git merge" without specifying any commit is a no-op by default.

A new option merge.defaultupstream can be set to true to cause such an
invocation of the command to merge the upstream branches configured for
the current branch by using their last observed values stored in their
remote tracking branches.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is more or less total rewrite, so I am taking the authorship
   from Jared, i.e. the bugs and blames are mine.

 Documentation/git-merge.txt    |   11 ++++++++---
 Documentation/merge-config.txt |   10 ++++++++++
 builtin/merge.c                |   39 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c1efaaa..cc8f424 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash]
 	[-s <strategy>] [-X <strategy-option>]
-	[--[no-]rerere-autoupdate] [-m <msg>] <commit>...
+	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
 
@@ -95,8 +95,13 @@ commit or stash your changes before running 'git merge'.
 
 <commit>...::
 	Commits, usually other branch heads, to merge into our branch.
-	You need at least one <commit>.  Specifying more than one
-	<commit> obviously means you are trying an Octopus.
+	Specifying more than one commit will create a merge with
+	more than two parents (affectionately called an Octopus merge).
++
+If no commit is given from the command line, and if `merge.defaultToUpstream`
+configuration variable is set, merge the remote tracking branches
+that the current branch is configured to use as its upstream.
+See also the configuration section of this manual page.
 
 
 PRE-MERGE CHECKS
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 1e5c22c..83dba63 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -6,6 +6,16 @@ merge.conflictstyle::
 	a `>>>>>>>` marker.  An alternate style, "diff3", adds a `|||||||`
 	marker and the original text before the `=======` marker.
 
+merge.defaultToUpstream::
+	If merge is called without any commit argument, merge the upstream
+	branches configured for the current branch by using their last
+	observed values stored in their remote tracking branches.
+	The values of the `branch.<current branch>.merge` that name the
+	branches at the remote named by `branch.<current branch>.remote`
+	are consulted, and then they are mapped via `remote.<remote>.fetch`
+	to their corresponding remote tracking branches, and the tips of
+	these tracking branches are merged.
+
 merge.log::
 	In addition to branch names, populate the log message with at
 	most the specified number of one-line descriptions from the
diff --git a/builtin/merge.c b/builtin/merge.c
index a2105ef..309bdd4 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -25,6 +25,7 @@
 #include "help.h"
 #include "merge-recursive.h"
 #include "resolve-undo.h"
+#include "remote.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -37,7 +38,7 @@ struct strategy {
 };
 
 static const char * const builtin_merge_usage[] = {
-	"git merge [options] <commit>...",
+	"git merge [options] [<commit>...]",
 	"git merge [options] <msg> HEAD <commit>",
 	"git merge --abort",
 	NULL
@@ -59,6 +60,7 @@ static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
 static int abort_current_merge;
+static int default_to_upstream;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -537,6 +539,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		if (is_bool && shortlog_len)
 			shortlog_len = DEFAULT_MERGE_LOG_LEN;
 		return 0;
+	} else if (!strcmp(k, "merge.defaulttoupstream")) {
+		default_to_upstream = git_config_bool(k, v);
+		return 0;
 	}
 	return git_diff_ui_config(k, v, cb);
 }
@@ -912,6 +917,35 @@ static int evaluate_result(void)
 	return cnt;
 }
 
+/*
+ * Pretend as if the user told us to merge with the tracking
+ * branch we have for the upstream of the current branch
+ */
+static int setup_with_upstream(const char ***argv)
+{
+	struct branch *branch = branch_get(NULL);
+	int i;
+	const char **args;
+
+	if (!branch)
+		die("No current branch.");
+	if (!branch->remote)
+		die("No remote for the current branch.");
+	if (!branch->merge_nr)
+		die("No default upstream defined for the current branch.");
+
+	args = xcalloc(branch->merge_nr + 1, sizeof(char *));
+	for (i = 0; i < branch->merge_nr; i++) {
+		if (!branch->merge[i]->dst)
+			die("No remote tracking branch for %s from %s",
+			    branch->merge[i]->src, branch->remote_name);
+		args[i] = branch->merge[i]->dst;
+	}
+	args[i] = NULL;
+	*argv = args;
+	return i;
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
@@ -984,6 +1018,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (!allow_fast_forward && fast_forward_only)
 		die("You cannot combine --no-ff with --ff-only.");
 
+	if (!argc && !abort_current_merge && default_to_upstream)
+		argc = setup_with_upstream(&argv);
+
 	if (!argc)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
-- 
1.7.4.1.433.gcd306
