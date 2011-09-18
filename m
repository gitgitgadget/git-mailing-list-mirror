From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCH] git-web--browse: invoke kfmclient directly
Date: Sun, 18 Sep 2011 22:20:24 +1200
Message-ID: <1316341224-4359-1-git-send-email-judge.packham@gmail.com>
References: <20110918032933.GA17977@sigill.intra.peff.net>
Cc: Chris Packham <judge.packham@gmail.com>, peff@peff.net,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 12:25:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5EYh-0001fA-0O
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 12:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab1IRKU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 06:20:29 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61875 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab1IRKU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 06:20:28 -0400
Received: by gxk6 with SMTP id 6so2989669gxk.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iK5RUjyx2CPqe62wrq1WipjbhGhdoR/gHlbG84CAtzE=;
        b=u7nxoJJLdxjCc9RQazRopsuvJ9KiL1F3qfEVMGkc39U+JiP86acjXY2E1cYRx9i7TQ
         UNJ344kb/5bdzUFPAwCZ5I/8kQtcJckm2iHspl1U/vO+GO5BqTtksRNTg9nLdPT6h7Zx
         zkcZ9NIAKPGOxaZTti9rdZVbsnxH3NVd3VBJ8=
Received: by 10.68.39.230 with SMTP id s6mr2321944pbk.11.1316341226831;
        Sun, 18 Sep 2011 03:20:26 -0700 (PDT)
Received: from localhost.localdomain (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id y5sm4540885pbe.6.2011.09.18.03.20.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 03:20:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc1.3.g5593.dirty
In-Reply-To: <20110918032933.GA17977@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181603>

Instead of using eval which causes problems when a URL contains an
appropriately escaped ampersand (\&).

Cc: peff@peff.net
Cc: chriscool@tuxfamily.org
Cc: jepler@unpythonic.net
Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
> Which implies that "$browser_path" must be the actual
> executable. In which case, I would think that:
>
>   "$browser_path" "$@" &
>
> would be the right thing. And indeed, that is what the firefox arm of
> the case statement does. But chrome, konqueror, and others use eval.

So here is my attempt at a fix for kfmclient.

For what it's worth I've included a testcase that detects my problem. I'm not
sure if the testcase is really worth it because the test library suppresses X
applications and even if it didn't the testcase is fairly trivial and might
just annoy people by opening web-browsers (and it snaps up the last t99xx
prefix). 

 git-web--browse.sh         |    4 ++--
 t/t9901-git-web--browse.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100755 t/t9901-git-web--browse.sh

diff --git a/git-web--browse.sh b/git-web--browse.sh
index e9de241..1164a22 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
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
diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
new file mode 100755
index 0000000..7ed38a0
--- /dev/null
+++ b/t/t9901-git-web--browse.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+#
+# Copyright (c) 2011 Chris Packham
+#
+
+test_description='git web--browse basic tests
+
+This test checks that git web--browse can handle various valid URLs with
+the supported browsers that are installed on the host system.'
+
+. ./test-lib.sh
+
+test -x /usr/bin/firefox && test_set_prereq FIREFOX
+test -x /usr/bin/konqueror && test_set_prereq KONQUEROR
+test -x /usr/bin/google-chrome && test_set_prereq CHROME
+test -x /usr/bin/opera && test_set_prereq OPERA
+
+test_expect_success \
+	'accepts a URL with an ampersand in it (default)' '
+    git web--browse http://example.com/foo\&bar/
+'
+
+test_expect_success FIREFOX \
+	'accepts a URL with an ampersand in it (firefox)' '
+    git web--browse --browser=firefox http://example.com/foo\&bar/
+'
+
+test_expect_success KONQUEROR \
+	'accepts a URL with an ampersand in it (konqueror)' '
+    git web--browse --browser=konqueror http://example.com/foo\&bar/
+'
+
+test_expect_success OPERA \
+	'accepts a URL with an ampersand in it (opera)' '
+    git web--browse --browser=opera http://example.com/foo\&bar/
+'
+
+test_expect_success CHROME \
+	'accepts a URL with an ampersand in it (chrome)' '
+    git web--browse --browser=google-chrome http://example.com/foo\&bar/
+'
+
+test_done
-- 
1.7.7.rc1.3.g5593.dirty
