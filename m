From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 4/7] completion: add tests for invalid variable name among
 completion words
Date: Sat, 17 Nov 2012 12:05:50 +0100
Message-ID: <1353150353-29874-5-git-send-email-szeder@ira.uka.de>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 12:06:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZgEf-0007IF-Qk
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 12:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495Ab2KQLGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 06:06:40 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:52589 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab2KQLGj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 06:06:39 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LuWn6-1T9Jdl36SO-010A6f; Sat, 17 Nov 2012 12:06:30 +0100
X-Mailer: git-send-email 1.8.0.220.g4d14ece
In-Reply-To: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:wI8WZagZV0u0lzSmuJN/ExP7QK2Zm21xqAhXEb7BCCB
 /6uFjrdAVVya0QmSw8UO4aX9Um5D1PmtylEoaAzTuE+HQ0YmAO
 /ORbeaJwGimA3iTtKCwsyqC7ohublXqxLIXUi06Lha53uv9v2h
 4s7VtBhKS1hxh1YDwxbWv1F7A/Jsw3px0gra5nWPxJznfyCf2f
 R6Ds25mMX5qWf1g4iNoOeNOCGD/dOtpwtUfXm5OlWsnCaxVAst
 fBC9YTtBa4aKZt2DlXZ6zd7EmTJ2O2qrWmnE9FmPUUZxveJWty
 6PyfIEH2BbCAVSsm7ITrNXiP851H360Ov3EspnOM1cjCSw3jcx
 zLCnGEfF2JF4jNK5vaFwElsr9zhSTfIPyeOBVvvy0qFRWMOATz
 uVkAZ3zN6IKdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209944>

The compgen Bash-builtin performs expansion on all words in the
wordlist given to its -W option, breaking Git's completion script in
various ways if one of those words can be expanded.  The breakage can
be simply bogus possible completion words, but it can also be a
failure:

  $ git branch '${foo.bar}'
  $ git checkout <TAB>
  bash: ${foo.bar}: bad substitution

${foo.bar} is an invalid variable name, which triggers the failure
when compgen attempts to expand it, completely breaking refs
completion.  The same applies to e.g. completing the <tree>:<path>
notation when a filename contains a similar expandable substring.

Since both __gitcomp() and __gitcomp_nl() rely on compgen, both are
affected by this issue.  So add a simple test for each of them to
check that such a word doesn't cause failures (but don't check the
resulting possible completion words for now, because that should be
quoted properly, and that's a separate topic).

Reported-by: Jeroen Meijer <jjgmeijer@hotmail.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 32b3e8c4..a108ec1c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -71,6 +71,7 @@ test_completion_long ()
 }
=20
 newline=3D$'\n'
+invalid_variable_name=3D"${foo.bar}"
=20
 test_expect_success '__gitcomp - trailing space - options' '
 	sed -e "s/Z$//" >expected <<-\EOF &&
@@ -155,6 +156,12 @@ test_expect_success '__gitcomp - suffix' '
 	test_cmp expected out
 '
=20
+test_expect_failure '__gitcomp - doesnt fail because of invalid variab=
le name' '
+	(
+		__gitcomp "$invalid_variable_name"
+	)
+'
+
 test_expect_success '__gitcomp_nl - trailing space' '
 	sed -e "s/Z$//" >expected <<-\EOF &&
 	maint Z
@@ -239,6 +246,12 @@ test_expect_success '__gitcomp_nl - no suffix' '
 	test_cmp expected out
 '
=20
+test_expect_failure '__gitcomp_nl - doesnt fail because of invalid var=
iable name' '
+	(
+		__gitcomp_nl "$invalid_variable_name"
+	)
+'
+
 test_expect_success 'basic' '
 	run_completion git "" &&
 	# built-in
--=20
1.8.0.220.g4d14ece
