From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] t0300: make alternate username tests more robust
Date: Wed, 14 Sep 2011 15:18:58 -0400
Message-ID: <20110914191857.GD28267@sigill.intra.peff.net>
References: <20110914191704.GA23201@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Brian Gernhardt <benji@silverinsanity.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 21:19:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uzC-0003lb-2G
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 21:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423Ab1INTTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 15:19:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36158
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757306Ab1INTTA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 15:19:00 -0400
Received: (qmail 13768 invoked by uid 107); 14 Sep 2011 19:19:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Sep 2011 15:19:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2011 15:18:58 -0400
Content-Disposition: inline
In-Reply-To: <20110914191704.GA23201@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181392>

One of the tests is to make sure that if we have a cached
credential "user/pass", that we ignore it when asking for
"--username=other", and instead get a new password. But
since askpass returns only a single fake value, we couldn't
differentiate between using the cached password and the new
one.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0300-credentials.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 09d5b15..41ab8cc 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -53,7 +53,11 @@ test_expect_success 'setup helper scripts' '
 	#!/bin/sh
 	echo >&2 askpass: $*
 	what=`echo $1 | tr A-Z a-z | tr -cd a-z`
-	echo "askpass-$what"
+	if test -f "askpass-$what"; then
+		cat "askpass-$what"
+	else
+		echo "askpass-$what"
+	fi
 	EOF
 	chmod +x askpass &&
 	GIT_ASKPASS=askpass &&
@@ -226,9 +230,11 @@ test_expect_success 'credential-cache requires matching usernames' '
 	askpass: Username:
 	askpass: Password:
 	EOF
+	test_when_finished "rm -f askpass-password" &&
+	echo other-password >askpass-password &&
 	check --unique=host --username=other cache <<-\EOF
 	username=other
-	password=askpass-password
+	password=other-password
 	--
 	askpass: Password:
 	EOF
-- 
1.7.6.252.ge9c18
