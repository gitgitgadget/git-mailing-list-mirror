From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pull: allow "git pull origin $something:$current_branch"
 into an unborn branch
Date: Tue, 14 Oct 2008 15:53:44 -0700
Message-ID: <7vmyh66b5z.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LNX.1.00.0810121501590.19665@iabervon.org>
 <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vod1obmlh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810132001230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LNX.1.00.0810131546180.19665@iabervon.org>
 <alpine.DEB.1.00.0810141145491.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LNX.1.00.0810141148010.19665@iabervon.org>
 <alpine.DEB.1.00.0810141815490.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LNX.1.00.0810141240510.19665@iabervon.org>
 <alpine.LNX.1.00.0810141258050.19665@iabervon.org>
 <7vk5ca7rw3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 00:55:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpsnH-0001vF-1j
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 00:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbYJNWx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 18:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbYJNWx4
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 18:53:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbYJNWxz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 18:53:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A54BF8AFA7;
	Tue, 14 Oct 2008 18:53:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 48F708AF98; Tue, 14 Oct 2008 18:53:49 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FA2BB2A2-9A42-11DD-9342-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98221>

Some misguided documents floating on the Net suggests this sequence:

    mkdir newdir && cd newdir
    git init
    git remote add origin $url
    git pull origin master:master

"git pull" has known about an misguided "pull" like this where the
underlying fetch updates the current branch for a long time, and it also
has known about another form of insanity "git pull origin master" into an
unborn branch, but these two workarounds were not aware of the existence
of each other and did not work well together.

This fixes it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This comes on top of js/maint-fetch-update-head.  Passes all the tests,
   and also its own.

 git-pull.sh     |    4 ++--
 t/t5520-pull.sh |   12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 75c3610..664fe34 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -124,7 +124,7 @@ orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
 git fetch --update-head-ok "$@" || exit 1
 
 curr_head=$(git rev-parse --verify HEAD 2>/dev/null)
-if test "$curr_head" != "$orig_head"
+if test -n "$orig_head" && test "$curr_head" != "$orig_head"
 then
 	# The fetch involved updating the current branch.
 
@@ -172,7 +172,7 @@ esac
 
 if test -z "$orig_head"
 then
-	git update-ref -m "initial pull" HEAD $merge_head "" &&
+	git update-ref -m "initial pull" HEAD $merge_head "$curr_head" &&
 	git read-tree --reset -u HEAD || exit 1
 	exit
 fi
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 997b2db..725771f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -29,6 +29,18 @@ test_expect_success 'checking the results' '
 	diff file cloned/file
 '
 
+test_expect_success 'pulling into void using master:master' '
+	mkdir cloned-uho &&
+	(
+		cd cloned-uho &&
+		git init &&
+		git pull .. master:master
+	) &&
+	test -f file &&
+	test -f cloned-uho/file &&
+	test_cmp file cloned-uho/file
+'
+
 test_expect_success 'test . as a remote' '
 
 	git branch copy master &&
-- 
1.6.0.2.711.gf1ba4
