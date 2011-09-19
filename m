From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCHv2] git-web--browse: avoid the use of eval
Date: Mon, 19 Sep 2011 21:26:55 +1200
Message-ID: <1316424415-11156-1-git-send-email-judge.packham@gmail.com>
References: <20110918183846.GA31176@sigill.intra.peff.net>
Cc: Chris Packham <judge.packham@gmail.com>, peff@peff.net,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 11:26:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5a7u-0005OU-0s
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 11:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855Ab1ISJ0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 05:26:53 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62731 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab1ISJ0x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 05:26:53 -0400
Received: by ywb5 with SMTP id 5so3916247ywb.19
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5I14q99QyVnK0Ytfkk9Xkg4u1M4wZaTtW0z1SkdKw5Q=;
        b=HySQ78W97tCNz8Kv2kP4rsQAu5P7UXCTP/filT/AhfQHkB8k0xwE5Ehw0aZhTMRxDL
         v3PNuboVsxzN2U90gqJ8ZAyBHQgciJgwLloaz+sLkjFpsojhLvA8Nl0BotUxyQIOnVNT
         Z1RFmnJ+scotn7AIoKl26gQKuDNaW5jnQo1yQ=
Received: by 10.68.31.101 with SMTP id z5mr3779043pbh.446.1316424412141;
        Mon, 19 Sep 2011 02:26:52 -0700 (PDT)
Received: from localhost.localdomain (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id y5sm15450726pbe.6.2011.09.19.02.26.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Sep 2011 02:26:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc1.4.g47f23.dirty
In-Reply-To: <20110918183846.GA31176@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181671>

Using eval causes problems when the URL contains an appropriately
escaped ampersand (\&). Dropping eval from the built-in browser
invocation avoids the problem.

Cc: peff@peff.net
Cc: chriscool@tuxfamily.org
Cc: jepler@unpythonic.net

Signed-off-by: Chris Packham <judge.packham@gmail.com>

---
Here's an updated patch which drops the uses of eval when invoking a
supported browser. The default case still uses eval but adds some extra
quoting which also fixes the problem. I've avoided touching the 'start'
case because I don't have access to a windows system to test with.

I've replaced my tests With the test suggested by Peff (should I be
giving him credit in the copyright line or something?). I've grabbed
t9901 but if there is a better set of miscellaneous minor tests that I
should be using let me know.

 git-web--browse.sh         |   10 +++++-----
 t/t9901-git-web--browse.sh |   21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 5 deletions(-)
 create mode 100755 t/t9901-git-web--browse.sh

diff --git a/git-web--browse.sh b/git-web--browse.sh
index e9de241..ee05f10 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -156,7 +156,7 @@ firefox|iceweasel|seamonkey|iceape)
 	;;
 google-chrome|chrome|chromium|chromium-browser)
 	# No need to specify newTab. It's default in chromium
-	eval "$browser_path" "$@" &
+	"$browser_path" "$@" &
 	;;
 konqueror)
 	case "$(basename "$browser_path")" in
@@ -164,10 +164,10 @@ konqueror)
 		# It's simpler to use kfmclient to open a new tab in konqueror.
 		browser_path="$(echo "$browser_path" | sed -e 's/konqueror$/kfmclient/')"
 		type "$browser_path" > /dev/null 2>&1 || die "No '$browser_path' found."
-		eval "$browser_path" newTab "$@"
+		"$browser_path" newTab "$@" &
 		;;
 	kfmclient)
-		eval "$browser_path" newTab "$@"
+		"$browser_path" newTab "$@" &
 		;;
 	*)
 		"$browser_path" "$@" &
@@ -175,7 +175,7 @@ konqueror)
 	esac
 	;;
 w3m|elinks|links|lynx|open)
-	eval "$browser_path" "$@"
+	"$browser_path" "$@"
 	;;
 start)
 	exec "$browser_path" '"web-browse"' "$@"
@@ -185,7 +185,7 @@ opera|dillo)
 	;;
 *)
 	if test -n "$browser_cmd"; then
-		( eval $browser_cmd "$@" )
+		( eval $browser_cmd \""$@"\" )
 	fi
 	;;
 esac
diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
new file mode 100755
index 0000000..141ed17
--- /dev/null
+++ b/t/t9901-git-web--browse.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+#
+# Copyright (c) 2011 Chris Packham
+#
+
+test_description='git web--browse basic tests
+
+This test checks that git web--browse can handle various valid URLs.'
+
+. ./test-lib.sh
+
+test_expect_success \
+	'accepts a URL with an ampersand in it' '
+	echo http://example.com/foo\&bar/ >expect &&
+	git config browser.custom.cmd echo &&
+	git web--browse --browser=custom \
+		http://example.com/foo\&bar/ >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.7.rc1.4.g47f23.dirty
