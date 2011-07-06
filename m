From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH 14/14] revert: Change insn sheet format
Date: Wed,  6 Jul 2011 07:54:28 +0000
Message-ID: <1309938868-2028-15-git-send-email-artagnon@gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:55:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMx3-00068m-Sa
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab1GFHzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:55:00 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48564 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab1GFHy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:54:56 -0400
Received: by mail-qy0-f174.google.com with SMTP id 29so1924487qyk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Td4RcLEv2pK94Qjqi7fapdjHYVmlkmqxkiGG76ToaeE=;
        b=ECvXGmAT7VUxxPp7pynCmGtPFFWVSciJ08ONWDS1Z79CL8l1+5FivW94Qnw6bUzC1z
         qMHhjhu648/bd978JX/FaDmmy+K4Jh4q4gOI0I/Hey04bUtqrsbemjoez236deY5uFFp
         gcBOFr62BExLEWbVQIz8HUOV0vOpPbnPUVFAc=
Received: by 10.224.135.133 with SMTP id n5mr6403453qat.392.1309938895910;
        Wed, 06 Jul 2011 00:54:55 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id e18sm6212790qcs.5.2011.07.06.00.54.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 00:54:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176658>

Add command-line options to the instruction sheet, but don't let the
existing parser break.  Parsing out the command-line options back into
a replay_opts struct is unimplemented.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I've intentionally left parse_cmdline_args unimplemented -- Although
 Stephen (and Christian subsequently) have written a parser [1], I'm
 not happy with it.  The point of this patch is to illustrate the
 problem with this instruction sheet format, and provoke some
 discussion about this.  I don't want to parse command-line arguments
 by hand handling all sorts of corner cases in quoting etc -- is there
 any other way?  Existing implementations in libraries like Glib are
 much too heavyweight.

 Note that I've used the '#' character as a separator to simplify
 parsing.  It's not the most elegant solution, but I think it should
 work.
 
 [1]: http://article.gmane.org/gmane.comp.version-control.git/162198

 builtin/revert.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 6ef56ee..a0a4377 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -638,6 +638,34 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
 	rollback_lock_file(&index_lock);
 }
 
+static void format_args(struct strbuf *buf, struct replay_opts *opts)
+{
+	int i;
+
+	if (opts->no_commit)
+		strbuf_addstr(buf, "-n ");
+	if (opts->edit)
+		strbuf_addstr(buf, "-e ");
+	if (opts->signoff)
+		strbuf_addstr(buf, "-s ");
+	if (opts->mainline)
+		strbuf_addf(buf, "-m %d ", opts->mainline);
+	if (opts->strategy)
+		strbuf_addf(buf, "--strategy %s ", opts->strategy);
+	if (opts->xopts)
+		for (i = 0; i < opts->xopts_nr; i ++)
+			strbuf_addf(buf, "-X %s ", opts->xopts[i]);
+	if (opts->record_origin)
+		strbuf_addstr(buf, "-x ");
+	if (opts->allow_ff)
+		strbuf_addstr(buf, "--ff ");
+}
+
+/*
+ * Instruction sheet format ::
+ * pick -s 537d2e # revert: Introduce --continue to continue the operation
+ * pick 4a15c1 # revert: Introduce --reset to cleanup sequencer data
+ */
 static void format_todo(struct strbuf *buf, struct commit_list *todo_list,
 			struct replay_opts *opts)
 {
@@ -651,29 +679,53 @@ static void format_todo(struct strbuf *buf, struct commit_list *todo_list,
 		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
 		if (get_message(cur->item, &msg))
 			die(_("Cannot get commit message for %s"), sha1_abbrev);
-		strbuf_addf(buf, "%s %s %s\n", action, sha1_abbrev, msg.subject);
+		strbuf_addf(buf, "%s ", action);
+		format_args(buf, opts);
+		strbuf_addf(buf, "%s # %s\n", sha1_abbrev, msg.subject);
 	}
 }
 
-static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
+static void parse_cmdline_args(struct strbuf *args_to_parse,
+			int *argc, const char ***argv)
+{
+	return;
+}
+
+static struct commit *parse_insn_line(const char *start, struct replay_opts *opts)
 {
 	unsigned char commit_sha1[20];
 	char sha1_abbrev[40];
 	struct commit *commit;
 	enum replay_action action;
 	int insn_len = 0;
-	char *p;
+	char *p, *end;
+
+	int argc = 0;
+	const char **argv = NULL;
+	struct strbuf args_to_parse = STRBUF_INIT;
 
-	p = start;
+	p = (char *) start;
 	if (!(p = strchr(p, ' ')))
 		return NULL;
 	insn_len = p - start;
-	if (!(p = strchr(p + 1, ' ')))
+	if (!(end = strchr(p + 1, '#')))
 		return NULL;
-	p += 1;
-	strlcpy(sha1_abbrev, start + insn_len + 1,
-		p - (start + insn_len + 1));
+	*(end - 1) = '\0';
+	strbuf_addstr(&args_to_parse, p + 1);
+
+	/* Parse argc, argv out of args_to_parse */
+	/* TODO: Implement parse_cmdline_args! */
+	parse_cmdline_args(&args_to_parse, &argc, &argv);
+	strbuf_release(&args_to_parse);
+	if (argc)
+		parse_args(argc, argv, opts);
+
+	/* Copy out the sha1_abbrev explicitly */
+	if (!(p = strrchr(p, ' ')))
+		return NULL;
+	strcpy(sha1_abbrev, p + 1);
 
+	/* Determine the action */
 	if (!strncmp(start, "pick", insn_len))
 		action = CHERRY_PICK;
 	else if (!strncmp(start, "revert", insn_len))
@@ -718,7 +770,7 @@ static void read_populate_todo(struct commit_list **todo_list,
 	close(fd);
 
 	next = todo_list;
-	for (p = buf.buf; *p; p = strchr(p, '\n') + 1) {
+	for (p = buf.buf; *p;) {
 		if (!(commit = parse_insn_line(p, opts))) {
 			strbuf_release(&buf);
 			die(_("Malformed instruction sheet: %s"), git_path(SEQ_TODO_FILE));
@@ -727,6 +779,11 @@ static void read_populate_todo(struct commit_list **todo_list,
 		new->item = commit;
 		*next = new;
 		next = &new->next;
+
+		if ((p = strchr(p, '\n')))
+			p += 1;
+		else
+			break;
 	}
 	*next = NULL;
 	strbuf_release(&buf);
-- 
1.7.5.GIT
