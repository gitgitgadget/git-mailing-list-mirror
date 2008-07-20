From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] git-add -a: add all files
Date: Sat, 19 Jul 2008 20:29:53 -0700
Message-ID: <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
 <20080717155538.GE11759@fieldses.org>
 <alpine.DEB.1.00.0807171915420.8986@racer>
 <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807171940160.8986@racer> <48806897.1080404@fastmail.fm>
 <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
 <7vsku5grpr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>,
	"Jay Soffian" <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 05:31:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKPdU-0007V4-By
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 05:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298AbYGTDaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 23:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755295AbYGTDaA
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 23:30:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275AbYGTD37 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 23:29:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A8EE3349A;
	Sat, 19 Jul 2008 23:29:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 295A133499; Sat, 19 Jul 2008 23:29:54 -0400 (EDT)
In-Reply-To: <7vsku5grpr.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 19 Jul 2008 20:27:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2195E96E-560C-11DD-98D8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89155>

People sometimes find that "git add -u && git add ." are 13 keystrokes too
many.

The support of this has been very low priority for me personally, because
I almost never do "git add ." in an already populated directory, and if a
directory is not already populated, there is no point saying "git add -u"
at the same time.

However, for two types of people that are very different from me, this
mode of operation may make sense and there is no reason to leave it
unsupported.  That is:

 (1) If you are extremely well disciplined and keep perfect .gitignore, it
     always is safe to say "git add ."; or

 (2) If you are extremely undisciplined and do not even know what files
     you created, and you do not very much care, it does not matter if
     "git add ." included everything.

So here it is, although I suspect I will not use it myself, ever.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-add.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 9b2ee8c..bc02fd7 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -190,7 +190,7 @@ static const char ignore_error[] =
 "The following paths are ignored by one of your .gitignore files:\n";
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
-static int ignore_add_errors;
+static int ignore_add_errors, addremove;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only),
@@ -200,6 +200,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching"),
 	OPT_BOOLEAN('f', "force", &ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', "update", &take_worktree_changes, "update tracked files"),
+	OPT_BOOLEAN('a', "all", &addremove, "add all, noticing removal of tracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip files which cannot be added because of errors"),
 	OPT_END(),
@@ -254,6 +255,14 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	git_config(add_config, NULL);
 
+	if (addremove && take_worktree_changes)
+		die("-a and -u are mutually incompatible");
+	if (addremove && !argc) {
+		static const char *here[2] = { ".", NULL };
+		argc = 1;
+		argv = here;
+	}
+
 	add_new_files = !take_worktree_changes && !refresh_only;
 	require_pathspec = !take_worktree_changes;
 
@@ -286,7 +295,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		goto finish;
 	}
 
-	if (take_worktree_changes)
+	if (take_worktree_changes || addremove)
 		exit_status |= add_files_to_cache(prefix, pathspec, flags);
 
 	if (add_new_files)
-- 
1.5.6.4.570.g052e6
