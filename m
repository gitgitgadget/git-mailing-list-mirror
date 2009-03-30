From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] bisect--helper: string output variables together with
 "&&"
Date: Mon, 30 Mar 2009 06:59:59 +0200
Message-ID: <20090330065959.98ff9e5e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 07:02:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo9dx-0004Hu-Nl
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbZC3FBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 01:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbZC3FBI
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:01:08 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36738 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600AbZC3FBG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 01:01:06 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 82D3F81805F;
	Mon, 30 Mar 2009 07:00:55 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with SMTP id 32B288180D5;
	Mon, 30 Mar 2009 07:00:53 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115068>

When doing:

eval "git bisect--helper --next-vars" | {
        while read line
        do
                echo "$line &&"
        done
        echo ':'
}

the result code comes from the last "echo ':'", not from running
"git bisect--helper --next-vars".

This patch get rid of the need to string the line from the output
of "git bisect--helper" by making "git bisect--helper --next-vars"
return output variables stringed together with "&&".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c           |    3 ++-
 bisect.h           |    1 +
 builtin-rev-list.c |   29 +++++++++++++++++++----------
 git-bisect.sh      |   15 +--------------
 4 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/bisect.c b/bisect.c
index 64a5ad5..df0ab4d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -554,5 +554,6 @@ int bisect_next_vars(const char *prefix)
 	revs.commits = find_bisection(revs.commits, &reaches, &all,
 				      !!skipped_sha1_nr);
 
-	return show_bisect_vars(&revs, reaches, all, SHOW_TRIED);
+	return show_bisect_vars(&revs, reaches, all,
+				SHOW_TRIED | SHOW_STRINGED);
 }
diff --git a/bisect.h b/bisect.h
index 4cff2ba..2e4b2af 100644
--- a/bisect.h
+++ b/bisect.h
@@ -12,6 +12,7 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
 /* show_bisect_vars flags */
 #define SHOW_ALL	1
 #define SHOW_TRIED	2
+#define SHOW_STRINGED	4
 
 /*
  * The flag SHOW_ALL should not be set if this function is called
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index c1c4a18..330f7f0 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -226,20 +226,20 @@ static int estimate_bisect_steps(int all)
 	return (e < 3 * x) ? n : n - 1;
 }
 
-static void show_tried_revs(struct commit_list *tried)
+static void show_tried_revs(struct commit_list *tried, int stringed)
 {
 	printf("bisect_tried='");
 	for (;tried; tried = tried->next) {
 		char *format = tried->next ? "%s|" : "%s";
 		printf(format, sha1_to_hex(tried->item->object.sha1));
 	}
-	printf("'\n");
+	printf(stringed ? "' &&\n" : "'\n");
 }
 
 int show_bisect_vars(struct rev_info *revs, int reaches, int all, int flags)
 {
 	int cnt;
-	char hex[41] = "";
+	char hex[41] = "", *format;
 	struct commit_list *tried;
 
 	if (!revs->commits && !(flags & SHOW_TRIED))
@@ -269,13 +269,22 @@ int show_bisect_vars(struct rev_info *revs, int reaches, int all, int flags)
 	}
 
 	if (flags & SHOW_TRIED)
-		show_tried_revs(tried);
-	printf("bisect_rev=%s\n"
-	       "bisect_nr=%d\n"
-	       "bisect_good=%d\n"
-	       "bisect_bad=%d\n"
-	       "bisect_all=%d\n"
-	       "bisect_steps=%d\n",
+		show_tried_revs(tried, flags & SHOW_STRINGED);
+	format = (flags & SHOW_STRINGED) ?
+		"bisect_rev=%s &&\n"
+		"bisect_nr=%d &&\n"
+		"bisect_good=%d &&\n"
+		"bisect_bad=%d &&\n"
+		"bisect_all=%d &&\n"
+		"bisect_steps=%d\n"
+		:
+		"bisect_rev=%s\n"
+		"bisect_nr=%d\n"
+		"bisect_good=%d\n"
+		"bisect_bad=%d\n"
+		"bisect_all=%d\n"
+		"bisect_steps=%d\n";
+	printf(format,
 	       hex,
 	       cnt - 1,
 	       all - reaches - 1,
diff --git a/git-bisect.sh b/git-bisect.sh
index 0f7590d..5074dda 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -279,18 +279,6 @@ bisect_auto_next() {
 	bisect_next_check && bisect_next || :
 }
 
-eval_and_string_together() {
-	_eval="$1"
-
-	eval "$_eval" | {
-		while read line
-		do
-			echo "$line &&"
-		done
-		echo ':'
-	}
-}
-
 exit_if_skipped_commits () {
 	_tried=$1
 	_bad=$2
@@ -429,8 +417,7 @@ bisect_next() {
 	test "$?" -eq "1" && return
 
 	# Get bisection information
-	eval="git bisect--helper --next-vars" &&
-	eval=$(eval_and_string_together "$eval") &&
+	eval=$(eval "git bisect--helper --next-vars") &&
 	eval "$eval" || exit
 
 	if [ -z "$bisect_rev" ]; then
-- 
1.6.2.1.404.gb0085.dirty
