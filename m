From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] bash completion: Improve responsiveness of git-log
	completion
Date: Sun, 13 Jul 2008 02:37:42 +0000
Message-ID: <20080713023742.GA31760@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 04:38:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHrU1-0007gL-SE
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 04:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbYGMChn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 22:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbYGMChn
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 22:37:43 -0400
Received: from george.spearce.org ([209.20.77.23]:47751 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbYGMChn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 22:37:43 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9F115382A6; Sun, 13 Jul 2008 02:37:42 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88282>

Junio noticed the bash completion has been taking a long time lately.
Petr Baudis tracked it down to 72e5e989b ("bash: Add space after
unique command name is completed.").  Tracing the code showed
we spent significant time inside of this loop within __gitcomp,
due to the string copying overhead.

  [28.146109654] _git common over
  [28.164791148] gitrefs in
  [28.280302268] gitrefs dir out
  [28.300939737] gitcomp in
  [28.308378112] gitcomp pre-case
* [28.313407453] gitcomp iter in
* [28.701270296] gitcomp iter out
  [28.713370786] out normal

Since __git_refs avoids this string copying by forking and using
echo we use the same trick here when we need to finish generating
the names for the caller.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Does this make things better?  Or worse?  I'm not seeing a huge
 difference on my own system.  Maybe its too fast these days...

 contrib/completion/git-completion.bash |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 27332ed..61581fe 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -114,9 +114,20 @@ __git_ps1 ()
 	fi
 }
 
+__gitcomp_1 ()
+{
+	local c IFS=' '$'\t'$'\n'
+	for c in $1; do
+		case "$c$2" in
+		--*=*) printf %s$'\n' "$c$2" ;;
+		*.)    printf %s$'\n' "$c$2" ;;
+		*)     printf %s$'\n' "$c$2 " ;;
+		esac
+	done
+}
+
 __gitcomp ()
 {
-	local all c s=$'\n' IFS=' '$'\t'$'\n'
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	if [ $# -gt 2 ]; then
 		cur="$3"
@@ -124,21 +135,14 @@ __gitcomp ()
 	case "$cur" in
 	--*=)
 		COMPREPLY=()
-		return
 		;;
 	*)
-		for c in $1; do
-			case "$c$4" in
-			--*=*) all="$all$c$4$s" ;;
-			*.)    all="$all$c$4$s" ;;
-			*)     all="$all$c$4 $s" ;;
-			esac
-		done
+		local IFS=$'\n'
+		COMPREPLY=($(compgen -P "$2" \
+			-W "$(__gitcomp_1 "$1" "$4")" \
+			-- "$cur"))
 		;;
 	esac
-	IFS=$s
-	COMPREPLY=($(compgen -P "$2" -W "$all" -- "$cur"))
-	return
 }
 
 __git_heads ()
-- 
1.5.6.2.393.g45096
