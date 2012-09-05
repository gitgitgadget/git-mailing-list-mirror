From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH 1/2] notes get-ref: --expand expands the output notes ref.
Date: Wed, 05 Sep 2012 08:52:44 -0400
Message-ID: <4eea4f3eab8ee827a40802a50aa2cda9e4b43943.1346849556.git.wking@tremily.us>
References: <cover.1346848834.git.wking@tremily.us>
Cc: "W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 15:53:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9G2q-0007Ig-JK
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 15:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607Ab2IENxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 09:53:22 -0400
Received: from vms173019pub.verizon.net ([206.46.173.19]:45658 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501Ab2IENxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 09:53:21 -0400
X-Greylist: delayed 3607 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2012 09:53:21 EDT
Received: from odin.tremily.us ([unknown] [72.68.111.221])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M9V006T7NS0EL90@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 05 Sep 2012 07:52:49 -0500 (CDT)
Received: from mjolnir (mjolnir.tremily.us [192.168.0.6])
	by odin.tremily.us (Postfix) with ESMTPS id 773BA5C2EAC; Wed,
 05 Sep 2012 08:52:47 -0400 (EDT)
Received: by mjolnir (sSMTP sendmail emulation); Wed, 05 Sep 2012 08:52:56 -0400
X-Mailer: git-send-email 1.7.12.176.g3fc0e4c.dirty
In-reply-to: <cover.1346848834.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204830>

From: "W. Trevor King" <wking@tremily.us>

Useful for debugging refs that don't seem to be expanding correctly.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-notes.txt |  6 +++++-
 builtin/notes.c             | 26 +++++++++++++++++++++-----
 t/t3301-notes.sh            |  8 ++++++++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index b95aafa..a93d211 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -19,7 +19,7 @@ SYNOPSIS
 'git notes' merge --abort [-v | -q]
 'git notes' remove [--ignore-missing] [--stdin] [<object>...]
 'git notes' prune [-n | -v]
-'git notes' get-ref
+'git notes' get-ref [-e]
 
 
 DESCRIPTION
@@ -165,6 +165,10 @@ OPTIONS
 	input (there is no reason you cannot combine this with object
 	names from the command line).
 
+-e::
+--expand::
+  Expand the notes ref before printing it.
+
 -n::
 --dry-run::
 	Do not remove anything; just report the object names whose notes
diff --git a/builtin/notes.c b/builtin/notes.c
index 3644d14..17c6136 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -31,7 +31,7 @@ static const char * const git_notes_usage[] = {
 	"git notes merge --abort [-v | -q]",
 	"git notes [--ref <notes_ref>] remove [<object>...]",
 	"git notes [--ref <notes_ref>] prune [-n | -v]",
-	"git notes [--ref <notes_ref>] get-ref",
+	"git notes [--ref <notes_ref>] get-ref [-e]",
 	NULL
 };
 
@@ -84,7 +84,7 @@ static const char * const git_notes_prune_usage[] = {
 };
 
 static const char * const git_notes_get_ref_usage[] = {
-	"git notes get-ref",
+	"git notes get-ref [<options>]",
 	NULL
 };
 
@@ -1046,16 +1046,32 @@ static int prune(int argc, const char **argv, const char *prefix)
 
 static int get_ref(int argc, const char **argv, const char *prefix)
 {
-	struct option options[] = { OPT_END() };
+	const char *ref;
+	struct strbuf buf = STRBUF_INIT;
+	int expand = 0;
+	struct option options[] = {
+		OPT_BOOL('e', "expand", &expand,
+		         "expand the notes ref before printing it"),
+		OPT_END()
+	};
 	argc = parse_options(argc, argv, prefix, options,
 			     git_notes_get_ref_usage, 0);
 
-	if (argc) {
+	if (argc > 1) {
 		error("too many parameters");
 		usage_with_options(git_notes_get_ref_usage, options);
 	}
 
-	puts(default_notes_ref());
+	ref = default_notes_ref();
+	if (expand) {
+		strbuf_insert(&buf, 0, ref, strlen(ref));
+		expand_notes_ref(&buf);
+		puts(buf.buf);
+		strbuf_release(&buf);
+	} else {
+		puts(ref);
+	}	
+
 	return 0;
 }
 
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 16de05a..c0486a0 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1222,4 +1222,12 @@ test_expect_success 'git notes get-ref (--ref)' '
 	test "$(GIT_NOTES_REF=refs/notes/bar git notes --ref=baz get-ref)" = "refs/notes/baz"
 '
 
+test_expect_success 'git notes get-ref (no expand)' '
+	test "$(GIT_NOTES_REF=commits git notes get-ref)" = "commits"
+'
+
+test_expect_success 'git notes get-ref (--expand)' '
+	test "$(GIT_NOTES_REF=commits git notes get-ref --expand)" = "refs/notes/commits"
+'
+
 test_done
-- 
1.7.12.176.g3fc0e4c.dirty
