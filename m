From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] git-grep: convert from bash to sh
Date: Sun, 18 Dec 2005 15:26:39 +0200
Message-ID: <20051218152639.5c14bc26.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 14:28:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnyZ7-0001RK-CB
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 14:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbVLRN0t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 08:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbVLRN0t
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 08:26:49 -0500
Received: from marski.suomi.net ([212.50.131.142]:23957 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S932701AbVLRN0t (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 08:26:49 -0500
Received: from spartak.suomi.net (spartak.suomi.net [212.50.140.227])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IRP00EDN40IYY30@marski.suomi.net> for git@vger.kernel.org;
 Sun, 18 Dec 2005 15:26:43 +0200 (EET)
Received: from spam2.suomi.net (spam2.suomi.net [212.50.131.166])
 by mailstore.suomi.net
 (Sun Java System Messaging Server 6.2-3.04 (built Jul 15 2005))
 with ESMTP id <0IRP0076R46ILQ40@mailstore.suomi.net>; Sun,
 18 Dec 2005 15:30:19 +0200 (EET)
Received: from garlic.home.net (addr-82-128-203-211.suomi.net [82.128.203.211])
	by spam2.suomi.net (Postfix) with SMTP id 0EB877047; Sun,
 18 Dec 2005 15:26:39 +0200 (EET)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.344,	required 5,
 autolearn=not spam, AWL 0.26, BAYES_00 -2.60)
X-OPOY-MailScanner-From: tihirvon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13793>


sh does not support arrays so we have to use eval instead.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>

---

 git-grep.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

11c29a066288c5f05a67ff0d46e9ce17cd7a37da
diff --git a/git-grep.sh b/git-grep.sh
index 2ed8e95..2f0a297 100755
--- a/git-grep.sh
+++ b/git-grep.sh
@@ -8,21 +8,21 @@ SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
 pattern=
-flags=()
-git_flags=()
+flags=
+git_flags=
 while : ; do
 	case "$1" in
 	--cached|--deleted|--others|--killed|\
 	--ignored|--exclude=*|\
 	--exclude-from=*|\--exclude-per-directory=*)
-		git_flags=("${git_flags[@]}" "$1")
+		git_flags="$git_flags '$1'"
 		;;
 	-e)
 		pattern="$2"
 		shift
 		;;
 	-A|-B|-C|-D|-d|-f|-m)
-		flags=("${flags[@]}" "$1" "$2")
+		flags="$flags '$1' '$2'"
 		shift
 		;;
 	--)
@@ -31,7 +31,7 @@ while : ; do
 		break
 		;;
 	-*)
-		flags=("${flags[@]}" "$1")
+		flags="$flags '$1'"
 		;;
 	*)
 		if [ -z "$pattern" ]; then
@@ -46,5 +46,5 @@ done
 [ "$pattern" ] || {
 	usage
 }
-git-ls-files -z "${git_flags[@]}" "$@" |
-	xargs -0 grep "${flags[@]}" -e "$pattern"
+eval git-ls-files -z "$git_flags" '"$@"' |
+	eval xargs -0 grep "$flags" -e '"$pattern"'
-- 
0.99.9.GIT
