From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] Catch history inconsistency in cg-admin-rewritehist.
Date: Wed, 10 May 2006 00:32:35 +0200
Message-ID: <20060509223235.20814.475.stgit@gandelf.nowhere.earth>
References: <20060509222738.20814.57282.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 00:29:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdahY-0003hK-Lh
	for gcvg-git@gmane.org; Wed, 10 May 2006 00:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWEIW3E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 18:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWEIW3D
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 18:29:03 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:5016 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751267AbWEIW3B (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 18:29:01 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 506AC6D7B0;
	Wed, 10 May 2006 00:29:00 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FdasK-0007GR-Q5; Wed, 10 May 2006 00:40:16 +0200
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060509222738.20814.57282.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19857>


This assertion is triggered by a bug in "cg-object-id -p", which
ignores grafts, when we attempt to rewrite a grafted commit whose
original parent does not get rewritten.

Dying here prevents to leave the user with a corrupted rewriten history.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 cg-admin-rewritehist |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/cg-admin-rewritehist b/cg-admin-rewritehist
index 958a8ab..8dd33f2 100755
--- a/cg-admin-rewritehist
+++ b/cg-admin-rewritehist
@@ -218,9 +218,13 @@ while read commit; do
 
 	parentstr=
 	for parent in $(cg-object-id -p $commit); do
-		for reparent in $(cat ../map/$parent); do
-			parentstr="$parentstr -p $reparent"
-		done
+		if [ -r "../map/$parent" ]; then
+			for reparent in $(cat "../map/$parent"); do
+				parentstr="$parentstr -p $reparent"
+			done
+		else
+			die "assertion failed: parent $parent for commit $commit not found in rewritten ones"
+		fi
 	done
 	if [ "$filter_parent" ]; then
 		parentstr="$(echo "$parentstr" | eval "$filter_parent")"
