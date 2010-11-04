From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH 2/2] rebase: teach --autosquash to match on sha1 in addition to message
Date: Wed,  3 Nov 2010 19:41:44 -0700
Message-ID: <1288838504-69114-2-git-send-email-kevin@sb.org>
References: <1288838504-69114-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 03:42:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDpm6-00066a-KL
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 03:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027Ab0KDCl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 22:41:57 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61896 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938Ab0KDClz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 22:41:55 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so88034pwj.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 19:41:55 -0700 (PDT)
Received: by 10.142.187.20 with SMTP id k20mr56631wff.409.1288838515251;
        Wed, 03 Nov 2010 19:41:55 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id e36sm14620504wfj.14.2010.11.03.19.41.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 19:41:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.201.g24941.dirty
In-Reply-To: <1288838504-69114-1-git-send-email-kevin@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160680>

Support lines of the form "fixup! 7a235b" that specify an exact commit
in addition to the normal "squash! Old commit message" form.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
I chose 4 characters as the restriction because that's the minimum number
that `git rev-parse --short=<n>` will emit.

 git-rebase--interactive.sh   |   13 +++++++++----
 t/t3415-rebase-autosquash.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 379bbac..9121bb6 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -693,12 +693,17 @@ rearrange_squash () {
 			case " $used" in
 			*" $squash "*) continue ;;
 			esac
-			case "$message" in
-			"$msg"*)
+			emit=0
+			case "$message" in "$msg"*) emit=1;; esac
+			if test $emit != 1; then
+				case "$sha1" in "$msg"*) emit=1;; esac
+				# ensure the message is at least 4 characters long
+				case "$msg" in ????*);; *) emit=0;; esac
+			fi
+			if test $emit = 1; then
 				printf '%s\n' "$action $squash $action! $msg"
 				used="$used$squash "
-				;;
-			esac
+			fi
 		done <"$1.sq"
 	done >"$1.rearranged" <"$1"
 	cat "$1.rearranged" >"$1"
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 712bbe8..14cdbeb 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -136,5 +136,38 @@ test_expect_success 'auto squash that matches a commit after the squash' '
 	test 1 = $(git cat-file commit HEAD | grep third | wc -l) &&
 	test 1 = $(git cat-file commit HEAD^ | grep third | wc -l)
 '
+test_expect_success 'auto squash that matches a sha1' '
+	git reset --hard base &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "squash! $(git rev-parse --short HEAD^)" &&
+	git tag final-shasquash &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	test 3 = $(wc -l <actual) &&
+	git diff --exit-code final-shasquash &&
+	test 1 = "$(git cat-file blob HEAD^:file1)" &&
+	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
+'
+
+# this test just ensures that < 4 characters can't match a sha1
+test_expect_success 'auto squash that accidentally matches a sha1' '
+	git reset --hard base &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "squash! $(git rev-parse HEAD^ | cut -c 1-3)" &&
+	git tag final-badshasquash &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	test 4 = $(wc -l <actual) &&
+	git diff --exit-code final-badshasquash &&
+	test 0 = "$(git cat-file blob HEAD^^:file1)" &&
+	test 0 = $(git cat-file commit HEAD^^ | grep squash | wc -l) &&
+	test 1 = $(git cat-file commit HEAD | grep squash | wc -l)
+'
 
 test_done
-- 
1.7.3.2.201.g24941.dirty
