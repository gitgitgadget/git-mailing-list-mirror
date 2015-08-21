From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PoC PATCH] completion: support 'git worktree'
Date: Fri, 21 Aug 2015 22:50:56 +0200
Message-ID: <1440190256-21794-1-git-send-email-szeder@ira.uka.de>
References: <20150821224918.Horde.edB9u314lsP17FLUzwFsQA1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:51:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZStHV-0004yd-4q
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 22:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbbHUUvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 16:51:16 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48914 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752573AbbHUUvQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2015 16:51:16 -0400
Received: from x4db19803.dyn.telefonica.de ([77.177.152.3] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZStHM-0006CT-4h; Fri, 21 Aug 2015 22:51:13 +0200
X-Mailer: git-send-email 2.5.0.418.gdd37a9b
In-Reply-To: <20150821224918.Horde.edB9u314lsP17FLUzwFsQA1@webmail.informatik.kit.edu>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1440190273.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276333>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

> I wrote a completion function for 'git worktree' as well, turns out a=
 week
> or two before you posted this, but I never submitted it as it was way=
 too
> convoluted.  Anyway, will send it in reply to this, just for referenc=
e.

And here it is.
=46rom the number of indentation levels and comment lines you can see w=
hy
I haven't submitted this patch yet :)

OTOH it offers refs for -b and -B, and there are only fairly narrow
corner cases when 'git --options' can fool it (but that's a general
issue with __git_find_on_cmdline(), I wouldn't go into that).

 contrib/completion/git-completion.bash | 59 ++++++++++++++++++++++++++=
++++++++
 1 file changed, 59 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c97c648d7e..20a17e2c50 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2564,6 +2564,65 @@ _git_whatchanged ()
 	_git_log
 }
=20
+_git_worktree ()
+{
+	local subcommand subcommand_idx sc c=3D1
+	local subcommands=3D"add prune"
+
+	while [ $c -lt $cword ] && [ -z "$subcommand" ]; do
+		for sc in $subcommands; do
+			if [ "$sc" =3D "${words[c]}" ]; then
+				subcommand=3D$sc
+				subcommand_idx=3D$c
+				break
+			fi
+		done
+		((c++))
+	done
+
+	case "$subcommand,$cur" in
+	,*)
+		__gitcomp "$subcommands"
+		;;
+	add,--*)
+		__gitcomp "--detach"
+		;;
+	add,*)
+		case "$prev" in
+		-b|-B)
+			__gitcomp_nl "$(__git_refs)"
+			;;
+		-*)	# $prev is an option without argument: have to complete
+			# the path for the new worktree, fall back to bash
+			# filename completion
+			;;
+		*)	# $prev is not an option, so it must be either the
+			# 'add' subcommand, an argument of an option (e.g.
+			# branch for -b|-B), or the path for the new worktree
+			if [ $cword -eq $((subcommand_idx+1)) ]; then
+				# right after the 'add' subcommand, have to
+				# complete the path
+				:
+			else
+				case "${words[cword-2]}" in
+				-b|-B)	# after '-b <branch>', have to complete
+					# the path
+					;;
+				*)	# after the path, have to complete the
+					# branch to be checked out
+					__gitcomp_nl "$(__git_refs)"
+					;;
+				esac
+			fi
+			;;
+		esac
+		;;
+	prune,--*)
+		__gitcomp "--dry-run --verbose --expire"
+		;;
+	esac
+}
+
 __git_main ()
 {
 	local i c=3D1 command __git_dir
--=20
2.5.0.418.gdd37a9b
