From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/10] revert: Eliminate global "commit" variable
Date: Wed, 25 May 2011 14:16:58 +0000
Message-ID: <1306333025-29893-4-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 16:17:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPEts-0003Uq-Aq
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396Ab1EYORQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:17:16 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36798 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757859Ab1EYORM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:17:12 -0400
Received: by mail-qy0-f174.google.com with SMTP id 7so2121342qyk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ncb+BTaNwSogdMDbAfrZmZ+6uPdoT7oIPWCSYu+DMMU=;
        b=MVHw+H+m2T1uG7tkIkFa6jP5G+nFPQ3eG47eYewcCWuVjynCLrKVfsqXRkQGdPjfVH
         LEJTFopkhFEQFgDQLQdTlzp8eL345qKcwdt2a1WM6g1JVL+SspXdNz/8zsVFEr/sN8eA
         b29MrohJtmDxf/yDYzJk9NtZQO3svRqraGw0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PSafRz3R57uc5EM2igIG1LdvLyInNbVQyU7Qlj6Bp/HOYf5XrMSXt8Ed1ShCxDmIvl
         iBHFmL0tibopmq6BsjQ04+11QHsC5/+YsNabMRmzupmMllM1l/7hEa8qOGZUfvateKWz
         3WEW15RU4SnKK//hCu3xUjzGUCVRcdfaIJz7A=
Received: by 10.224.217.7 with SMTP id hk7mr3886714qab.59.1306333032386;
        Wed, 25 May 2011 07:17:12 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id t17sm5285636qcs.35.2011.05.25.07.17.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 07:17:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174395>

Since we want to develop the functionality to either pick/ revert
individual commits atomically later in the series, make "commit" a
local variable.  Modify the get_message and add_message_to_msg API to
take an additional parameter: the pre-computed SHA1 character string
to use.  When reporting a program bug in get_encoding, don't include
the commit in the message.

Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 523d41a..6c485f6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -37,7 +37,6 @@ static const char * const cherry_pick_usage[] = {
 
 static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
 static enum { REVERT, CHERRY_PICK } action;
-static struct commit *commit;
 static int commit_argc;
 static const char **commit_argv;
 static int allow_rerere_auto;
@@ -116,11 +115,12 @@ struct commit_message {
 	const char *message;
 };
 
-static int get_message(const char *raw_message, struct commit_message *out)
+static int get_message(const char *sha1_abbrev, const char *raw_message,
+		struct commit_message *out)
 {
 	const char *encoding;
-	const char *abbrev, *subject;
-	int abbrev_len, subject_len;
+	const char *subject;
+	int subject_len;
 	char *q;
 
 	if (!raw_message)
@@ -139,17 +139,14 @@ static int get_message(const char *raw_message, struct commit_message *out)
 	if (out->reencoded_message)
 		out->message = out->reencoded_message;
 
-	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
-	abbrev_len = strlen(abbrev);
-
 	subject_len = find_commit_subject(out->message, &subject);
 
-	out->parent_label = xmalloc(strlen("parent of ") + abbrev_len +
+	out->parent_label = xmalloc(strlen("parent of ") + DEFAULT_ABBREV +
 			      strlen("... ") + subject_len + 1);
 	q = out->parent_label;
 	q = mempcpy(q, "parent of ", strlen("parent of "));
 	out->label = q;
-	q = mempcpy(q, abbrev, abbrev_len);
+	q = mempcpy(q, sha1_abbrev, DEFAULT_ABBREV);
 	q = mempcpy(q, "... ", strlen("... "));
 	out->subject = q;
 	q = mempcpy(q, subject, subject_len);
@@ -168,8 +165,7 @@ static char *get_encoding(const char *message)
 	const char *p = message, *eol;
 
 	if (!p)
-		die (_("Could not read commit message of %s"),
-				sha1_to_hex(commit->object.sha1));
+		die (_("BUG: get_encoding() called with NULL"));
 	while (*p && *p != '\n') {
 		for (eol = p + 1; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
@@ -185,25 +181,26 @@ static char *get_encoding(const char *message)
 	return NULL;
 }
 
-static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
+static void add_message_to_msg(const char *fallback, struct strbuf *msgbuf,
+			const char *message)
 {
 	const char *p = message;
 	while (*p && (*p != '\n' || p[1] != '\n'))
 		p++;
 
 	if (!*p)
-		strbuf_addstr(msgbuf, sha1_to_hex(commit->object.sha1));
+		strbuf_addstr(msgbuf, fallback);
 
 	p += 2;
 	strbuf_addstr(msgbuf, p);
 }
 
-static void write_cherry_pick_head(void)
+static void write_cherry_pick_head(const char *commit_sha1_hex)
 {
 	int fd;
 	struct strbuf buf = STRBUF_INIT;
 
-	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
+	strbuf_addf(&buf, "%s\n", commit_sha1_hex);
 
 	fd = open(git_path("CHERRY_PICK_HEAD"), O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
@@ -370,7 +367,7 @@ static int run_git_commit(const char *defmsg)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(void)
+static int do_pick_commit(struct commit *commit)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -378,6 +375,7 @@ static int do_pick_commit(void)
 	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
+	const char *sha1_abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 	int res;
 
 	if (no_commit) {
@@ -434,7 +432,7 @@ static int do_pick_commit(void)
 		return error(_("%s: cannot parse parent commit %s"),
 			me, sha1_to_hex(parent->object.sha1));
 
-	if (get_message(commit->buffer, &msg) != 0)
+	if (get_message(sha1_abbrev, commit->buffer, &msg) != 0)
 		return error(_("Cannot get commit message for %s"),
 			sha1_to_hex(commit->object.sha1));
 
@@ -463,18 +461,19 @@ static int do_pick_commit(void)
 		}
 		strbuf_addstr(&msgbuf, ".\n");
 	} else {
+		const char *commit_sha1_hex = sha1_to_hex(commit->object.sha1);
 		base = parent;
 		base_label = msg.parent_label;
 		next = commit;
 		next_label = msg.label;
-		add_message_to_msg(&msgbuf, msg.message);
+		add_message_to_msg(commit_sha1_hex, &msgbuf, msg.message);
 		if (no_replay) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
 		if (!no_commit)
-			write_cherry_pick_head();
+			write_cherry_pick_head(commit_sha1_hex);
 	}
 
 	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
@@ -552,6 +551,7 @@ static void read_and_refresh_cache(const char *me)
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	struct rev_info revs;
+	struct commit *commit;
 
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
@@ -574,7 +574,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	prepare_revs(&revs);
 
 	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit();
+		int res = do_pick_commit(commit);
 		if (res)
 			return res;
 	}
-- 
1.7.5.GIT
