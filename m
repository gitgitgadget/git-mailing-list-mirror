From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 5/5] test-lib-functions: detect test_when_finished in subshell
Date: Sat,  5 Sep 2015 14:12:49 +0100
Message-ID: <59a8583f79c5ac4661f140262e01cd602286f740.1441458341.git.john@keeping.me.uk>
References: <20150905085429.GB25039@sigill.intra.peff.net>
 <cover.1441458341.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 15:14:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYDIP-0000Uz-AP
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 15:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbbIENOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 09:14:15 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:50850 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbIENON (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 09:14:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 18964CDA566;
	Sat,  5 Sep 2015 14:14:13 +0100 (BST)
X-Quarantine-ID: <v81h7sJXtzQ7>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id v81h7sJXtzQ7; Sat,  5 Sep 2015 14:14:12 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id C57C6CDA603;
	Sat,  5 Sep 2015 14:13:56 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441458341.git.john@keeping.me.uk>
In-Reply-To: <cover.1441458341.git.john@keeping.me.uk>
References: <cover.1441458341.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277374>

test_when_finished does nothing in a subshell because the change to
test_cleanup does not affect the parent.

There is no POSIX way to detect that we are in a subshell ($$ and $PPID
are specified to remain unchanged), but we can detect it on Bash and
fall back to ignoring the bug on other shells.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/test-lib-functions.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0e80f37..6dffb8b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -736,6 +736,11 @@ test_seq () {
 # what went wrong.
 
 test_when_finished () {
+	# We cannot detect when we are in a subshell in general, but by
+	# doing so on Bash is better than nothing (the test will
+	# silently pass on other shells).
+	test "${BASH_SUBSHELL-0}" = 0 ||
+	error "bug in test script: test_when_finished does nothing in a subshell"
 	test_cleanup="{ $*
 		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
 }
-- 
2.5.0.466.g9af26fa
