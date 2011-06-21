From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH 13/13] revert: Introduce --continue to continue the operation
Date: Tue, 21 Jun 2011 13:04:49 +0000
Message-ID: <1308661489-20080-14-git-send-email-artagnon@gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 15:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ0eA-00065X-3Y
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 15:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692Ab1FUNF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 09:05:29 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51876 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519Ab1FUNFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 09:05:25 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so1679724vxb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 06:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=EGeGuMEsRBuveR/w3Z81c+WsFPb3Divv+8Cd0IFi3Pg=;
        b=RTInZ6WPLuKCulqilioSrNMcAXT168iNaGBfi0thuKL/x4F7zAttoawP2OwVOAI5Wu
         8/Fk2eBIe9lKLT+afdeK7jFuI0xikfKD9LoZrJElfVHpl2PcaEIQniJRmujCdihmvOLO
         HZ+sY0lksMXe8AXCw9kh0PjCRcW7DuWCMI3J8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Htrh6KxaDOT6gZ+Fo3J+7Sx0mQyNF8zb9h/SGjJFDeGWUKhPbiDJvUbTGeHO7tqbeD
         KnilT1bM6Z+/lV6N9Ph333FA+YtC/1wQF4FJCJ003nFHcEbYN+mYd+y+OmXRJot7EI0f
         8LoHR/vpczHq0oGqPOTYFfxxezxQ4cLxf7OSc=
Received: by 10.52.168.3 with SMTP id zs3mr2016687vdb.76.1308661525124;
        Tue, 21 Jun 2011 06:05:25 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id k9sm1575853vbn.0.2011.06.21.06.05.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 06:05:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176148>

After resolving a conflict, the user has the option to continue the
operation.  Mixing operations (cherry-pick and revert in the same
todo_list) and command-line options are unsupported at this stage.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |  127 +++++++++++++++++++++++++++++++++++++-
 t/t3510-cherry-pick-sequence.sh |   28 +++++++++
 2 files changed, 151 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index eb68068..7c28268 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -46,8 +46,9 @@ enum replay_action { REVERT, CHERRY_PICK };
 struct replay_opts {
 	enum replay_action action;
 
-	/* --skip-all */
+	/* --skip-all and --continue */
 	int skipall_oper;
+	int continue_oper;
 
 	/* Boolean options */
 	int edit;
@@ -106,12 +107,37 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 	va_end(ap);
 }
 
+static void verify_opt_mutually_compatible(const char *me, ...)
+{
+	const char *opt1, *opt2;
+	va_list ap;
+	int set;
+
+	va_start(ap, me);
+	while ((opt1 = va_arg(ap, const char *))) {
+		set = va_arg(ap, int);
+		if (set)
+			break;
+	}
+	if (!opt1)
+		goto ok;
+	while ((opt2 = va_arg(ap, const char *))) {
+		set = va_arg(ap, int);
+		if (set)
+			die(_("%s: %s cannot be used with %s"),
+				me, opt1, opt2);
+	}
+ok:
+	va_end(ap);
+}
+
 static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	int noop;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "skip-all", &opts->skipall_oper, "skip remaining instructions"),
+		OPT_BOOLEAN(0, "continue", &opts->continue_oper, "continue the current operation"),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
 		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
@@ -141,9 +167,21 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 					PARSE_OPT_KEEP_ARGV0 |
 					PARSE_OPT_KEEP_UNKNOWN);
 
+	/* Check for mutually incompatible command line arguments */
+	verify_opt_mutually_compatible(me,
+				"--skip-all", opts->skipall_oper,
+				"--continue", opts->continue_oper,
+				NULL);
+
 	/* Check for incompatible command line arguments */
-	if (opts->skipall_oper) {
-		verify_opt_compatible(me, "--skip-all",
+	if (opts->skipall_oper || opts->continue_oper) {
+		char *this_oper;
+		if (opts->skipall_oper)
+			this_oper = "--skip-all";
+		else
+			this_oper = "--continue";
+
+		verify_opt_compatible(me, this_oper,
 				"--no-commit", opts->no_commit,
 				"--signoff", opts->signoff,
 				"--mainline", opts->mainline,
@@ -614,6 +652,78 @@ static void format_todo(struct strbuf *buf, struct commit_list *todo_list,
 	}
 }
 
+static void read_populate_todo(struct commit_list **todo_list,
+			struct replay_opts *opts)
+{
+	struct strbuf buf = STRBUF_INIT;
+	enum replay_action action;
+	struct commit *commit;
+	struct commit_list *new_item;
+	struct commit_list *cur = NULL;
+	unsigned char commit_sha1[20];
+	char sha1_abbrev[40];
+	char *p;
+	int insn_len = 0;
+	char *insn;
+	int fd;
+
+	fd = open(TODO_FILE, O_RDONLY);
+	if (fd < 0) {
+		strbuf_release(&buf);
+		die_errno(_("Could not open %s."), TODO_FILE);
+	}
+	if (strbuf_read(&buf, fd, 0) < buf.len) {
+		close(fd);
+		strbuf_release(&buf);
+		die(_("Could not read %s."), TODO_FILE);
+	}
+	close(fd);
+
+	for (p = buf.buf; *p; p = strchr(p, '\n') + 1) {
+		insn = p;
+		if (!(p = strchr(p, ' ')))
+			goto error;
+		insn_len = p - insn;
+		if (!(p = strchr(p + 1, ' ')))
+			goto error;
+		p += 1;
+		strlcpy(sha1_abbrev, insn + insn_len + 1,
+			p - (insn + insn_len + 1));
+
+		if (!strncmp(insn, "pick", insn_len))
+			action = CHERRY_PICK;
+		else if (!strncmp(insn, "revert", insn_len))
+			action = REVERT;
+		else
+			goto error;
+
+		/* Verify that the action matches up with the one in
+		   opts; we don't support arbitrary instructions */
+		if (action != opts->action)
+			goto error;
+
+		/* Now create a commit corresponding to sha1_abbrev
+		   and put it into the todo_list */
+		if ((get_sha1(sha1_abbrev, commit_sha1) < 0)
+			|| !(commit = lookup_commit_reference(commit_sha1)))
+			goto error;
+		new_item = xmalloc(sizeof(struct commit_list));
+		new_item->item = commit;
+		if (cur)
+			cur->next = new_item;
+		else
+			*todo_list = new_item;
+		cur = new_item;
+	}
+	cur->next = NULL;
+	strbuf_release(&buf);
+
+	return;
+error:
+	strbuf_release(&buf);
+	die(_("Malformed instruction sheet: %s"), TODO_FILE);
+}
+
 static void walk_revs_populate_todo(struct commit_list **todo_list,
 				struct replay_opts *opts)
 {
@@ -720,13 +830,22 @@ static int process_continuation(struct replay_opts *opts)
 		if (!file_exists(TODO_FILE))
 			goto error;
 		return cleanup_sequencer_data();
+	} else if (opts->continue_oper) {
+		if (!file_exists(TODO_FILE))
+			goto error;
+		read_populate_todo(&todo_list, opts);
+
+		/* Verify that the conflict has been resolved */
+		if (!index_differs_from("HEAD", 0))
+			todo_list = todo_list->next;
 	} else {
 		/* Start a new cherry-pick/ revert sequence; but
 		   first, make sure that an existing one isn't in
 		   progress */
 		if (file_exists(TODO_FILE)) {
 			error(_("A %s is already in progress"), me);
-			advise(_("Use %s --skip-all to forget about it"), me);
+			advise(_("Use %s --continue to continue the operation"), me);
+			advise(_("or --skip-all to skip all the remaining instructions"), me);
 			return -1;
 		}
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index a797ae3..159be55 100644
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -48,4 +48,32 @@ test_expect_success '--skip-all cleans up sequencer directory' '
 	test_must_fail test -d .git/sequencer
 '
 
+test_expect_success '--continue complains when no cherry-pick is in progress' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --continue >actual 2>&1 &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success '--continue complains when there are unresolved conflicts' '
+	pristine_detach initial &&
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick base..picked &&
+	test_must_fail git cherry-pick --continue &&
+	git cherry-pick --skip-all
+'
+
+test_expect_success '--continue continues after conflicts are resolved' '
+	pristine_detach initial &&
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick base..picked &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	git cherry-pick --continue &&
+	test_must_fail test -d .git/sequencer &&
+	git rev-list --count HEAD >actual &&
+	echo 3 >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.5.GIT
