From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 06:33:48 +0900
Message-ID: <20090618063348.6117@nanako3.lavabit.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 23:34:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH2mH-0000gw-8X
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 23:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbZFQVec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 17:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbZFQVeb
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 17:34:31 -0400
Received: from karen.lavabit.com ([72.249.41.33]:59608 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758AbZFQVea (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 17:34:30 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id B3D1011B813;
	Wed, 17 Jun 2009 16:34:32 -0500 (CDT)
Received: from 8297.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id EWI6W1XHK2M1; Wed, 17 Jun 2009 16:34:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=IxvgF+pZLEU9Omlz7aBX3jJKSLSnw5/GOwJq3skhhlA+WPXWN4JMHzI8Ozs4cKTWRUY5G4yoIgL1o0tbvpkiVYrR6vvRBI5jzdjlx1ySShEHrI1PtRnjWCXfKG2212O9cC9wf+fpukfdAgg0Jq0+CeTo3WXUUES+qFXXQ/LQblk=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vvdmurfao.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121777>

When the commit log message begins with "squash to ...", and there
is a commit whose title begins with the same ..., automatically
modify the todo list of rebase -i so that the commit marked for
squashing come right after the commit to be modified, and change
the action of the moved commit from pick to squash.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

  Quoting Junio C Hamano <gitster@pobox.com>:

  I think you meant --amend, but it often happens to me that after preparing
  a three-patch series:
  
      [1/3] Clean up the surrounding code I will touch
      [2/3] Lay the groundwork
      [3/3] Implement a cool new feature
  
  I find that there are more clean-up that should have been done in [1/3].
  The way "rebase -i" expects me to work is:
  
      $ edit ;# more clean-ups
      $ git commit -a -m 'squash to "clean up"'
      $ git rebase -i HEAD~5
  
  which will give me
          
      pick 1/3 Clean up ...
      pick 2/3 Lay the groundwork
      pick 3/3 Implement
      pick 4/3 squash to "clean up"
  
  that I'll change to 
  
      pick 1/3 Clean up ...
      squash 4/3 squash to "clean up"
      pick 2/3 Lay the groundwork
      pick 3/3 Implement
  
  and then I'll need to edit the commit message for the first two combined.

How about this patch?  It does not let you say 'squash to "clean up"'
but other people who are more skillfull than me can enhance such details.

 git-rebase--interactive.sh   |   31 +++++++++++++++++++++++++++++++
 t/t3414-rebase-autosquash.sh |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100755 t/t3414-rebase-autosquash.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f96d887..0832164 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -482,6 +482,35 @@ get_saved_options () {
 	test -f "$DOTEST"/rebase-root && REBASE_ROOT=t
 }
 
+# Rearrange the todo list that has both "pick sha1 msg" and
+# "pick sha1 squash to msg" in it, so that the latter comes
+# immediately after the former, and change "pick" to "squash".
+rearrange_squash () {
+	sed -n -e 's/^pick \([0-9a-f]*\) squash to /\1 /p' "$1" >"$1.sq"
+	test -s "$1.sq" || return
+
+	used=
+	while read pick sha1 message
+	do
+		case " $used" in
+		*" $sha1 "*) continue ;;
+		esac
+		echo "$pick $sha1 $message"
+		while read squash msg
+		do
+			case "$message" in
+			"$msg"*)
+				echo "squash $squash to $msg"
+				used="$used$squash "
+				break
+				;;
+			esac
+		done <"$1.sq"
+	done <"$1" >"$1.rearranged"
+
+	cat "$1.rearranged" >"$1"
+}
+
 while test $# != 0
 do
 	case "$1" in
@@ -746,6 +776,7 @@ first and then run 'git rebase --continue' again."
 		fi
 
 		test -s "$TODO" || echo noop >> "$TODO"
+		rearrange_squash "$TODO"
 		cat >> "$TODO" << EOF
 
 # Rebase $SHORTREVISIONS onto $SHORTONTO
diff --git a/t/t3414-rebase-autosquash.sh b/t/t3414-rebase-autosquash.sh
new file mode 100755
index 0000000..ddb0daf
--- /dev/null
+++ b/t/t3414-rebase-autosquash.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='auto squash'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo 0 > file0
+	git add .
+	test_tick
+	git commit -m "initial commit"
+	echo 0 > file1
+	echo 2 > file2
+	git add .
+	test_tick
+	git commit -m "first commit"
+	echo 3 > file3
+	git add .
+	test_tick
+	git commit -m "second commit"
+'
+
+test_expect_success 'auto squash' '
+	echo 1 > file1
+	git add -u
+	test_tick
+	git commit -m "squash to first"
+	git tag final
+	test_tick
+	git rebase -i HEAD^^^
+	git log --oneline >actual
+	test 3 = $(wc -l <actual) &&
+	git diff --exit-code final
+'
+
+test_done
-- 
1.6.2.GIT

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
