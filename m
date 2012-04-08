From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/12] completion: calculate argument position properly
Date: Sun,  8 Apr 2012 06:07:56 +0300
Message-ID: <1333854479-23260-10-git-send-email-felipe.contreras@gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Scott Bronson <bronson@rinspin.com>,
	Nathan Broadbent <nathan.f77@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:09:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGiV8-0007HT-8O
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517Ab2DHDI5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Apr 2012 23:08:57 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53218 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754302Ab2DHDIg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Apr 2012 23:08:36 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so2813271lah.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yEzRjo37VDOJ7ygFXjkuL6CpJhCpgto+w2k5hepKKBw=;
        b=QROrgClrEiOa2lWrf9+xWd1U01wDhvYiIVrCwo0ezvTgdIfsPCfM9Fr+iip26wVR2m
         H1uAZmOyN2JXUVTEDCwD6BY2J4XFOvRFawIGoKs3bm5Tt4MZ1xfUwMhEesnj0dLn+Fw4
         DTXO5B69smYMtFTzek+xmxyzFayCieCgKervdHU/Z7vloCSef5igjrBtnLWoXDzHJeG6
         yPgTFAeVIZMdA/HXUSzTMJ34nG1lV22HXc5PgBTKXzj6vchX5udZCiHsOyQLS2CPfY9T
         6j4uaNx8r4ZW9i7Z0dMqCgxu7YJ41EI4sZCdIygL2n/JEUJ6uSqeDlS5FI51BPP7jjrk
         /J3A==
Received: by 10.152.146.234 with SMTP id tf10mr4744769lab.31.1333854515540;
        Sat, 07 Apr 2012 20:08:35 -0700 (PDT)
Received: from localhost (84-231-195-184.elisa-mobile.fi. [84.231.195.184])
        by mx.google.com with ESMTPS id pd3sm11376604lab.14.2012.04.07.20.08.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 20:08:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3.g5a738d
In-Reply-To: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194963>

Positions are currently hard-coded, which means completions in the form
of 'git --foo bar' fail, because positions have been shifted.

This fixes the issue that was spotted in the mailing list regarding
certain aliases[1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/185184

Cc: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Cc: Scott Bronson <bronson@rinspin.com>
Cc: Nathan Broadbent <nathan.f77@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   35 +++++++++++++++++++++++-=
--------
 t/t9902-completion.sh                  |   21 +++++++++++++++++++
 2 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c26f96c..60ea224 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -719,10 +719,18 @@ __git_complete_revlist ()
 	__git_complete_revlist_file
 }
=20
+__git_get_pos ()
+{
+	echo $(( t =3D cmd_pos - 2 + $1 ))
+}
+
 __git_complete_remote_or_refspec ()
 {
 	local cur_=3D"$cur"
-	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
+	local i c remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
+
+	c=3D$(__git_get_pos 2)
+
 	if [ "$cmd" =3D "remote" ]; then
 		((c++))
 	fi
@@ -974,7 +982,8 @@ __git_aliased_command ()
 # __git_find_on_cmdline requires 1 argument
 __git_find_on_cmdline ()
 {
-	local word subcommand c=3D1
+	local word subcommand c
+	c=3D$(__git_get_pos 1)
 	while [ $c -lt $cword ]; do
 		word=3D"${words[c]}"
 		for subcommand in $1; do
@@ -989,7 +998,8 @@ __git_find_on_cmdline ()
=20
 __git_has_doubledash ()
 {
-	local c=3D1
+	local c
+	c=3D$(__git_get_pos 1)
 	while [ $c -lt $cword ]; do
 		if [ "--" =3D "${words[c]}" ]; then
 			return 0
@@ -1109,8 +1119,8 @@ _git_bisect ()
=20
 _git_branch ()
 {
-	local i c=3D1 only_local_ref=3D"n" has_r=3D"n"
-
+	local i c only_local_ref=3D"n" has_r=3D"n"
+	c=3D$(__git_get_pos 1)
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
 		case "$i" in
@@ -1142,8 +1152,9 @@ _git_bundle ()
 {
 	local subcommands=3D'create list-heads verify unbundle'
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
-
-	case "$cword" in
+	local r
+	(( r =3D cword - cmd_pos + 2 ))
+	case "$r" in
 	2)
 		__gitcomp "$subcommands"
 		;;
@@ -1427,6 +1438,7 @@ __git_match_ctag() {
 _git_grep ()
 {
 	__git_has_doubledash && return
+	local p=3D$(__git_get_pos 2)
=20
 	case "$cur" in
 	--*)
@@ -1447,7 +1459,7 @@ _git_grep ()
 	esac
=20
 	case "$cword,$prev" in
-	2,*|*,-*)
+	$p,*|*,-*)
 		if test -r tags; then
 			__gitcomp_nl "$(__git_match_ctag "$cur" tags)"
 			return
@@ -2562,7 +2574,8 @@ _git_svn ()
=20
 _git_tag ()
 {
-	local i c=3D1 f=3D0
+	local i c f=3D0
+	c=3D$(__git_get_pos 1)
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
 		case "$i" in
@@ -2601,7 +2614,7 @@ _git_whatchanged ()
=20
 _git ()
 {
-	local i c=3D1 cmd __git_dir
+	local i c=3D1 cmd cmd_pos __git_dir
=20
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
@@ -2656,6 +2669,8 @@ _git ()
 		return
 	fi
=20
+	(( cmd_pos =3D c + 1 ))
+
 	local completion_func=3D"_git_${cmd//-/_}"
 	declare -f $completion_func >/dev/null && $completion_func && return
=20
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f1b660f..b99fb88 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -284,4 +284,25 @@ test_expect_success 'other' '
 	test_completion "git tag -d v" "v0.1 "
 '
=20
+test_expect_success 'global options extra checks' '
+	test_completion "git --no-pager fetch o" "origin " &&
+	test_completion "git --no-pager fetch origin m" "master:master " &&
+	test_completion "git --no-pager pull o" "origin " &&
+	test_completion "git --no-pager pull origin m" "master " &&
+	test_completion "git --no-pager push o" "origin " &&
+	test_completion "git --no-pager push origin m" "master " &&
+	test_completion "git --no-pager bisect st" "start " &&
+	test_completion "git --no-pager add -- foo" "" &&
+	test_completion "git --no-pager config --file=3Dfoo --get c" "color.u=
i " &&
+	cat >expected <<-\EOF &&
+	origin/HEAD=20
+	origin/master=20
+	EOF
+	test_completion "git --no-pager branch -r o" &&
+	test_completion "git --no-pager bundle cr" "create " &&
+	test_completion "git --no-pager grep f" "foobar " &&
+	test_completion "git --no-pager notes --ref m" "master " &&
+	test_completion "git --no-pager tag -d v" "v0.1 "
+'
+
 test_done
--=20
1.7.10.3.g5a738d
