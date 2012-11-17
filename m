From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 5/7] completion: fix expansion issues in __gitcomp_nl()
Date: Sat, 17 Nov 2012 12:05:51 +0100
Message-ID: <1353150353-29874-6-git-send-email-szeder@ira.uka.de>
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
X-From: git-owner@vger.kernel.org Sat Nov 17 12:07:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZgF3-0007g5-AM
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 12:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab2KQLG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 06:06:58 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:58113 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab2KQLG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 06:06:56 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0LmRp1-1Szn7F0QXT-00aDKi; Sat, 17 Nov 2012 12:06:38 +0100
X-Mailer: git-send-email 1.8.0.220.g4d14ece
In-Reply-To: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:+DSI/d/E3QYvjUrgOUk3yQWH/xhrmNM6eVZe0qaUuBb
 H9B8UVye+vfcdWEI6QLorV0sbbK9pxjsMMfJm0SWt2U+DqzADT
 CVNbqXNeaUkCPiSLFClXgW1fTS0CfS7I7porci/f+5uyRAVonV
 R/kV78ebQ7jOycQSb5v6THLGpFd/kZ1HiJycY78Wb1aR8BXpoZ
 Uuf6QLFPdQ9Oo/9VWVZlV0d+xRrtoWL3JNW2jo6Q0njkAD6RkZ
 QJBQstCyljoOLu1hDuHAoj2RTPmlEQh8B6x3tTc7HO2Lg54Hfa
 oqRW8Bvw7IJQsvQBDUKGvXZUAJDrDIKdbe8rlZxEn3cYOmIHUM
 dqrfPQM8H5X0hNwqYrGISki3//yGp6UWFLMS1oTh/X/0Ujttk0
 S/vvi3NWEYiHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209947>

The compgen Bash-builtin performs expansion on all words in the
wordlist given to its -W option, breaking Git's completion script when
refs or filenames passed to __gitcomp_nl() contain expandable
substrings.  At least one user can't use ref completion at all in a
repository, which contains tags with metacharacters like

  Build%20V%20${bamboo.custom.jiraversion.name}%20Build%20721

Such a ref causes a failure in compgen as it tries to expand the
variable with invalid name.

Unfortunately, compgen has no option to turn off this expansion.
However, in __gitcomp_nl() we use only a small subset of compgen's
functionality, namely the filtering of matching possible completion
words and adding a prefix and/or suffix to each of those words.  So,
to avoid compgen's problematic expansion we get rid of compgen, and
implement the equivalent functionality in a small awk script.  The
reason for using awk instead of sed is that awk allows plain (i.e.
non-regexp) string comparison, making quoting of regexp characters in
the current word unnecessary.

Note, that such expandable words need quoting to be of any use on the
command line.  This patch doesn't perform that quoting, but it could
be implemented later on top by extending the awk script to unquote
$cur and to quote matching words.  Nonetheless, this patch still a
step forward, because at least refs can be completed even in the
presence of one with metacharacters.

Also update the function's description a bit.

Reported-by: Jeroen Meijer <jjgmeijer@hotmail.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

awk doesn't have a prefixcmp().  I'm no awk wizard, so I'm not sure thi=
s
is the right way to do it.

 contrib/completion/git-completion.bash | 17 +++++++++++++----
 t/t9902-completion.sh                  |  4 ++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index bc0657a2..65196ddd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -249,19 +249,28 @@ __gitcomp ()
 	esac
 }
=20
-# Generates completion reply with compgen from newline-separated possi=
ble
-# completion words by appending a space to all of them.
+# Generates completion reply for the word in $cur from newline-separat=
ed
+# possible completion words, appending a space to all of them.
 # It accepts 1 to 4 arguments:
 # 1: List of possible completion words, separated by a single newline.
 # 2: A prefix to be added to each possible completion word (optional).
-# 3: Generate possible completion matches for this word (optional).
+# 3: Generate possible completion matches for this word instead of $cu=
r
+#    (optional).
 # 4: A suffix to be appended to each possible completion word instead =
of
 #    the default space (optional).  If specified but empty, nothing is
 #    appended.
 __gitcomp_nl ()
 {
 	local IFS=3D$'\n'
-	COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}")=
)
+	COMPREPLY=3D($(awk -v pfx=3D"${2-}" -v sfx=3D"${4- }" -v cur=3D"${3-$=
cur}" '
+		BEGIN {
+			FS=3D"\n";
+			len=3Dlength(cur);
+		}
+		{
+			if (cur =3D=3D substr($1, 1, len))
+				print pfx$1sfx;
+		}' <<< "$1" ))
 }
=20
 __git_heads ()
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a108ec1c..fa289324 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -246,7 +246,7 @@ test_expect_success '__gitcomp_nl - no suffix' '
 	test_cmp expected out
 '
=20
-test_expect_failure '__gitcomp_nl - doesnt fail because of invalid var=
iable name' '
+test_expect_success '__gitcomp_nl - doesnt fail because of invalid var=
iable name' '
 	(
 		__gitcomp_nl "$invalid_variable_name"
 	)
@@ -383,7 +383,7 @@ test_expect_success 'complete tree filename with sp=
aces' '
 	EOF
 '
=20
-test_expect_failure 'complete tree filename with metacharacters' '
+test_expect_success 'complete tree filename with metacharacters' '
 	echo content >"name with \${meta}" &&
 	git add . &&
 	git commit -m meta &&
--=20
1.8.0.220.g4d14ece
