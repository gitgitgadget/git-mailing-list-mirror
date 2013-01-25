From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH] git-web--browser: avoid errors in terminal when running Firefox on Windows
Date: Fri, 25 Jan 2013 18:44:13 +0400
Message-ID: <3eeabf4989f7f1b4593e89e4c6bcfa8710a7b793.1359125053.git.Alex.Crezoff@gmail.com>
References: <20111111202636.GA20515@sigill.intra.peff.net>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 15:44:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TykWZ-0007js-3x
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 15:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab3AYOoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 09:44:37 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:49244 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab3AYOof (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 09:44:35 -0500
Received: by mail-lb0-f170.google.com with SMTP id ge1so852134lbb.1
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=V4YTyNUWbzMLEfgB5/qAcVYwv30W/PdiicMyPf/H8DI=;
        b=mKxKHLayJ8Lj6n13wOToQlMhPs/8+JQBD90OHsp6GcY9UVLVz+9mwdPxhm7ZPDguET
         tmeL8W19oFrKeSzm9Kp/MWJhIg9kh0B7aZCeQzsA9MTgBhfjtkG7WN9+lPI2VqcDFAlo
         wWONPIUFtE2/HciOFSpwgneHVt59J1npR+Smh+Ie50Jj1SmfbThX6w8zCZJZ3KWmBRvh
         +J7gLAdGMYSbAyQYaLWpYFeMwbLaBVbWJzPDMib2lARPmxnUtLsPTTQ77YN7VCd2xqQ0
         3UB9dljwSi/hj6q/RqFF+PgxTPi1TpM7cltbAtr96Inz0sHkE2GDbljhg7U0KeicXxB6
         AFpA==
X-Received: by 10.112.83.133 with SMTP id q5mr2305278lby.40.1359125074411;
        Fri, 25 Jan 2013 06:44:34 -0800 (PST)
Received: from ds212plus (ppp91-77-56-11.pppoe.mtu-net.ru. [91.77.56.11])
        by mx.google.com with ESMTPS id ft8sm595909lab.9.2013.01.25.06.44.32
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 06:44:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by ds212plus (Postfix) with ESMTP id B7FB16005B;
	Fri, 25 Jan 2013 18:45:16 +0400 (MSK)
X-Mailer: git-send-email 1.8.1.1.10.g9255f3f
In-Reply-To: <20111111202636.GA20515@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214555>

Firefox on Windows by default is placed in "C:\Program Files\Mozilla Firefox"
folder, i.e. its path contains spaces. Before running this browser "git-web--browse"
tests version of Firefox to decide whether to use "-new-tab" option or not.

Quote browser path to avoid error during this test.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Reviewed-by: Jeff King <peff@peff.net>
---
 git-web--browse.sh         |  2 +-
 t/t9901-git-web--browse.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 1e82726..f96e5bd 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -149,7 +149,7 @@ fi
 case "$browser" in
 firefox|iceweasel|seamonkey|iceape)
 	# Check version because firefox < 2.0 does not support "-new-tab".
-	vers=$(expr "$($browser_path -version)" : '.* \([0-9][0-9]*\)\..*')
+	vers=$(expr "$("$browser_path" -version)" : '.* \([0-9][0-9]*\)\..*')
 	NEWTAB='-new-tab'
 	test "$vers" -lt 2 && NEWTAB=''
 	"$browser_path" $NEWTAB "$@" &
diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
index b0a6bad..30d5294 100755
--- a/t/t9901-git-web--browse.sh
+++ b/t/t9901-git-web--browse.sh
@@ -8,8 +8,21 @@ This test checks that git web--browse can handle various valid URLs.'
 . ./test-lib.sh
 
 test_web_browse () {
-	# browser=$1 url=$2
+	# browser=$1 url=$2 sleep_timeout=$3
+	sleep_timeout="$3"
 	git web--browse --browser="$1" "$2" >actual &&
+	# if $3 is set
+	# as far as Firefox is run in background (it is run with &)
+	# we trying to avoid race condition
+	# by waiting for "$sleep_timeout" seconds of timeout for 'fake_browser_ran' file appearance
+	(test -z "$sleep_timeout" || (
+	    for timeout in $(seq 1 $sleep_timeout); do
+			test -f fake_browser_ran && break
+			sleep 1
+		done
+		test $timeout -ne $sleep_timeout
+		)
+	) &&
 	tr -d '\015' <actual >text &&
 	test_cmp expect text
 }
@@ -48,6 +61,48 @@ test_expect_success \
 '
 
 test_expect_success \
+	'Firefox below v2.0 paths are properly quoted' '
+	echo fake: http://example.com/foo >expect &&
+	rm -f fake_browser_ran &&
+	cat >"fake browser" <<-\EOF &&
+	#!/bin/sh
+
+	: > fake_browser_ran
+	if test "$1" = "-version"; then
+		echo Fake Firefox browser version 1.2.3
+	else
+		# Firefox (in contrast to w3m) is run in background (with &)
+		# so redirect output to "actual"
+		echo fake: "$@" > actual
+	fi
+	EOF
+	chmod +x "fake browser" &&
+	git config browser.firefox.path "`pwd`/fake browser" &&
+	test_web_browse firefox http://example.com/foo 5
+'
+
+test_expect_success \
+	'Firefox not lower v2.0 paths are properly quoted' '
+	echo fake: -new-tab http://example.com/foo >expect &&
+	rm -f fake_browser_ran &&
+	cat >"fake browser" <<-\EOF &&
+	#!/bin/sh
+
+	: > fake_browser_ran
+	if test "$1" = "-version"; then
+		echo Fake Firefox browser version 2.0.0
+	else
+		# Firefox (in contrast to w3m) is run in background (with &)
+		# so redirect output to "actual"
+		echo fake: "$@" > actual
+	fi
+	EOF
+	chmod +x "fake browser" &&
+	git config browser.firefox.path "`pwd`/fake browser" &&
+	test_web_browse firefox http://example.com/foo 5
+'
+
+test_expect_success \
 	'browser command allows arbitrary shell code' '
 	echo "arg: http://example.com/foo" >expect &&
 	git config browser.custom.cmd "
-- 
1.8.1.1.10.g9255f3f
