From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/4] tmp: remote-helper: add timers to catch errors
Date: Tue,  2 Apr 2013 04:31:48 -0600
Message-ID: <1364898709-21583-4-git-send-email-felipe.contreras@gmail.com>
References: <1364898709-21583-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 12:33:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMyWr-0002XF-VB
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 12:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab3DBKc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 06:32:57 -0400
Received: from mail-gg0-f170.google.com ([209.85.161.170]:55733 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761062Ab3DBKcz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 06:32:55 -0400
Received: by mail-gg0-f170.google.com with SMTP id k4so22486ggn.1
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 03:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=CC2OslaCBDoRc9829XWNjdtp3piFdwrEwApH4TxgDnQ=;
        b=0abRgq0QLp9p5Z20eXSEFzSd3FH4wU2O8L80X5l8hHgwpDj26gKrrWnazvN3Gzmv6R
         5m6ff82GeHYcgeigEYxBMUOLlSuuwjqH2XzKULmlZGs/2euTkSfxjdI2HrMW03Yr0ErL
         Zp3vxQy9H8i/zoYU/B4Lz+FZcC7i5Qbk2dSSPmPH9vYvpqA+7EzanXHqVG/jR9KZii2d
         WeRX3BRiRtcH1i0SmzqsAMYHpq76gHo+ofAyVvlcpd2eTbVUgpl3wjC1HHTq+UQGZBVs
         zK1jd5lQjHhl7O7tdqvKtWDpabg65wSPnWDwC82pbhHs4LQaWxntj55d1L7YW8iYXWpv
         16xA==
X-Received: by 10.236.77.196 with SMTP id d44mr13952550yhe.44.1364898774756;
        Tue, 02 Apr 2013 03:32:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id v60sm1911730yhh.23.2013.04.02.03.32.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 03:32:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364898709-21583-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219765>

This way the test reliably succeeds (in catching the failure).

Not sure what's the proper way to do this, but here it is for the
record.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit        | 1 +
 t/t5801-remote-helpers.sh | 2 +-
 transport-helper.c        | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index ca0cf09..6ae1b7f 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -75,6 +75,7 @@ do
 	export)
 		if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
 		then
+			sleep 1 # don't let fast-export get SIGPIPE
 			exit -1
 		fi
 
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index efe67e2..d6702b4 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -176,7 +176,7 @@ test_expect_success 'proper failure checks for fetching' '
 '
 
 # We sleep to give fast-export a chance to catch the SIGPIPE
-test_expect_failure 'proper failure checks for pushing' '
+test_expect_success 'proper failure checks for pushing' '
 	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
 	export GIT_REMOTE_TESTGIT_FAILURE &&
 	cd local &&
diff --git a/transport-helper.c b/transport-helper.c
index dfdfa7a..f0d28aa 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -823,6 +823,9 @@ static int push_refs_with_export(struct transport *transport,
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
 
+	if (getenv("GIT_REMOTE_TESTGIT_FAILURE"))
+		sleep(2);
+
 	if (!check_command(data->helper))
 		die("Error while running helper");
 
-- 
1.8.2
