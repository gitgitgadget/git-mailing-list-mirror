From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] bash completion: Resolve git show ref:path<tab> losing
	ref: portion
Date: Tue, 15 Jul 2008 05:52:04 +0000
Message-ID: <20080715055204.GA3337@spearce.org>
References: <20080715053907.GA3254@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 07:53:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIdTI-0007pn-0O
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 07:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbYGOFwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 01:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758640AbYGOFwH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 01:52:07 -0400
Received: from george.spearce.org ([209.20.77.23]:45838 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758645AbYGOFwF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 01:52:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E4A28383A4; Tue, 15 Jul 2008 05:52:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080715053907.GA3254@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88527>

Linus reported that the bash completion for git show often dropped
the ref portion of the argument (stuff before the :) when trying
to complete a file name of a file in another branch or tag.

Bj=C3=B6rn Steinbrink tracked it down to the gvfs completion script
which comes standard on many Fedora Core based systems.  That is
removing : from COMP_WORDBREAKS, making readline treat the entire
argument (including the ref) as the name that must be completed.
When the git completion routines supplied a completion of just the
filename, readline replaced everything.

Since Git users often need to use "ref:path" or "ref:ref" sort of
arguments, and expect completion support on both sides of the :
we really want the : in COMP_WORDBREAKS to provide a good user
experience.  This is also the default that ships with bash as it
can be useful in other contexts, such as rcp/scp.

We now try to add : back to COMP_WORDBREAKS if it has been removed
by a script that loaded before us.  However if this doesn't work
(as the : is stripped after we load) we fallback in the completion
routines to include "ref:" as part of the prefix for completions,
allowing readine to fully insert the argument the user wanted.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Second time's the charm?  The prior version had a mangled commit
 message, due to character encoding stupidity between my keyboard
 and my chair.

 contrib/completion/git-completion.bash |   27 ++++++++++++++++++++++++=
+--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c03230a..5844804 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -45,6 +45,11 @@
 #       git@vger.kernel.org
 #
=20
+case "$COMP_WORDBREAKS" in
+*:*) : great ;;
+*)   COMP_WORDBREAKS=3D"$COMP_WORDBREAKS:"
+esac
+
 __gitdir ()
 {
 	if [ -z "$1" ]; then
@@ -294,6 +299,12 @@ __git_complete_file ()
 			ls=3D"$ref"
 			;;
 	    esac
+
+		case "$COMP_WORDBREAKS" in
+		*:*) : great ;;
+		*)   pfx=3D"$ref:$pfx" ;;
+		esac
+
 		local IFS=3D$'\n'
 		COMPREPLY=3D($(compgen -P "$pfx" \
 			-W "$(git --git-dir=3D"$(__gitdir)" ls-tree "$ls" \
@@ -700,7 +711,12 @@ _git_fetch ()
 	*)
 		case "$cur" in
 		*:*)
-			__gitcomp "$(__git_refs)" "" "${cur#*:}"
+			local pfx=3D""
+			case "$COMP_WORDBREAKS" in
+			*:*) : great ;;
+			*)   pfx=3D"${cur%%:*}:" ;;
+			esac
+			__gitcomp "$(__git_refs)" "$pfx" "${cur#*:}"
 			;;
 		*)
 			local remote
@@ -876,7 +892,14 @@ _git_push ()
 			git-push)  remote=3D"${COMP_WORDS[1]}" ;;
 			git)       remote=3D"${COMP_WORDS[2]}" ;;
 			esac
-			__gitcomp "$(__git_refs "$remote")" "" "${cur#*:}"
+
+			local pfx=3D""
+			case "$COMP_WORDBREAKS" in
+			*:*) : great ;;
+			*)   pfx=3D"${cur%%:*}:" ;;
+			esac
+
+			__gitcomp "$(__git_refs "$remote")" "$pfx" "${cur#*:}"
 			;;
 		+*)
 			__gitcomp "$(__git_refs)" + "${cur#+}"
--=20
1.5.6.2.393.g45096
