From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 06/18] revert: remove "commit" global variable
Date: Thu, 25 Nov 2010 22:20:37 +0100
Message-ID: <20101125212050.5188.99356.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:55:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrGs-0006kW-H5
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab0KZFyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:54:46 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47456 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860Ab0KZFyp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:54:45 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CD94FA613E;
	Fri, 26 Nov 2010 06:54:37 +0100 (CET)
X-git-sha1: d02637f2971e3b92128ad6e0e7085045927c2fc4 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162188>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   49 ++++++++++++++++++++++++-------------------------
 1 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 947e666..e3dea19 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -38,7 +38,6 @@ static const char * const cherry_pick_usage[] = {
 
 static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
 static enum { REVERT, CHERRY_PICK } action;
-static struct commit *commit;
 static int commit_argc;
 static const char **commit_argv;
 static int allow_rerere_auto;
@@ -48,7 +47,7 @@ static const char *strategy;
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
-static char *get_encoding(const char *message);
+static char *get_encoding(const char *message, const unsigned char *sha1);
 
 static const char * const *revert_or_cherry_pick_usage(void)
 {
@@ -99,7 +98,8 @@ struct commit_message {
 	const char *message;
 };
 
-static int get_message(const char *raw_message, struct commit_message *out)
+static int get_message(const char *raw_message, const unsigned char *sha1,
+		       struct commit_message *out)
 {
 	const char *encoding;
 	const char *abbrev, *subject;
@@ -108,7 +108,7 @@ static int get_message(const char *raw_message, struct commit_message *out)
 
 	if (!raw_message)
 		return -1;
-	encoding = get_encoding(raw_message);
+	encoding = get_encoding(raw_message, sha1);
 	if (!encoding)
 		encoding = "UTF-8";
 	if (!git_commit_encoding)
@@ -122,7 +122,7 @@ static int get_message(const char *raw_message, struct commit_message *out)
 	if (out->reencoded_message)
 		out->message = out->reencoded_message;
 
-	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
+	abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
 	abbrev_len = strlen(abbrev);
 
 	subject_len = find_commit_subject(out->message, &subject);
@@ -146,13 +146,12 @@ static void free_message(struct commit_message *msg)
 	free(msg->reencoded_message);
 }
 
-static char *get_encoding(const char *message)
+static char *get_encoding(const char *message, const unsigned char *sha1)
 {
 	const char *p = message, *eol;
 
 	if (!p)
-		die ("Could not read commit message of %s",
-				sha1_to_hex(commit->object.sha1));
+		die ("Could not read commit message of %s", sha1_to_hex(sha1));
 	while (*p && *p != '\n') {
 		for (eol = p + 1; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
@@ -168,25 +167,25 @@ static char *get_encoding(const char *message)
 	return NULL;
 }
 
-static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
+static void add_message_to_msg(struct strbuf *msgbuf, const char *message,
+			       const unsigned char *sha1)
 {
 	const char *p = message;
 	while (*p && (*p != '\n' || p[1] != '\n'))
 		p++;
 
 	if (!*p)
-		strbuf_addstr(msgbuf, sha1_to_hex(commit->object.sha1));
+		strbuf_addstr(msgbuf, sha1_to_hex(sha1));
 
 	p += 2;
 	strbuf_addstr(msgbuf, p);
 }
 
-static void set_author_ident_env(const char *message)
+static void set_author_ident_env(const char *message, const unsigned char *sha1)
 {
 	const char *p = message;
 	if (!p)
-		die ("Could not read commit message of %s",
-				sha1_to_hex(commit->object.sha1));
+		die ("Could not read commit message of %s", sha1_to_hex(sha1));
 	while (*p && *p != '\n') {
 		const char *eol;
 
@@ -200,7 +199,7 @@ static void set_author_ident_env(const char *message)
 			email = strchr(line, '<');
 			if (!email)
 				die ("Could not extract author email from %s",
-					sha1_to_hex(commit->object.sha1));
+					sha1_to_hex(sha1));
 			if (email == line)
 				pend = line;
 			else
@@ -212,7 +211,7 @@ static void set_author_ident_env(const char *message)
 			timestamp = strchr(email, '>');
 			if (!timestamp)
 				die ("Could not extract author time from %s",
-					sha1_to_hex(commit->object.sha1));
+					sha1_to_hex(sha1));
 			*timestamp = '\0';
 			for (timestamp++; *timestamp && isspace(*timestamp);
 					timestamp++)
@@ -227,8 +226,7 @@ static void set_author_ident_env(const char *message)
 		if (*p == '\n')
 			p++;
 	}
-	die ("No author information found in %s",
-			sha1_to_hex(commit->object.sha1));
+	die ("No author information found in %s", sha1_to_hex(sha1));
 }
 
 static void advise(const char *advice, ...)
@@ -240,7 +238,7 @@ static void advise(const char *advice, ...)
 	va_end(params);
 }
 
-static void print_advice(void)
+static void print_advice(const unsigned char *sha1)
 {
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
 
@@ -254,7 +252,7 @@ static void print_advice(void)
 
 	if (action == CHERRY_PICK)
 		advise("and commit the result with 'git commit -c %s'",
-		       find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
+		       find_unique_abbrev(sha1, DEFAULT_ABBREV));
 }
 
 static int write_message(struct strbuf *msgbuf, const char *filename)
@@ -391,7 +389,7 @@ static int run_git_commit(const char *defmsg)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(void)
+static int do_pick_commit(struct commit *commit)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -452,7 +450,7 @@ static int do_pick_commit(void)
 		return error("%s: cannot parse parent commit %s",
 			     me, sha1_to_hex(parent->object.sha1));
 
-	if (get_message(commit->buffer, &msg) != 0)
+	if (get_message(commit->buffer, commit->object.sha1, &msg) != 0)
 		return error("Cannot get commit message for %s",
 			     sha1_to_hex(commit->object.sha1));
 
@@ -485,8 +483,8 @@ static int do_pick_commit(void)
 		base_label = msg.parent_label;
 		next = commit;
 		next_label = msg.label;
-		set_author_ident_env(msg.message);
-		add_message_to_msg(&msgbuf, msg.message);
+		set_author_ident_env(msg.message, commit->object.sha1);
+		add_message_to_msg(&msgbuf, msg.message, commit->object.sha1);
 		if (no_replay) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
@@ -521,7 +519,7 @@ static int do_pick_commit(void)
 		      action == REVERT ? "revert" : "apply",
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
 		      msg.subject);
-		print_advice();
+		print_advice(commit->object.sha1);
 		rerere(allow_rerere_auto);
 	} else {
 		if (!no_commit)
@@ -572,6 +570,7 @@ static void read_and_refresh_cache(const char *me)
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	struct rev_info revs;
+	struct commit *commit;
 
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
@@ -594,7 +593,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	prepare_revs(&revs);
 
 	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit();
+		int res = do_pick_commit(commit);
 		if (res)
 			return res;
 	}
-- 
1.7.3.2.504.g59d466
