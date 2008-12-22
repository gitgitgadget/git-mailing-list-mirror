From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] rebase -i -p: Fix --continue after a merge could
 not be redone
Date: Mon, 22 Dec 2008 22:06:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812222139340.30769@pacific.mpi-cbg.de>
References: <1229012461-31377-1-git-send-email-j6t@kdbg.org> <1229335531-32707-1-git-send-email-j6t@kdbg.org> <1229335531-32707-2-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Stephen Haberman <stephen@exigencecorp.com>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Dec 22 22:01:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEruA-0005nH-CH
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 22:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131AbYLVVAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 16:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754938AbYLVVAM
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 16:00:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:43074 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754751AbYLVVAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 16:00:10 -0500
Received: (qmail invoked by alias); 22 Dec 2008 21:00:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 22 Dec 2008 22:00:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/35qYPw7j3JnIgrfAed+PuyJduSxBa7HgB8wpLVG
	/CFSDjruF5j3Rt
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1229335531-32707-2-git-send-email-j6t@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103770>

Hi,

On Mon, 15 Dec 2008, Johannes Sixt wrote:

> When a merge that has a conflict was rebased, then rebase stopped to let
> the user resolve the conflicts. However, thereafter --continue failed
> because the author-script was not saved. (This is rebase -i's way to
> preserve a commit's authorship.) This fixes it by doing taking the same
> failure route after a merge that is also taken after a normal cherry-pick.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  This is an attempt at fixing the failure.  I don't know whether it is
>  problematic to leave a "patch" behind if there was actually a merge.

I'd suggest leaving behind a --cc patch, so that nobody is tempted to 
"fix" the patch until it applies.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 1172e47..89c39eb 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -253,15 +253,14 @@ pick_one_preserving_merges () {
>  			if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
>  				GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
>  				GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
>  				output git merge $STRATEGY -m "$msg" \
>  					$new_parents
>  			then
> -				git rerere

Why?  I found rerere pretty helpful when rebasing merges.

Ah, it is done by die_with_patch() already.  You might want to prevent 
headscratching and hunting around for a few minutes, by simply mentioning 
that fact in the commit message.

I'll leave the commit message fixing to you, but the --cc patch probably 
looks something like this -- feel free to squash in:

---

 git-rebase--interactive.sh |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 89c39eb..b20c101 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -115,9 +115,21 @@ mark_action_done () {
 }
 
 make_patch () {
-	parent_sha1=$(git rev-parse --verify "$1"^) ||
-		die "Cannot get patch for $1^"
-	git diff-tree -p "$parent_sha1".."$1" > "$DOTEST"/patch
+	sha1_and_parents="$(git rev-list --parents -1 $1)"
+	case "$sha1_and_parents" in
+	*' '*' '*' '*)
+		echo "Octopus merge"
+	;;
+	*' '*' '*)
+		git diff --cc $sha1_and_parents
+	;;
+	*' '*)
+		git diff-tree -R -p $sha1_and_parents
+	;;
+	*)
+		echo "Root commit"
+	;;
+	esac > "$DOTEST"/patch
 	test -f "$DOTEST"/message ||
 		git cat-file commit "$1" | sed "1,/^$/d" > "$DOTEST"/message
 	test -f "$DOTEST"/author-script ||
