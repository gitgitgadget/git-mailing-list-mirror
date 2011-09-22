From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] branch: teach --edit-description option
Date: Thu, 22 Sep 2011 15:09:19 -0700
Message-ID: <1316729362-7714-4-git-send-email-gitster@pobox.com>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <1316729362-7714-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 00:09:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6rSn-0007M2-9I
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 00:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab1IVWJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 18:09:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62793 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955Ab1IVWJa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 18:09:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 590B96ED4
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=icV2
	2FJ0Ho7QBSJQDZXtqyPV4ng=; b=g/puG0UFayGm1s8sb5cJkxCxjm+ohb4iATGW
	snos6v/D7fI0PPiGP+bSbQ0X13ZSq5HYIJS1TKegZMD5mZ+SZIJT7qcKm8yHwsd7
	+bcOnsof7z/yyUT+48XiAUxZHYNVzq3Jf721PlaLLerjZz5/OqXp83LWGp7AShUS
	E60uqbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=IwW1Tv
	URfk2G0ig9jD5E41AeDrEk1gBrLhfOJ3WzZDRxQzUQwdjCDt/D67gho6Zu5sEuIw
	8EevUhHXspbSc8c/bmBt03uR6T4LFJESwWgHIsQB7yq3Kif47jtDomrwpOf3Xvpi
	IuL1zkJyli6lIq1ZM1JaLo+RVCDhaQPJcoB8M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 515B66ED3
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A594E6ED2 for
 <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:29 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc2.4.g5ec82
In-Reply-To: <1316729362-7714-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8AF602FC-E567-11E0-83E2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181925>

Using branch.$name.description as the configuration key, give users a
place to write about what the purpose of the branch is and things like
that, so that various subsystems, e.g. "push -s", "request-pull", and
"format-patch --cover-letter", can later be taught to use this
information.

The "-m" option similar to "commit/tag" is deliberately omitted, as the
whole point of branch description is about giving descriptive information
(the name of the branch itself is a better place for information that fits
on a single-line).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-branch.txt |    5 +++
 builtin/branch.c             |   56 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 507b8d0..8871a4e 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
+'git branch' --edit-description [<branchname>]
 
 DESCRIPTION
 -----------
@@ -144,6 +145,10 @@ start-point is either a local or remote-tracking branch.
 	like '--track' would when creating the branch, except that where
 	branch points to is not changed.
 
+--edit-description::
+	Open an editor and edit the text to explain what the branch is
+	for, to be used by various other commands (e.g. `request-pull`).
+
 --contains <commit>::
 	Only list branches which contain the specified commit.
 
diff --git a/builtin/branch.c b/builtin/branch.c
index f49596f..fffa319 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -606,11 +606,49 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
 	return 0;
 }
 
+static const char edit_description[] = "BRANCH_DESCRIPTION";
+
+static int edit_branch_description(const char *branch_name)
+{
+	FILE *fp;
+	int status;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf name = STRBUF_INIT;
+
+	read_branch_desc(&buf, branch_name);
+	if (!buf.len || buf.buf[buf.len-1] != '\n')
+		strbuf_addch(&buf, '\n');
+	strbuf_addf(&buf,
+		    "# Please edit the description for the branch\n"
+		    "#   %s\n"
+		    "# Lines starting with '#' will be stripped.\n",
+		    branch_name);
+	fp = fopen(git_path(edit_description), "w");
+	if ((fwrite(buf.buf, 1, buf.len, fp) < buf.len) || fclose(fp)) {
+		strbuf_release(&buf);
+		return error(_("could not write branch description template: %s\n"),
+			     strerror(errno));
+	}
+	strbuf_reset(&buf);
+	if (launch_editor(git_path(edit_description), &buf, NULL)) {
+		strbuf_release(&buf);
+		return -1;
+	}
+	stripspace(&buf, 1);
+
+	strbuf_addf(&name, "branch.%s.description", branch_name);
+	status = git_config_set(name.buf, buf.buf);
+	strbuf_release(&name);
+	strbuf_release(&buf);
+
+	return status;
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force_create = 0;
 	int verbose = 0, abbrev = -1, detached = 0;
-	int reflog = 0;
+	int reflog = 0, edit_description = 0;
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
@@ -648,6 +686,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('m', NULL, &rename, "move/rename a branch and its reflog", 1),
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
+		OPT_BOOLEAN(0, "edit-description", &edit_description,
+			    "edit the description for the branch"),
 		OPT__FORCE(&force_create, "force creation (when already exists)"),
 		{
 			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
@@ -694,7 +734,19 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (argc == 0)
+	else if (edit_description) {
+		const char *branch_name;
+		if (detached)
+			die("Cannot give description to detached HEAD");
+		if (!argc)
+			branch_name = head;
+		else if (argc == 1)
+			branch_name = argv[0];
+		else
+			usage_with_options(builtin_branch_usage, options);
+		if (edit_branch_description(branch_name))
+			return 1;
+	} else if (argc == 0)
 		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
-- 
1.7.7.rc2.4.g5ec82
