From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] bisect: parse revs before passing them to
 check_expected_revs()
Date: Thu, 25 Dec 2014 19:25:32 +0100
Message-ID: <20141225182534.32540.83491.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 19:42:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4DN7-0008Qm-Cx
	for gcvg-git-2@plane.gmane.org; Thu, 25 Dec 2014 19:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbaLYSmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2014 13:42:46 -0500
Received: from delay-3y.bbox.fr ([194.158.98.73]:51044 "EHLO delay-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbaLYSmp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2014 13:42:45 -0500
Received: from mail-2y.bbox.fr (bt8sssoo.cs.dolmen.bouyguestelecom.fr [172.24.208.129])
	by delay-3y.bbox.fr (Postfix) with ESMTP id 7A073A7F2
	for <git@vger.kernel.org>; Thu, 25 Dec 2014 19:29:36 +0100 (CET)
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 9AECFB7;
	Thu, 25 Dec 2014 19:29:33 +0100 (CET)
X-git-sha1: 137caafa92ba21fed2dc352d861661a85b565ef0 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261823>

When running for example "git bisect bad HEAD" or
"git bisect good master", the parameter passed to
"git bisect (bad|good)" has to be parsed into a
commit hash before checking if it is the expected
commit or not.

We could do that in is_expected_rev() or in
check_expected_revs(), but it is already done in
bisect_state(). Let's just store the hash values
that result from this parsing, and then reuse
them after all the parsing is done.

This way we can also use a for loop over these
values to call bisect_write() on them, instead of
using eval.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
I think that it is a better patch than the one I sent
previously to the list as with this one we parse revs
only once. 

Merry Christmas!

 git-bisect.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 6cda2b5..2fc07ac 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -237,15 +237,18 @@ bisect_state() {
 		check_expected_revs "$rev" ;;
 	2,bad|*,good|*,skip)
 		shift
-		eval=''
+		hash_list=''
 		for rev in "$@"
 		do
 			sha=$(git rev-parse --verify "$rev^{commit}") ||
 				die "$(eval_gettext "Bad rev input: \$rev")"
-			eval="$eval bisect_write '$state' '$sha'; "
+			hash_list="$hash_list $sha"
 		done
-		eval "$eval"
-		check_expected_revs "$@" ;;
+		for rev in $hash_list
+		do
+			bisect_write "$state" "$rev"
+		done
+		check_expected_revs $hash_list ;;
 	*,bad)
 		die "$(gettext "'git bisect bad' can take only one argument.")" ;;
 	*)
-- 
2.1.2.555.gfbecd99
