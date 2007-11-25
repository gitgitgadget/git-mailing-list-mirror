From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] revert/cherry-pick: do not mention the original ref
Date: Sun, 25 Nov 2007 15:15:48 -0800
Message-ID: <7vwss5j4rf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 00:16:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwQhu-0003TX-VC
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 00:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716AbXKYXPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 18:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756875AbXKYXPw
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 18:15:52 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38291 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697AbXKYXPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 18:15:52 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 214AC2EF;
	Sun, 25 Nov 2007 18:16:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A131699BF2;
	Sun, 25 Nov 2007 18:16:11 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66025>

When you cherry-pick or revert a commit, naming it with an annotated
tag, we added a comment, attempting to repeat what we got from the end
user, to the message.

But this was inconsistent.  When we got "cherry-pick branch", we
recorded the object name (40-letter SHA-1) without saying anything like
"original was 'branch'".  There was no need to.  Also recent rewrite to
use parse-options made it impossible to parrot the original command line
without "unparsing".

This removes the code that implements the misguided "we dereferenced the
tag so record that in the commit message" behaviour.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-revert.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 365b330..a0586f9 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -30,7 +30,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, needed_deref, mainline;
+static int edit, no_replay, no_commit, mainline;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 
@@ -66,7 +66,6 @@ static void parse_args(int argc, const char **argv)
 	if (commit->object.type == OBJ_TAG) {
 		commit = (struct commit *)
 			deref_tag((struct object *)commit, arg, strlen(arg));
-		needed_deref = 1;
 	}
 	if (commit->object.type != OBJ_COMMIT)
 		die ("'%s' does not point to a commit", arg);
@@ -333,17 +332,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			add_to_msg(")\n");
 		}
 	}
-	if (needed_deref) {
-		add_to_msg("(original 'git ");
-		add_to_msg(me);
-		add_to_msg("' arguments: ");
-		for (i = 0; i < argc; i++) {
-			if (i)
-				add_to_msg(" ");
-			add_to_msg(argv[i]);
-		}
-		add_to_msg(")\n");
-	}
 
 	if (merge_recursive(sha1_to_hex(base->object.sha1),
 				sha1_to_hex(head), "HEAD",
