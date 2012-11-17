From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 6/7] completion: fix expansion issue in __gitcomp()
Date: Sat, 17 Nov 2012 12:05:52 +0100
Message-ID: <1353150353-29874-7-git-send-email-szeder@ira.uka.de>
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
X-From: git-owner@vger.kernel.org Sat Nov 17 12:07:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZgEw-0007bQ-Er
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 12:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525Ab2KQLG4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 06:06:56 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:56534 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab2KQLGz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 06:06:55 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MZ6Kl-1Tlxu12zVD-00VD5o; Sat, 17 Nov 2012 12:06:47 +0100
X-Mailer: git-send-email 1.8.0.220.g4d14ece
In-Reply-To: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:9nho2ArPu5vBhidYk4WCfwPg9xoDJRv2XoEu9YVP2xs
 WugYGihvOHY7I+IfBSgsUs8ndFWCZkQRj+Dt2IjR2tzR2bQoS7
 nUUP1hcFUbrFS3Z11drTOyrjn8Y5sZf1zNkk1DrjDtTwMURJ6I
 sBZ14vmPGTT6hQKWTEDhgYilfrn0oJP9P9a+v1lUpdQF4ynYc1
 1odf/7UAOHmk3MFbJdeMmk4JD+sDN3MR6WZ7/TfKTCAVPnoD62
 hYluSun7If6YxJIi9um3ubpI2idFEGaxo+YkQq27XJaAsdflGL
 vvB0GPk3ceIFjiSErs/cAOTWV4MFaoi2yB4vq9yEBKRPGByIok
 3vOZl4JKxesCN9DAe4O2V53DDSPh4L9s0r7GKE5fEze1ahgcNH
 mDPh1Zmb7r0aw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209945>

The compgen Bash-builtin performs expansion on all words in the
wordlist given to its -W option, breaking Git's completion script when
words passed to __gitcomp() contain expandable substrings.

In __gitcomp() we only use a small subset ot compgen's functionality,
namely the filtering of matching possible completion words and adding
a prefix to each of those words; suffix is added by the __gitcomp_1()
helper function instead.  Now, since we already have to iterate over
all words in the wordlist to append a trailing space if necessary, we
can check in the same loop whether a word matches the word to be
completed and store matching words with possible prefix and/or suffix
in the COMPREPLY array.  This way we achieve the same functionality
without the compgen builtin and, more importantly, without it's
problematic expansions.

An additional benefit, especially for Windows/MSysGit users, is the
loss of two subshells, one to run __gitcomp_1() and the other to run
the compgen builtin.

Note, that like the previous patch for __gitcomp_nl(), this patch
doesn't quote expandable words either, but that could be implemented
later on top by unquoting $cur and then quoting what get stored in
COMPREPLY.

Also update the function's description a bit.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 27 ++++++++++++++++++++------=
-
 t/t9902-completion.sh                  |  2 +-
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 65196ddd..283ef99b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -225,12 +225,13 @@ _get_comp_words_by_ref ()
 fi
 fi
=20
-# Generates completion reply with compgen, appending a space to possib=
le
-# completion words, if necessary.
+# Generates completion reply for the word in $cur, appending a space t=
o
+# possible completion words, if necessary.
 # It accepts 1 to 4 arguments:
 # 1: List of possible completion words.
 # 2: A prefix to be added to each possible completion word (optional).
-# 3: Generate possible completion matches for this word (optional).
+# 3: Generate possible completion matches for this word instead of $cu=
r
+#    (optional).
 # 4: A suffix to be appended to each possible completion word (optiona=
l).
 __gitcomp ()
 {
@@ -241,10 +242,22 @@ __gitcomp ()
 		COMPREPLY=3D()
 		;;
 	*)
-		local IFS=3D$'\n'
-		COMPREPLY=3D($(compgen -P "${2-}" \
-			-W "$(__gitcomp_1 "${1-}" "${4-}")" \
-			-- "$cur_"))
+		local i=3D0 c IFS=3D$' \t\n'
+		for c in $1; do
+			case $c in
+			"$cur_"*)
+				c=3D"$c${4-}"
+				case $c in
+				--*=3D*|*.) ;;
+				*) c=3D"$c " ;;
+				esac
+				COMPREPLY[$i]=3D"${2-}$c"
+				i=3D$((++i))
+				;;
+			*)
+				;;
+			esac
+		done
 		;;
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index fa289324..d08f4259 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -156,7 +156,7 @@ test_expect_success '__gitcomp - suffix' '
 	test_cmp expected out
 '
=20
-test_expect_failure '__gitcomp - doesnt fail because of invalid variab=
le name' '
+test_expect_success '__gitcomp - doesnt fail because of invalid variab=
le name' '
 	(
 		__gitcomp "$invalid_variable_name"
 	)
--=20
1.8.0.220.g4d14ece
