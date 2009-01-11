From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 4/4] word diff: test customizable word splits
Date: Sun, 11 Jan 2009 11:27:14 +0100
Message-ID: <0da6ba6dd66a2de84be34f58566d0d6ccbd7e949.1231669012.git.trast@student.ethz.ch>
References: <cover.1231669012.git.trast@student.ethz.ch>
 <4aea85caafd38a058145c5769fe8a30ffdbd4d13.1231669012.git.trast@student.ethz.ch>
 <529cd830908f018f796dbc46d3b055c1f8ba9c1b.1231669012.git.trast@student.ethz.ch>
 <72242bd75fa8d55c2afc723f8539ef56f2569d3e.1231669012.git.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 11:29:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLxYy-0002xC-LA
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 11:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbZAKK1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 05:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbZAKK1Y
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 05:27:24 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:42017 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbZAKK1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 05:27:21 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 11:27:06 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 11:27:05 +0100
X-Mailer: git-send-email 1.6.1.279.g41f0
In-Reply-To: <72242bd75fa8d55c2afc723f8539ef56f2569d3e.1231669012.git.trast@student.ethz.ch>
In-Reply-To: <7vr63atykr.fsf@gitster.siamese.dyndns.org>
References: <7vr63atykr.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 11 Jan 2009 10:27:05.0556 (UTC) FILETIME=[265CF940:01C973D7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105164>

Several tests for regex-configured word splits via command line and
gitattributes.  For good measure we also do a basic test of the
default --color-words since it was so far not covered at all.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t4033-diff-color-words.sh |   90 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100755 t/t4033-diff-color-words.sh

diff --git a/t/t4033-diff-color-words.sh b/t/t4033-diff-color-words.sh
new file mode 100755
index 0000000..536cdac
--- /dev/null
+++ b/t/t4033-diff-color-words.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+
+
+test_description='diff --color-words'
+. ./test-lib.sh
+
+cat <<EOF > test_a
+foo_bar_baz
+a qu_ux b c
+alpha beta gamma delta
+EOF
+
+cat <<EOF > test_b
+foo_baz_baz
+a qu_new_ux b c
+alpha 4 2 delta
+EOF
+
+# t4026-diff-color.sh tests the color escapes, so we assume they do
+# not change
+
+munge () {
+    tail -n +5 | tr '\033' '!'
+}
+
+cat <<EOF > expect-plain
+![36m@@ -1,3 +1,3 @@![m
+![31mfoo_bar_baz![m![32mfoo_baz_baz![m
+a ![m![31mqu_ux ![m![32mqu_new_ux ![mb ![mc![m
+alpha ![m![31mbeta ![m![31mgamma ![m![32m4 ![m![32m2 ![mdelta![m
+EOF
+
+test_expect_success 'default settings' '
+	git diff --no-index --color-words test_a test_b |
+		munge > actual-plain &&
+	test_cmp expect-plain actual-plain
+'
+
+test_expect_success 'trivial regex yields same as default' '
+	git diff --no-index --color-words="\\S+" test_a test_b |
+		munge > actual-trivial &&
+	test_cmp expect-plain actual-trivial
+'
+
+cat <<EOF > expect-chars
+![36m@@ -1,3 +1,3 @@![m
+f![mo![mo![m_![mb![ma![m![31mr![m![32mz![m_![mb![ma![mz![m
+a ![mq![mu![m_![m![32mn![m![32me![m![32mw![m![32m_![mu![mx ![mb ![mc![m
+a![ml![mp![mh![ma ![m![31mb![m![31me![m![31mt![m![31ma ![m![31mg![m![31ma![m![31mm![m![31mm![m![31ma ![m![32m4 ![m![32m2 ![md![me![ml![mt![ma![m
+EOF
+
+test_expect_success 'character by character regex' '
+	git diff --no-index --color-words="\\S" test_a test_b |
+		munge > actual-chars &&
+	test_cmp expect-chars actual-chars
+'
+
+cat <<EOF > expect-nontrivial
+![36m@@ -1,3 +1,3 @@![m
+foo![m_![m![31mbar![m![32mbaz![m_![mbaz![m
+a ![mqu![m_![m![32mnew![m![32m_![mux ![mb ![mc![m
+alpha ![m![31mbeta ![m![31mgamma ![m![32m4![m![32m ![m![32m2![m![32m ![mdelta![m
+EOF
+
+test_expect_success 'nontrivial regex' '
+	git diff --no-index --color-words="[a-z]+|_" test_a test_b |
+		munge > actual-nontrivial &&
+	test_cmp expect-nontrivial actual-nontrivial
+'
+
+test_expect_success 'set a diff driver' '
+	git config diff.testdriver.wordregex "\\S" &&
+	cat <<EOF > .gitattributes
+test_* diff=testdriver
+EOF
+'
+
+test_expect_success 'use default supplied by driver' '
+	git diff --no-index --color-words test_a test_b |
+		munge > actual-chars-2 &&
+	test_cmp expect-chars actual-chars-2
+'
+
+test_expect_success 'option overrides default' '
+	git diff --no-index --color-words="[a-z]+|_" test_a test_b |
+		munge > actual-nontrivial-2 &&
+	test_cmp expect-nontrivial actual-nontrivial-2
+'
+
+test_done
-- 
1.6.1.269.g0769
