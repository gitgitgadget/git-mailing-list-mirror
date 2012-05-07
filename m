From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v4 5/6] completion: calculate argument position properly
Date: Mon,  7 May 2012 03:23:19 +0200
Message-ID: <1336353800-17323-6-git-send-email-felipe.contreras@gmail.com>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Scott Bronson <bronson@rinspin.com>,
	Nathan Broadbent <nathan.f77@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 03:23:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRCg2-0004OI-DD
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 03:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab2EGBXp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 21:23:45 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33037 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab2EGBXo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 21:23:44 -0400
Received: by wgbdr13 with SMTP id dr13so4368209wgb.1
        for <git@vger.kernel.org>; Sun, 06 May 2012 18:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qQprEYXDZq84Jxibm8YH/TpN4DoBqvLOEaf5h6nEISM=;
        b=fvfegdA7MRWdlu98F8Y7yD5vl83AEbDMhls5IPXasxmGwhRTcMX1QFCQxuyxxaYZOz
         4lDuiiA69TdK7RlI/oUS0NlXCvLk45m/otFGJW60wG07UGWv8rHWfPcmgq1LHTL5V5K9
         t2cMacv/vckJQPz280b6W3OuapLczZz/BXOS0pogJsMVzkj7nhVBVWFpp9JjXEy+ON55
         VPVLwusGFtHohW3HYu5fHe529PEV9u9aAz+NqHgwqWTQ7275hU0kiUTth5zU2h6B3n+7
         DNDRPfL/BXRMkwdak99qfod1ehSjd8fQVWPj2pIhcHr5Ve0i9IY+r/B7Abbn8FuDANTN
         m6Cw==
Received: by 10.180.78.233 with SMTP id e9mr790170wix.5.1336353822975;
        Sun, 06 May 2012 18:23:42 -0700 (PDT)
Received: from localhost (ip-109-43-0-55.web.vodafone.de. [109.43.0.55])
        by mx.google.com with ESMTPS id du4sm28305950wib.10.2012.05.06.18.23.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 18:23:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197232>

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
 contrib/completion/git-completion.bash |   16 +++++++++-------
 t/t9902-completion.sh                  |   21 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index e648d7c..049110e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -724,7 +724,8 @@ __git_complete_revlist ()
 __git_complete_remote_or_refspec ()
 {
 	local cur_=3D"$cur"
-	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
+	local i c=3D$cmd_pos remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=
=3D0
+
 	if [ "$cmd" =3D "remote" ]; then
 		((c++))
 	fi
@@ -1144,12 +1145,11 @@ _git_bundle ()
 {
 	local subcommands=3D'create list-heads verify unbundle'
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
-
-	case "$cword" in
-	2)
+	case $(( cword - cmd_pos )) in
+	0)
 		__gitcomp "$subcommands"
 		;;
-	3)
+	1)
 		# looking for a file
 		;;
 	*)
@@ -1449,7 +1449,7 @@ _git_grep ()
 	esac
=20
 	case "$cword,$prev" in
-	2,*|*,-*)
+	$cmd_pos,*|*,-*)
 		if test -r tags; then
 			__gitcomp_nl "$(__git_match_ctag "$cur" tags)"
 			return
@@ -2603,7 +2603,7 @@ _git_whatchanged ()
=20
 _git ()
 {
-	local i c=3D1 cmd __git_dir
+	local i c=3D1 cmd cmd_pos __git_dir
=20
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
@@ -2642,6 +2642,8 @@ _git ()
 		return
 	fi
=20
+	(( cmd_pos =3D c + 1 ))
+
 	local completion_func=3D"_git_${cmd//-/_}"
 	declare -f $completion_func >/dev/null && $completion_func && return
=20
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index bb66848..6904594 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -295,4 +295,25 @@ test_expect_success 'other' '
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
1.7.10
