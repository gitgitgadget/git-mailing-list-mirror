From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtins: search builtin commands via binary search.
Date: Mon, 29 Jul 2013 09:18:31 -0700
Message-ID: <7v4nbd1grs.fsf@alter.siamese.dyndns.org>
References: <1374871850-24323-1-git-send-email-stefanbeller@googlemail.com>
	<20130726205737.GI14690@google.com> <51F38997.9010507@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 18:18:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3q9f-0005fa-UI
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 18:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459Ab3G2QSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 12:18:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62760 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754677Ab3G2QSf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 12:18:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2608631073;
	Mon, 29 Jul 2013 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1mXLtIt9BQmQX532RaQ4272cI/U=; b=lAGHxL
	tZ6BV4XIpVqkbq5XyS0DUZRPy2qaWHz/e0m4iv/3ivADrfo2mTbdU2Q3hjHjoT3j
	lh6iPpWZ3T1s7sTsOPzXtDMXVBp76HHTuSgygWy7ldlbnl+BsfNo3PO5o5c6vlrN
	/bXBqAcSgh8w47B8HmeLgI53zIt5mmaH2haGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tqp5fszekGtf8u6pIwrFBg/qGM+er0Vb
	eDduToNFP98+w0YhXfHr9+l4yJ8EZms/GDX89ZtjFYU4XPks/zeZUYh+sSH9j6VC
	pw7aceNXmnSpDLKnuB/CqW8wqWHjO4D7h7w8967O5CMbIL0q+ehdoS+ccnmpkHS0
	5UC6tNaLSsA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AFF231071;
	Mon, 29 Jul 2013 16:18:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E0593106E;
	Mon, 29 Jul 2013 16:18:33 +0000 (UTC)
In-Reply-To: <51F38997.9010507@googlemail.com> (Stefan Beller's message of
	"Sat, 27 Jul 2013 10:49:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 838F9CE0-F86A-11E2-858D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231298>

Stefan Beller <stefanbeller@googlemail.com> writes:

> However I could not find a speedup.
> So if the patch is accepted, it would only be for readability.

This adds a maintenance burden.  It is very easy for somebody to
mistakenly run "sort" on the region in her editor under non C
locale.

Perhaps with a change like the attached, if we were to do so.  Then
have a test that runs "git --check-builtins-sorted" will ensure we
won't ever screw it up.

FOR ILLUSTRATION PURPOSES ONLY: diff --git a/git.c b/git.c
index 2025f77..3155273 100644
--- a/git.c
+++ b/git.c
@@ -34,6 +34,150 @@ static void commit_pager_choice(void) {
 	}
 }
 
+struct cmd_struct {
+	const char *cmd;
+	int (*fn)(int, const char **, const char *);
+	int option;
+};
+
+#define RUN_SETUP		(1<<0)
+#define RUN_SETUP_GENTLY	(1<<1)
+#define USE_PAGER		(1<<2)
+/*
+ * require working tree to be present -- anything uses this needs
+ * RUN_SETUP for reading from the configuration file.
+ */
+#define NEED_WORK_TREE		(1<<3)
+
+static struct cmd_struct builtin_commands[] = {
+	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "annotate", cmd_annotate, RUN_SETUP },
+	...
+	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
+	{ "write-tree", cmd_write_tree, RUN_SETUP },
+};
+
+static void make_sure_the_builtin_array_is_sorted(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(builtin_commands) - 1; i++) {
+		struct cmd_struct *it = &builtin_commands[i];
+		if (strcmp(it[0].cmd, it[1].cmd) >= 0)
+			die("BUG: builtin command list not sorted %s > %s",
+			    it[0].cmd, it[1].cmd);
+	}
+}
+
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	const char **orig_argv = *argv;
@@ -62,6 +206,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				puts(git_exec_path());
 				exit(0);
 			}
+		} else if (!strcmp(cmd, "--check-builtins-sorted")) {
+			make_sure_the_builtin_array_is_sorted();
+			exit(0);
 		} else if (!strcmp(cmd, "--html-path")) {
 			puts(system_path(GIT_HTML_PATH));
 			exit(0);
@@ -241,21 +388,6 @@ static int handle_alias(int *argcp, const char ***argv)
 	return ret;
 }
 
-#define RUN_SETUP		(1<<0)
-#define RUN_SETUP_GENTLY	(1<<1)
-#define USE_PAGER		(1<<2)
-/*
- * require working tree to be present -- anything uses this needs
- * RUN_SETUP for reading from the configuration file.
- */
-#define NEED_WORK_TREE		(1<<3)
-
-struct cmd_struct {
-	const char *cmd;
-	int (*fn)(int, const char **, const char *);
-	int option;
-};
-
 static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 {
 	int status, help;
@@ -312,123 +444,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 static void handle_internal_command(int argc, const char **argv)
 {
 	const char *cmd = argv[0];
-	static struct cmd_struct commands[] = {
-		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-		{ "annotate", cmd_annotate, RUN_SETUP },
-		...
-		{ "whatchanged", cmd_whatchanged, RUN_SETUP },
-		{ "write-tree", cmd_write_tree, RUN_SETUP },
-	};
 	int i;
 	static const char ext[] = STRIP_EXTENSION;
 
@@ -447,8 +462,8 @@ static void handle_internal_command(int argc, const char **argv)
 		argv[0] = cmd = "help";
 	}
 
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		struct cmd_struct *p = commands+i;
+	for (i = 0; i < ARRAY_SIZE(builtin_commands); i++) {
+		struct cmd_struct *p = builtin_commands+i;
 		if (strcmp(p->cmd, cmd))
 			continue;
 		exit(run_builtin(p, argc, argv));
