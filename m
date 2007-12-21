From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: [PATCH] Make "git stash" configurable
Date: Fri, 21 Dec 2007 19:22:20 +0900
Message-ID: <200712211026.lBLAQWWM014059@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 11:22:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5f1q-0001Di-PT
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 11:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbXLUKWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 05:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbXLUKWa
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 05:22:30 -0500
Received: from mi0.bluebottle.com ([206.188.25.15]:36067 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbXLUKW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 05:22:29 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id lBLAQWWM014059
	for <git@vger.kernel.org>; Fri, 21 Dec 2007 02:26:32 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=L9aolUSfqRobt7xQbu67x6ef2dDDwam74e2RwbMZpwBHC91lDNEX8XKejlU6IJ5jh
	NaOgCOljbIbA/WCvGCecA8+2DtKHi/mlV/5Cp43HENZXvIKc2yNN/rtsbPXgeW7
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id lBLAMMLY032335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Dec 2007 02:22:26 -0800
X-Trusted-Delivery: <998d63d56291a8fd7574a7324aa5f57d>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69051>

"git stash" without argument originally created an unnamed
stash, but some people felt this can be confusing to new
users.  This introduces per-user config variable stash.quick to
control this behavior.

The variable can take one of three values: true, false, ask.

When set to "true", the command allows to create a quick
stash without any user interaction.  When set to "false",
the command shows the list of stash instead.  When set to
"ask", the command asks the user.

For the first time users, when the variable is not set,
the command helps the user to set it interactively.

Signed-off-by: Nanako Shiraishi <nanako3@bluebottle.com>
---
 Documentation/git-stash.txt |   17 +++++++++-
 git-stash.sh                |   72 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index c0147b9..5d39da2 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -22,11 +22,24 @@ and reverts the working directory to match the `HEAD` commit.
 The modifications stashed away by this command can be listed with
 `git-stash list`, inspected with `git-stash show`, and restored
 (potentially on top of a different commit) with `git-stash apply`.
-Calling git-stash without any arguments is equivalent to `git-stash
-save`.  A stash is by default listed as "WIP on 'branchname' ...", but
+A stash is by default listed as "WIP on 'branchname' ...", but
 you can give a more descriptive message on the command line when
 you create one.
 
+Calling git-stash without any arguments is equivalent to `git-stash
+save` when the command is run non-interactively.  When running
+interactively, the value of the `stash.quick` configuration
+variable in `$HOME/.gitconfig` determines what happens.
+
+ - If `stash.quick` is set to `true`, a stash without message is
+   created.
+
+ - If `stash.quick` is set to `false`, it shows the list of
+   stash, without creating a new one.
+
+ - If `stash.quick` is set to `ask`, the user is asked which
+   behavior is desired.
+
 The latest stash you created is stored in `$GIT_DIR/refs/stash`; older
 stashes are found in the reflog of this reference and can be named using
 the usual reflog syntax (e.g. `stash@\{0}` is the most recently
diff --git a/git-stash.sh b/git-stash.sh
index f16fd9c..b6223bd 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -192,6 +192,69 @@ apply_stash () {
 	fi
 }
 
+allow_quick_stash () {
+
+	quick=$(git config --global stash.quick)
+	if test $? != 0
+	then
+		if ! test -t 0 || ! test -t 1
+		then
+			return 0
+		fi
+
+		echo '
+*** First time users ***
+
+"git stash" can create an unnamed stash entry without user interaction.
+This is a quick way to save away your work in progress.  Some people
+find this behaviour confusing or dangerous to new users.  You can
+configure the command to list the existing stash entries instead.'
+
+		while :
+		do
+			echo '
+Do you want the command without argument to always...
+
+1. Ask for confirmation
+2. Create an unnamed stash
+3. List existing stash entries
+'
+			printf 'Which one? [1/2/3] '
+			read reply
+			quick=
+			case "$reply" in
+			1|A*)	quick=ask ;;
+			2|C*)	quick=true ;;
+			3|L*)	quick=false ;;
+			*)	continue ;;
+			esac
+			break
+		done
+		git config --global stash.quick $quick
+		echo '
+You can reconfigure this by editing your $HOME/.gitconfig file'
+
+	fi
+
+	case "$quick" in
+	true)	return 0 ;;
+	false)	return 1 ;;
+	ask)	: do not return ;;
+	esac
+
+	if ! test -t 0 || ! test -t 1
+	then
+		return 0
+	fi
+
+	printf 'Do you want to create an unnamed stash? [Y/n] '
+	read reply
+	case "$reply" in
+	[nN]*)	return 1 ;;
+	*)	return 0 ;;
+	esac
+}
+
 # Main command set
 case "$1" in
 list)
@@ -226,11 +289,16 @@ create)
 	create_stash "$*" && echo "$w_commit"
 	;;
 *)
-	if test $# -eq 0
+	if test $# -ne 0
+	then
+		usage
+	fi
+	if allow_quick_stash
 	then
 		save_stash && git-reset --hard
 	else
-		usage
+		echo "*** Stash List ***"
+		list_stash
 	fi
 	;;
 esac
-- 
1.5.3.7

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Free pop3 email with a spam filter.
http://www.bluebottle.com/tag/5
