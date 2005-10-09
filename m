From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH 1/2] Fix git-verify-tag for local tags
Date: Sun, 09 Oct 2005 20:12:47 +0200
Message-ID: <20051009181246.17885.81654.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 20:54:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOgIS-0007p6-20
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 20:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVJISxI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Oct 2005 14:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVJISxI
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Oct 2005 14:53:08 -0400
Received: from ppp-62-11-74-46.dialup.tiscali.it ([62.11.74.46]:34278 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932254AbVJISxG
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Oct 2005 14:53:06 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 3A9F19A1C9;
	Sun,  9 Oct 2005 20:12:50 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9867>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

It currently exits printing "git-cat-file SHA1: bad file", while instead we must
just abort the verification for local tags (i.e. referring to commit objects).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 git-verify-tag.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-verify-tag.sh b/git-verify-tag.sh
--- a/git-verify-tag.sh
+++ b/git-verify-tag.sh
@@ -3,6 +3,10 @@
 
 tag=$(git-rev-parse $1) || exit 1
 
+type=$(git-cat-file -t $tag) || exit 1
+[ "$type" = "commit" ] && die "Light tag - verification impossible"
+[ "$type" = "tag" ] || die "Bad tag - SHA1 doesn't refer to a tag object nor to a commit one."
+
 git-cat-file tag $tag > .tmp-vtag || exit 1
 cat .tmp-vtag | sed '/-----BEGIN PGP/Q' | gpg --verify .tmp-vtag - || exit 1
 rm -f .tmp-vtag
