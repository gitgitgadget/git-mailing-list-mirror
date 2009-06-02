From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/2] Rename submodule.<name>.rebase to submodule.<name>.update
Date: Wed, 03 Jun 2009 00:59:11 +0200
Message-ID: <1243983552-24810-2-git-send-email-johan@herland.net>
References: <7v63fgpwyd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	apenwarr@gmail.com, peter.hutterer@who-t.net,
	markus.heidelberg@web.de, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 03 01:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBcz1-00007d-UG
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 01:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbZFBXBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 19:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbZFBXBW
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 19:01:22 -0400
Received: from mx.getmail.no ([84.208.15.66]:64777 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751515AbZFBXBV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 19:01:21 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KKM000UWVY8A000@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 03 Jun 2009 01:01:20 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KKM00EMTVVXLQ80@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 03 Jun 2009 01:01:15 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.6.2.224626
X-Mailer: git-send-email 1.6.3.rc0.1.gf800
In-reply-to: <7v63fgpwyd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120557>

The addition of "submodule.<name>.rebase" demonstrates the usefulness of
alternatives to the default behaviour of "git submodule update". However,
by naming the config variable "submodule.<name>.rebase", and making it a
boolean choice, we are artificially constraining future git versions that
may want to add _more_ alternatives than just "rebase".

Therefore, while "submodule.<name>.rebase" are not yet in a stable git
release, future-proof it, by changing it from

  submodule.<name>.rebase = true/false

to

  submodule.<name>.update = checkout/rebase

where "checkout" specifies the default behaviour of "git submodule update"
(checking out the new commit to a detached HEAD), and "rebase" specifies
the --rebase behaviour (where the current local branch in the submodule is
rebase onto the new commit). Thus .update == checkout is .rebase == false,
and .update == rebase is equivalent to .rebase == false. Finally, leaving
.update unset is equivalent to leaving .rebase unset.

In future git versions, other alternatives to "git submodule update"
behaviour can be included by adding them to the list of allowable values
for the submodule.<name>.update variable.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-submodule.txt |    4 ++--
 Documentation/gitmodules.txt    |   10 ++++++++--
 git-submodule.sh                |   32 +++++++++++++++++---------------
 t/t7406-submodule-update.sh     |   16 ++++++++--------
 4 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index acd16ac..cd8e861 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -116,7 +116,7 @@ update::
 	Update the registered submodules, i.e. clone missing submodules and
 	checkout the commit specified in the index of the containing repository.
 	This will make the submodules HEAD be detached unless '--rebase' is
-	specified or the key `submodule.$name.rebase` is set to `true`.
+	specified or the key `submodule.$name.update` is set to	`rebase`.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -186,7 +186,7 @@ OPTIONS
 	superproject. If this option is given, the submodule's HEAD will not
 	be detached. If a a merge failure prevents this process, you will have
 	to resolve these failures with linkgit:git-rebase[1].
-	If the key `submodule.$name.rebase` is set to `true`, this option is
+	If the key `submodule.$name.update` is set to `rebase`, this option is
 	implicit.
 
 --reference <repository>::
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 7c22c40..1b67f0a 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -30,8 +30,14 @@ submodule.<name>.path::
 submodule.<name>.url::
 	Defines an url from where the submodule repository can be cloned.
 
-submodule.<name>.rebase::
-	Defines that the submodule should be rebased by default.
+submodule.<name>.update::
+	Defines what to do when the submodule is updated by the superproject.
+	If 'checkout' (the default), the new commit specified in the
+	superproject will be checked out in the submodule on a detached HEAD.
+	If 'rebase', the current branch of the submodule will be rebased onto
+	the commit specified in the superproject.
+	This config option is overridden if 'git submodule update' is given
+	the '--rebase' option.
 
 
 EXAMPLES
diff --git a/git-submodule.sh b/git-submodule.sh
index bbca183..19a3a84 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -18,7 +18,7 @@ quiet=
 reference=
 cached=
 nofetch=
-rebase=
+update=
 
 #
 # print stuff on stdout unless -q was specified
@@ -311,10 +311,10 @@ cmd_init()
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"
 
-		test true != "$(git config -f .gitmodules --bool \
-			submodule."$name".rebase)" ||
-		git config submodule."$name".rebase true ||
-		die "Failed to register submodule path '$path' as rebasing"
+		upd="$(git config -f .gitmodules submodule."$name".update)"
+		test -z "$upd" ||
+		git config submodule."$name".update "$upd" ||
+		die "Failed to register update mode for submodule path '$path'"
 
 		say "Submodule '$name' ($url) registered for path '$path'"
 	done
@@ -345,7 +345,7 @@ cmd_update()
 			;;
 		-r|--rebase)
 			shift
-			rebase=true
+			update="rebase"
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
@@ -379,7 +379,7 @@ cmd_update()
 	do
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
-		rebase_module=$(git config --bool submodule."$name".rebase)
+		update_module=$(git config submodule."$name".update)
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
@@ -400,9 +400,9 @@ cmd_update()
 			die "Unable to find current revision in submodule path '$path'"
 		fi
 
-		if test true = "$rebase"
+		if ! test -z "$update"
 		then
-			rebase_module=true
+			update_module=$update
 		fi
 
 		if test "$subsha1" != "$sha1"
@@ -420,16 +420,18 @@ cmd_update()
 				die "Unable to fetch in submodule path '$path'"
 			fi
 
-			if test true = "$rebase_module"
-			then
-				command="git-rebase"
+			case "$update_module" in
+			rebase)
+				command="git rebase"
 				action="rebase"
 				msg="rebased onto"
-			else
-				command="git-checkout $force -q"
+				;;
+			*)
+				command="git checkout $force -q"
 				action="checkout"
 				msg="checked out"
-			fi
+				;;
+			esac
 
 			(unset GIT_DIR; cd "$path" && $command "$sha1") ||
 			die "Unable to $action '$sha1' in submodule path '$path'"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 3442c05..0773fe4 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -76,9 +76,9 @@ test_expect_success 'submodule update --rebase staying on master' '
 	)
 '
 
-test_expect_success 'submodule update - rebase true in .git/config' '
+test_expect_success 'submodule update - rebase in .git/config' '
 	(cd super &&
-	 git config submodule.submodule.rebase true
+	 git config submodule.submodule.update rebase
 	) &&
 	(cd super/submodule &&
 	  git reset --hard HEAD~1
@@ -93,9 +93,9 @@ test_expect_success 'submodule update - rebase true in .git/config' '
 	)
 '
 
-test_expect_success 'submodule update - rebase false in .git/config but --rebase given' '
+test_expect_success 'submodule update - checkout in .git/config but --rebase given' '
 	(cd super &&
-	 git config submodule.submodule.rebase false
+	 git config submodule.submodule.update checkout
 	) &&
 	(cd super/submodule &&
 	  git reset --hard HEAD~1
@@ -110,9 +110,9 @@ test_expect_success 'submodule update - rebase false in .git/config but --rebase
 	)
 '
 
-test_expect_success 'submodule update - rebase false in .git/config' '
+test_expect_success 'submodule update - checkout in .git/config' '
 	(cd super &&
-	 git config submodule.submodule.rebase false
+	 git config submodule.submodule.update checkout
 	) &&
 	(cd super/submodule &&
 	  git reset --hard HEAD^
@@ -131,9 +131,9 @@ test_expect_success 'submodule init picks up rebase' '
 	(cd super &&
 	 git config submodule.rebasing.url git://non-existing/git &&
 	 git config submodule.rebasing.path does-not-matter &&
-	 git config submodule.rebasing.rebase true &&
+	 git config submodule.rebasing.update rebase &&
 	 git submodule init rebasing &&
-	 test true = $(git config --bool submodule.rebasing.rebase)
+	 test "rebase" = $(git config submodule.rebasing.update)
 	)
 '
 
-- 
1.6.3.rc0.1.gf800
