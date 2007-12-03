From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-commit --allow-empty
Date: Mon, 03 Dec 2007 00:44:14 -0800
Message-ID: <7v63zgkw0x.fsf@gitster.siamese.dyndns.org>
References: <4751A0FB.6090705@gmail.com>
	<7vd4tq41zt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stelian@popies.net, git@vger.kernel.org
To: Mark Drago <markdrago@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 09:44:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz6ux-0004Pl-7e
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 09:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbXLCIoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 03:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbXLCIoW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 03:44:22 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40640 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbXLCIoV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 03:44:21 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2A00C2EF;
	Mon,  3 Dec 2007 03:44:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8005399389;
	Mon,  3 Dec 2007 03:44:38 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66888>

It does not usually make sense to record a commit that has the exact
same tree as its sole parent commit and that is why git-commit prevents
you from making such a mistake, but when data from foreign scm is
involved, it is a different story.  We are equipped to represent such an
(perhaps insane, perhaps by mistake, or perhaps done on purpose) empty
change, and it is better to represent it bypassing the safety valve for
native use.

This is primarily for use by foreign scm interface scripts.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is for 'next', on top of an earlier "allow amending '-s ours' merge".

 Documentation/git-commit.txt |    8 +++++++-
 builtin-commit.c             |    5 +++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d4bfd49..a7ef71f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git-commit' [-a | --interactive] [-s] [-v] [-u]
 	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
-	   [--no-verify] [-e] [--author <author>]
+	   [--allow-empty] [--no-verify] [-e] [--author <author>]
 	   [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
@@ -89,6 +89,12 @@ OPTIONS
 	This option bypasses the pre-commit hook.
 	See also link:hooks.html[hooks].
 
+--allow-empty::
+	Usually recording a commit that has the exact same tree as its
+	sole parent commit and the command prevents you from making such
+	a mistake.  This option bypasses the safety, and is primarily
+	for use by foreign scm interface scripts.
+
 -e|--edit::
 	The message taken from file with `-F`, command line with
 	`-m`, and from file with `-C` are usually used as the
diff --git a/builtin-commit.c b/builtin-commit.c
index 6c2dc39..e635d99 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -46,7 +46,7 @@ static enum {
 static char *logfile, *force_author, *template_file;
 static char *edit_message, *use_message;
 static int all, edit_flag, also, interactive, only, amend, signoff;
-static int quiet, verbose, untracked_files, no_verify;
+static int quiet, verbose, untracked_files, no_verify, allow_empty;
 
 static int no_edit, initial_commit, in_merge;
 const char *only_include_assumed;
@@ -87,6 +87,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	OPT_BOOLEAN(0, "untracked-files", &untracked_files, "show all untracked files"),
+	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
 
 	OPT_END()
 };
@@ -710,7 +711,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!prepare_log_message(index_file, prefix) && !in_merge &&
-	    !(amend && is_a_merge(head_sha1))) {
+	    !allow_empty && !(amend && is_a_merge(head_sha1))) {
 		run_status(stdout, index_file, prefix);
 		rollback_index_files();
 		unlink(commit_editmsg);
-- 
1.5.3.7-2077-ga07a
