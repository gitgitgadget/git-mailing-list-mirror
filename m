From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make sure quickfetch is not fooled with a previous, incomplete fetch.
Date: Mon, 16 Apr 2007 23:40:01 -0700
Message-ID: <11767920013264-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 08:40:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdhMf-0001Nh-Pk
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 08:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbXDQGkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 02:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbXDQGkF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 02:40:05 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:56044 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbXDQGkC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 02:40:02 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417064001.QVNS1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Tue, 17 Apr 2007 02:40:01 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id o6g11W00F1kojtg0000000; Tue, 17 Apr 2007 02:40:01 -0400
X-Mailer: git-send-email 1.5.1.1.125.g402f-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44735>

This adds a new option --check-blob to rev-list command (and it
even documents it ;-), and uses it to make sure the quick-fetch
optimization we introduced earlier is not fooled by a previous
incomplete fetch.

The quick-fetch optimization works by running this command:

	git rev-list --objects <<commit-list>> --not --all

where <<commit-list>> is a list of commits that we are going to
fetch from the other side.  If there is any object missing to
complete the <<commit-list>>, the rev-list would fail and die
(say, the commit was in our repository, but its tree wasn't --
then it will barf while trying to list the blobs the tree
contains because it cannot read that tree).

Usually we do not have the objects (otherwise why would we
fetching?), but in one important special case we do: when the
remote repository is used as an alternate object store
(i.e. pointed by .git/objects/info/alternates).  We could check
.git/objects/info/alternates to see if the remote we are
interacting with is one of them (or is used as an alternate,
recursively, by one of them), but that check is more cumbersome
than it is worth.

The above check however does not catch missing blob, because
usual object listing code does not read nor check blob objects,
knowing that blobs do not contain any further references to
other objects.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

I've benched this with

	git rev-list --objects --all >/dev/null

in the kernel repository, with three different implementations
of the "check-blob".

 - Checking with has_sha1_file() has negligible (unmeasurable)
   performance penalty, which is what this patch has.

 - Checking with sha1_object_info() makes it somewhat slower,
   perhaps by 5%.

 - Checking with read_sha1_file() to cause a fully re-validation
   is prohibitively expensive (about 4 times as much runtime).

I am tempted to make the version with has_sha1_file() the
default, getting rid of this new --check-blob option.

 Documentation/git-rev-list.txt |   13 +++++-
 builtin-rev-list.c             |   10 ++++
 git-fetch.sh                   |    2 +-
 t/t5502-quickfetch.sh          |   89 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 2 deletions(-)
 create mode 100755 t/t5502-quickfetch.sh

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 12b71ed..3efd3d8 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -24,7 +24,7 @@ SYNOPSIS
 	     [ \--left-right ]
 	     [ \--encoding[=<encoding>] ]
 	     [ \--(author|committer|grep)=<pattern> ]
-	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
+	     [ [\--objects | \--objects-edge] [ \--unpacked ] [ \--check-blob] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
 	     [ \--bisect-vars ]
@@ -335,6 +335,17 @@ These options are mostly targeted for packing of git repositories.
 	objects in deltified form based on objects contained in these
 	excluded commits to reduce network traffic.
 
+--check-blob::
+
+	When the command lists objects contained in commits with
+	`--objects` (or `--objects-edge`) option, it does not
+	usually check if the listed blob objects exist in the
+	repository (this is usually not a problem, as the
+	command is typically used to dig from the existing refs,
+	and objects reachable from refs are by definition
+	complete).  This command makes the command additionally
+	ensure the blobs it lists exist.
+
 --unpacked::
 
 	Only useful with '--objects'; print the object IDs that are not
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 09774f9..3404766 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -44,6 +44,7 @@ static const char rev_list_usage[] =
 static struct rev_info revs;
 
 static int bisect_list;
+static int check_blob;
 static int show_timestamp;
 static int hdr_termination;
 static const char *header_prefix;
@@ -113,6 +114,11 @@ static void show_object(struct object_array_entry *p)
 	 * confuse downstream git-pack-objects very badly.
 	 */
 	const char *ep = strchr(p->name, '\n');
+
+	if (check_blob && p->item->type == OBJ_BLOB
+	    && !has_sha1_file(p->item->sha1))
+		die("missing blob object '%s'", sha1_to_hex(p->item->sha1));
+
 	if (ep) {
 		printf("%s %.*s\n", sha1_to_hex(p->item->sha1),
 		       (int) (ep - p->name),
@@ -490,6 +496,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			bisect_show_vars = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--check-blob")) {
+			check_blob = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--stdin")) {
 			if (read_from_stdin++)
 				die("--stdin given twice?");
diff --git a/git-fetch.sh b/git-fetch.sh
index 832b20c..e95a9ec 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -195,7 +195,7 @@ fetch_all_at_once () {
 			# This will barf when $theirs reach an object that
 			# we do not have in our repository.  Otherwise,
 			# we already have everything the fetch would bring in.
-			git-rev-list --objects $theirs --not --all \
+			git-rev-list --objects --check-blob $theirs --not --all \
 				>/dev/null 2>/dev/null
 		then
 			git-fetch--tool pick-rref "$rref" "$ls_remote_result"
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
new file mode 100755
index 0000000..b4760f2
--- /dev/null
+++ b/t/t5502-quickfetch.sh
@@ -0,0 +1,89 @@
+#!/bin/sh
+
+test_description='test quickfetch from local'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	test_tick &&
+	echo ichi >file &&
+	git add file &&
+	git commit -m initial &&
+
+	cnt=$( (
+		git count-objects | sed -e "s/ *objects,.*//"
+	) ) &&
+	test $cnt -eq 3
+'
+
+test_expect_success 'clone without alternate' '
+
+	(
+		mkdir cloned &&
+		cd cloned &&
+		git init-db &&
+		git remote add -f origin ..
+	) &&
+	cnt=$( (
+		cd cloned &&
+		git count-objects | sed -e "s/ *objects,.*//"
+	) ) &&
+	test $cnt -eq 3
+'
+
+test_expect_success 'further commits in the original' '
+
+	test_tick &&
+	echo ni >file &&
+	git commit -a -m second &&
+
+	cnt=$( (
+		git count-objects | sed -e "s/ *objects,.*//"
+	) ) &&
+	test $cnt -eq 6
+'
+
+test_expect_success 'copy commit and tree but not blob by hand' '
+
+	git rev-list --objects HEAD |
+	git pack-objects --stdout |
+	(
+		cd cloned &&
+		git unpack-objects
+	) &&
+
+	cnt=$( (
+		cd cloned &&
+		git count-objects | sed -e "s/ *objects,.*//"
+	) ) &&
+	test $cnt -eq 6
+
+	blob=$(git rev-parse HEAD:file | sed -e "s|..|&/|") &&
+	test -f "cloned/.git/objects/$blob" &&
+	rm -f "cloned/.git/objects/$blob" &&
+
+	cnt=$( (
+		cd cloned &&
+		git count-objects | sed -e "s/ *objects,.*//"
+	) ) &&
+	test $cnt -eq 5
+
+'
+
+test_expect_success 'quickfetch should not leave a corrupted repository' '
+
+	(
+		cd cloned &&
+		git fetch
+	) &&
+
+	cnt=$( (
+		cd cloned &&
+		git count-objects | sed -e "s/ *objects,.*//"
+	) ) &&
+	test $cnt -eq 6
+
+'
+
+test_done
-- 
1.5.1.1.821.g88bdb
