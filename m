From: larsxschneider@gmail.com
Subject: [PATCH v3 3/3] submodule: extend die message on failed checkout with depth argument
Date: Mon, 21 Dec 2015 00:19:55 +0100
Message-ID: <1450653595-22676-4-git-send-email-larsxschneider@gmail.com>
References: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
Cc: sbeller@google.com, peff@peff.net, Jens.Lehmann@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 00:20:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAnHA-00046l-Hr
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 00:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbbLTXUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 18:20:19 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33879 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbbLTXUD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 18:20:03 -0500
Received: by mail-wm0-f67.google.com with SMTP id l126so11066216wml.1
        for <git@vger.kernel.org>; Sun, 20 Dec 2015 15:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N0iHsDjhE+hHKbuWa/lpZVvJlE4TRzxtABI9ENlF8Ko=;
        b=vXeDsuH2ChIfiQYu0M70W4n05duZcIOzYeQvH2d8cU+cgpP0saG/ISy/v+uy1myjB6
         h3Kpkk3/BarqHCEd98Ckk0UIRbu3zdqafuBPLZsfLEnoAUVNS177YrhzPJZzWAcXKgzY
         WGf7zF90mX5aF1OBafHVjYPONi11+WxtNXFwbuKUGTwDKAnm5h8ufK6HRDWT9/5snto9
         lPcDIm50lqvHq5lYJxBQp6v335e3HdBG5N6bw/jAZEtT+kV74xlfA9+5siyUb/7q/w3y
         sAaZLfOb8TTQg4RSv05n/dphbbe3i+O2e9c5dpNPUVfmStqwY8dQYhvKABMV0mVxkvaX
         D+Og==
X-Received: by 10.28.89.69 with SMTP id n66mr17480048wmb.63.1450653602164;
        Sun, 20 Dec 2015 15:20:02 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA24E.dip0.t-ipconnect.de. [80.139.162.78])
        by smtp.gmail.com with ESMTPSA id da10sm25396623wjb.22.2015.12.20.15.20.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Dec 2015 15:20:01 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282777>

From: Lars Schneider <larsxschneider@gmail.com>

A submodule checkout might fail due missing hashes caused by a shallow
fetch operation triggered with the "--depth" argument. Make the user
aware of this with an extended die message.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-submodule.sh            |  4 ++++
 t/t7406-submodule-update.sh | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9bc5c5f..b555d87 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -764,6 +764,10 @@ Maybe you want to use 'update --init'?")"
 				command="git checkout $subforce -q"
 				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
+				if ! test -z "$depth"
+				then
+					die_msg="$die_msg $(eval_gettext "Commit is probably not on the default branch. Try to remove the '\$depth' argument!")"
+				fi
 				;;
 			rebase)
 				command="git rebase"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index b5bd976..52b7120 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -31,6 +31,14 @@ test_expect_success 'setup a submodule tree' '
 	git clone super rebasing &&
 	git clone super merging &&
 	git clone super none &&
+	git clone super non-default-branch &&
+	(cd non-default-branch &&
+	 git checkout -b non-default &&
+	 echo "non-default" >file &&
+	 git add file &&
+	 git commit -m "Commit on non-default branch" &&
+	 git checkout master
+	) &&
 	(cd super &&
 	 git submodule add ../submodule submodule &&
 	 test_tick &&
@@ -63,6 +71,15 @@ test_expect_success 'setup a submodule tree' '
 	 git submodule add ../none none &&
 	 test_tick &&
 	 git commit -m "none"
+	) &&
+	(cd super &&
+	 git submodule add ../non-default-branch non-default-branch &&
+	 (cd non-default-branch &&
+	  git checkout non-default
+	 ) &&
+     git add non-default-branch &&
+	 test_tick &&
+	 git commit -m "non-default-branch"
 	)
 '
 
@@ -752,17 +769,29 @@ test_expect_success SYMLINKS 'submodule update can handle symbolic links in pwd'
 	)
 '
 
-test_expect_success 'submodule update clone shallow submodule' '
+test_expect_success 'submodule update clone shallow submodule on default branch' '
 	git clone cloned super3 &&
 	pwd=$(pwd) &&
 	(cd super3 &&
 	 sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
 	 mv -f .gitmodules.tmp .gitmodules &&
+	 git config submodule.non-default-branch.update none &&
 	 git submodule update --init --depth=3 &&
 	 (cd submodule &&
 	  test 1 = $(git log --oneline | wc -l)
 	 )
-)
+	)
+'
+
+test_expect_success 'submodule update clone shallow submodule on non-default branch' '
+	git clone cloned super4 &&
+	pwd=$(pwd) &&
+	(cd super4 &&
+	 sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
+	 mv -f .gitmodules.tmp .gitmodules &&
+	 test_must_fail git submodule update --init --depth=3 2>submodule.out &&
+	 test_i18ngrep --count "Commit is probably not on the default branch." submodule.out
+    )
 '
 
 test_expect_success 'submodule update --recursive drops module name before recursing' '
-- 
2.5.1
