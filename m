From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v3 2/2] completion: add git status
Date: Thu, 02 Jun 2016 17:11:36 +0200
Message-ID: <1464880296.3720.0.camel@virtuell-zuhause.de>
References: <20160601141510.Horde.M2zGuJrzBNqf_2zYLo0P2Sx@webmail.informatik.kit.edu>
	 <9ef8cfd8fb89bcacd123ddbebc12f961a292ef8b.1464879648.git.thomas.braun@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 17:13:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8UJg-0007P7-Jl
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 17:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932971AbcFBPNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 11:13:40 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:51902 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932875AbcFBPNh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 11:13:37 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1b8UJT-0003kd-0C; Thu, 02 Jun 2016 17:13:35 +0200
In-Reply-To: <9ef8cfd8fb89bcacd123ddbebc12f961a292ef8b.1464879648.git.thomas.braun@virtuell-zuhause.de>
X-Mailer: Evolution 3.12.9-1+b1 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1464880417;b82f73aa;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296206>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 55 ++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index addea89..fa7a03a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1782,6 +1782,61 @@ _git_stage ()
 	_git_add
 }
 
+_git_status ()
+{
+	local complete_opt
+	local untracked_state
+
+	case "$cur" in
+	--ignore-submodules=*)
+		__gitcomp "none untracked dirty all" "" "${cur##--ignore-submodules=}"
+		return
+		;;
+	--untracked-files=*)
+		__gitcomp "$__git_untracked_file_modes" "" "${cur##--untracked-files=}"
+		return
+		;;
+	--column=*)
+		__gitcomp "
+			always never auto column row plain dense nodense
+			" "" "${cur##--column=}"
+		return
+		;;
+	--*)
+		__gitcomp "
+			--short --branch --porcelain --long --verbose
+			--untracked-files= --ignore-submodules= --ignored
+			--column= --no-column
+			"
+		return
+		;;
+	esac
+
+	untracked_state="$(__git_find_on_cmdline "--untracked-files=no\
+		--untracked-files=normal --untracked-files=all")"
+	untracked_state=${untracked_state##--untracked-files=}
+
+	if [ -z "$untracked_state" ]; then
+		untracked_state="$(git --git-dir="$(__gitdir)" config "status.showUntrackedFiles")"
+	fi
+
+	case "$untracked_state" in
+		no)
+			# --ignored option does not matter
+			complete_opt=
+			;;
+		all|normal|*)
+			complete_opt="--cached --directory --no-empty-directory --others"
+
+			if [ -n "$(__git_find_on_cmdline "--ignored")" ]; then
+				complete_opt="$complete_opt --ignored --exclude=*"
+			fi
+			;;
+	esac
+
+	__git_complete_index_file "$complete_opt"
+}
+
 __git_config_get_set_variables ()
 {
 	local prevword word config_file= c=$cword
-- 
2.8.3.windows.1
