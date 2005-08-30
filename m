From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cg-diff fixed to work with BSD xargs
Date: Tue, 30 Aug 2005 07:20:40 -0700
Message-ID: <7v7je3ld53.fsf@assigned-by-dhcp.cox.net>
References: <11253960093915-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 16:23:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EA6yj-0003nr-FJ
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 16:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVH3OUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 10:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVH3OUm
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 10:20:42 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:13511 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932147AbVH3OUm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2005 10:20:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050830142042.CFZB7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 Aug 2005 10:20:42 -0400
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <11253960093915-git-send-email-martin@catalyst.net.nz> (Martin
	Langhoff's message of "Tue, 30 Aug 2005 22:00:10 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7955>

Martin Langhoff <martin@catalyst.net.nz> writes:

> Calls to cg-diff without filename parameters were dependent on GNU xargs
> traits. BSD xargs is hardcoded to do --no-run-if-empty -- so if the filter
> is effectively empty we avoid calling xargs.
>
> Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>

The fix you did and the reason you stated why you did it in your
commit log message makes perfect sense (I think you missed the
other call to git-diff-tree at the end which is done the same
way with xargs, though); what I write below is not a complaint
to your patch.

But the code you are fixing looks to me like it is already
somewhat obsolete, even if it is still working.  The munging of
user-given paths into $filter temporary file was necessary only
because older git-diff-* family did not work from anywhere but
the top-level directory; they do, thanks to Linus' enhancements,
these days.

I think it is time to start updating Cogito to take advantage of
the modern core.  I do not do Porcelains, but here is my stab at
it.

------------
[PATCH] Redo cg-diff without its own "relative path" support.

It used to be that you had to do "relative path" by hand if you
wanted to work from a subdirectory, but some commands, notably
git-diff-* family, from the modern core knows how to do that
themselves, so take advantage of that.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

    jc: The upstream maintainer is welcome to take it, but this
    patch is not intended for immediate inclusion.  I am sure
    there are corner cases I overlooked, without knowing the
    subtleties of what tree-id is supposed to do, for example.
    Setting _git_repo_unneeded upfront to forcibly disable the
    relative path support is another thing I am not proud about;
    there would probably be a better way which I did not find
    only because I did not look closely enough.

cd /opt/packrat/playpen/public/in-place/git/git.pasky/
git diff HEAD
diff --git a/cg-diff b/cg-diff
--- a/cg-diff
+++ b/cg-diff
@@ -39,6 +39,7 @@
 
 USAGE="cg-diff [-c] [-m] [-p] [-r FROM_ID[:TO_ID]] [FILE]..."
 
+_git_repo_unneeded=t
 . ${COGITO_LIB}cg-Xlib || exit 1
 
 
@@ -136,17 +137,11 @@ if [ "$mergebase" ]; then
 fi
 
 
-filter=$(mktemp -t gitdiff.XXXXXX)
-[ "$_git_relpath" -a ! "$ARGS" ] && echo "$_git_relpath" >>$filter
-for file in "${ARGS[@]}"; do
-	echo "${_git_relpath}$file" >>$filter
-done
-
 if [ "$id2" = " " ]; then
 	if [ "$id1" != " " ]; then
-		tree=$(tree-id "$id1") || exit 1
+		tree=$(git-rev-parse --verify "$id1") || exit 1
 	else
-		tree=$(tree-id) || exit 1
+		tree=$(git-rev-parse --verify --default HEAD) || exit 1
 	fi
 
 	# Ensure to only diff modified files
@@ -155,21 +150,18 @@ if [ "$id2" = " " ]; then
 	# FIXME: Update ret based on what did we match. And take "$@"
 	# to account after all.
 	ret=
-	cat $filter | xargs git-diff-cache -r -p $tree | colorize | pager
-
-	rm $filter
+	git-diff-cache -r -p $tree "${ARGS[@]}" | colorize | pager
 
 	[ "$ret" ] && die "no files matched"
 	exit $ret
 fi
 
 
-id1=$(tree-id "$id1") || exit 1
-id2=$(tree-id "$id2") || exit 1
+id1=$(git-rev-parse --verify --default HEAD "$id1") || exit 1
+id2=$(git-rev-parse --verify --default HEAD "$id2") || exit 1
 
 [ "$id1" = "$id2" ] && die "trying to diff $id1 against itself"
 
-cat $filter | xargs git-diff-tree -r -p $id1 $id2 | colorize | pager
+git-diff-tree -r -p $id1 $id2 "${ARGS[@]}" | colorize | pager
 
-rm $filter
 exit 0
