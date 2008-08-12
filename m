From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: TOPGIT: [PATCH] tg create: add --force option to resolve merge
 dependencies.
Date: Tue, 12 Aug 2008 15:01:46 +0200
Organization: lilypond-design.org
Message-ID: <1218546106.7264.11.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 15:12:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KStfO-0001zO-95
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 15:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbYHLNKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 09:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753279AbYHLNKi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 09:10:38 -0400
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:36788 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbYHLNKh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 09:10:37 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id C11C211E70E;
	Tue, 12 Aug 2008 15:10:35 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 54154DC08A;
	Tue, 12 Aug 2008 15:10:35 +0200 (CEST)
X-Mailer: Evolution 2.23.6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92096>

I have been trying to adapt my ooo-build export to topgit
instead of plain git and ran into the (documented and
expected) merge conflicts in .top*.

After unsuccesfully trying to script around it in my
gob git-export script, I found that this simple tg-create.sh
seems to work for me: just remove any <<<,===,>>> from
.topdeps and simply generate the new .topmgs later.

What do you think?  Is this naive way of 'auto' resolving
dependency problems doing the right thing?

BTW: thanks for creating topgit, it looks like just what
     I was missing.

-- janneke

Signed-off-by: Jan Nieuwenhuizen <janneke@gnu.org>
---
 tg-create.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/tg-create.sh b/tg-create.sh
index 6cce7ed..0c83460 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -14,6 +14,8 @@ name=
 while [ -n "$1" ]; do
 	arg="$1"; shift
 	case "$arg" in
+	--force)
+		force=1;;
 	-*)
 		echo "Usage: tg create NAME [DEPS...]" >&2
 		exit 1;;
@@ -82,6 +84,11 @@ while [ -n "$merge" ]; do
 	info "Merging $name base with $branch..."
 
 	if ! git merge "$branch"; then
+	    if test "$force" = "1"; then
+                mv .topdeps .topdeps~ && grep -Ev '(<|>|=){7}' .topdeps~ > .topdeps && rm .topdeps~
+                git add .topdeps .topmsg
+                git commit -am 'Auto-resolve topgit .top* merge failure.'
+	    else
 		info "Please commit merge resolution and call: tg create"
 		info "It is also safe to abort this operation using \`git reset --hard\`"
 		info "but please remember you are on the base branch now;"
@@ -89,6 +96,7 @@ while [ -n "$merge" ]; do
 		echo "$deps" >"$git_dir/top-deps"
 		echo "$merge" >"$git_dir/top-merge"
 		exit 2
+	    fi
 	fi
 done
 
-- 
1.6.0.rc0.44.g67270


-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
