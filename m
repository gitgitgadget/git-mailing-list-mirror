From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH (topgit) 1/2] Implement setup_pager just like in git
Date: Tue,  6 Jan 2009 18:16:38 +0300
Message-ID: <acaae74f79d385014e726b97f8258b2a0caa3dd0.1231254832.git.kirr@landau.phys.spbu.ru>
References: <cover.1231254832.git.kirr@landau.phys.spbu.ru>
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 16:17:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKDfq-0006PP-N8
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 16:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbZAFPP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 10:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbZAFPP1
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 10:15:27 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:1370 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbZAFPPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 10:15:25 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id B532C17B6B2; Tue,  6 Jan 2009 18:15:23 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1LKDfb-0003w9-Gh; Tue, 06 Jan 2009 18:16:39 +0300
X-Mailer: git-send-email 1.6.1.48.ge9b8
In-Reply-To: <cover.1231254832.git.kirr@landau.phys.spbu.ru>
In-Reply-To: <cover.1231254832.git.kirr@landau.phys.spbu.ru>
References: <cover.1231254832.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104692>

setup_pager() spawns a pager process and redirect the rest of our output
to it.

This will be needed to fix `tg patch` output in the next commit.

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 tg.sh |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/tg.sh b/tg.sh
index 8c23d26..51a82af 100644
--- a/tg.sh
+++ b/tg.sh
@@ -243,6 +243,59 @@ do_help()
 	fi
 }
 
+## Pager stuff
+
+# isatty FD
+isatty()
+{
+	tty -s 0<&$1 || return 1
+	return 0
+}
+
+# setup_pager
+# Spawn pager process and redirect the rest of our output to it
+setup_pager()
+{
+	isatty 1 || return 0
+
+	# TG_PAGER = GIT_PAGER | PAGER
+	# http://unix.derkeiler.com/Newsgroups/comp.unix.shell/2004-03/0792.html
+	case ${GIT_PAGER+XXX} in
+	'')
+		case ${PAGER+XXX} in
+		'')
+			# both GIT_PAGER & PAGER unset
+			TG_PAGER=''
+			;;
+		*)
+			TG_PAGER="$PAGER"
+			;;
+		esac
+		;;
+	*)
+		TG_PAGER="$GIT_PAGER"
+		;;
+	esac
+
+	[ -z "$TG_PAGER"  -o  "$TG_PAGER" = "cat" ]  && return 0
+
+
+	# now spawn pager
+	export LESS=${LESS:-FRSX}	# as in pager.c:pager_preexec()
+
+	_pager_fifo="$(mktemp -t tg-pager-fifo.XXXXXX)"
+	rm "$_pager_fifo" && mkfifo -m 600 "$_pager_fifo"
+
+	"$TG_PAGER" < "$_pager_fifo" &
+	exec > "$_pager_fifo"		# dup2(pager_fifo.in, 1)
+
+	# this is needed so e.g. `git diff` will still colorize it's output if
+	# requested in ~/.gitconfig with color.diff=auto
+	export GIT_PAGER_IN_USE=1
+
+	# atexit(close(1); wait pager)
+	trap "exec >&-; rm $_pager_fifo; wait" EXIT
+}
 
 ## Startup
 
-- 
1.6.1.48.ge9b8
