From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [PATCH 4/5] git-submodule: give submodules proper names
Date: Mon, 11 Jun 2007 02:03:12 +0200
Message-ID: <op.ttqc3mis9pspc6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 02:00:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxXL7-0000dn-9j
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 02:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761089AbXFKAAr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 20:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761090AbXFKAAr
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 20:00:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:21204 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761089AbXFKAAq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2007 20:00:46 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1357666ugf
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 17:00:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:to:subject:from:content-type:mime-version:content-transfer-encoding:message-id:user-agent;
        b=EUOiKdF5NSe82uUFgbJ/uWnbPDx4u0F+Zvu1KGxdQPni/qBMAOQplNUhHYvEKL7nmk5KCMh5K1N0z5SQVj706JxtXe2TnOSrxli9YoEiVlXz+DnA1fS008EMSFyaPWk/Gfbfw9qk8JxDxGEyUTPKpfu+RP5XHWs7GK9C3SHUaj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:subject:from:content-type:mime-version:content-transfer-encoding:message-id:user-agent;
        b=m2aGNtkRRhaV9KIbljIX1SCmp8m5/zj6hDDCxVgr3G80BnBGQ7DysSf5sACUS9ZU1QNcbA/A13eS/f5b8Do7921+irjs+oR0iNrCAjyMavQebiMF1V2z5Xr+ILqOs1g8Ba7oeKGqA76/THmCBPhcDqCadL5q5EXAaJ+4hJd6u0E=
Received: by 10.67.29.12 with SMTP id g12mr4702524ugj.1181520043973;
        Sun, 10 Jun 2007 17:00:43 -0700 (PDT)
Received: from localhost ( [88.88.169.227])
        by mx.google.com with ESMTP id b30sm12438340ika.2007.06.10.17.00.42
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2007 17:00:43 -0700 (PDT)
User-Agent: Opera Mail/9.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49799>

This changes the way git-submodule uses .gitmodules: Subsections no longer
specify the submodule path, they now specify the submodule name. The
submodule path is found under the new key "submodule.<name>.path", which is
a required key.

With this change a submodule can be moved between different 'checkout paths'
without upsetting git-submodule.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
  git-submodule.sh           |   45 ++++++++++++++++++++++++++++++-------------
  t/t7400-submodule-basic.sh |   20 +++++++++++++++---
  2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 6c83c52..89a3885 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -25,6 +25,19 @@ say()
  	fi
  }

+#
+# Map submodule path to submodule name
+#
+# $1 = path
+#
+module_name()
+{
+       name=$(GIT_CONFIG=.gitmodules git-config --get-regexp '^submodule\..*\.path$' "$1" |
+       sed -nre 's/^submodule\.(.+)\.path .+$/\1/p')
+       test -z "$name" &&
+       die "No submodule mapping found in .gitmodules for path '$path'"
+       echo "$name"
+}

  #
  # Clone a submodule
@@ -49,7 +62,7 @@ module_clone()
  	die "A file already exist at path '$path'"

  	git-clone -n "$url" "$path" ||
-	die "Clone of submodule '$path' failed"
+	die "Clone of '$url' into submodule path '$path' failed"
  }

  #
@@ -63,17 +76,18 @@ modules_init()
  	while read mode sha1 stage path
  	do
  		# Skip already registered paths
-		url=$(git-config submodule."$path".url)
+		name=$(module_name "$path") || exit
+		url=$(git-config submodule."$name".url)
  		test -z "$url" || continue

-		url=$(GIT_CONFIG=.gitmodules git-config submodule."$path".url)
+		url=$(GIT_CONFIG=.gitmodules git-config submodule."$name".url)
  		test -z "$url" &&
-		die "No url found for submodule '$path' in .gitmodules"
+		die "No url found for submodule path '$path' in .gitmodules"

-		git-config submodule."$path".url "$url" ||
-		die "Failed to register url for submodule '$path'"
+		git-config submodule."$name".url "$url" ||
+		die "Failed to register url for submodule path '$path'"

-		say "Submodule '$path' registered with url '$url'"
+		say "Submodule '$name' ($url) registered for path '$path'"
  	done
  }

@@ -87,13 +101,14 @@ modules_update()
  	git ls-files --stage -- "$@" | grep -e '^160000 ' |
  	while read mode sha1 stage path
  	do
-		url=$(git-config submodule."$path".url)
+		name=$(module_name "$path") || exit
+		url=$(git-config submodule."$name".url)
  		if test -z "$url"
  		then
  			# Only mention uninitialized submodules when its
  			# path have been specified
  			test "$#" != "0" &&
-			say "Submodule '$path' not initialized"
+			say "Submodule path '$path' not initialized"
  			continue
  		fi

@@ -104,22 +119,22 @@ modules_update()
  		else
  			subsha1=$(unset GIT_DIR && cd "$path" &&
  				git-rev-parse --verify HEAD) ||
-			die "Unable to find current revision of submodule '$path'"
+			die "Unable to find current revision in submodule path '$path'"
  		fi

  		if test "$subsha1" != "$sha1"
  		then
  			(unset GIT_DIR && cd "$path" && git-fetch &&
  				git-checkout -q "$sha1") ||
-			die "Unable to checkout '$sha1' in submodule '$path'"
+			die "Unable to checkout '$sha1' in submodule path '$path'"

-			say "Submodule '$path': checked out '$sha1'"
+			say "Submodule path '$path': checked out '$sha1'"
  		fi
  	done
  }

  #
-# List all registered submodules, prefixed with:
+# List all submodules, prefixed with:
  #  - submodule not initialized
  #  + different revision checked out
  #
@@ -133,7 +148,9 @@ modules_list()
  	git ls-files --stage -- "$@" | grep -e '^160000 ' |
  	while read mode sha1 stage path
  	do
-		if ! test -d "$path"/.git
+		name=$(module_name "$path") || exit
+		url=$(git-config submodule."$name".url)
+		if test -z "url" || ! test -d "$path"/.git
  		then
  			say "-$sha1 $path"
  			continue;
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 9f2d4f9..7a9b505 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -18,7 +18,7 @@ subcommands of git-submodule.
  #  -add directory lib to 'superproject', this creates a DIRLINK entry
  #  -add a couple of regular files to enable testing of submodule filtering
  #  -mv lib subrepo
-#  -add an entry to .gitmodules for path 'lib'
+#  -add an entry to .gitmodules for submodule 'example'
  #
  test_expect_success 'Prepare submodule testing' '
  	mkdir lib &&
@@ -40,7 +40,19 @@ test_expect_success 'Prepare submodule testing' '
  	git-add a lib z &&
  	git-commit -m "super commit 1" &&
  	mv lib .subrepo &&
-	GIT_CONFIG=.gitmodules git-config submodule.lib.url git://example.com/lib.git
+	GIT_CONFIG=.gitmodules git-config submodule.example.url git://example.com/lib.git
+'
+
+test_expect_success 'status should fail for unmapped paths' '
+	if git-submodule status
+	then
+		echo "[OOPS] submodule status succeeded"
+		false
+	elif ! GIT_CONFIG=.gitmodules git-config submodule.example.path lib
+	then
+		echo "[OOPS] git-config failed to update .gitmodules"
+		false
+	fi
  '

  test_expect_success 'status should only print one line' '
@@ -54,12 +66,12 @@ test_expect_success 'status should initially be "missing"' '

  test_expect_success 'init should register submodule url in .git/config' '
  	git-submodule init &&
-	url=$(git-config submodule.lib.url) &&
+	url=$(git-config submodule.example.url) &&
  	if test "$url" != "git://example.com/lib.git"
  	then
  		echo "[OOPS] init succeeded but submodule url is wrong"
  		false
-	elif ! git-config submodule.lib.url ./.subrepo
+	elif ! git-config submodule.example.url ./.subrepo
  	then
  		echo "[OOPS] init succeeded but update of url failed"
  		false
-- 
1.5.2.1.914.gbd3a7
