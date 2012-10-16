From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 3/4v2] test-lib: provide lazy TIME_COMMAND prereq
Date: Tue, 16 Oct 2012 17:07:01 +0200
Message-ID: <28ca29e59c5905ba7232dcdbe4661f37ef90cac5.1350399860.git.git@drmicha.warpmail.net>
References: <007001cdaba8$5afc6c00$10f54400$@schmitz-digital.de>
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 17:07:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO8jm-0000HR-6W
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 17:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865Ab2JPPHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 11:07:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48452 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754598Ab2JPPHD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 11:07:03 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B773B2046F;
	Tue, 16 Oct 2012 11:07:02 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 16 Oct 2012 11:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=PdH2rQRHNXBi9oay8JpD/vFos
	AM=; b=fUpPefLf5D8MdWt4DuSSR4lmhZUUOSgaeMMvp2Fhm5lb+HOe9VY/tfO5z
	q7b/hDmKXF2Lk94gQycCiw5LlUBm8PRmvjDvrT3iY6ZsKvDn9KC30MnUQ155mSyR
	AsdTMhSZfigdcXx3eM/K/YbAGfP88Q3X0wdhimqAqLQz9dIqw8=
X-Sasl-enc: OH5jLwQmQrHrIx1LMPttZNjyCMs2dktfwk1JB0gw9VSV 1350400022
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5343D4827E6;
	Tue, 16 Oct 2012 11:07:02 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc2.304.g9f3ac5c
In-Reply-To: <007001cdaba8$5afc6c00$10f54400$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207834>

Some test want to use the time command (not the shell builtin) and test
for its availability at /usr/bin/time.

Provide a lazy prereq TIME_COMMAND which tests for $TEST_COMMAND_PATH,
which can be set from config.mak. It defaults to /usr/bin/time.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Here's what the make variable version could look like.
1/4 and 4/4 would stay as is, 2/4 could be dropped.

 t/Makefile    | 5 +++--
 t/test-lib.sh | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 88e289f..52b4039 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -13,6 +13,7 @@ TAR ?= $(TAR)
 RM ?= rm -f
 PROVE ?= prove
 DEFAULT_TEST_TARGET ?= test
+TIME_COMMAND_PATH ?= /usr/bin/time
 
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
@@ -27,11 +28,11 @@ test: pre-clean $(TEST_LINT)
 	$(MAKE) aggregate-results-and-cleanup
 
 prove: pre-clean $(TEST_LINT)
-	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
+	@echo "*** prove ***"; GIT_CONFIG=.git/config TIME_COMMAND_PATH=$(TIME_COMMAND_PATH) $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
-	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
+	@echo "*** $@ ***"; GIT_CONFIG=.git/config TIME_COMMAND_PATH=$(TIME_COMMAND_PATH) '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
 pre-clean:
 	$(RM) -r test-results
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 489bc80..173eb13 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -738,6 +738,10 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
 	esac
 '
 
+test_lazy_prereq TIME_COMMAND '
+	test -x "$TIME_COMMAND_PATH"
+'
+
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
 test -w / || test_set_prereq SANITY
-- 
1.8.0.rc2.304.g9f3ac5c
