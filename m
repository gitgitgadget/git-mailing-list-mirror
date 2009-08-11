From: Ori Avtalion <ori@avtalion.name>
Subject: [PATCH] git stash: Give friendlier errors when there is nothing to
	apply
Date: Tue, 11 Aug 2009 14:12:13 +0300
Message-ID: <4a81787d.0e0f660a.5238.4c8b@mx.google.com>
References: <200908111409.04506.trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:56:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Marq0-00056n-14
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbZHKN4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754729AbZHKN4O
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:56:14 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:39762 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbZHKN4N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 09:56:13 -0400
Received: by fxm28 with SMTP id 28so1536827fxm.17
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:sender:from:to
         :date:references:in-reply-to:subject;
        bh=tPM9kRCUKUsDwAtHu4FqSpTzIwOwt0AukMtXQcV2wKI=;
        b=GX653lpbbf2mRNU5aP361G8m+PkhP6suSuMpFhZHSgujDBaMctvTSE8/19OhdVq+H9
         yybXqViklbB+OzYKEd2p4iGM9CfyjxSqMja3a9ORv+M1wtj4Q14N3F8XwJlT4hXi324p
         QRRi+tPSq9lgWW7HjpuCYOxDpurLKAIMVGTCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:sender:from:to:date:references:in-reply-to:subject;
        b=kES5bfSXs5FZnb/uWaxDv2cqnj5FXmlUP3vKSu4dFaMs3w45NovzYwGHQHMwWcmgvm
         6tENB5poAzDHhpSpn8mZZzjeBNy+ybZgNcyr5ZtBPSypXsypiMfgzbd0JKrp1gWqvVW9
         F1JTwUZtr+icAT8Sa8IWx6UpnKEGoBb9mrHJw=
Received: by 10.103.107.11 with SMTP id j11mr1753206mum.92.1249998973332;
        Tue, 11 Aug 2009 06:56:13 -0700 (PDT)
Received: from ?127.0.1.1? (bzq-82-81-59-125.red.bezeqint.net [82.81.59.125])
        by mx.google.com with ESMTPS id 14sm25498151muo.3.2009.08.11.06.56.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 06:56:13 -0700 (PDT)
In-Reply-To: <200908111409.04506.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125560>

The change makes sure a stash (given or default) exists before
checking if the working tree is dirty.

If the default stash is requested, the old message was scary and
included a 'fatal' error from rev-parse:
     fatal: Needed a single revision
     : no valid stashed state found

It is replaced with a friendlier 'Nothing to apply' error, similar to
'git stash branch'.

If a specific stash is specified, the 'Needed a single revision' errors
from rev-parse are suppressed.

Signed-off-by: Ori Avtalion <ori@avtalion.name>
---

Thomas, I added handling for the 'git stash apply <stash>' case based
on your reminder, and also changed the error messages related to it.

All of the stash tests pass, as before.

 git-stash.sh |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 03e589f..d61c9d0 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -162,10 +162,6 @@ show_stash () {
 }
 
 apply_stash () {
-	git update-index -q --refresh &&
-	git diff-files --quiet --ignore-submodules ||
-		die 'Cannot apply to a dirty working tree, please stage your changes'
-
 	unstash_index=
 
 	while test $# != 0
@@ -184,18 +180,27 @@ apply_stash () {
 		shift
 	done
 
-	# current index state
-	c_tree=$(git write-tree) ||
-		die 'Cannot apply a stash in the middle of a merge'
+	if test $# = 0
+	then
+		have_stash || die 'Nothing to apply'
+	fi
 
 	# stash records the work tree, and is a merge between the
 	# base commit (first parent) and the index tree (second parent).
-	s=$(git rev-parse --verify --default $ref_stash "$@") &&
-	w_tree=$(git rev-parse --verify "$s:") &&
-	b_tree=$(git rev-parse --verify "$s^1:") &&
-	i_tree=$(git rev-parse --verify "$s^2:") ||
+	s=$(git rev-parse --quiet --verify --default $ref_stash "$@") &&
+	w_tree=$(git rev-parse --quiet --verify "$s:") &&
+	b_tree=$(git rev-parse --quiet --verify "$s^1:") &&
+	i_tree=$(git rev-parse --quiet --verify "$s^2:") ||
 		die "$*: no valid stashed state found"
 
+	git update-index -q --refresh &&
+	git diff-files --quiet --ignore-submodules ||
+		die 'Cannot apply to a dirty working tree, please stage your changes'
+
+	# current index state
+	c_tree=$(git write-tree) ||
+		die 'Cannot apply a stash in the middle of a merge'
+
 	unstashed_index_tree=
 	if test -n "$unstash_index" && test "$b_tree" != "$i_tree" &&
 			test "$c_tree" != "$i_tree"
-- 
1.6.4.115.g82cf7
