From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH] contrib/subtree: Add command from-submodule
Date: Sun, 24 Mar 2013 20:59:40 +0000
Message-ID: <1364158780-31211-1-git-send-email-pcampbell@kemitix.net>
References: <7vwqtebp3m.fsf@alter.siamese.dyndns.org>
Cc: greened@obbligato.org, Paul Campbell <pcampbell@kemitix.net>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Wayne Walter" <wayne@tickzoom.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 22:00:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJs22-0002Uc-5q
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab3CXVAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:00:00 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35607 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab3CXU77 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 16:59:59 -0400
Received: by mail-wg0-f49.google.com with SMTP id gg9so3998206wgb.4
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 13:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=yYrR+IvmvmRblZPa+5I0UgSl77XaitdSTXTdUayX2to=;
        b=YupB+jUT1pdgRkigRwDVWYZfc+2WNVrYfhwiw9ZTv91YL8JKvd8Y6Uc89nkSXlAcfC
         dfbO4zXYn7KyTFnL4k6HjOjCushdP5QIIKvYyy19pYXlJlU43ICuBOrfAU+T+lUbWGGc
         Tpkot9E58zLipVyXDRa6fizSEtuF8xU7VXnmg7HtfWf2ws1BltNzS5Th5bg3N7xbrlM7
         7GstSloewWngrYCaG6AZOdO/ZKM4VhEgi5PbvVmJ68Hi3LoCfexbUICbGP0qAsfc4vGW
         YD++hybLHD/jIgc3Fczf7fGMIt+OoQyjPGdvMPzBVKqrXdqxuadRBv88TEEKwjfebEuT
         8wXw==
X-Received: by 10.194.173.167 with SMTP id bl7mr14049809wjc.50.1364158797993;
        Sun, 24 Mar 2013 13:59:57 -0700 (PDT)
Received: from coyote.home (host-2-102-87-178.as13285.net. [2.102.87.178])
        by mx.google.com with ESMTPS id ek4sm24210605wib.11.2013.03.24.13.59.56
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 13:59:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <7vwqtebp3m.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkaIfhlmqQNo0IwBoZd4TOz8ub9EPB9J903XpywpuA3n6KOlfOsQkBOco/i+bqPQpCOZr6F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218978>

Converts a git-submodule into a git-subtree.

Based-on-patch-by: Peter Jaros <pjaros@pivotallabs.com>
Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index a81dfef..5e3c0b8 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -14,6 +14,7 @@ git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <refspec...>
 git subtree push  --prefix=<prefix> <repository> <refspec...>
 git subtree split --prefix=<prefix> <commit...>
+git subtree from-submodule --prefix=<prefix>
 --
 h,help        show the help
 q             quiet
@@ -114,7 +115,7 @@ prefix="${prefix%/}";
 command="$1"
 shift
 case "$command" in
-	add|merge|pull) default= ;;
+	add|merge|pull|from-submodule) default= ;;
 	split|push) default="--default HEAD" ;;
 	*) die "Unknown command '$command'" ;;
 esac
@@ -140,7 +141,14 @@ if ( test "$command" != "pull" ) && ( test "$command" != "add" ) && ( test "$com
 	fi
 fi
 
+# map command to a function
+case $command in
+	from-submodule) cmd=cmd_from_submodule;;
+	*) cmd="cmd_$command";;
+esac
+
 debug "command: {$command}"
+debug "function: {$function}"
 debug "quiet: {$quiet}"
 debug "revs: {$revs}"
 debug "dir: {$dir}"
@@ -766,4 +774,29 @@ cmd_push()
 	fi
 }
 
-"cmd_$command" "$@"
+cmd_from_submodule()
+{
+	ensure_clean
+
+	# Remove references to submodule.
+	git config --remove-section "submodule.$prefix"
+	git config --file .gitmodules --remove-section "submodule.$prefix"
+	git add .gitmodules
+
+	# Move submodule aside.
+	tmp_repo="$(mktemp -d git-subtree.XXXXX)"
+	rm -r $tmp_repo
+	mv "$prefix" $tmp_repo
+	git rm "$prefix"
+
+	# Commit changes.
+	git commit -m "Remove '$prefix/' submodule"
+
+	# subtree add from submodule repo.
+	cmd_add_repository $tmp_repo HEAD
+
+	# Remove submodule repo.
+	rm -rf $tmp_repo
+}
+
+"$cmd" "$@"
-- 
1.8.2
