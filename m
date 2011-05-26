From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t: test subject handling in format-patch / am pipeline
Date: Thu, 26 May 2011 16:41:18 -0400
Message-ID: <20110526204118.GA31340@sigill.intra.peff.net>
References: <20110526203625.GA31018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Thu May 26 22:41:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhN8-0004yS-RX
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 22:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954Ab1EZUlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 16:41:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55352
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932934Ab1EZUlV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 16:41:21 -0400
Received: (qmail 16956 invoked by uid 107); 26 May 2011 20:41:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 16:41:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 16:41:18 -0400
Content-Disposition: inline
In-Reply-To: <20110526203625.GA31018@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174562>

Commit a1f6baa (format-patch: wrap long header lines,
2011-02-23) changed format-patch's behavior with respect to
long header lines, but made no accompanying changes to the
receiving side. It was thought that "git am" would handle
these folded subjects fine, but there is a regression when
using "am -k".

Let's add a test documenting this. While we're at it, let's
give more complete test coverage to document what should be
happening in each case. We test three types of subjects:
a short one, one long enough to require wrapping, and a
multiline subject. For each, we test these three
combinations:

  format-patch | am
  format-patch -k | am
  format-patch -k | am -k

We don't bother testing "format-patch | am -k", which is
nonsense (you will be adding in [PATCH] cruft to each
subject).

This reveals the regression above (long subjects have
linebreaks introduced via "format-patch -k | am -k"),
as well as an existing non-optimal behavior (multiline
subjects are not preserved using "-k").

Signed-off-by: Jeff King <peff@peff.net>
---
This can go straight on top of the jk/format-patch-multiline-header
which went into v1.7.5 (the tip was c22e7de).

 t/t4152-am-subjects.sh |   77 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)
 create mode 100755 t/t4152-am-subjects.sh

diff --git a/t/t4152-am-subjects.sh b/t/t4152-am-subjects.sh
new file mode 100755
index 0000000..7222c06
--- /dev/null
+++ b/t/t4152-am-subjects.sh
@@ -0,0 +1,77 @@
+#!/bin/sh
+
+test_description='test subject preservation with format-patch | am'
+. ./test-lib.sh
+
+make_patches() {
+	type=$1
+	subject=$2
+	test_expect_success "create patches with $type subject" '
+		git reset --hard baseline &&
+		echo $type >file &&
+		git commit -a -m "$subject" &&
+		git format-patch -1 --stdout >$type.patch &&
+		git format-patch -1 --stdout -k >$type-k.patch
+	'
+}
+
+check_subject() {
+	git reset --hard baseline &&
+	git am $2 $1.patch &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'setup baseline commit' '
+	test_commit baseline file
+'
+
+SHORT_SUBJECT='short subject'
+make_patches short "$SHORT_SUBJECT"
+
+LONG_SUBJECT1='this is a long subject that is virtually guaranteed'
+LONG_SUBJECT2='to require wrapping via format-patch if it is all'
+LONG_SUBJECT3='going to appear on a single line'
+LONG_SUBJECT="$LONG_SUBJECT1 $LONG_SUBJECT2 $LONG_SUBJECT3"
+make_patches long "$LONG_SUBJECT"
+
+MULTILINE_SUBJECT="$LONG_SUBJECT1
+$LONG_SUBJECT2
+$LONG_SUBJECT3"
+make_patches multiline "$MULTILINE_SUBJECT"
+
+echo "$SHORT_SUBJECT" >expect
+test_expect_success 'short subject preserved (format-patch | am)' '
+	check_subject short
+'
+test_expect_success 'short subject preserved (format-patch -k | am)' '
+	check_subject short-k
+'
+test_expect_success 'short subject preserved (format-patch -k | am -k)' '
+	check_subject short-k -k
+'
+
+echo "$LONG_SUBJECT" >expect
+test_expect_success 'long subject preserved (format-patch | am)' '
+	check_subject long
+'
+test_expect_success 'long subject preserved (format-patch -k | am)' '
+	check_subject long-k
+'
+test_expect_failure 'long subject preserved (format-patch -k | am -k)' '
+	check_subject long-k -k
+'
+
+echo "$LONG_SUBJECT" >expect
+test_expect_success 'multiline subject unwrapped (format-patch | am)' '
+	check_subject multiline
+'
+test_expect_success 'multiline subject unwrapped (format-patch -k | am)' '
+	check_subject multiline-k
+'
+echo "$MULTILINE_SUBJECT" >expect
+test_expect_failure 'multiline subject preserved (format-patch -k | am -k)' '
+	check_subject multiline-k -k
+'
+
+test_done
-- 
1.7.4.5.26.g0c6a2
