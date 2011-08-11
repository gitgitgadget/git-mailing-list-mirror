From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 2/2] add update 'none' flag to disable update of submodule by default
Date: Thu, 11 Aug 2011 19:51:46 +0200
Message-ID: <a8cbba7af22649f8cebaf56895304e9ae4378d75.1312923673.git.hvoigt@hvoigt.net>
References: <cover.1312923673.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 19:52:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZQs-0007jo-S8
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab1HKRw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:52:26 -0400
Received: from darksea.de ([83.133.111.250]:57056 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752249Ab1HKRwX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:52:23 -0400
Received: (qmail 25994 invoked from network); 11 Aug 2011 19:52:21 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 11 Aug 2011 19:52:21 +0200
X-Mailer: git-send-email 1.7.6.435.g741d34
In-Reply-To: <cover.1312923673.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1312923673.git.hvoigt@hvoigt.net>
References: <cover.1312923673.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179114>

This is useful to mark a submodule as unneeded by default. When this
option is set and the user wants to work with such a submodule he
needs to configure 'submodule.<name>.update=checkout' or pass the
--checkout option. Then the submodule can be handled like a normal
submodule.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/git-submodule.txt |    8 ++++-
 git-submodule.sh                |    9 +++++
 t/t7406-submodule-update.sh     |   62 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 67cf5f0..6ec3fef 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -120,6 +120,8 @@ too (and can also report changes to a submodule's work tree).
 init::
 	Initialize the submodules, i.e. register each submodule name
 	and url found in .gitmodules into .git/config.
+	It will also copy the value of `submodule.$name.update` into
+	.git/config.
 	The key used in .git/config is `submodule.$name.url`.
 	This command does not alter existing information in .git/config.
 	You can then customize the submodule clone URLs in .git/config
@@ -133,7 +135,7 @@ update::
 	checkout the commit specified in the index of the containing repository.
 	This will make the submodules HEAD be detached unless `--rebase` or
 	`--merge` is specified or the key `submodule.$name.update` is set to
-	`rebase` or `merge`.
+	`rebase`, `merge` or `none`.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -141,6 +143,10 @@ submodule with the `--init` option.
 +
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
++
+If the configuration key `submodule.$name.update` is set to `none` the
+submodule with name `$name` will not be updated by default. This can be
+overriden by adding `--checkout` to the command.
 
 summary::
 	Show commit summary between the given commit (defaults to HEAD) and
diff --git a/git-submodule.sh b/git-submodule.sh
index e544dbc..34d2be6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -429,6 +429,9 @@ cmd_update()
 		--recursive)
 			recursive=1
 			;;
+		--checkout)
+			update="checkout"
+			;;
 		--)
 			shift
 			break
@@ -468,6 +471,12 @@ cmd_update()
 			update_module=$(git config submodule."$name".update)
 		fi
 
+		if test "$update_module" = "none"
+		then
+			echo "Skipping submodule '$path'"
+			continue
+		fi
+
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index c679f36..58877d3 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -30,6 +30,7 @@ test_expect_success 'setup a submodule tree' '
 	git clone super submodule &&
 	git clone super rebasing &&
 	git clone super merging &&
+	git clone super none &&
 	(cd super &&
 	 git submodule add ../submodule submodule &&
 	 test_tick &&
@@ -58,6 +59,11 @@ test_expect_success 'setup a submodule tree' '
 	 test_tick &&
 	 git commit -m "rebasing"
 	)
+	(cd super &&
+	 git submodule add ../none none &&
+	 test_tick &&
+	 git commit -m "none"
+	)
 '
 
 test_expect_success 'submodule update detaching the HEAD ' '
@@ -298,6 +304,62 @@ test_expect_success 'submodule update ignores update=rebase config for new submo
 	)
 '
 
+test_expect_success 'submodule init picks up update=none' '
+	(cd super &&
+	 git config -f .gitmodules submodule.none.update none &&
+	 git submodule init none &&
+	 test "none" = "$(git config submodule.none.update)"
+	)
+'
+
+test_expect_success 'submodule update - update=none in .git/config' '
+	(cd super &&
+	 git config submodule.submodule.update none &&
+	 (cd submodule &&
+	  git checkout master &&
+	  compare_head
+	 ) &&
+	 git diff --raw | grep "	submodule" &&
+	 git submodule update &&
+	 git diff --raw | grep "	submodule" &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git config --unset submodule.submodule.update &&
+	 git submodule update submodule
+	)
+'
+
+test_expect_success 'submodule update - update=none in .git/config but --checkout given' '
+	(cd super &&
+	 git config submodule.submodule.update none &&
+	 (cd submodule &&
+	  git checkout master &&
+	  compare_head
+	 ) &&
+	 git diff --raw | grep "	submodule" &&
+	 git submodule update --checkout &&
+	 test_must_fail git diff --raw \| grep "	submodule" &&
+	 (cd submodule &&
+	  test_must_fail compare_head
+	 ) &&
+	 git config --unset submodule.submodule.update
+	)
+'
+
+test_expect_success 'submodule update --init skips submodule with update=none' '
+	(cd super &&
+	 git add .gitmodules &&
+	 git commit -m ".gitmodules"
+	) &&
+	git clone super cloned &&
+	(cd cloned &&
+	 git submodule update --init &&
+	 test -e submodule/.git &&
+	 test_must_fail test -e none/.git
+	)
+'
+
 test_expect_success 'submodule update continues after checkout error' '
 	(cd super &&
 	 git reset --hard HEAD &&
-- 
1.7.6.435.g741d34
