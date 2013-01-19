From: "=?utf-8?q?Jean-No=C3=ABl?= AVILA" <avila.jn@gmail.com>
Subject: Re: Re* t9902 fails
Date: Sat, 19 Jan 2013 14:43:32 +0100
Message-ID: <201301191443.32661.avila.jn@gmail.com>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com> <50FA316E.8060807@web.de> <7vwqv9obie.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 14:44:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwYiL-0006g7-Bj
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 14:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360Ab3ASNno convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 08:43:44 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:58645 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157Ab3ASNno convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 08:43:44 -0500
Received: from cayenne.localnet (unknown [82.239.31.145])
	by smtp2-g21.free.fr (Postfix) with ESMTP id F358F4B013A;
	Sat, 19 Jan 2013 14:43:35 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.8.0-rc4jna; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vwqv9obie.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213977>

Le samedi 19 janvier 2013 08:52:25, Junio C Hamano a =C3=A9crit :
>  (2) instead of being inclusive, collecting all executable in
>      GIT_EXEC_PATH that happens to be named "git-", add a mode to
>      "git help" that lists those that we know to be standard
>      commands that the users may want to complete from the command
>      line.

Am I wrong when I say that "git help -a" already provides the differenc=
e=20
between core git commands and other commands available through path?

If we use this, then we can instruct git-completion that we are in test=
 mode=20
and that it should not provide additional completions.

---
 contrib/completion/git-completion.bash | 13 +++++++++++--
 t/t9902-completion.sh                  |  2 +-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-
completion.bash
index 14dd5e7..dc0ea5b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -23,6 +23,8 @@
 #    3) Consider changing your PS1 to also show the current branch,
 #       see git-prompt.sh for details.
=20
+__testing_git=3D$1
+
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
 *)   COMP_WORDBREAKS=3D"$COMP_WORDBREAKS:"
@@ -533,8 +535,15 @@ __git_complete_strategy ()
=20
 __git_list_all_commands ()
 {
-	local i IFS=3D" "$'\n'
-	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
+	local i cmdlist IFS=3D" "$'\n'
+
+	if [ "x$__testing_git" !=3D "xTEST" ]; then
+		cmdlist=3D$(git help -a|egrep '^  [a-zA-Z0-9]')
+	else
+		cmdlist=3D$(git help -a| egrep -m 1 -B1000 PATH | egrep '^  [a-zA-Z0=
-9]')
+	fi
+
+	for i in $cmdlist
 	do
 		case $i in
 		*--*)             : helper pattern;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3cd53f8..51463b2 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -13,7 +13,7 @@ complete ()
 	return 0
 }
=20
-. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
+. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" TEST
=20
 # We don't need this function to actually join words or do anything sp=
ecial.
 # Also, it's cleaner to avoid touching bash's internal completion vari=
ables.
--=20
1.8.1.1.271.g02f55e6
