From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [PATCH 1/2] git-submodule: move cloning into a separate function
Date: Tue, 05 Jun 2007 13:13:28 +0200
Message-ID: <op.ttf34qd99pspc6@localhost>
References: <11810357523435-git-send-email-hjemli@gmail.com> <11810357522478-git-send-email-hjemli@gmail.com> <46653DB2.997A3ABD@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 13:11:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvWwb-0006k7-BZ
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 13:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbXFELLM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 07:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762389AbXFELLL
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 07:11:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:48803 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbXFELLK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2007 07:11:10 -0400
Received: by ug-out-1314.google.com with SMTP id j3so137365ugf
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 04:11:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:to:subject:from:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=F+gMnMyeDTSOyE9plOYWZcTW6aPgEKKvZN0no5hehpvrM60K7YZytm7g+ReMtO9bW3NmtHnhn3XoDsL+zBStz4SPnJc18d3o9kGmBEODEro6YU1XM3O07dbNacPqCQUlJ8erlWoGtI2uubrz+nIDpFVTqmbG/PSW8kKJ2WLIw/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:subject:from:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=Hjb8J17dvtqyWAvIUCpQV6gQxtcjoH0O3nSiEpufogIgVVOVPXdNzVGUTTk3i3FT3g4jlm8l+mmsTRwW00918KPrE9mIsIrv3PzoxccYzGqVJPnx5aRfiZhts9qJDKNxsQ/j5osmgNOoQ2F4MJxMA+J7JKZGrDAWXqqEPRg1lFk=
Received: by 10.67.115.19 with SMTP id s19mr398430ugm.1181041869359;
        Tue, 05 Jun 2007 04:11:09 -0700 (PDT)
Received: from localhost ( [80.213.29.208])
        by mx.google.com with ESMTP id c25sm3098023ika.2007.06.05.04.11.06;
        Tue, 05 Jun 2007 04:11:07 -0700 (PDT)
In-Reply-To: <46653DB2.997A3ABD@eudaptics.com>
User-Agent: Opera Mail/9.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49191>

This is just a simple refactoring of modules_init() with no change in
functionality.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

On Tue, 05 Jun 2007 12:40:50 +0200, Johannes Sixt <J.Sixt@eudaptics.com> wrote:

> Lars Hjemli wrote:
>> +               module_clone "$path" "$url" || exit $?
>
> Minor nit: The idiom that is commonly used in situations like this (see
> other git-* shell scripts):
>
> 		module_clone "$path" "$url" || exit
>
> because exit without argument uses the code of the last command
> executed.
>

Thanks, I'll follow up with matching changes to [patch 2/2].


  git-submodule.sh |   44 ++++++++++++++++++++++++++++----------------
  1 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 6ed5a6c..a89ea88 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -25,6 +25,33 @@ say()
  	fi
  }

+
+#
+# Clone a submodule
+#
+module_clone()
+{
+	path=$1
+	url=$2
+
+	# If there already is a directory at the submodule path,
+	# expect it to be empty (since that is the default checkout
+	# action) and try to remove it.
+	# Note: if $path is a symlink to a directory the test will
+	# succeed but the rmdir will fail. We might want to fix this.
+	if test -d "$path"
+	then
+		rmdir "$path" 2>/dev/null ||
+		die "Directory '$path' exist, but is neither empty nor a git repository"
+	fi
+
+	test -e "$path" &&
+	die "A file already exist at path '$path'"
+
+	git-clone -n "$url" "$path" ||
+	die "Clone of submodule '$path' failed"
+}
+
  #
  # Run clone + checkout on missing submodules
  #
@@ -40,20 +67,6 @@ modules_init()
  		# repository
  		test -d "$path"/.git && continue

-		# If there already is a directory at the submodule path,
-		# expect it to be empty (since that is the default checkout
-		# action) and try to remove it.
-		# Note: if $path is a symlink to a directory the test will
-		# succeed but the rmdir will fail. We might want to fix this.
-		if test -d "$path"
-		then
-			rmdir "$path" 2>/dev/null ||
-			die "Directory '$path' exist, but is neither empty nor a git repository"
-		fi
-
-		test -e "$path" &&
-		die "A file already exist at path '$path'"
-
  		url=$(GIT_CONFIG=.gitmodules git-config module."$path".url)
  		test -z "$url" &&
  		die "No url found for submodule '$path' in .gitmodules"
@@ -69,8 +82,7 @@ modules_init()
  		# logical modulename (if present) as key. But this would need
  		# another fallback mechanism if the module wasn't named.

-		git-clone -n "$url" "$path" ||
-		die "Clone of submodule '$path' failed"
+		module_clone "$path" "$url" || exit

  		(unset GIT_DIR && cd "$path" && git-checkout -q "$sha1") ||
  		die "Checkout of submodule '$path' failed"
-- 
1.5.2.841.gc9eafb
