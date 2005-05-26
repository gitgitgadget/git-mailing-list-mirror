From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add git-external-diff-script
Date: Thu, 26 May 2005 02:31:05 -0700
Message-ID: <7vll62cp0m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 11:30:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbEgJ-0001F2-0h
	for gcvg-git@gmane.org; Thu, 26 May 2005 11:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVEZJbR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 05:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVEZJbR
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 05:31:17 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:44195 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261235AbVEZJbH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 05:31:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526093106.QWLD8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 05:31:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a demonstration of GIT_EXTERNAL_DIFF mechanism, and a
testbed for tweaking and enhancing what the built-in diff should
do.  This script is designed to output exactly the same output
as what the built-in diff driver produces when used as the
GIT_EXTERNAL_DIFF command.

I've run this and updated built-in diff on the entire history of
linux-2.6 git repository, and JG's udev.git repository which has
interesting symlink cases to make sure it is equivalent to the
built-in diff driver.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

git-external-diff-script |   67 +++++++++++++++++++++++++++++++++++++++++++++++
1 files changed, 67 insertions(+)
new file (100755): git-external-diff-script

diff --git a/git-external-diff-script b/git-external-diff-script
new file mode 100755
--- /dev/null
+++ b/git-external-diff-script
@@ -0,0 +1,67 @@
+#!/bin/sh
+# Copyright (C) 2005 Junio C Hamano
+#
+# This script is designed to emulate what the built-in diff driver
+# does when set as GIT_EXTERNAL_SCRIPT.
+
+case "$#" in
+1)
+    echo "* Unmerged path $1"
+    exit 0 ;;
+*)
+    name1="$1" tmp1="$2" hex1="$3" mode1="$4" tmp2="$5" hex2="$6" mode2="$7"
+    case "$#" in
+    7)
+	name2="$name1" ;;
+    9)
+	name2="$8" xfrm_msg="$9" ;;
+    esac ;;	
+esac
+
+show_create () {
+    name_="$1" tmp_="$2" hex_="$3" mode_="$4"
+    echo "diff --git a/$name_ b/$name_"
+    echo "new file mode $mode_"
+    diff ${GIT_DIFF_OPTS-'-pu'} -L /dev/null -L "b/$name_" /dev/null "$tmp_"
+}
+
+show_delete () {
+    name_="$1" tmp_="$2" hex_="$3" mode_="$4"
+    echo "diff --git a/$name_ b/$name_"
+    echo "deleted file mode $mode_"
+    diff ${GIT_DIFF_OPTS-'-pu'} -L "a/$name_" -L /dev/null "$tmp_" /dev/null
+}
+
+case "$mode1" in
+120*) type1=l ;;
+100*) type1=f ;;
+.)    show_create "$name2" "$tmp2" "$hex2" "$mode2"
+      exit 0 ;;
+esac
+case "$mode2" in
+120*) type2=l ;;
+100*) type2=f ;;
+.)    show_delete "$name1" "$tmp1" "$hex1" "$mode1"
+      exit 0 ;;
+esac
+
+if test "$type1" != "$type2"
+then
+	show_delete "$name1" "$tmp1" "$hex1" "$mode1"
+	show_create "$name2" "$tmp2" "$hex2" "$mode2"
+	exit 0
+fi
+
+echo diff --git "a/$name1" "b/$name2"
+if test "$mode1" != "$mode2"
+then
+    echo "old mode $mode1"
+    echo "new mode $mode2"
+    if test "$xfrm_msg" != ""
+    then
+	echo -n $xfrm_msg
+    fi
+fi
+diff ${GIT_DIFF_OPTS-'-pu'} -L "a/$name1" -L "b/$name2" "$tmp1" "$tmp2"
+exit 0
+
------------------------------------------------

