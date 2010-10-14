From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC PATCH] Makefile: new prove target for running the tests with TAP
Date: Thu, 14 Oct 2010 10:53:36 +0200
Message-ID: <5c46df95f93b56aa2fce56c7efe7b2be80642c8b.1287045908.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 14 10:53:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6JZ2-0002j7-WC
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 10:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034Ab0JNIxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 04:53:22 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48750 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755030Ab0JNIxV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 04:53:21 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 68FF743C;
	Thu, 14 Oct 2010 04:53:20 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 14 Oct 2010 04:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=LvdyHsoCK/hoSbW4Vdq8y/tGhwI=; b=U2n/UycquJ3abFCkcbV05x8zAtGUPqYNua+rs3nm9NrPy50uA3Hskc1QGt830GVGxrlcEKzFYrj7xI6yOqVaj4frI08YPuXg3iUmKrJueoa3Mu3YXkyQ91cRzFLpfE2M5Pm/ygkKfNtrb6kNqrapFnJlENIdzQLvEZ6qJQL5tqA=
X-Sasl-enc: vBjyhSG7YArBpXhUdZZ44/DnnOBV2n2xzQQ2hXRwCsLe 1287046399
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DD8E640374D;
	Thu, 14 Oct 2010 04:53:19 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.1.184.g5b1fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159029>

Introduce a new make target "prove" which runs the tests via "prove" (or
$(PROVE) if set) so that one does not have to cd around any more. One
can simply use "make prove" for "make test" or go wild as in:

GIT_SKIP_TESTS='t[0-4]??? t91?? t9200.8' GIT_PROVE_OPTS="-j9 -v" GIT_TEST_OPTS="--verbose --debug" make prove

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
RFC also because of lack of doc, and:

Currently, one can do

make -C t t6010-merge-base.sh

or even

make -C t t601*

which is cool but undocumented. If we want this with prove it requires more
effort, or shoving prove into the $(T) target rule which is doable, of course.
I'm just wondering whether it's accepted to introduce a specific rule for prove
at all.

 Makefile   |    3 +++
 t/Makefile |    5 +++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 1f1ce04..3478515 100644
--- a/Makefile
+++ b/Makefile
@@ -2046,6 +2046,9 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
 
+prove: all
+	$(MAKE) -C t/ prove
+
 test-ctype$X: ctype.o
 
 test-date$X: date.o ctype.o
diff --git a/t/Makefile b/t/Makefile
index c7baefb..e4661c0 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -11,6 +11,7 @@ SHELL_PATH ?= $(SHELL)
 PERL_PATH ?= /usr/bin/perl
 TAR ?= $(TAR)
 RM ?= rm -f
+PROVE ?= prove
 
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
@@ -21,6 +22,10 @@ TSVN = $(wildcard t91[0-9][0-9]-*.sh)
 all: pre-clean
 	$(MAKE) aggregate-results-and-cleanup
 
+prove: pre-clean
+	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
+	$(MAKE) clean
+
 $(T):
 	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
-- 
1.7.3.1.184.g5b1fd
