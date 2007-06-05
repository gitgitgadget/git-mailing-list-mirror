From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [PATCH 2/2] git-submodule: clone during update, not during init
Date: Tue, 05 Jun 2007 13:18:17 +0200
Message-ID: <op.ttf4crpn9pspc6@localhost>
References: <11810357523435-git-send-email-hjemli@gmail.com> <11810357523233-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 13:16:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvX1E-0007Vc-El
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 13:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbXFELQA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 07:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754639AbXFELQA
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 07:16:00 -0400
Received: from hu-out-0506.google.com ([72.14.214.230]:25074 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbXFELP7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2007 07:15:59 -0400
Received: by hu-out-0506.google.com with SMTP id 19so704164hue
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 04:15:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:to:subject:from:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=F8l8cHOwVJVxXvjAb+T35669QXqQ8aZ1+aPZbjv2VcNlrygihHu05CniRYXNQZzhQbSscW6MDM/2N/8PdiXS3eiZuTv93EVRuaOz0EITC8ahkg538JhIk1vVbOPz/N73MZnAmRb4FTdB6Bhimg1mOU/OS0/0MRqK7lOshk0DrEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:subject:from:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=K2LjcgsT4bcHUNPFkuQx/xmHjedBQVDZAHgG5gI3mfYA+JNI4IvzpUcAuOWlW/JMZEMMtWhHS1VzRFi5ufDNajAJUD6I/LUDEJvpZk6r4iF2lj41e5YmqgnRmK9Dqk84hqlCQvjQZCr/FzgdczukGX4Rakp7IZncdMwqQ86eJ7g=
Received: by 10.67.88.20 with SMTP id q20mr408678ugl.1181042157033;
        Tue, 05 Jun 2007 04:15:57 -0700 (PDT)
Received: from localhost ( [80.213.29.208])
        by mx.google.com with ESMTP id y37sm3100343iky.2007.06.05.04.15.54;
        Tue, 05 Jun 2007 04:15:55 -0700 (PDT)
In-Reply-To: <11810357523233-git-send-email-hjemli@gmail.com>
User-Agent: Opera Mail/9.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49192>

This teaches 'git-submodule init' to register submodule paths and urls in
.git/config instead of actually cloning them. The cloning is now handled
as part of 'git-submodule update'.

With this change it is possible to specify preferred/alternate urls for
the submodules in .git/config before the submodules are cloned.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

Changed from '|| exit @?' to '|| exit'.


  Documentation/git-submodule.txt |   16 +++++++-------
  git-submodule.sh                |   41 ++++++++++++++++----------------------
  t/t7400-submodule-basic.sh      |   38 ++++++++++++++++++++++++-----------
  3 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index cb0424f..f8fb80f 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -23,15 +23,15 @@ status::
  	repository. This command is the default command for git-submodule.

  init::
-	Initialize the submodules, i.e. clone the git repositories specified
-	in the .gitmodules file and checkout the submodule commits specified
-	in the index of the containing repository. This will make the
-	submodules HEAD be detached.
+	Initialize the submodules, i.e. register in .git/config each submodule
+	path and url found in .gitmodules. The key used in git/config is
+	`submodule.$path.url`. This command does not alter existing information
+	in .git/config.

  update::
-	Update the initialized submodules, i.e. checkout the submodule commits
-	specified in the index of the containing repository. This will make
-	the submodules HEAD be detached.
+	Update the registered submodules, i.e. clone missing submodules and
+	checkout the commit specified in the index of the containing repository.
+	This will make the submodules HEAD be detached.


  OPTIONS
@@ -50,7 +50,7 @@ OPTIONS

  FILES
  -----
-When cloning submodules, a .gitmodules file in the top-level directory
+When initializing submodules, a .gitmodules file in the top-level directory
  of the containing repository is used to find the url of each submodule.
  This file should be formatted in the same way as $GIR_DIR/config. The key
  to each submodule url is "module.$path.url".
diff --git a/git-submodule.sh b/git-submodule.sh
index a89ea88..e7b6978 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -53,7 +53,7 @@ module_clone()
  }

  #
-# Run clone + checkout on missing submodules
+# Register submodules in .git/config
  #
  # $@ = requested paths (default to all)
  #
@@ -62,37 +62,23 @@ modules_init()
  	git ls-files --stage -- "$@" | grep -e '^160000 ' |
  	while read mode sha1 stage path
  	do
-		# Skip submodule paths that already contain a .git directory.
-		# This will also trigger if $path is a symlink to a git
-		# repository
-		test -d "$path"/.git && continue
+		# Skip already registered paths
+		url=$(git-config submodule."$path".url)
+		test -z "$url" || continue

  		url=$(GIT_CONFIG=.gitmodules git-config module."$path".url)
  		test -z "$url" &&
  		die "No url found for submodule '$path' in .gitmodules"

-		# MAYBE FIXME: this would be the place to check GIT_CONFIG
-		# for a preferred url for this submodule, possibly like this:
-		#
-		# modname=$(GIT_CONFIG=.gitmodules git-config module."$path".name)
-		# alturl=$(git-config module."$modname".url)
-		#
-		# This would let the versioned .gitmodules file use the submodule
-		# path as key, while the unversioned GIT_CONFIG would use the
-		# logical modulename (if present) as key. But this would need
-		# another fallback mechanism if the module wasn't named.
+		git-config submodule."$path".url "$url" ||
+		die "Failed to register url for submodule '$path'"

-		module_clone "$path" "$url" || exit
-
-		(unset GIT_DIR && cd "$path" && git-checkout -q "$sha1") ||
-		die "Checkout of submodule '$path' failed"
-
-		say "Submodule '$path' initialized"
+		say "Submodule '$path' registered with url '$url'"
  	done
  }

  #
-# Checkout correct revision of each initialized submodule
+# Update each submodule path to correct revision, using clone and checkout as needed
  #
  # $@ = requested paths (default to all)
  #
@@ -101,14 +87,21 @@ modules_update()
  	git ls-files --stage -- "$@" | grep -e '^160000 ' |
  	while read mode sha1 stage path
  	do
-		if ! test -d "$path"/.git
+		url=$(git-config submodule."$path".url)
+		if test -z "$url"
  		then
  			# Only mention uninitialized submodules when its
  			# path have been specified
  			test "$#" != "0" &&
  			say "Submodule '$path' not initialized"
-			continue;
+			continue
  		fi
+
+		if ! test -d "$path"/.git
+		then
+			module_clone "$path" "$url" || exit
+		fi
+
  		subsha1=$(unset GIT_DIR && cd "$path" &&
  			git-rev-parse --verify HEAD) ||
  		die "Unable to find current revision of submodule '$path'"
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 6274729..3940433 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -40,7 +40,7 @@ test_expect_success 'Prepare submodule testing' '
  	git-add a lib z &&
  	git-commit -m "super commit 1" &&
  	mv lib .subrepo &&
-	GIT_CONFIG=.gitmodules git-config module.lib.url ./.subrepo
+	GIT_CONFIG=.gitmodules git-config module.lib.url git://example.com/lib.git
  '

  test_expect_success 'status should only print one line' '
@@ -52,41 +52,55 @@ test_expect_success 'status should initially be "missing"' '
  	git-submodule status | grep "^-$rev1"
  '

-test_expect_success 'init should fail when path is used by a file' '
+test_expect_success 'init should register submodule url in .git/config' '
+	git-submodule init &&
+	url=$(git-config submodule.lib.url) &&
+	if test "$url" != "git://example.com/lib.git"
+	then
+		echo "[OOPS] init succeeded but submodule url is wrong"
+		false
+	elif ! git-config submodule.lib.url ./.subrepo
+	then
+		echo "[OOPS] init succeeded but update of url failed"
+		false
+	fi
+'
+
+test_expect_success 'update should fail when path is used by a file' '
  	echo "hello" >lib &&
-	if git-submodule init
+	if git-submodule update
  	then
-		echo "[OOPS] init should have failed"
+		echo "[OOPS] update should have failed"
  		false
  	elif test -f lib && test "$(cat lib)" != "hello"
  	then
-		echo "[OOPS] init failed but lib file was molested"
+		echo "[OOPS] update failed but lib file was molested"
  		false
  	else
  		rm lib
  	fi
  '

-test_expect_success 'init should fail when path is used by a nonempty directory' '
+test_expect_success 'update should fail when path is used by a nonempty directory' '
  	mkdir lib &&
  	echo "hello" >lib/a &&
-	if git-submodule init
+	if git-submodule update
  	then
-		echo "[OOPS] init should have failed"
+		echo "[OOPS] update should have failed"
  		false
  	elif test "$(cat lib/a)" != "hello"
  	then
-		echo "[OOPS] init failed but lib/a was molested"
+		echo "[OOPS] update failed but lib/a was molested"
  		false
  	else
  		rm lib/a
  	fi
  '

-test_expect_success 'init should work when path is an empty dir' '
+test_expect_success 'update should work when path is an empty dir' '
  	rm -rf lib &&
  	mkdir lib &&
-	git-submodule init &&
+	git-submodule update &&
  	head=$(cd lib && git-rev-parse HEAD) &&
  	if test -z "$head"
  	then
@@ -99,7 +113,7 @@ test_expect_success 'init should work when path is an empty dir' '
  	fi
  '

-test_expect_success 'status should be "up-to-date" after init' '
+test_expect_success 'status should be "up-to-date" after update' '
  	git-submodule status | grep "^ $rev1"
  '

-- 
1.5.2.841.gc9eafb
