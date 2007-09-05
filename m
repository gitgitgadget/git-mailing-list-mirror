From: Junio C Hamano <gitster@pobox.com>
Subject: Invoke "git gc --auto" from commit, merge, am and rebase.
Date: Wed, 05 Sep 2007 14:59:59 -0700
Message-ID: <7vmyw0hixs.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	<7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0709051634190.21186@xanadu.home>
	<7vwsv4hjfi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 00:00:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT2v3-0005mQ-7E
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 00:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbXIEWAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 18:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbXIEWAL
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 18:00:11 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:41137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207AbXIEWAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 18:00:09 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 82D8D12C7D5;
	Wed,  5 Sep 2007 18:00:24 -0400 (EDT)
In-Reply-To: <7vwsv4hjfi.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 05 Sep 2007 14:49:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57771>

The point of auto gc is to pack new objects created in loose
format, so a good rule of thumb is where we do update-ref after
creating a new commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
  Let's chuck the previous "git add/git fetch" one, and replace it
  with this.

  Also I realize I misread your earlier comment about "git add".
  You are still among the only few people on the list that I
  consider are always more right than I am ;-).

 git-am.sh                  |    2 ++
 git-commit.sh              |    1 +
 git-merge.sh               |    1 +
 git-rebase--interactive.sh |    2 ++
 4 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 6809aa0..4db4701 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -466,6 +466,8 @@ do
 		"$GIT_DIR"/hooks/post-applypatch
 	fi
 
+	git gc --auto
+
 	go_next
 done
 
diff --git a/git-commit.sh b/git-commit.sh
index 1d04f1f..d22d35e 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -652,6 +652,7 @@ git rerere
 
 if test "$ret" = 0
 then
+	git gc --auto
 	if test -x "$GIT_DIR"/hooks/post-commit
 	then
 		"$GIT_DIR"/hooks/post-commit
diff --git a/git-merge.sh b/git-merge.sh
index 3a01db0..697bec2 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -82,6 +82,7 @@ finish () {
 			;;
 		*)
 			git update-ref -m "$rlogm" HEAD "$1" "$head" || exit 1
+			git gc --auto
 			;;
 		esac
 		;;
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index abc2b1c..8258b7a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -307,6 +307,8 @@ do_next () {
 	rm -rf "$DOTEST" &&
 	warn "Successfully rebased and updated $HEADNAME."
 
+	git gc --auto
+
 	exit
 }
 
