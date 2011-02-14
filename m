From: Mike Galbraith <mgalbraith@suse.de>
Subject: [PATCH] guilt: improve patch header handling
Date: Mon, 14 Feb 2011 05:55:03 +0100
Message-ID: <1297659303.7999.28.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 14 05:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoqSx-0005kW-Lx
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 05:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470Ab1BNEzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 23:55:09 -0500
Received: from cantor2.suse.de ([195.135.220.15]:36916 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094Ab1BNEzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 23:55:07 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 2CED787567;
	Mon, 14 Feb 2011 05:55:06 +0100 (CET)
X-Mailer: Evolution 2.30.1.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166688>

Greetings,

Below is a hacklet which made guilt more useful for my workflow.
Entirely disposable, just sharing.

	-Mike

Teach guilt to handle patch header Date Author AuthorDate etc lines,
to deal properly with git commits and tip-bot patches.  Previously,
a Date line in the patch header was emitted into the commit message
body, which seems to confuse git format-patch.

With this applied, git log emits..
   commit 40298016b331950394a4d6e12909506afc3cf54b
   Author: Mike Galbraith <efault@gmx.de>
   Date:   Sun Feb 13 07:16:35 2011 +0100
..and gitk
   Author: Mike Galbraith <efault@gmx.de>  2011-02-13 07:16:35
   Committer: Mike Galbraith <mgalbraith@suse.de>  2011-02-14 05:09:05
..and git format-patch
   From 40298016b331950394a4d6e12909506afc3cf54b Mon Sep 17 00:00:00 2001
   From: Mike Galbraith <efault@gmx.de>
   Date: Sun, 13 Feb 2011 07:16:35 +0100
   Subject: [PATCH] guilt: improve patch header handling

Whereas previously, git log emitted..
   commit 19e82183944cb645bb8f1f4c2fbcd3ee99698b05
   Author: Mike Galbraith <efault@gmx.de>
   Date:   Mon Feb 14 05:24:10 2011 +0100  <== commit date

   guilt: improve patch header handling
   Date: Sun Feb 13 07:16:35 CET 2011  <== lands between subject and body
and gitk...
   Author: Mike Galbraith <efault@gmx.de>  2011-02-14 05:24:10  <== authordate wrong
   Committer: Mike Galbraith <mgalbraith@suse.de>  2011-02-14 05:24:10
and git format-patch
   From 19e82183944cb645bb8f1f4c2fbcd3ee99698b05 Mon Sep 17 00:00:00 2001
   From: Mike Galbraith <efault@gmx.de>
   Date: Mon, 14 Feb 2011 05:24:10 +0100
   Subject: [PATCH] guilt: improve patch header handling
    Date: Sun Feb 13 07:16:35 CET 2011  <== lands in subject when imported into evolution

Signed-off-by: Mike Galbraith <efault@gmx.de>
Cc: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt |   54 +++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/guilt b/guilt
index ec4fb04..875fc06 100755
--- a/guilt
+++ b/guilt
@@ -342,17 +342,24 @@ BEGIN{}
 # usage: do_get_header patchfile
 do_get_header()
 {
-	# The complexity arises from the fact that we want to ignore the
-	# From line and the empty line after it if it exists
-
-	# 2nd line skips the From line
-	# 3rd line skips the empty line right after a From line
-	# 4th line terminates execution when we encounter the diff
+	# The complexity arises from the fact that we want to ignore all
+	# but the Subject line of the header, and any empty lines after it,
+	# if these exist, and inject only the Subject line as the first
+	# line of the commit message.
+
+	# 1st line prints first encountered Subject line plus empty line.
+	# 2nd line skips standard email/git patch header lines.
+	# 3rd line skips tip's additional header lines.
+	# 4th line skips any empty lines thereafter.
+	# 5th line turns off empty line skip upon seeing a non-empty line.
+	# 6th line terminates execution when we encounter the diff
 	cat "$1" | awk '
-BEGIN{skip=0}
-/^Subject:/ && (NR==1){print substr($0, 10); next}
-/^From:/{skip=1; next}
-/^[ \t\f\n\r\v]*$/ && (skip==1){skip=0; next}
+BEGIN{body=0; subj=0}
+/^Subject:/ && (body == 0 && subj == 0){subj=1; print substr($0, 10) "\n"; next}
+/^(Subject:|From:|Author:|Date:|commit)/ && (body == 0){next}
+/^(Commit-ID:|Gitweb:|AuthorDate:|Committer:CommitDate:)/ && (body == 0){next}
+/^[ \t\f\n\r\v]*$/ && (body==0){next}
+/^.*$/ && (body==0){body=1}
 /^(diff |---$|--- )/{exit}
 {print $0}
 END{}
@@ -526,13 +533,26 @@ commit()
 		# make a default commit message if patch doesn't contain one
 		[ ! -s "$TMP_MSG" ] && echo "patch $pname" > "$TMP_MSG"
 
-		# extract a From line from the patch header, and set
-		# GIT_AUTHOR_{NAME,EMAIL}
-		author_str=`sed -n -e '/^From:/ { s/^From: //; p; q; }; /^(diff |---$|--- )/ q' "$p"`
+		# extract author and date lines from the patch header, and set
+		# GIT_AUTHOR_{NAME,EMAIL,DATE}
+		# prefering Author/AuthorDate lines if available.
+		author_str=`sed -n -e '/^Author:/ { s/^Author: //; p; q; }; /^(diff |---$|--- )/ q' "$p"`
+		if [ -z "$author_str" ]; then
+			author_str=`sed -n -e '/^From:/ { s/^From: //; p; q; }; /^(diff |---$|--- )/ q' "$p"`
+		fi
+
 		if [ ! -z "$author_str" ]; then
 			GIT_AUTHOR_NAME=`echo $author_str | sed -e 's/ *<.*$//'`
 			export GIT_AUTHOR_NAME="${GIT_AUTHOR_NAME:-" "}"
                         export GIT_AUTHOR_EMAIL="`echo $author_str | sed -e 's/[^<]*//'`"
+
+			author_date_str=`sed -n -e '/^AuthorDate:/ { s/^AuthorDate: //; p; q; }; /^(diff |---$|--- )/ q' "$p"`
+			if [ -z "$author_date_str" ]; then
+				author_date_str=`sed -n -e '/^Date:/ { s/^Date: //; p; q; }; /^(diff |---$|--- )/ q' "$p"`
+			fi
+			if [ ! -z "$author_date_str" ]; then
+				export GIT_AUTHOR_DATE=`echo $author_date_str`
+			fi
 		fi
 
 		ct=`git log -1 --pretty=%ct`
@@ -549,9 +569,13 @@ commit()
 		# confused, and makes up strange timestamps from the past
 		# (chances are it decides to interpret it as a unix
 		# timestamp).
-		export GIT_AUTHOR_DATE="`stat -c %y "$p" | sed -e '
+		export GIT_COMMITTER_DATE="`stat -c %y "$p" | sed -e '
 s/^\([0-9]\{4\}\)-\([0-9]\{2\}\)-\([0-9]\{2\}\) \([0-9]\{2\}\):\([0-9]\{2\}\):\([0-9]\{2\}\)\.[0-9]* \(.*\)$/\1-\2-\3 \4:\5:\6 \7/'`"
-		export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
+
+		# export GIT_AUTHOR_DATE only if a Date line was unavailable
+		if [ -z "$author_date_str" ]; then
+			export GIT_AUTHOR_DATE="$GIT_COMMITTER_DATE"
+		fi
 
 		# commit
 		treeish=`git write-tree`
-- 
1.7.4
