From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCHv3] git-web--browse: avoid the use of eval
Date: Sun,  2 Oct 2011 13:44:17 +1300
Message-ID: <1317516257-24435-1-git-send-email-judge.packham@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org,
	Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 02 02:44:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAAAo-0000Pn-Cp
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 02:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab1JBAol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 20:44:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54616 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab1JBAoj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 20:44:39 -0400
Received: by gyg10 with SMTP id 10so2490523gyg.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 17:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=LgTzspZzz01ttszWhZHCA6YAfaDHSuI6ea2ExEelDNg=;
        b=j3RWOWqxmxUe3gdZ6MQZdMf8mKO42u6ba0i9IASMU2DaTc0pQDX9qy9AwBNYiHtcpN
         RFSqCtoVV6y1LhxCsSrpJfwJ2Cn4a5IAQwTaZHyCu9x44EQNF4owkDtx5GitF+oIo3FZ
         uxWn3P9BvTqEiGsOXrfAB/99wponTZ2dz7YLQ=
Received: by 10.68.37.67 with SMTP id w3mr9529064pbj.9.1317516278742;
        Sat, 01 Oct 2011 17:44:38 -0700 (PDT)
Received: from localhost.localdomain (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id d1sm14541565pbm.3.2011.10.01.17.44.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Oct 2011 17:44:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182586>

Using eval causes problems when the URL contains an appropriately
escaped ampersand (\&). Dropping eval from the built-in browser
invocation avoids the problem.

Helped-by: Jeff King <peff@peff.net> (test case)
Signed-off-by: Chris Packham <judge.packham@gmail.com>

---
The consensus from the last round of discussion [1] seemed to be to
remove the eval from the built in browsers but quote custom browser
commands appropriately.

I've expanded the tests a little. A semi-colon had the same error as
the ampersand. A hash was another common character that had meaning in
a shell and in URL.

[1] http://article.gmane.org/gmane.comp.version-control.git/181671

 git-web--browse.sh         |   10 +++++-----
 t/t9901-git-web--browse.sh |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 5 deletions(-)
 create mode 100755 t/t9901-git-web--browse.sh

diff --git a/git-web--browse.sh b/git-web--browse.sh
index e9de241..1e82726 100755
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
+		( eval "$browser_cmd \"\$@\"" )
 	fi
 	;;
 esac
diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
new file mode 100755
index 0000000..c6f48a9
--- /dev/null
+++ b/t/t9901-git-web--browse.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+
+test_description='git web--browse basic tests
+
+This test checks that git web--browse can handle various valid URLs.'
+
+. ./test-lib.sh
+
+test_expect_success \
+	'URL with an ampersand in it' '
+	echo http://example.com/foo\&bar >expect &&
+	git config browser.custom.cmd echo &&
+	git web--browse --browser=custom \
+		http://example.com/foo\&bar >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success \
+	'URL with a semi-colon in it' '
+	echo http://example.com/foo\;bar >expect &&
+	git config browser.custom.cmd echo &&
+	git web--browse --browser=custom \
+		http://example.com/foo\;bar >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success \
+	'URL with a hash in it' '
+	echo http://example.com/foo#bar >expect &&
+	git config browser.custom.cmd echo &&
+	git web--browse --browser=custom \
+		http://example.com/foo#bar >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.7
