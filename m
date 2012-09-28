From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 4/5] completion: test __gitcomp() and __gitcomp_nl() with
 expandable words
Date: Fri, 28 Sep 2012 12:09:34 +0200
Message-ID: <1348826975-2225-4-git-send-email-szeder@ira.uka.de>
References: <20120928100530.GL10144@goldbirke>
 <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 12:10:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THXWZ-0005cK-9S
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 12:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456Ab2I1KKG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 06:10:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:58622 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341Ab2I1KKE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 06:10:04 -0400
Received: from localhost6.localdomain6 (p5B130716.dip0.t-ipconnect.de [91.19.7.22])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0LfHq4-1TodGa23iK-00ow4L; Fri, 28 Sep 2012 12:10:00 +0200
X-Mailer: git-send-email 1.7.12.1.438.g7dfa67b
In-Reply-To: <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:muUs5lfsyNThz3HGz/+sVEejzZvij9/6mcjUJy7TeMd
 T9AtcB3JCsJrlHKswSQo/ywtDUy//LjrrbYcCLvJzB/DqXOYYr
 1kVvYr3zwpY/CqxC69C+fGz/GL7EPScLrM6JM+X7fBEbux0Vtt
 +P7adr6SSMLAgF8koczt2FOcac0ykI2vR0ptBxkZ/ibDjuMXlf
 ZQKVegCEV2DLbj19vG7/bPd3GvmC3nW+aWx/aonDhT19o2j3Wh
 s1kLe0Efjb3/lKBnVegpne8ZGVlsPY3Nv2Od5brEZ3FmtcUnXp
 eQDRUjS7jz6zJMsu9JQneNtG7givAmeTUfblZYWqOSfVKGoQyB
 1SOc4LFzdQLJJpHrlskr+V1RB/rlu7u3kMJ4H47l0s52phDj+t
 b75E8qRzNkwbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206551>

compgen performs expansion on all words in the list given to its -W
option.  This breaks completion in various ways if one of those words
can be expanded.  The funniest breakage is probably this, as the
command_not_found_handle kicks in:

$ git branch '$(foo)'
$ git branch <TAB>No command 'foo' found, did you mean:
Command 'fio' from package 'fio' (universe)
Command 'goo' from package 'goo' (universe)
Command 'fop' from package 'fop' (main)
Command 'fox' from package 'objcryst-fox' (universe)
Command 'xoo' from package 'xoo' (universe)
Command 'zoo' from package 'zoo' (universe)
foo: command not found

Document this breakage with tests.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 01f33220..4af2a149 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -146,6 +146,22 @@ test_expect_success '__gitcomp - suffix' '
 	test_cmp expected out
 '
=20
+test_expect_failure '__gitcomp - expandable words' '
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	$foo Z
+	$(bar) Z
+	${baz} Z
+	EOF
+	(
+		local -a COMPREPLY &&
+		cur=3D"" &&
+		__gitcomp "\$foo \$(bar) \${baz}" &&
+		IFS=3D"$newline" &&
+		echo "${COMPREPLY[*]}" > out
+	) &&
+	test_cmp expected out
+'
+
 test_expect_success '__gitcomp_nl - trailing space' '
 	sed -e "s/Z$//" >expected <<-\EOF &&
 	maint Z
@@ -193,6 +209,22 @@ test_expect_success '__gitcomp_nl - suffix' '
 	test_cmp expected out
 '
=20
+test_expect_failure '__gitcomp_nl - expandable words' '
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	$foo Z
+	$(bar) Z
+	${baz} Z
+	EOF
+	(
+		local -a COMPREPLY &&
+		cur=3D"" &&
+		__gitcomp_nl "\$foo$newline\$(bar)$newline\${baz}" &&
+		IFS=3D"$newline" &&
+		echo "${COMPREPLY[*]}" > out
+	) &&
+	test_cmp expected out
+'
+
 test_expect_success 'basic' '
 	run_completion git "" &&
 	# built-in
--=20
1.7.12.1.438.g7dfa67b
