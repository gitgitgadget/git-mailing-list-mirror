From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rebase: allow a hook to refuse rebasing.
Date: Mon, 13 Feb 2006 23:53:14 -0800
Message-ID: <7v1wy6tlzp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 14 08:53:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8v0D-0001U2-GL
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 08:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWBNHxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 02:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbWBNHxR
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 02:53:17 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:6840 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030423AbWBNHxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 02:53:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214075153.NQSA20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 02:51:53 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16130>

This lets a hook to interfere a rebase and help prevent certain
branches from being rebased by mistake.  A sample hook to show
how to prevent a topic branch that has already been merged into
publish branch.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This was done while switching my workflow to more stable
   "next".  A companion script which is more private nature is
   in the TODO branch, file TO.  I use that one to manage the
   "next" branch, and this sample hook prevents me from rebasing
   topic branches too eagerly by mistake.

 git-rebase.sh               |    9 +++
 templates/hooks--pre-rebase |  150 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+), 0 deletions(-)
 create mode 100644 templates/hooks--pre-rebase

9a111c91b01455ee1ea9f33c60da7ad50d460a7b
diff --git a/git-rebase.sh b/git-rebase.sh
index 16d4359..f84160d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -36,6 +36,15 @@ other=$(git-rev-parse --verify "$1^0") |
 # Make sure the branch to rebase is valid.
 head=$(git-rev-parse --verify "${2-HEAD}^0") || exit
 
+# If a hook exists, give it a chance to interrupt
+if test -x "$GIT_DIR/hooks/pre-rebase"
+then
+	"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} || {
+		echo >&2 "The pre-rebase hook refused to rebase."
+		exit 1
+	}
+fi
+
 # If the branch to rebase is given, first switch to it.
 case "$#" in
 2)
diff --git a/templates/hooks--pre-rebase b/templates/hooks--pre-rebase
new file mode 100644
index 0000000..981c454
--- /dev/null
+++ b/templates/hooks--pre-rebase
@@ -0,0 +1,150 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Junio C Hamano
+#
+
+publish=next
+basebranch="$1"
+if test "$#" = 2
+then
+	topic="refs/heads/$2"
+else
+	topic=`git symbolic-ref HEAD`
+fi
+
+case "$basebranch,$topic" in
+master,refs/heads/??/*)
+	;;
+*)
+	exit 0 ;# we do not interrupt others.
+	;;
+esac
+
+# Now we are dealing with a topic branch being rebased
+# on top of master.  Is it OK to rebase it?
+
+# Is topic fully merged to master?
+not_in_master=`git-rev-list --pretty=oneline ^master "$topic"`
+if test -z "$not_in_master"
+then
+	echo >&2 "$topic is fully merged to master; better remove it."
+	exit 1 ;# we could allow it, but there is no point.
+fi
+
+# Is topic ever merged to next?  If so you should not be rebasing it.
+only_next_1=`git-rev-list ^master "^$topic" ${publish} | sort`
+only_next_2=`git-rev-list ^master           ${publish} | sort`
+if test "$only_next_1" = "$only_next_2"
+then
+	not_in_topic=`git-rev-list "^$topic" master`
+	if test -z "$not_in_topic"
+	then
+		echo >&2 "$topic is already up-to-date with master"
+		exit 1 ;# we could allow it, but there is no point.
+	else
+		exit 0
+	fi
+else
+	not_in_next=`git-rev-list --pretty=oneline ^${publish} "$topic"`
+	perl -e '
+		my $topic = $ARGV[0];
+		my $msg = "* $topic has commits already merged to public branch:\n";
+		my (%not_in_next) = map {
+			/^([0-9a-f]+) /;
+			($1 => 1);
+		} split(/\n/, $ARGV[1]);
+		for my $elem (map {
+				/^([0-9a-f]+) (.*)$/;
+				[$1 => $2];
+			} split(/\n/, $ARGV[2])) {
+			if (!exists $not_in_next{$elem->[0]}) {
+				if ($msg) {
+					print STDERR $msg;
+					undef $msg;
+				}
+				print STDERR " $elem->[1]\n";
+			}
+		}
+	' "$topic" "$not_in_next" "$not_in_master"
+	exit 1
+fi
+
+exit 0
+
+################################################################
+
+This sample hook safeguards topic branches that have been
+published from being rewound.
+
+The workflow assumed here is:
+
+ * Once a topic branch forks from "master", "master" is never
+   merged into it again (either directly or indirectly).
+
+ * Once a topic branch is fully cooked and merged into "master",
+   it is deleted.  If you need to build on top of it to correct
+   earlier mistakes, a new topic branch is created by forking at
+   the tip of the "master".  This is not strictly necessary, but
+   it makes it easier to keep your history simple.
+
+ * Whenever you need to test or publish your changes to topic
+   branches, merge them into "next" branch.
+
+The script, being an example, hardcodes the publish branch name
+to be "next", but it is trivial to make it configurable via
+$GIT_DIR/config mechanism.
+
+With this workflow, you would want to know:
+
+(1) ... if a topic branch has ever been merged to "next".  Young
+    topic branches can have stupid mistakes you would rather
+    clean up before publishing, and things that have not been
+    merged into other branches can be easily rebased without
+    affecting other people.  But once it is published, you would
+    not want to rewind it.
+
+(2) ... if a topic branch has been fully merged to "master".
+    Then you can delete it.  More importantly, you should not
+    build on top of it -- other people may already want to
+    change things related to the topic as patches against your
+    "master", so if you need further changes, it is better to
+    fork the topic (perhaps with the same name) afresh from the
+    tip of "master".
+
+Let's look at this example:
+
+		   o---o---o---o---o---o---o---o---o---o "next"
+		  /       /           /           /
+		 /   a---a---b A     /           /
+		/   /               /           /
+	       /   /   c---c---c---c B         /
+	      /   /   /             \         /
+	     /   /   /   b---b C     \       /
+	    /   /   /   /             \     /
+    ---o---o---o---o---o---o---o---o---o---o---o "master"
+
+
+A, B and C are topic branches.
+
+ * A has one fix since it was merged up to "next".
+
+ * B has finished.  It has been fully merged up to "master" and "next",
+   and is ready to be deleted.
+
+ * C has not merged to "next" at all.
+
+We would want to allow C to be rebased, refuse A, and encourage
+B to be deleted.
+
+To compute (1):
+
+	git-rev-list ^master ^topic next
+	git-rev-list ^master        next
+
+	if these match, topic has not merged in next at all.
+
+To compute (2):
+
+	git-rev-list master..topic
+
+	if this is empty, it is fully merged to "master".
-- 
1.2.0.g45dc
