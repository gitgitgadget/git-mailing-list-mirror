From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] t0300: make askpass tests a little more robust
Date: Wed, 14 Sep 2011 15:18:15 -0400
Message-ID: <20110914191814.GC28267@sigill.intra.peff.net>
References: <20110914191704.GA23201@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Brian Gernhardt <benji@silverinsanity.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 21:18:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uyU-0003Ro-9I
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 21:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757418Ab1INTSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 15:18:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36153
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757306Ab1INTSR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 15:18:17 -0400
Received: (qmail 13737 invoked by uid 107); 14 Sep 2011 19:19:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Sep 2011 15:19:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2011 15:18:15 -0400
Content-Disposition: inline
In-Reply-To: <20110914191704.GA23201@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181391>

Our fake askpass always just returned "askpass-result";
let's actually have it return a different fake value for
usernames and passwords, to be sure values are getting
routed correctly.

All tests should still pass.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0300-credentials.sh |   77 ++++++++++++++++++++++++-----------------------
 1 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 5d54976..09d5b15 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -52,7 +52,8 @@ test_expect_success 'setup helper scripts' '
 	cat >askpass <<-\EOF &&
 	#!/bin/sh
 	echo >&2 askpass: $*
-	echo askpass-result
+	what=`echo $1 | tr A-Z a-z | tr -cd a-z`
+	echo "askpass-$what"
 	EOF
 	chmod +x askpass &&
 	GIT_ASKPASS=askpass &&
@@ -155,8 +156,8 @@ test_expect_success 'do not bother completing already-full credential' '
 # askpass helper is run, we know the internal getpass is working.
 test_expect_success 'empty methods falls back to internal getpass' '
 	check <<-\EOF
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
@@ -166,7 +167,7 @@ test_expect_success 'empty methods falls back to internal getpass' '
 test_expect_success 'internal getpass does not ask for known username' '
 	check --username=foo <<-\EOF
 	username=foo
-	password=askpass-result
+	password=askpass-password
 	--
 	askpass: Password:
 	EOF
@@ -176,7 +177,7 @@ test_expect_success 'internal getpass can pull from config' '
 	git config credential.foo.username configured-username
 	check --unique=foo <<-\EOF
 	username=configured-username
-	password=askpass-result
+	password=askpass-password
 	--
 	askpass: Password:
 	EOF
@@ -185,15 +186,15 @@ test_expect_success 'internal getpass can pull from config' '
 test_expect_success 'credential-cache caches password' '
 	test_when_finished "git credential-cache --exit" &&
 	check --unique=host cache <<-\EOF &&
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
 	EOF
 	check --unique=host cache <<-\EOF
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	EOF
 '
@@ -201,15 +202,15 @@ test_expect_success 'credential-cache caches password' '
 test_expect_success 'credential-cache requires matching unique token' '
 	test_when_finished "git credential-cache --exit" &&
 	check --unique=host cache <<-\EOF &&
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
 	EOF
 	check --unique=host2 cache <<-\EOF
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
@@ -219,15 +220,15 @@ test_expect_success 'credential-cache requires matching unique token' '
 test_expect_success 'credential-cache requires matching usernames' '
 	test_when_finished "git credential-cache --exit" &&
 	check --unique=host cache <<-\EOF &&
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
 	EOF
 	check --unique=host --username=other cache <<-\EOF
 	username=other
-	password=askpass-result
+	password=askpass-password
 	--
 	askpass: Password:
 	EOF
@@ -236,16 +237,16 @@ test_expect_success 'credential-cache requires matching usernames' '
 test_expect_success 'credential-cache times out' '
 	test_when_finished "git credential-cache --exit || true" &&
 	check --unique=host "cache --timeout=1" <<-\EOF &&
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
 	EOF
 	sleep 2 &&
 	check --unique=host cache <<-\EOF
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
@@ -255,18 +256,18 @@ test_expect_success 'credential-cache times out' '
 test_expect_success 'credential-cache removes rejected credentials' '
 	test_when_finished "git credential-cache --exit || true" &&
 	check --unique=host cache <<-\EOF &&
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
 	EOF
-	check --reject --unique=host --username=askpass-result cache <<-\EOF &&
+	check --reject --unique=host --username=askpass-username cache <<-\EOF &&
 	--
 	EOF
 	check --unique=host cache <<-\EOF
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
@@ -276,15 +277,15 @@ test_expect_success 'credential-cache removes rejected credentials' '
 test_expect_success 'credential-store stores password' '
 	test_when_finished "rm -f .git-credentials" &&
 	check --unique=host store <<-\EOF &&
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
 	EOF
 	check --unique=host store <<-\EOF
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	EOF
 '
@@ -292,15 +293,15 @@ test_expect_success 'credential-store stores password' '
 test_expect_success 'credential-store requires matching unique token' '
 	test_when_finished "rm -f .git-credentials" &&
 	check --unique=host store <<-\EOF &&
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
 	EOF
 	check --unique=host2 store <<-\EOF
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
@@ -310,18 +311,18 @@ test_expect_success 'credential-store requires matching unique token' '
 test_expect_success 'credential-store removes rejected credentials' '
 	test_when_finished "rm -f .git-credentials" &&
 	check --unique=host store <<-\EOF &&
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
 	EOF
-	check --reject --unique=host --username=askpass-result store <<-\EOF &&
+	check --reject --unique=host --username=askpass-username store <<-\EOF &&
 	--
 	EOF
 	check --unique=host store <<-\EOF
-	username=askpass-result
-	password=askpass-result
+	username=askpass-username
+	password=askpass-password
 	--
 	askpass: Username:
 	askpass: Password:
-- 
1.7.6.252.ge9c18
