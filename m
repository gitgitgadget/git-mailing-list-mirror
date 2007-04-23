From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH] git-fetch: Fix Argument list too long
Date: Tue, 24 Apr 2007 04:26:26 +0900
Message-ID: <87wt02nb8d.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 21:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg4M7-00064e-PP
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 21:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161488AbXDWThp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 15:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161490AbXDWThp
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 15:37:45 -0400
Received: from mail.parknet.jp ([210.171.160.80]:4286 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161488AbXDWTho (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 15:37:44 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Apr 2007 15:37:43 EDT
X-AuthUser: hirofumi@parknet.jp
Received: from ibmpc.myhome.or.jp ([210.171.168.39]:1995)
	by parknet.jp with [XMail 1.21 ESMTP Server]
	id <S12BB4> for <git@vger.kernel.org> from <hirofumi@mail.parknet.co.jp>;
	Tue, 24 Apr 2007 04:29:26 +0900
Received: from duaron.myhome.or.jp (root@duaron.myhome.or.jp [192.168.0.2])
	by ibmpc.myhome.or.jp (8.13.8/8.13.8/Debian-3) with ESMTP id l3NJRR71013489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 24 Apr 2007 04:27:29 +0900
Received: from duaron.myhome.or.jp (hirofumi@localhost [127.0.0.1])
	by duaron.myhome.or.jp (8.13.8/8.13.8/Debian-3) with ESMTP id l3NJRRhH001048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 24 Apr 2007 04:27:27 +0900
Received: (from hirofumi@localhost)
	by duaron.myhome.or.jp (8.13.8/8.13.8/Submit) id l3NJQRSe029725;
	Tue, 24 Apr 2007 04:26:27 +0900
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.98 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45355>

If $ls_remote_result was too long,

    git-fetch--tool -s pick-rref "$rref" "$ls_remote_result"

in git-fetch will fail by "Argument list too long".

This patch fixes git-fetch--tool and git-fetch by reading
$ls_remote_result from stdin.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 builtin-fetch--tool.c |    6 +++++-
 git-fetch.sh          |   11 ++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index be341c1..3145c01 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -571,9 +571,13 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 		return parse_reflist(reflist);
 	}
 	if (!strcmp("pick-rref", argv[1])) {
+		const char *ls_remote_result;
 		if (argc != 4)
 			return error("pick-rref takes 2 args");
-		return pick_rref(sopt, argv[2], argv[3]);
+		ls_remote_result = argv[3];
+		if (!strcmp(ls_remote_result, "-"))
+			ls_remote_result = get_stdin();
+		return pick_rref(sopt, argv[2], ls_remote_result);
 	}
 	if (!strcmp("expand-refs-wildcard", argv[1])) {
 		const char *reflist;
diff --git a/git-fetch.sh b/git-fetch.sh
index 832b20c..ea3c20d 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -189,8 +189,8 @@ fetch_all_at_once () {
 			# See if all of what we are going to fetch are
 			# connected to our repository's tips, in which
 			# case we do not have to do any fetch.
-			theirs=$(git-fetch--tool -s pick-rref \
-					"$rref" "$ls_remote_result") &&
+			theirs=$(echo "$ls_remote_result" | \
+				git-fetch--tool -s pick-rref "$rref" "-") &&
 
 			# This will barf when $theirs reach an object that
 			# we do not have in our repository.  Otherwise,
@@ -198,7 +198,8 @@ fetch_all_at_once () {
 			git-rev-list --objects $theirs --not --all \
 				>/dev/null 2>/dev/null
 		then
-			git-fetch--tool pick-rref "$rref" "$ls_remote_result"
+			echo "$ls_remote_result" | \
+				git-fetch--tool pick-rref "$rref" "-"
 		else
 			git-fetch-pack --thin $exec $keep $shallow_depth \
 				$quiet $no_progress "$remote" $rref ||
@@ -263,8 +264,8 @@ fetch_per_ref () {
 	  fi
 
 	  # Find $remote_name from ls-remote output.
-	  head=$(git-fetch--tool -s pick-rref \
-			"$remote_name" "$ls_remote_result")
+	  head=$(echo "$ls_remote_result" | \
+	  	git-fetch--tool -s pick-rref "$remote_name" "-")
 	  expr "z$head" : "z$_x40\$" >/dev/null ||
 		die "No such ref $remote_name at $remote"
 	  echo >&2 "Fetching $remote_name from $remote using $proto"
-- 
1.5.2.rc0.1.g2cc31-dirty
