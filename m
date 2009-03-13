From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 8/7] rev-list: make "--bisect-skip" read skipped revisions
 from stdin
Date: Fri, 13 Mar 2009 06:29:46 +0100
Message-ID: <20090313062946.440e2ed7.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 06:32:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li00Q-0000Bb-3d
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 06:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbZCMFao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 01:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753048AbZCMFan
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 01:30:43 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:58109 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbZCMFam (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 01:30:42 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 99186E0809B;
	Fri, 13 Mar 2009 06:30:33 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with SMTP id 6E81EE0804A;
	Fri, 13 Mar 2009 06:30:30 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113143>

Previously, skipped revisions should be passed like this:

$ git rev-list --bisect-skip=<rev1>,<rev2>,<rev3> ...

but there could be problems on systems where there is a tight limit
on command line lenght.

As the "--bisect-skip" option will be mostly used by porcelain
commands, and as the current "git-bisect.sh" porcelain does not use
stdin to pass good or bad revisions, it is acceptable to have
"--bisect-skip" now read skipped commits from stdin.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect-skip.c      |   19 +++++++++++++++++--
 bisect.h           |    2 +-
 builtin-rev-list.c |   11 ++++++++---
 git-bisect.sh      |    4 ++--
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/bisect-skip.c b/bisect-skip.c
index 789ee09..079e787 100644
--- a/bisect-skip.c
+++ b/bisect-skip.c
@@ -7,7 +7,8 @@ static unsigned char (*skipped_sha1)[20];
 static int skipped_sha1_nr;
 static int skipped_sha1_alloc;
 
-void register_skipped(const char *skipped)
+
+static void register_skipped(const char *skipped)
 {
 	struct strbuf sb, **list, **it, *cur;
 	int len = strlen(skipped);
@@ -15,7 +16,7 @@ void register_skipped(const char *skipped)
 	strbuf_init(&sb, len);
 	strbuf_add(&sb, skipped, len);
 
-	list = strbuf_split(&sb, ',', 0);
+	list = strbuf_split(&sb, ' ', 0);
 
 	for (it = list; (cur = *it); it++) {
 		ALLOC_GROW(skipped_sha1, skipped_sha1_nr + 1,
@@ -28,6 +29,20 @@ void register_skipped(const char *skipped)
 	strbuf_release(&sb);
 }
 
+void read_skipped_revisions_from_stdin(void)
+{
+	char line[1000];
+
+	while (fgets(line, sizeof(line), stdin) != NULL) {
+		int len = strlen(line);
+		if (len && line[len - 1] == '\n')
+			line[--len] = '\0';
+		if (!len)
+			break;
+		register_skipped(line);
+	}
+}
+
 int skipped_nr(void)
 {
 	return skipped_sha1_nr;
diff --git a/bisect.h b/bisect.h
index ff9c781..c41b568 100644
--- a/bisect.h
+++ b/bisect.h
@@ -1,7 +1,7 @@
 #ifndef BISECT_H
 #define BISECT_H
 
-void register_skipped(const char *skipped);
+void read_skipped_revisions_from_stdin(void);
 int skipped_nr(void);
 struct commit_list *filter_skipped(struct commit_list *list,
 				   struct commit_list **tried,
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 4af70d7..bf16197 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -334,16 +334,21 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			bisect_show_vars = 1;
 			continue;
 		}
-		if (!prefixcmp(arg, "--bisect-skip=")) {
+		if (!prefixcmp(arg, "--bisect-skip")) {
 			bisect_list = 1;
 			bisect_show_vars = 1;
-			bisect_skip = 1;
-			register_skipped(arg + 14);
+			if (bisect_skip++)
+				die("--bisect-skip given twice?");
+			if (read_from_stdin)
+				die("--bisect-skip cannot work with --stdin");
+			read_skipped_revisions_from_stdin();
 			continue;
 		}
 		if (!strcmp(arg, "--stdin")) {
 			if (read_from_stdin++)
 				die("--stdin given twice?");
+			if (bisect_skip)
+				die("--stdin cannot work with --bisect-skip");
 			read_revisions_from_stdin(&revs);
 			continue;
 		}
diff --git a/git-bisect.sh b/git-bisect.sh
index 31e7cff..da3c077 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -429,8 +429,8 @@ bisect_next() {
 	test "$?" -eq "1" && return
 
 	# Get bisection information
-	skip=$(echo $skip | tr ' ' ',')
-	eval="git rev-list --bisect-skip=$skip $good $bad --" &&
+	eval="echo $skip | tr ' ' '\012'" &&
+	eval="$eval | git rev-list --bisect-skip $good $bad --" &&
 	eval="$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
 	eval=$(eval_and_string_together "$eval") &&
 	eval "$eval" || exit
-- 
1.6.2.84.gcd0b4.dirty
