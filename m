From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] merge: GIT_MERGE_ALLOW_UNRELATED_HISTORIES environment
Date: Thu, 21 Apr 2016 12:24:59 -0700
Message-ID: <20160421192500.23563-4-gitster@pobox.com>
References: <20160421192500.23563-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 21:34:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atKMQ-0001yk-Cp
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 21:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbcDUTdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 15:33:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752318AbcDUTdx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 15:33:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E9E3E1326A;
	Thu, 21 Apr 2016 15:25:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=iBEp
	qQUVF8h872cL/+jslt6yZYk=; b=iLodnpusMNR8PvsY8btUcsJlWol1wdaPy4me
	kCUHsAO7lTqm9w9DIFj3Jc19v+hx58MCjCVjxCyLi96DXsgv3r4kP9tgDZSjqGQw
	rXqkQSW11bmh1h/MYSRz6B2SZNeAlUfTpg3AoRikUXz5C8ztST5H1uoT6RKcYf+Z
	/FSBNOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=KkrfGS
	6tFrYGchf+RwxA0zJRtnMMsBvy4tVIJeQYe3bup5yLATZ044YcRbT77v9zlulrep
	K3CrbUijEAn2UpbEKGh6KAZGVL4LbXhwLNxg5T3G7VXfyuAwSWseqHke0SLK5Eth
	qtOponjzR+A8UMeX77xPLG16ysUf9bzR9ND8A=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1D6D13268;
	Thu, 21 Apr 2016 15:25:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4580913247;
	Thu, 21 Apr 2016 15:25:08 -0400 (EDT)
X-Mailer: git-send-email 2.8.1-422-g6d9b748
In-Reply-To: <20160421192500.23563-1-gitster@pobox.com>
X-Pobox-Relay-ID: C23553A6-07F6-11E6-A0AF-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292148>

It is rumored that some scripts rely on being able to regularly
create two project merges.  Instead of forcing them to pass the
option --allow-unrelated-histories when they call "git merge", allow
them to set and export an environment at the beginning and forget
about it.

This will be less damaging than adding a configuration variable to
disable the safety, as contaminating the configuration file of users
of such a script will allow any invocation of "git merge", not
limited to such a script, to go without the safety.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 3 +++
 builtin/merge.c       | 3 +++
 builtin/pull.c        | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 754dc80..5c9380d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1138,6 +1138,9 @@ of clones and fetches.
 	  - any external helpers are named by their protocol (e.g., use
 	    `hg` to allow the `git-remote-hg` helper)
 
+'GIT_MERGE_ALLOW_UNRELATED_HISTORIES'::
+	Allow "git merge" to merge unrelated histories by default.
+
 
 Discussion[[Discussion]]
 ------------------------
diff --git a/builtin/merge.c b/builtin/merge.c
index e3db41b..4e8b1a1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1191,6 +1191,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		head_commit = lookup_commit_or_die(head_sha1, "HEAD");
 
 	git_config(git_merge_config, NULL);
+	if (getenv("GIT_MERGE_ALLOW_UNRELATED_HISTORIES"))
+		allow_unrelated_histories =
+			git_env_bool("GIT_MERGE_ALLOW_UNRELATED_HISTORIES", 0);
 
 	if (branch_mergeoptions)
 		parse_branch_merge_options(branch_mergeoptions);
diff --git a/builtin/pull.c b/builtin/pull.c
index 797932d..4e886a5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -86,7 +86,7 @@ static char *opt_verify_signatures;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
 static char *opt_gpg_sign;
-static int opt_allow_unrelated_histories;
+static int opt_allow_unrelated_histories = -1; /* unspecified */
 
 /* Options passed to git-fetch */
 static char *opt_all;
@@ -159,6 +159,9 @@ static struct option pull_options[] = {
 	OPT_SET_INT(0, "allow-unrelated-histories",
 		    &opt_allow_unrelated_histories,
 		    N_("allow merging unrelated histories"), 1),
+	OPT_SET_INT(0, "no-allow-unrelated-histories",
+		    &opt_allow_unrelated_histories,
+		    N_("do not allow merging unrelated histories"), 0),
 
 	/* Options passed to git-fetch */
 	OPT_GROUP(N_("Options related to fetching")),
@@ -609,6 +612,8 @@ static int run_merge(void)
 		argv_array_push(&args, opt_gpg_sign);
 	if (opt_allow_unrelated_histories > 0)
 		argv_array_push(&args, "--allow-unrelated-histories");
+	else if (!opt_allow_unrelated_histories)
+		argv_array_push(&args, "--no-allow-unrelated-histories");
 
 	argv_array_push(&args, "FETCH_HEAD");
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
-- 
2.8.1-422-g6d9b748
