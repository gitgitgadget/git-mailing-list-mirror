From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] archive test: test new --fix-attributes feature
Date: Wed, 15 Apr 2009 19:28:37 -0700
Message-ID: <1239848917-14399-6-git-send-email-gitster@pobox.com>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com>
 <1239848917-14399-2-git-send-email-gitster@pobox.com>
 <1239848917-14399-3-git-send-email-gitster@pobox.com>
 <1239848917-14399-4-git-send-email-gitster@pobox.com>
 <1239848917-14399-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 04:31:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuHNg-0000r0-AF
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 04:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757585AbZDPC3A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2009 22:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756479AbZDPC3A
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 22:29:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757034AbZDPC26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 22:28:58 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E9BACAA3C4;
	Wed, 15 Apr 2009 22:28:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E81D6AA3C3; Wed,
 15 Apr 2009 22:28:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc0.6.g08087
In-Reply-To: <1239848917-14399-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 56B65AA6-2A2E-11DE-9A41-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116660>

=46rom: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5001-archive-attr.sh |   62 +++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100755 t/t5001-archive-attr.sh

diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
new file mode 100755
index 0000000..b754f21
--- /dev/null
+++ b/t/t5001-archive-attr.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+
+test_description=3D'git archive attribute tests'
+
+. ./test-lib.sh
+
+SUBSTFORMAT=3D%H%n
+
+test_expect_success 'setup' '
+	echo ignored >ignored &&
+	echo ignored export-ignore >>.git/info/attributes &&
+	git add ignored &&
+
+	echo ignored by tree >ignored-by-tree &&
+	echo ignored-by-tree export-ignore >.gitattributes &&
+	git add ignored-by-tree .gitattributes &&
+
+	echo ignored by worktree >ignored-by-worktree &&
+	echo ignored-by-worktree export-ignore >.gitattributes &&
+	git add ignored-by-worktree &&
+
+	printf "A\$Format:%s\$O" "$SUBSTFORMAT" >nosubstfile &&
+	printf "A\$Format:%s\$O" "$SUBSTFORMAT" >substfile1 &&
+	printf "A not substituted O" >substfile2 &&
+	echo "substfile?" export-subst >>.git/info/attributes &&
+	git add nosubstfile substfile1 substfile2 &&
+
+	git commit -m.
+'
+
+test_expect_success 'git archive' '
+	git archive HEAD >archive.tar &&
+	(mkdir archive && cd archive && "$TAR" xf -) <archive.tar
+'
+
+test_expect_success 'git archive with worktree attributes' '
+	git archive --fix-attributes HEAD >worktree.tar &&
+	(mkdir worktree && cd worktree && "$TAR" xf -) <worktree.tar
+'
+
+test_expect_success 'export-ignore' '
+	test ! -e archive/ignored &&
+	test ! -e archive/ignored-by-tree &&
+	test   -e archive/ignored-by-worktree &&
+	test ! -e worktree/ignored &&
+	test   -e worktree/ignored-by-tree &&
+	test ! -e worktree/ignored-by-worktree
+'
+
+test_expect_success 'export-subst' '
+	git log "--pretty=3Dformat:A${SUBSTFORMAT}O" HEAD >substfile1.expecte=
d &&
+	test_cmp nosubstfile archive/nosubstfile &&
+	test_cmp substfile1.expected archive/substfile1 &&
+	test_cmp substfile2 archive/substfile2
+'
+
+test_expect_success 'git tar-tree vs. git archive with worktree attrib=
utes' '
+	git tar-tree HEAD >tar-tree.tar &&
+	test_cmp worktree.tar tar-tree.tar
+'
+
+test_done
--=20
1.6.3.rc0.6.g08087
