From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] cherry-pick: show commit name instead of sha1
Date: Thu, 11 Feb 2010 16:08:15 -0500
Message-ID: <20100211210815.GD9066@coredump.intra.peff.net>
References: <20100211210445.GA8819@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 22:08:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfgGo-0006wt-LN
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 22:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757218Ab0BKVIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 16:08:13 -0500
Received: from peff.net ([208.65.91.99]:51481 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757197Ab0BKVIN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 16:08:13 -0500
Received: (qmail 22077 invoked by uid 107); 11 Feb 2010 21:08:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Feb 2010 16:08:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2010 16:08:15 -0500
Content-Disposition: inline
In-Reply-To: <20100211210445.GA8819@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139628>

When we have a conflict, we advise the user to do:

  git commit -c $sha1

This works fine, but is unnecessarily confusing and annoying
for the user to type, when:

  git commit -c $the_thing_you_called_cherry_pick_with

works just as well.

Signed-off-by: Jeff King <peff@peff.net>
---
I am pretty sure of the "works just as well". I couldn't think of a
reason why the commit name they gave would have changed between the
cherry-pick and the time they commit the resolved state.

 builtin-revert.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 77e4f4e..ad61249 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -38,6 +38,7 @@ static const char * const cherry_pick_usage[] = {
 static int edit, no_replay, no_commit, mainline, signoff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
+static const char *commit_name;
 static int allow_rerere_auto;
 
 static const char *me;
@@ -49,7 +50,6 @@ static void parse_args(int argc, const char **argv)
 	const char * const * usage_str =
 		action == REVERT ?  revert_usage : cherry_pick_usage;
 	unsigned char sha1[20];
-	const char *arg;
 	int noop;
 	struct option options[] = {
 		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
@@ -64,10 +64,10 @@ static void parse_args(int argc, const char **argv)
 
 	if (parse_options(argc, argv, NULL, options, usage_str, 0) != 1)
 		usage_with_options(usage_str, options);
-	arg = argv[0];
 
-	if (get_sha1(arg, sha1))
-		die ("Cannot find '%s'", arg);
+	commit_name = argv[0];
+	if (get_sha1(commit_name, sha1))
+		die ("Cannot find '%s'", commit_name);
 	commit = lookup_commit_reference(sha1);
 	if (!commit)
 		exit(1);
@@ -198,7 +198,7 @@ static void set_author_ident_env(const char *message)
 			sha1_to_hex(commit->object.sha1));
 }
 
-static char *help_msg(const unsigned char *sha1)
+static char *help_msg(const char *name)
 {
 	struct strbuf helpbuf = STRBUF_INIT;
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
@@ -214,7 +214,7 @@ static char *help_msg(const unsigned char *sha1)
 		strbuf_addf(&helpbuf,
 			"  When committing, use the option '-c %s'\n"
 			"to retain authorship and message.",
-			find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			name);
 	}
 	return strbuf_detach(&helpbuf, NULL);
 }
@@ -403,7 +403,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		if (commit_lock_file(&msg_file) < 0)
 			die ("Error wrapping up %s", defmsg);
 		fprintf(stderr, "Automatic %s failed.%s\n",
-			me, help_msg(commit->object.sha1));
+			me, help_msg(commit_name));
 		rerere(allow_rerere_auto);
 		exit(1);
 	}
-- 
1.7.0.rc2.40.g33ed2.dirty
