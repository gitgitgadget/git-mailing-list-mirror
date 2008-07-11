From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-bisect: use dash-less form on git bisect log
Date: Fri, 11 Jul 2008 18:01:29 +0200
Message-ID: <1215792089-27201-1-git-send-email-vmiklos@frugalware.org>
References: <200807110839.14764.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 18:02:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHL4W-0008Tl-Tt
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 18:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbYGKQBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 12:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbYGKQBP
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 12:01:15 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:50803 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbYGKQBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 12:01:14 -0400
Received: from vmobile.example.net (dsl5401CCAB.pool.t-online.hu [84.1.204.171])
	by yugo.frugalware.org (Postfix) with ESMTP id 807761DDC5B;
	Fri, 11 Jul 2008 18:01:11 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id F3E941A9833; Fri, 11 Jul 2008 18:01:29 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.450.g8d367.dirty
In-Reply-To: <200807110839.14764.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88135>

Given that users are supposed to type 'git bisect' now, make the output
of 'git bisect log' consistent with this.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Fri, Jul 11, 2008 at 08:39:14AM +0200, Christian Couder <chriscool@tuxfamily.org> wrote:
> Wouldn't it be better if bisect_replay could read old logs?
>
> Maybe with something like:
>
> +     while read git bisect command rev
>       do
> -             test "$bisect" = "git-bisect" || continue
> +             test "$git $bisect" = "git bisect" -o "$git" =
> "git-bisect" || continue
> +             if test "$git" = "git-bisect"; then
> +                     rev="$command"
> +                     command="$bisect"
> +             fi

You are right, here is an updated patch.

 git-bisect.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 991b2ef..3cac20d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -149,7 +149,7 @@ bisect_start() {
 	echo "$start_head" >"$GIT_DIR/BISECT_START" &&
 	sq "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval" &&
-	echo "git-bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
+	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
 	# Check if we can proceed to the next bisect state.
 	#
@@ -169,7 +169,7 @@ bisect_write() {
 	esac
 	git update-ref "refs/bisect/$tag" "$rev" || exit
 	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
-	test -n "$nolog" || echo "git-bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
+	test -n "$nolog" || echo "git bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
 
 bisect_state() {
@@ -426,9 +426,13 @@ bisect_clean_state() {
 bisect_replay () {
 	test -r "$1" || die "cannot read $1 for replaying"
 	bisect_reset
-	while read bisect command rev
+	while read git bisect command rev
 	do
-		test "$bisect" = "git-bisect" || continue
+		test "$git $bisect" = "git bisect" -o "$git" = "git-bisect" || continue
+		if test "$git" = "git-bisect"; then
+			rev="$command"
+			command="$bisect"
+		fi
 		case "$command" in
 		start)
 			cmd="bisect_start $rev"
-- 
1.5.6.2.450.g8d367.dirty
