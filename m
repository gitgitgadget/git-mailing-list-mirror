From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 3/3] archive: do not read .gitattributes in working
      directory
Date: Mon, 13 Apr 2009 14:18:39 +0200
Message-ID: <49E32D9F.2050906@lsrfire.ath.cx>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com> 	<1239260490-6318-2-git-send-email-pclouds@gmail.com> <1239260490-6318-3-git-send-email-pclouds@gmail.com> 	<1239260490-6318-4-git-send-email-pclouds@gmail.com> <7vws9u2ov4.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0904090353s4ec770bfk3cd3f6559c367a20@mail.gmail.com> <49E316CD.7030001@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Apr 13 14:20:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtL9L-00080p-0H
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 14:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbZDMMS7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 08:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbZDMMS6
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 08:18:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:40564 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbZDMMS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 08:18:58 -0400
Received: from [10.0.1.101] (p57B7FFE1.dip.t-dialin.net [87.183.255.225])
	by india601.server4you.de (Postfix) with ESMTPSA id A7B652F8056;
	Mon, 13 Apr 2009 14:18:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <49E316CD.7030001@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116435>

Ren=C3=A9 Scharfe schrieb:
> I
> think it makes sense to create a separate script for the new tests an=
d
> eventually move the existing archive attribute tests there.

Something like this?


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
