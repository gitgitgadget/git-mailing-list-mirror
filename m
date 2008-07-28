From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] git-merge -s theirs
Date: Mon, 28 Jul 2008 02:18:24 -0700
Message-ID: <7vfxpus6xr.fsf_-_@gitster.siamese.dyndns.org>
References: <20080720192130.6117@nanako3.lavabit.com>
 <7vhcak45ez.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 11:20:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNOtA-0006SD-43
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 11:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbYG1JSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 05:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbYG1JSb
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 05:18:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52630 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbYG1JSb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 05:18:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C83A446B18;
	Mon, 28 Jul 2008 05:18:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E3CF946B15; Mon, 28 Jul 2008 05:18:25 -0400 (EDT)
In-Reply-To: <7vhcak45ez.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 20 Jul 2008 14:22:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 24760F58-5C86-11DD-B18B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90429>

Junio C Hamano <gitster@pobox.com> writes:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
> ...
> That is certainly cute, but I do not like it for two reasons:
>
>  - This advertizes "theirs" as available when you ask "git merge -s whoa",
>    and then the user is told "don't use this stupid, go away".  That is
>    not exactly a good diplomacy to earn friends.
>
>  - The message gives a rather long hexdecimal string in its suggestion to
>    run "git reset --hard".  This is not exactly your fault, though. The
>    original refname the user gave to "git-merge" is not available to your
>    strategy.

This does not address the first point at all, but attempts to solve the
second issue.  Strategies now get the remote in the symbolic form
originally used on the command line.

All strategies know that they need to expect that the refs can be given
with arbitrary SHA-1 expressions, so this change should be safe.

 builtin-merge.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index e78fa18..1a9850f 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -22,6 +22,7 @@
 #include "log-tree.h"
 #include "color.h"
 #include "rerere.h"
+#include "decorate.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -504,7 +505,7 @@ static void write_tree_trivial(unsigned char *sha1)
 }
 
 static int try_merge_strategy(const char *strategy, struct commit_list *common,
-			      const char *head_arg)
+			      const char *head_arg, struct decoration *symbolic)
 {
 	const char **args;
 	int i = 0, ret;
@@ -520,8 +521,12 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
 	args[i++] = "--";
 	args[i++] = head_arg;
-	for (j = remoteheads; j; j = j->next)
-		args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
+	for (j = remoteheads; j; j = j->next) {
+		char *name = lookup_decoration(symbolic, &j->item->object);
+		if (!name)
+			name = sha1_to_hex(j->item->object.sha1);
+		args[i++] = xstrdup(name);
+	}
 	args[i] = NULL;
 	ret = run_command_v_opt(args, RUN_GIT_CMD);
 	strbuf_release(&buf);
@@ -773,6 +778,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list **remotes = &remoteheads;
+	struct decoration symbolic_remote_head;
 
 	setup_work_tree();
 	if (unmerged_cache())
@@ -870,6 +876,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&buf, " %s", argv[i]);
 	setenv("GIT_REFLOG_ACTION", buf.buf, 0);
 	strbuf_reset(&buf);
+	memset(&symbolic_remote_head, 0, sizeof(symbolic_remote_head));
 
 	for (i = 0; i < argc; i++) {
 		struct object *o;
@@ -877,6 +884,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		o = peel_to_type(argv[i], 0, NULL, OBJ_COMMIT);
 		if (!o)
 			die("%s - not something we can merge", argv[i]);
+		add_decoration(&symbolic_remote_head, o, xstrdup(argv[i]));
 		remotes = &commit_list_insert(lookup_commit(o->sha1),
 			remotes)->next;
 
@@ -1041,7 +1049,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		wt_strategy = use_strategies[i]->name;
 
 		ret = try_merge_strategy(use_strategies[i]->name,
-			common, head_arg);
+					 common, head_arg,
+					 &symbolic_remote_head);
 		if (!option_commit && !ret) {
 			merge_was_ok = 1;
 			/*
@@ -1105,7 +1114,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		restore_state();
 		printf("Using the %s to prepare resolving by hand.\n",
 			best_strategy);
-		try_merge_strategy(best_strategy, common, head_arg);
+		try_merge_strategy(best_strategy, common, head_arg,
+				   &symbolic_remote_head);
 	}
 
 	if (squash)
