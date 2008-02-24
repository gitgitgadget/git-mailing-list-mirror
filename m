From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] send-email: test compose functionality
Date: Sun, 24 Feb 2008 16:04:14 -0500
Message-ID: <20080224210414.GB9150@coredump.intra.peff.net>
References: <20080224205720.GA7085@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 22:05:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTO1s-0007Kz-It
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 22:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbYBXVER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 16:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbYBXVER
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 16:04:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4544 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753315AbYBXVEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 16:04:16 -0500
Received: (qmail 1857 invoked by uid 111); 24 Feb 2008 21:04:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Feb 2008 16:04:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Feb 2008 16:04:14 -0500
Content-Disposition: inline
In-Reply-To: <20080224205720.GA7085@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74963>

This is just a basic sanity check that --compose works at
all.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9001-send-email.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4975048..cbbfa9c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -137,4 +137,33 @@ test_expect_success 'Valid In-Reply-To when prompting' '
 	! grep "^In-Reply-To: < *>" msgtxt1
 '
 
+test_expect_success 'setup fake editor' '
+	(echo "#!/bin/sh" &&
+	 echo "echo fake edit >>\$1"
+	) >fake-editor &&
+	chmod +x fake-editor
+'
+
+test_expect_success '--compose works' '
+	clean_fake_sendmail &&
+	echo y | \
+		GIT_EDITOR=$(pwd)/fake-editor \
+		GIT_SEND_EMAIL_NOTTY=1 \
+		git send-email \
+		--compose --subject foo \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches \
+		2>errors
+'
+
+test_expect_success 'first message is compose text' '
+	grep "^fake edit" msgtxt1
+'
+
+test_expect_success 'second message is patch' '
+	grep "Subject:.*Second" msgtxt2
+'
+
 test_done
-- 
1.5.4.3.307.gacd7
